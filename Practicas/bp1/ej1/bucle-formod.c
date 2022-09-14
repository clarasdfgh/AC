#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
   #include <omp.h>
#else
   #define omp_get_thread_num() 0
#endif

int main(int argc, char **argv)
{
   int i, n = 9;

  if(argc < 2){
    fprintf(stderr,"\n[ERROR] - Falta nº de iteraciones \n");
    exit(-1);
  }
   n = atoi(argv[1]);

#pragma omp parallel for
{
   for (i=0; i<n; i++)
      printf("Hebra %d ejecuta la iteración %d del bucle\n",
      omp_get_thread_num(),i);
}

   return(0);
}
