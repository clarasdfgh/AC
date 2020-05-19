#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main (int argc, char **argv){
	struct timespec cgt1, cgt2;			//Medicion de tiempo
	double ncgt;
	
	const int A = 150;						//Constante arbitraria

	if ( argc < 2 ) {
        fprintf(stderr,"Introduzca un num\n");
        exit(-1);
    }

	int n = atoi(argv[1]);
	int x[n], y[n];
	
	for (int i = 0; i <= n; i++){
		x[i] = i;
		y[i] = 2*i;
	}
	
	clock_gettime(CLOCK_REALTIME,&cgt1);
	
	for (int i = 1;i <= n; i++){
		y[i] = A * x[i] + y[i];
	} 
	
	clock_gettime(CLOCK_REALTIME,&cgt2);
	ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec) + (double) ((cgt2.tv_nsec-cgt1.tv_nsec) / (1.e+9));
	
	
	printf("\ny[0]: %d, y[%d]: %d\n", y[0], n, y[n]); 	
	printf("Tiempo: %11.9f\n", ncgt);
	
	return 0;
}
