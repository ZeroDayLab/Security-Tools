#include <stdio.h>

int main(int argc, char *argv[]) {
    int k; // using int here and not char since EOF is an int
    while((k = getchar()) != EOF)
        if(k != 0x0D && k != 0x0A) putchar(k); //0x0D is carriage return and 0x0A is new line
//        else putchar(''); // When above is found replace character with any character
    return 0;
}
