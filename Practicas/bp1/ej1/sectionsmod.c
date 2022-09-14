#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
  #include <omp.h>
#else
  #define omp_get_thread_num() 0
#endif

void funcA()
{
   printf("En funcA: esta sección la ejecuta la hebra %d\n",
        omp_get_thread_num());
}
void funcB()
{
   printf("En funcB: esta sección la ejecuta la hebra %d\n",
        omp_get_thread_num());
}

int main()
{
	#pragma omp parallel sections
	{
	      #pragma omp section
	        (void) funcA();

	      #pragma omp section
	        (void) funcB();
	}

   return(0);
}
