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
	
	int dyn_var = omp_get_dynamic();
	int nthreads_var = omp_get_max_threads();
	int thread_limit_var = omp_get_thread_limit();
	int run_sched_var;
		omp_sched_t kind;
		omp_get_schedule(&kind, &run_sched_var);
	
	for (i=0; i<n; i++) a[i] = i; 
	
	printf("\nFUERA DE REGION PARALELA, sin modificar:");
	printf("\n\tdyn_var: %d  \
	\n\tnthreads_var: %d  \
	\n\tthread_limit_var: %d  \
	\n\trun_sched_var: %d  \
	\n", dyn_var, nthreads_var, thread_limit_var, run_sched_var);
	
	#pragma omp parallel for firstprivate(suma) \
			lastprivate(suma) schedule(dynamic,chunk) 
	for (i=0; i<n; i++) { 
		suma = suma + a[i]; 
		printf(" thread %d suma a[%d]=%d suma=%d \n", omp_get_thread_num(),i,a[i],suma); 
	}
	
		#pragma omp single
		{
			omp_set_dynamic(4);
			omp_set_num_threads(6);
			omp_set_schedule(omp_sched_dynamic, 6);
		
			dyn_var = omp_get_dynamic();
			nthreads_var = omp_get_max_threads();
			thread_limit_var = omp_get_thread_limit();
			omp_get_schedule(&kind, &run_sched_var);
		
			printf("\nDENTRO DE REGION PARALELA, modificado:");
			printf("\n\tdyn_var: %d  \
			\n\tnthreads_var: %d  \
			\n\tthread_limit_var: %d  \
			\n\trun_sched_var: %d  \
			\n", dyn_var, nthreads_var, thread_limit_var, run_sched_var);
	 	}
	 
	
	printf("Fuera de 'parallel for' suma=%d\n",suma); 
}
