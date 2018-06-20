/************************************************************/
/* Toggle TPM Reset GPIO                      */
/* Written with libsoc C library              */
/*                             */
/*                             */
/* You can do interrupt programming with this library    */
/*                             */
/************************************************************/

#include <stdio.h>
#include <stdlib.h>

#include "libsoc_gpio.h"
/* #include "libsoc_debug.h" */
#include "libsoc_board.h"

unsigned int GPIO_RESET;

/* This bit of code below makes this example work on all */
/* 96Boards, Though you could just call this in main */
__attribute__((constructor)) static void _init()
{
  board_config *config = libsoc_board_init();
  GPIO_RESET = libsoc_board_gpio_id(config, "GPIO-D");
  libsoc_board_free(config);
}
/* End of 96Boards special code */

int main()
{
  gpio  *gpio_reset;

  /* libsoc_set_debug(0); */
  gpio_reset = libsoc_gpio_request(GPIO_RESET,LS_SHARED);

  if (gpio_reset == NULL)
  {
    return(-1);
  }
  libsoc_gpio_set_direction(gpio_reset,OUTPUT);

  if (libsoc_gpio_get_direction(gpio_reset) != OUTPUT)
  {
    return(-1);
  }

 libsoc_gpio_set_level(gpio_reset,1);
 usleep(100000);
 libsoc_gpio_set_level(gpio_reset,0);
 usleep(100000);
 libsoc_gpio_set_level(gpio_reset,1);
 usleep(100000);
 
  return EXIT_SUCCESS;
}


