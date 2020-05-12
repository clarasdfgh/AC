#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

//#define GLOBAL
#define DINAMICO

const int MAX = 4294967295;

int main(int argc, char** argv){
	struct timespec cgt1, cgt2;			//Medicion de tiempo
	double ncgt;
	
	if(argc < 2) { 
		fprintf(stderr,"Falta el tamanio de la matriz\n"); 
		exit(-1);
	} 
	
	unsigned int n = atoi(argv[1]);
	int i, j;

	#ifdef GLOBAL
		printf("\nEjecutando de forma GLOBAL\n");
		if(n > MAX) {
			n = MAX;
		}
		
		int A[n][n];
		int B[n];
		int C[n];
		
	#endif	
	
	#ifdef DINAMICO
		printf("\nEjecutando de forma DINAMICA\n");
		int **A = (int**) malloc(n * sizeof(int*));
		int *B = (int*) malloc(n * sizeof(int));
		int *C = (int*) malloc(n * sizeof(int));

		for(int i = 0; i < n; i++) {
			A[i] = (int*) malloc(n * sizeof(int));
		}
	#endif	

	srand(time(NULL));		//Generador de numeros aleatorios

	#pragma omp parallel for private(i,j)
	for(i = 0; i < n; i++){
		B[i] = rand() % 100 + 1;
		C[i] = 0;
		for(j=0; j < n; j++){
			A[i][j] = rand() % 100 + 1;
		}
	}
	
	if(n<=11){
		printf("\nMatriz inicial:\n");
		for(i = 0; i < n; i++){
			for(j = 0; j < n; j++){
				printf(" %d ", A[i][j]);
			}
			printf("\n");
		}
	
	
		printf("\nVector inicial:  |");
		for(i = 0; i < n; i++){
			printf(" %d |", B[i]);
		}
	}
	
	clock_gettime(CLOCK_REALTIME,&cgt1);
	
	for(i = 0; i < n; i++) {
		#pragma omp parallel for private(j), reduction(+:C[i])
		for(j = 0; j < n; j++) {
			C[i] += A[i][j]*B[j];
		}
	}	

	clock_gettime(CLOCK_REALTIME,&cgt2);
	
	ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec) + (double) ((cgt2.tv_nsec-cgt1.tv_nsec) / (1.e+9));
	
	printf("\nTiempo matriz tamanio %d: %11.9f", n, ncgt);

	if(n<=11){
		printf("\nVector resultado:  |");
		for(i = 0; i < n; i++){
			printf(" %d |", C[i]);
		}
	}

	#ifdef DYNAMIC
		for(int i = 0; i < n; i++){
			free(A[i]);
		}

		free(A);
		free(B);
		free(C);	
	#endif

	return 0;
}
