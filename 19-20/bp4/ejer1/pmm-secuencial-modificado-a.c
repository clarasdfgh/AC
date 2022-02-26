#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>


#define MAX 1024
int A[MAX][MAX], B[MAX][MAX], C[MAX][MAX];


int main(int argc, char** argv){
	struct timespec cgt1, cgt2;			//Medicion de tiempo
	double ncgt;
	
	if(argc < 2) { 
		fprintf(stderr,"Falta el tamanio de la matriz\n"); 
		exit(-1);
	} 
	
	unsigned int n = atoi(argv[1]);
	int i, j;

	if(n > MAX){
		n = MAX;
	}


	for(i = 0; i < n; i++){
		for(j = 0; j < n; j++){
			A[i][j] = n + (2*j) - i  + 1;
			B[i][j] = n + (2*j) - i  + 1;
			C[i][j] = 0;
		}
	}
	

	if(n <= 11){
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
	
	for(i = 0; i < n; i++) {
		for(j = 0; j < n; j++) {
			for(int k = 0; k < n; k += 4){
				C[i][j] += A[i][k] * B[k][j] + A[i][k+1] * B[k+1][j] + A[i][k+2] * B[k+2][j] + A[i][k+3]  * B[k+3][j];
			}
		}
	}	

	clock_gettime(CLOCK_REALTIME,&cgt2);
	
	ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec) + (double) ((cgt2.tv_nsec-cgt1.tv_nsec) / (1.e+9));
	
	printf("\nTiempo matriz tamanio %d: %11.9f", n, ncgt);

	if(n <= 11){
			printf("\nMatriz resultado:\n");
		for(i = 0; i < n; i++){
			for(j = 0; j < n; j++){
				printf(" %d ", C[i][j]);
			}
			printf("\n");
		}
	}

	return 0;
}
