#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif


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
		//printf("\nEjecutando de forma GLOBAL\n");
		if(n > MAX) {
			n = MAX;
		}
		
		int A[n][n];
		int B[n][n];
		int C[n][n];
		
	#endif	
	
	#ifdef DINAMICO
		//printf("\nEjecutando de forma DINAMICA\n");
		int **A = (int**) malloc(n * sizeof(int*));
		int **B = (int**) malloc(n * sizeof(int*));
		int **C = (int**) malloc(n * sizeof(int*));

		for(int i = 0; i < n; i++) {
			A[i] = (int*) malloc(n * sizeof(int));
			B[i] = (int*) malloc(n * sizeof(int));
			C[i] = (int*) malloc(n * sizeof(int));
		}
	#endif	

	#pragma omp parallel for
	for(i = 0; i < n; i++){
		for(j = 0; j < n; j++){
			A[i][j] = n + (2*j) - i  + 1;
			B[i][j] = n + (2*j) - i  + 1;
			C[i][j] = 0;
		}
	}
	

	if(n<=11){
		printf("\nMatriz A:\n");
		for(i = 0; i < n; i++){
			for(j = 0; j < n; j++){
				printf(" %d ", A[i][j]);
			}
			printf("\n");
		}
	
	
		printf("\nMatriz B:\n");
		for(i = 0; i < n; i++){
			for(j = 0; j < n; j++){
				printf(" %d ", B[i][j]);
			}
			printf("\n");
		}
	}
	
	clock_gettime(CLOCK_REALTIME,&cgt1);
	
	int k;
	
	#pragma omp parallel shared(A, B, C) private(i, j, k)
	{
		#pragma omp for
		for(i = 0; i < n; i++) {
			for(j = 0; j < n; j++) {
				for(int k = 0; k < n; k++){
					C[i][j] += A[i][k] * B[k][j];
				}
			}
		}
	}	

	clock_gettime(CLOCK_REALTIME,&cgt2);
	
	ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec) + (double) ((cgt2.tv_nsec-cgt1.tv_nsec) / (1.e+9));
	
	printf("\nTiempo matriz tamanio %d: %11.9f", n, ncgt);

	if(n<=11){
			printf("\nMatriz resultado:\n");
		for(i = 0; i < n; i++){
			for(j = 0; j < n; j++){
				printf(" %d ", C[i][j]);
			}
			printf("\n");
		}
	}

	#ifdef DYNAMIC
		for(int i = 0; i < n; i++){
			free(A[i]);
			free(B[i]);
			free(C[i]);
		}

		free(A);
		free(B);
		free(C);	
	#endif

	return 0;
}
