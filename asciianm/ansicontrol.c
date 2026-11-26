#include <stdio.h>

void ansi_restore_cursor(void);
void ansi_goto11(void);
void ansi_clear(void);
void ansi_init(void);


void ansi_init(void) {
    printf("\x1b[H\x1b[2J");
	 printf("\x1b[?25l\x1b[H\x1b[2K");
 	 printf("\x1b[H");
}

void ansi_restore_cursor(void) {
	printf("\x1b[17H\x1b[?25h");
}

void ansi_clear(void) {
    printf ("\x1b[H\x1b[2J");
}

void ansi_goto11(void){
printf("\x1b[H");
}
