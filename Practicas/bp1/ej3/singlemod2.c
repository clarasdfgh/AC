#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
  #include <omp.h>
#else
  #define omp_get_thread_num() 0
#endif

int main()
{
   int n = 9;
   int i, a, b[n];

   for (i=0; i<n; i++)
       b[i] = -1;
#pragma omp parallel
{
   #pragma omp single
   {
      printf("Introduce valor de inicialización a: ");scanf("%d",&a);
      printf("Single ejecutada por la hebra %d\n",
             omp_get_thread_num());
   }

   #pragma omp for
   for (i=0; i<n; i++)
       b[i] = a;

	 #pragma omp master
 	{
		printf("Depués de la región parallel:\n");
		for (i=0; i<n; i++)
				printf(" b[%d] = %d\t",i,b[i]);
		printf("\n");

		printf("Salida single ejecutada por la hebra %d\n",
					 omp_get_thread_num());
 	}

}


   return(0);
}
