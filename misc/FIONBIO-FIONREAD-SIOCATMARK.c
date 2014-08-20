/*
 
    Program to determine the values for 2nd
    parameter of the ioctl system call
    on Windows.

    gcc FIONBIO-FIONREAD-SIOCATMARK.c -o FIONBIO-FIONREAD-SIOCATMARK.exe
    
    
    See also
        http://eli.thegreenplace.net/2006/04/07/non-blocking-socket-access-on-windows/

*/
#include <stdio.h>
#include <winsock2.h>

int main() {
  printf("FIONBIO    : 0x%x   %12d\n", FIONBIO   , FIONBIO   );  // 0x8004667e    -2147195266
  printf("FIONREAD   : 0x%x   %12d\n", FIONREAD  , FIONREAD  );  // 0x4004667f     1074030207
  printf("SIOCATMARK : 0x%x   %12d\n", SIOCATMARK, SIOCATMARK);  // 0x40047307     1074033415
}
