#include <stdio.h>

int main(int argc, char *argv[]) {
    int k; // using int here and not char since EOF is an int
    while((k = getchar()) != EOF)
        if(k != 0x0D && k != 0x0A) putchar(k);
//        else putchar(''); // replace newlines with spaces
    return 0;
}
