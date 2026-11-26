/*
 *
 * Ascii Animation Program v.2 (8/2002) 
 * By Maistrelis Kostas.
 *
 * Released under the terms of the GNU GPL license.
 *
 * Changed 25/11/2026: the places marked 2026 (see ChangeLog).
 */

/*#include <sys/types.h>*/
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>          /* 2026 */
#include <sys/select.h>     /* 2026 */
#include <termios.h>        /* 2026 */
#include <time.h>           /* 2026 */
#include "timer.h"
#include "ansicontrol.h"

#ifdef NCURSES
#include <ncurses.h>
#endif

#define versionstr "Ascii Animation program v.2 (8/2002) By Maistrelis Kostas.\n"

int cols =80;
int lines =22;
int sinoloepanal =1;
unsigned int msecs =100;
char desc[100];

int flag_arg=0;  /* simea gia to an to arxio ascii periexei mia
                  * proti grami me tis parametrous opote afti
                  * i grami na agnoi8ei apo to display*/

int warning=0; /* ypar3i control xaraktiron*/

pid_t pid;
char *arxio;
char *onomaentolis;
FILE *fp;

int param_apo_arxio(void);
int size_chek(void);
void odigies(void);
void display_file(void);
int display_kare(void);
void window_handler(int);
void termination_handler(int);
void usr1_handler(int);
void timer_handler(int);
void info();
void init_screan(void);
void version(void);

int play=0;
int karef=0;
int microsecs=0;
int returneof=0;         /* 2026: the file ended together with a frame */
int telos=0;             /* 2026: q was pressed */
int pafsi=0;             /* 2026: space: paused */
int pliktra=0;           /* 2026: keys are read (stdin and stdout are a terminal) */
char *othoni=NULL;       /* 2026: what is on the screen, lines x (cols+1), to leave it there at the end */
struct termios palio;    /* 2026: the terminal as it was (ANSI only; ncurses has its own) */
void diavase_pliktro(void);
void perimene(sigset_t *mask);
void arxise_pliktra(void);
void epanafora(void);
void grapse_othoni(void);
#ifdef NCURSES
int curses=1; 
#else
int curses=0; 
#endif
int main(int argc, char *argv[])
{


char *orisma;


 pid = getpid();
 orisma='\0';
 onomaentolis = argv[0];

 if ( argc == 1 ) {
   odigies();
 }

 if (argc >= 2){
   arxio = argv[1];
   if (!strcmp(arxio, "--help")) { odigies(); }
   if (!strcmp(arxio, "--version")) { version(); }
   if (!strcmp(arxio, "-v")) { version(); }
	if (!strcmp(arxio, "--info")) { 
		if (argc >= 3) {
			arxio = argv[2];
			info();
		} else {	odigies();	}
	}
   if(param_apo_arxio())
        flag_arg=1;
 }

 if (argc >= 3){
      orisma = argv[2];
  	   if (!strcmp(orisma, "-ansi")) { curses=0;} 
		else {msecs = atoi(orisma);}
 }

 if (argc >= 4){
     orisma = argv[3];
	  if (!strcmp(orisma, "-ansi")) { curses=0;} 
	  else{lines = atoi(orisma);}
 }

 if (argc >= 5){
     orisma = argv[4];
  	  if (!strcmp(orisma, "-ansi")) { curses=0;} 
     else{cols = atoi(orisma);}
 }

 if (argc >= 6){
     orisma = argv[5];
	  if (!strcmp(orisma, "-ansi")) { curses=0;}
	  else {sinoloepanal = atoi(orisma);}
 }

 if (argc >= 7){
     orisma = argv[6];
 	  if (!strcmp(orisma, "-ansi")) { curses=0;} 
 }



 if (msecs < 6){
	 	microsecs=6;
 } else {
	  	microsecs=msecs*1000;
 }


/*-------SET SIGNAL HANDLERS------------------------------*/
if (signal(SIGWINCH, window_handler) == SIG_ERR) {
   fprintf(stderr, "Cannot set handler for SIGWINCH\n");
   exit(1);
}
if (signal(SIGINT, termination_handler) == SIG_ERR) {
   fprintf(stderr, "Cannot set handler for SIGINT\n");
   exit(1);
}
if (signal(SIGTERM, termination_handler) == SIG_ERR) {
   fprintf(stderr, "Cannot set handler for SIGTERM\n");
   exit(1);
}

if (signal(SIGUSR1, usr1_handler) == SIG_ERR) {
   fprintf(stderr, "Cannot set handler for SIGTERM\n");
   exit(1);
}
/*--------------------------------------------------------*/


 /* init ektiposis */



init_screan();

 if (sinoloepanal == 0){
    sinoloepanal = -2;
 }
 {unsigned long i;
  for (i=0; i != sinoloepanal && !telos; i++){
      
		display_file();
  }
 }

 /* 2026: the last frame is seen as long as the others, and stays on the screen */
 if (!telos) {
	struct timespec xronos;
	if (isatty(1)) {
		xronos.tv_sec = microsecs / 1000000;
		xronos.tv_nsec = (microsecs % 1000000) * 1000L;
		nanosleep(&xronos, NULL);
	}
 }
 epanafora();
 grapse_othoni();
 
  if (warning)
     fprintf(stderr,"Warning: illegal characters\n");


 exit(0);
}
/*----------------------------------------------------------*/
/*----------------------------------------------------------*/



void display_file(void){

  /*perioxi ektiposis */
/* FILE *fp; */
 char grami[100];
 sigset_t alrm, old;   /* 2026 */
 returneof = 0;
 
 play=1;
 if ((fp = fopen (arxio, "r")) == NULL) {
      fprintf(stderr, "%s: Cannot open file: %s\n",onomaentolis,arxio);
#ifdef NCURSES
		if (curses){endwin();}
#endif		
      exit(1);
   }

 if (flag_arg)
     fgets(grami, 100, fp);

 /* 2026: SIGALRM arrives only inside perimene(), so a frame is never drawn in the
  * middle of something else, and the end of the file is not missed. Then the timer is
  * stopped, a tick that still waits is thrown away, and the file is closed (it is
  * opened again in every repetition). */
 sigemptyset(&alrm);
 sigaddset(&alrm, SIGALRM);
 sigaddset(&alrm, SIGWINCH);
 sigprocmask(SIG_BLOCK, &alrm, &old);
 inittimer(microsecs,0);
 settimer(); 
 while(play && !telos){perimene(&old);};
 cleartimer();
 signal(SIGALRM, SIG_IGN);
 sigprocmask(SIG_SETMASK, &old, NULL);
 fclose(fp);
 fp = NULL;
 if (!curses && returneof)
	ansi_goto11();       /* as before 2026, when the end of the file took one more tick: the output of -ansi stays the same */

 } /* perioxi ektiposis */



 int display_kare(void) {
 const int NLINES=lines;
 const int NCOLS=cols;
 int counterch=0;
 int countergramon=0;
 int ch;   /* 2026: was char; where char is unsigned, EOF was never seen */
 char grami[NCOLS+1];
 int returnval=0;

 karef=1;
 while (countergramon < NLINES)
 {
	 if ((ch=getc(fp)) != EOF) {
		 counterch++;
	    if (ch < 32 || ch > 126)
	       if (ch != '\n'){
	          ch = 32;
	          warning=1;
			 }

	    if (ch =='\n'){
	     if (counterch < NCOLS){
	            int i;
	            for (i= counterch; i < (NCOLS); ++i){
	                grami[i-1] = 32;
	            }
	     }

	     grami[NCOLS-1]='\n';
	     grami[NCOLS]='\0';
   

	     if (othoni)                /* 2026 */
	        memcpy(othoni + countergramon*(NCOLS+1), grami, NCOLS+1);
	     ++countergramon;
#ifdef NCURSES
        if (curses){
		  		addstr(grami);
		  }else {
		  		printf("%s",grami);
		  }
#else
  		  printf("%s",grami);
#endif
	     counterch=0;
	    }else if (counterch < NCOLS){
	     grami[counterch-1] = ch;
	    }
	} else {
		returnval=1;
		break;
	}
}

 /* 2026: if this was the last frame, say so now and not at the next tick (it was seen twice as
  * long as the others). The NULs that some files have at their end do not count. */
 if (returnval == 0) {
	while ((ch=getc(fp)) == 0) ;
	if (ch == EOF) { returnval=1; returneof=1; } else ungetc(ch, fp);
 }

#ifdef NCURSES
if (curses){
	move(LINES-1,COLS-1);
	refresh();
	move(0,0);
}else{
	ansi_goto11();
}
#else
	ansi_goto11();
#endif
karef=0;
return returnval;

}


 int param_apo_arxio(void){

 FILE *fp;
 int i,j,count_arg,mikos;
 char *p;
 int flag = 0;
 char grami[100];
 char buf[100];

 if ((fp = fopen (arxio, "r")) == NULL) {
      fprintf(stderr, "%s: Cannot open file: %s\n",onomaentolis,arxio);
      exit(1);
 }


 fgets(grami, 100, fp);
 mikos = strlen(grami);

 fclose(fp);
 
 desc[0]='\0';
 if ((p = strstr(grami,"ARGUMENTS:")) != NULL){
  flag = 1;
  count_arg = 1;
  j=0;
  for (i=10;i<mikos;i++){
     if (grami[i] != ':'){
        if (grami[i] == '#')
                     break; 
        buf[j]=grami[i];
     }else{

        buf[j]='\0';
        j=-1;

      if (count_arg == 1)
         lines=atoi(buf);
      if (count_arg == 2)
         cols=atoi(buf);
      if (count_arg == 3)
         msecs=atoi(buf);
      if (count_arg == 4)
         sinoloepanal=atoi(buf);
      if (count_arg == 5)
         strcpy(desc,buf);

     count_arg++;
     } /*if*/
     j++;
  } /*for*/

 }


 if (flag)
    return(1);

 return(0);

}


void window_handler(int sig){
	  signal(SIGWINCH,window_handler);
#ifdef NCURSES	  
     if (curses) {
		   endwin();
	      refresh();           /* 2026: was initscr */
	      clear();
		} else {
			ansi_clear();
		}
#else
			ansi_clear();
#endif
 	}

void termination_handler(int sig){
	  cleartimer();
	  epanafora();          /* 2026 */
	  play=0;
	  if (fp) fclose(fp);   /* 2026: it is closed between two repetitions */
	  exit(0);
}

void usr1_handler(int sig){
;
}


/*
 * handler - catch alarm signal
 */
void timer_handler(int sig)
{
	if (karef == 0) 
	if (display_kare()) {
		cleartimer();
		play=0;
/*  	   kill(pid,SIGUSR1); */
	}
}


void info(void) {
 unsigned long counterLines = 0;
 unsigned long counterKare = 0;
 char grami[100];
 int ch;   /* 2026: was char */

 if(param_apo_arxio()) {
 if ((fp = fopen (arxio, "r")) == NULL) {
      fprintf(stderr, "%s: Cannot open file: %s\n",onomaentolis,arxio);
      exit(1);
 }
 fgets(grami, 100, fp);
 counterKare = 0;
 while ((ch=getc(fp)) != EOF)
 {
    if (ch < 32 || ch > 126)
       if (ch != '\n'){
          ch =' ';
          warning=1;
	}
    if (ch =='\n'){
		counterLines++; 
	 }
 }

 fclose(fp);
 counterKare = (counterLines/lines);
 if ((counterLines - (counterKare * lines)) > 0){
 	counterKare += 1;
 }

	printf(" Comment          : %s\n",desc);
	printf(" Frame Lines      : %d\n",lines);
	printf(" Frame Columns    : %d\n",cols);
	printf(" Number of Frames : %ld\n",counterKare);
	printf(" Number of Lines  : %ld\n",counterLines);
	printf(" Speed (msecs)    : %d\n",msecs);
	if (sinoloepanal) {
	printf(" Repetition       : %d\n",sinoloepanal);
	} else {
	printf(" Repetition       : for ever\n");
	}
	if (warning) {
	printf("\n");
	printf(" Warning: the file has illegal characters\n");
	}
	
 }else 
		printf(" No info available\n");
 exit(0);

}

void odigies(void) {
 /*printf("odigies prosexos!!\n\n");*/
 
printf(versionstr);
#ifdef NCURSES
 printf("Usage:   %s <name> [[speed] [lines] [cols]  [count]] || [-ansi]\n", onomaentolis);
#else
 printf("Usage:   %s <name> [[speed] [lines] [cols]  [count]\n", onomaentolis);
#endif
 printf("         %s [--version] || [-v] \n", onomaentolis);
 printf("         %s <--info> <name> \n", onomaentolis);
 printf("Options: name  : the name of ascii animation file             \n");
 printf("         speed : The speed of animation  (msec)  - default 100\n");
 printf("         lines : The length of frame             - default  22\n");
 printf("         cols  : The Number of columns of frame  - default  80\n");
 printf("         count : The Number of repetitions                    \n");
 printf("                 0 for ever                      - default 1  \n");
 printf("Keys:    q quit, space pause, + faster, - slower\n");
#ifdef NCURSES
 printf("         -ansi : uses ANSI control characters instead of CURSES\n");
#endif

 exit(0);

}

void version(){
printf(versionstr);
#ifdef NCURSES	  
printf("Curses and ANSI control of Screen.\n");
#else
printf("ANSI Control of Screen.\n");
#endif
exit(0);
}

#ifdef NCURSES	  
int size_chek(void) {
int clines=0;
int ccols=0;

if (!curses) { return(0);}
clines=LINES;
ccols=COLS; 

 if ((lines > clines) || (cols > ccols)){
      endwin();
      fprintf(stderr," %s: the terminal is too small\n needed: %dx%d\n now:    %dx%d\n",onomaentolis,cols,lines,ccols,clines);
   return(1);
   }
return(0);
}
#endif


void init_screan(void) {
#ifdef NCURSES
if (curses) {
 	 initscr(); 
	  if(size_chek())
	  	  exit(1);
	 clear();
	 curs_set(0);
	 cbreak();              /* 2026: keys */
	 noecho();
	 refresh();
	 } else {
	 	ansi_init();
	 }
#else
	   ansi_init();
#endif	 
 arxise_pliktra();         /* 2026 */
}

/*----------------------------------------------------------*/
/* 2026: keys, and the screen at the end                    */

/* read keys only when a person is there: not when the output goes to a file (-ansi > x.vt) */
void arxise_pliktra(void) {
 pliktra = isatty(0) && isatty(1);
 if (curses) {
	othoni = malloc(lines * (cols+1));
	if (othoni) memset(othoni, '\n', lines * (cols+1));
 } else if (pliktra) {
	struct termios t;
	if (tcgetattr(0, &palio) == -1) { pliktra = 0; return; }
	t = palio;
	t.c_lflag &= ~(ICANON | ECHO);
	t.c_cc[VMIN] = 1;
	t.c_cc[VTIME] = 0;
	tcsetattr(0, TCSANOW, &t);
 }
}

/* wait for a tick of the timer, or for a key */
void perimene(sigset_t *mask) {
 fd_set f;
 if (!pliktra) { sigsuspend(mask); return; }
 FD_ZERO(&f);
 FD_SET(0, &f);
 if (pselect(1, &f, NULL, NULL, NULL, mask) > 0)
	diavase_pliktro();
}

void diavase_pliktro(void) {
 char k;
 ssize_t n = read(0, &k, 1);
 if (n == 0 || (n < 0 && errno != EINTR)) { pliktra = 0; return; }
 if (n != 1) return;
 switch (k) {
 case 'q': case 'Q':
	telos = 1;
	return;
 case ' ':
	pafsi = !pafsi;
	break;
 case '+': case '=':
	microsecs = microsecs * 4 / 5;
	if (microsecs < 1000) microsecs = 1000;
	break;
 case '-': case '_':
	if (microsecs < 1000) microsecs = 1000;
	microsecs = microsecs / 4 * 5;
	if (microsecs > 20000000) microsecs = 20000000;
	break;
 default:
	return;
 }
 if (pafsi) cleartimer();
 else { inittimer(microsecs,0); settimer(); }
}

/* the terminal as it was */
void epanafora(void) {
#ifdef NCURSES
 if (curses) { endwin(); return; }
#endif
 if (pliktra) tcsetattr(0, TCSANOW, &palio);
 if (isatty(1)) printf("\x1b[%d;1H\x1b[?25h", lines+1);      /* below the frame */
 else ansi_restore_cursor();
 fflush(stdout);
}

/* ncurses takes the picture away when it ends: write it again */
void grapse_othoni(void) {
 int i, j, n = 0;
 if (!curses || !othoni || !isatty(1)) return;
 for (i = 0; i < lines; i++) {            /* up to the last line with something on it */
	char *l = othoni + i*(cols+1);
	for (j = 0; j < cols && l[j] != '\n'; j++)
		if (l[j] != ' ') { n = i+1; break; }
 }
 for (i = 0; i < n; i++) {
	char *l = othoni + i*(cols+1);
	for (j = 0; j < cols && l[j] != '\n'; j++) ;
	while (j > 0 && l[j-1] == ' ') j--;
	printf("%.*s\n", j, l);
 }
}




