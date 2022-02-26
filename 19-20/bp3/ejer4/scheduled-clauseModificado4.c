#include <stdio.h> 
#include <stdlib.h> 
#ifdef _OPENMP 
	#include <omp.h> 
#else 
	#define omp_get_thread_num() 0 
#endif 

int main(int argc, char **argv) { 
	int i, n=200,chunk,a[n],suma=0; 
	
	if(argc < 3) { 
		fprintf(stderr,"\nFalta iteraciones o chunk \n"); 
		exit(-1); 
	} 
	
	n = atoi(argv[1]); if (n>200) n=200; chunk = atoi(argv[2]); 
	
	int num_threads = omp_get_num_threads();
	int num_procs = omp_get_num_procs();
	int in_parallel = omp_in_parallel();
	
	
	for (i=0; i<n; i++) a[i] = i; 
	
	printf("\nFUERA DE REGION PARALELA:");
	printf("\
	\n\tnum_threads: %d  \
	\n\tnum_procs: %d  \
	\n\tin_parallel: %d  \
	\n", num_threads, num_procs, in_parallel);
	
	#pragma omp parallel for firstprivate(suma) \
			lastprivate(suma) schedule(dynamic,chunk) 
	for (i=0; i<n; i++) { 
		suma = suma + a[i]; 
		printf(" thread %d suma a[%d]=%d suma=%d \n", omp_get_thread_num(),i,a[i],suma); 
	}
	
		#pragma omp single
		{
			num_threads = omp_get_num_threads();
			num_procs = omp_get_num_procs();
			in_parallel = omp_in_parallel();
			
			printf("\nDENTRO DE REGION PARALELA:");
			printf("\
			\n\tnum_threads: %d  \
			\n\tnum_procs: %d  \
			\n\tin_parallel: %d  \
			\n", num_threads, num_procs, in_parallel);
	 	}
	
	printf("Fuera de 'parallel for' suma=%d\n",suma); 
}
