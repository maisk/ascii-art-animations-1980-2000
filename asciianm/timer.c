#include <sys/time.h>
#include <signal.h>
#include <unistd.h>
#include <stdio.h>
#include "timer.h"




struct itimerval itv;

extern void  timer_handler(int);
void    		settimer(void);
void    		inittimer(unsigned long int microsec, unsigned int sec);
void                    cleartimer(void);

void  inittimer(unsigned long int microsec,  unsigned int sec)
{


    /*
     * Set up a timeout.
     */
    struct sigaction sa;            /* 2026: nothing else interrupts the drawing of a frame */
    sa.sa_handler = timer_handler;
    sa.sa_flags = 0;
    sigemptyset(&sa.sa_mask);
    sigaddset(&sa.sa_mask, SIGINT);
    sigaddset(&sa.sa_mask, SIGTERM);
    sigaddset(&sa.sa_mask, SIGWINCH);
    sigaction(SIGALRM, &sa, NULL);
    sec += microsec / 1000000;      /* 2026: tv_usec must be less than a second */
    microsec %= 1000000;
    itv.it_interval.tv_usec = microsec; /* an den simpliro8oun afta 8elei */
    itv.it_interval.tv_sec = sec;       /* setitimer ka8e fora pou pernaei
					 * o xronos                       */
    itv.it_value.tv_usec = microsec;    /*edo dilonoume microsec 10^-6 */
    itv.it_value.tv_sec = sec;          /* edo dilonoume seconds */


}


/* 3ekinaei to timer */
void settimer(void)
{
    setitimer(ITIMER_REAL, &itv, (struct itimerval *) 0);
}




/*
 * Turn off the alarm. */
void cleartimer(void)
{
    itv.it_value.tv_usec = 0;
    itv.it_value.tv_sec = 0;
    settimer();                     /* 2026: until now the timer was not stopped */
}
