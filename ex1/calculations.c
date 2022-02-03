#include <math.h>
#include "calculations.h"

#define N 1234577

int add(int a, int b) { return translate(a + b); }
int substract(int a, int b) { return translate(a - b); }
int power(int a, int b) { return translate((int)pow((double)a, (double)b)); }
int multiply(int a, int b) { return translate(a * b); }
int divide(int a, int b) { return a / b; }
int modulo(int a, int b) { return a % b; }
int neg(int a) { return translate(-a); }
int translate(int a) {
    if(a > 0) return a % N;
    while(a < 0) a += N;
    return a;
}