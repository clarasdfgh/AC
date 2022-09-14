# AC 21/22 - Resumen seminarios prácticas

## Seminario 0 - Entorno de programación: ATCgrid y gestor de carga de trabajo

### 1. Cluster de prácticas (atcgrid) 

#### Componentes

- Nodos de cómputo, tres servidores ATCgrid1 a 3

  - Dos procesadores (o sea, dos socket). Cada procesador tiene 6 núcleos, con dos niveles de caché L1 y L2. 
  - Los procesadores son multithread, así que cada procesador tiene 6 cores y 12 hebras
  - En total, 24 cores lógicos y 12 cores físicos

- Nodo de cómputo, un servidor ATCgrid 4, más tocho que los otros 3

  - 2 procesadores, con 16 cores cada uno y multithreading, así que 32 hebras en cada uno

    Entonces, cores físicos: 32, cores lógicos: 64

- Nodo front-end, desde donde mandamos las cosas a los otros 4 nodos

#### Acceso

Cada usuario tiene un home en el nodo front-end del clúster ATCgrid.

Para ejecutar comandos (srun, sbatch, squeue…), con un cliente ssh (secure shell): 

```
Linux: $ ssh -X username@atcgrid.ugr.es (pide password del usuario “username”) 
```

Para cargar y descargar ficheros (put hello, get slurm-9.out, …), con un cliente sftp (secure file transfer protocol) 

```
Linux: $ sftp username@atcgrid.ugr.es (pide password del usuario “username”)
```

### 2. Gestor de carga de trabajo (workload manager) 

Se ejecutará en el front-end con conexión ssh:

![image-20220614164751954](/home/clara/.config/Typora/typora-user-images/image-20220614164751954.png)

![image-20220614164800303](/home/clara/.config/Typora/typora-user-images/image-20220614164800303.png)

### 3. Ejemplo de script

![image-20220614165352662](/home/clara/.config/Typora/typora-user-images/image-20220614165352662.png)

### BP0 -- Apuntes

- Cores físicos: num procesadores * num cores
- Cores lógicos: num procesadores * num cores * num hebras

------

## Seminario 1 - Herramientas de programación paralela I: directivas OpenMP

### 1. OpenMP

**Open Multi-Processing:**

- Especificaciones abiertas (Open) para multiprocesamiento (Multi-processing) generadas mediante trabajo colaborativo de diferentes entidades interesadas de la industria del hardware y software, además del mundo académico y del gobierno (Intel, IBM, Oracle, Microsoft, NASA, universidades...)

Es una API para C/C++ y Fortran para escribir código paralelo , usando directivas y funciones, con el paradigma/estilo de programación de variables compartidas para ejecutar aplicaciones en paralelo en varios threads.

- **API (Application Programming Interface):** Capa de abstracción que permite al programador acceder cómodamente a través de una interfaz a un conjunto de funcionalidades. La API OpenMP define/comprende: 
  - Directivas del compilador
  - Funciones de biblioteca
  - Variables de entorno

![image-20220614183815201](/home/clara/.config/Typora/typora-user-images/image-20220614183815201.png)

OpenMP es una herramienta de programación paralela...

- No automática (no extrae paralelismo implícito, es tarea del programador)
- Con un modelo de programación...
  - Basado en el paradigma de variables compartidas
  - Multithread
  - Basado en directivas del compilador y funciones (el código paralelo OpenMP es código escrito en un lenguaje secuencial + directivas y func de OpenMP)
- Portable (API específica para C/C++ y Fortran, la mayor parte de las prataformas SO/hardware tienen implementaciones OpenMP)
- Prácticamente estándar (adoptada y desarrollada por los mayores vendedores de hardware y software)

### 2. Componentes de OpenMP

- **Directivas**: el preprocesador del compilador las sustituye por código
- **Funciones**: fijar parámetros, obtener parámetros...
- **Variables** **de** **entorno**: para fijar parámetros previa ejecución

##### Sintaxis directivas C/C++

| #pragma omp | [nombre]    | OPC[clausula, [...] ... ]                    | \n                                                           |
| ----------- | ----------- | -------------------------------------------- | ------------------------------------------------------------ |
| Obligatorio | Obligatorio | Opcional. Pueden aparecer en cualquier orden | Salto de línea obligatorio. La directiva engloba al bloque estructurado |

- El nombre define y controla la acción que se realiza 

  - Ej.: parallel, for, section … 

- Las cláusulas especifican adicionalmente la acción o comportamiento, la ajustan 

  - Ej.: private, schedule, reduction … 

- Las comas separando cláusulas son opcionales 

- Se distingue entre mayúsculas y minúsculas 

  ```
  EJEMPLO:
  #pragma omp parallel num_threads(8) if(N>20)
  ```

##### Portabilidad

- Compilación C/C++: `gcc -fopenmp`  /  `g++ -fopenmp` 
- Directivas: las directivas no se tendrán en cuenta si no se compila usando OpenMP
  - -fopenmp, -openmp, etc. 
- Funciones: se evitan usando compilación condicional. 
  - Para C/C++: usando _OPENMP y #ifdef … #endif 
  - _OPENMP se define cuando se compila usando OpenMP

##### Definiciones

- Directiva ejecutable (executable directive):
  - Aparece en código ejecutable 
- Bloque estructurado (structured block): 
  - Un conjunto de sentencias con un única entrada al principio del mismo y una única salida al final. 
  - No tiene saltos para entrar o salir 
  - Se permite exit() en C/C++ 
- Construcción (construct) (extensión estática o léxica):
  - Directiva ejecutable + [sentencia, bucle o bloque estructurado]
- Región (extensión dinámica):
  - Código encontrado en una instancia concreta de la ejecución de una construcción o subrutina de la biblioteca OpenMP 
  - Una construcción puede originar varias regiones durante la ejecución 
  - Incluye: código de subrutinas y código implícito introducido por OpenMP

### 3. Directivas

La directiva define la acción que se realiza. En color, las directivas que vamos a estudiar.

Subrayadas, las directivas con barrera implícita al final.

![image-20220614191741236](/home/clara/.config/Typora/typora-user-images/image-20220614191741236.png)

#### Directiva parallel

```c++
#pragma omp parallel [clause[[,]clause]...] 
	//bloque estructurado
```

- Especifica qué cálculos se ejecutarán en paralelo 
- Un thread (master) crea un conjunto de threads cuando alcanza una Directiva parallel 
- Cada thread ejecuta el código incluido en la región que conforma el bloque estructurado 
- No reparte tareas entre threads 
- Barrera implícita al final 
- Se pueden usar de forma anidada

##### Ejemplo: hello world

<img src="/home/clara/.config/Typora/typora-user-images/image-20220614192118901.png" alt="image-20220614192118901" style="zoom:50%;" /><img src="/home/clara/.config/Typora/typora-user-images/image-20220614192131621.png" alt="image-20220614192131621" style="zoom:50%;" />

![image-20220614192048157](/home/clara/.config/Typora/typora-user-images/image-20220614192048157.png)

##### ¿Cómo se enumeran y cuántas threads se usan?

Se enumeran comenzando desde 0 (0… nº threads-1). El master es la 0 

¿Cuántos thread se usan en las ejecuciones anteriores? Empezando por las de más prioridad, a menos:

- El nº fijado por el usuario modificando la variable de entorno OMP_NUM_THREADS 
  - Con el shell o intérprete de comandos Unix csh (C shell):  `setenv OMP_NUM_THREADS 4` 
  - Con el shell o intérprete de comandos Unix ksh (Korn shell) o bash (Bourne-again shell):  `export OMP_NUM_THREADS=4` 
- Fijado por defecto por la implementación: normalmente el nº de cpu de un nodo, aunque puede variar dinámicamente

#### Directivas de trabajo compartido (worksharing)

- `#pragma omp for` - para distribuir las iteraciones de un bucle entre threads (paralelismo de datos)

  ```c++
  #pragma omp for [clause[[,]clause]...] 
  	//for-loop
  ```

  Se tiene que conocer el nº de iteraciones. No se puede bucles do-while. Las iteraciones deben poder ser paralelizables (la herramienta no sabe). La asignación se hace sola a no ser que usemos cláusula schedule.

  - Tipo de paralelismo: de datos o a nivel de bucle
  - Tipo de estructuras de procesos/tareas: descomposición del dominio, divide y vencerás
  - Sincronización: barrera implícita al final, no al principio
  - Asignación de tareas: lo hace la herramienta, a no ser que usemos cláusula schedule

- `#pragma omp sections` - para distribuir trozos de código independientes entre las threads (paralelismo de tareas)

  ```c++
  #pragma omp sections [clause[[,]clause]...] { 
  	[#pragma omp section ] 
  		//structured block 
  	[#pragma omp section ] 
  		//structured block 
  		... 
  }
  ```

  - Tipo de paralelismo: de tareas o a nivel de función
  - Tipo de estructuras de procesos/tareas: maestro-esclavo, cliente-servidor, flujo de datos, descomposición del dominio, divide y vencerás
  - Sincronización: barrera implícita al final, no al principio
  - Asignación de tareas: lo hace la herramienta

- `#pragma omp single` - para que uno de los threads ejecute un trozo de código secuencial, útil cuando algo no es thread-safe como la E/S

  ```c++
  #pragma omp single [clause[[,]clause]...] { 
  	//structured block 
  ```

  - Tipo de paralelismo: no es paralelismo, ejecuta secuencialmente un trozo
  - Sincronización: barrera implícita al final, no al principio
  - Asignación de tareas: lo hace la herramienta, puede ser cualquier thread

#### Combinar parallel con worksharing

![image-20220614193621353](/home/clara/.config/Typora/typora-user-images/image-20220614193621353.png)

#### Directivas básicas de comunicación y sincronización

- `#pragma omp barrier` - para definir una barrera, un punto en el que las hebras se esperan entre sí. Al final de parallel y de las worksharing hay barrera implícita

- `#pragma omp critical` - evita que varios thread accedan a variables compartidas a la vez, evita condición de carrera

  ```c++
  #pragma omp critical [(name)] 
  	//bloque estructurado
  ```

  "Name" permite evitar cerrojos. Sección crítica es el código que accede a variables compartidas

- `#pragma omp atomic` - puede ser una alternativa a critical más eficiente, para operaciones atómicas

  ```c++
  #pragma omp atomic 
  	x <binop> = expre. … [+, *, -, /, ^, &, |, <<, >>]
  
  #pragma omp atomic 
  	x ++, ++x, x-- o -- x.
  ```

#### Directiva master

```c++
#pragma omp master 
	//structured block
```

No es una directiva de trabajo compartido, no tiene barrera implícita.

### BP1 -- Apuntes

- Acordarse siempre que usemos master de poner una barrier al final

------

## Seminario 2 - Herramientas de programación paralela II: cláusulas OpenMP

### 1. Cláusulas

Las cláusulas ajustan el comportamiento de las directivas. Las directivas con cláusulas son:

- parallel
- worksharing: for, sections, single, workshare
- parallel for, parallel sections
  - aceptan cláusulas de las dos directivas excepto nowait

No aceptan cláusulas:

- master
- sincronización/consistencia: critical, barrier, atomic, flush
- ordered
- threadprivate

![image-20220614233940302](/home/clara/.config/Typora/typora-user-images/image-20220614233940302.png)

Las que aceptan cláusulas están en cursiva.

### 2. Ámbito de los datos por defecto. Cláusulas de compartición de datos

En color, las cláusulas que vamos a comentar

![image-20220614234255697](/home/clara/.config/Typora/typora-user-images/image-20220614234255697.png)

#### Ámbito de los datos o atributos de compartición

Como regla general para regiones paralelas: las variables declaradas fuera de una región y las dinámicas son compartidas por las threads de la región. Las variables declaradas dentro son privadas. 

Son excepciones el índice de los bucle for (predeterminado ámbito privado) y variables declaradas static.

#### Cláusulas de compartición de datos

- shared(list) - se comparten las variables de la lista list por todas las threads. Precaución cuando al menos un thread lee lo que otro escribe en alguna variable de la lista.
- private(list) - el valor de entrada y de salida está indefinido, aunque la variable esté declarada fuera de la construcción. 
- lastprivate(lista) - la acción de private, y la copia (al salir de la región paralela) del último valor (en una ej. secuencial) de las variables de la lista se hace pública.
  - En un bucle, el valor de la última iteración
  - En un sections, el valor tras la última sección
- firstprivate(lista) - la acción de private, e inicializa las variables de la lista al entrar en la región paralela.
- default(none/shared) - sólo puede haber una cláusula default
  - Con none, el programador debe especificar el alcance de todas las variables usadas en la construcción, menos variables threadprivate e índices de bucles for.
  - Con default, se ponen a su ámbito por defecto
    - Se pueden excluir del ámbito por defecto usando shared, private, firstprivate, lastprivate, reduction...

### 3. Cláusulas de comunicación/sincronización

- reduction(operator:list) - reduce al final los valores de list operando con el operador suministrado. Comunicación colectiva todos-a-uno.

  <img src="/home/clara/.config/Typora/typora-user-images/image-20220615001505290.png" alt="image-20220615001505290" style="zoom: 80%;" /><img src="/home/clara/.config/Typora/typora-user-images/image-20220615001428279.png" alt="image-20220615001428279" style="zoom: 80%;" />

- copyprivate(list) - solo se puede usar en single. Permite que una variable privada de una hebra se copia a las variables privadas del mismo nombre del resto de threads (difusión). Útil para entrada de variables.

  ![image-20220615001653598](/home/clara/.config/Typora/typora-user-images/image-20220615001653598.png)

------

## Seminario 3 - Herramientas de programación paralela III: interacción con el entorno en OpenMP y evaluación de prestaciones

Objetivos: consulta y modificación de parámetros (número de threads, tipo de planificación de tareas...).

Relaicón con el entorno de ejecución, de más a menos prioridad...

- Variables de control internas
- Variables de entorno
- Funciones del entorno de ejecución
- Cláusulas (no modifican variables de control)

### 1. Variables de control

#### Variables de control internas que afectan a parallel

![image-20220615003709351](/home/clara/.config/Typora/typora-user-images/image-20220615003709351.png)

#### Variables de control internas que afectan a do/loop

![image-20220615003741937](/home/clara/.config/Typora/typora-user-images/image-20220615003741937.png)

### 2. Variables de entorno

![image-20220615003753056](/home/clara/.config/Typora/typora-user-images/image-20220615003753056.png)

### 3. Funciones del entorno de ejecución

![image-20220615003811303](/home/clara/.config/Typora/typora-user-images/image-20220615003811303.png)

#### Otras rutinas del entorno de ejecución (V2.5)

- omp_get_thread_num() 
  - Devuelve al thread su identificador dentro del grupo de thread 
- omp_get_num_threads() 
  - Obtiene el nº de threads que se están usando en una región paralela 
  - Devuelve 1 en código secuencial 
- omp_get_num_procs() 
  - Devuelve el nº de procesadores disponibles para el programa en el momento de la ejecución. 
- omp_in_parallel() 
  - Devuelve true si se llama a la rutina dentro de una región parallel activa (puede estar dentro de varios parallel, basta que uno esté activo) y false en caso contrario.

### 4. Cláusulas para interactuar con el entorno

#### ¿Cuántos threads se usan?

Orden de precedencia para fijar el nº de threads, de más a menos prioridad:

- El nº resultante de evaluar la cláusula if
- El nº que fija la cláusula num_threads 
- El nº que fija la función omp_set_num_threads() 
- El contenido de la variable de entorno OMP_NUM_THREADS
- Fijado por defecto por la implementación: normalmente el nº de cores de un nodo

![image-20220615003943375](/home/clara/.config/Typora/typora-user-images/image-20220615003943375.png)

#### Cláusulas para interactuar con el entorno

- Cláusula if - no hay ejecución paralela si no se cumple la condición. Sólo en construcciones parallel.

- Cláusula schedule(kind OPT[, chunk]) - kind forma de asignación, chunk granularidad de la distribución.

  Sólo bucles, kind por defecto static en la mayor parte de implementaciones. Mejor no asumir una granularidad por defecto.

  - `schedule(static, chunk)` - las unidades se asignan en round robin, las iteraciones se diviten unidades de "chunk" iteraciones. Un único chunk a cada thread.

  - `schedule(dynamic, chunk)` - distribución en tiempo de ejecución, apropiado si se desconoce el tiempo de ejecución de las iteraciones. La unidad de distribución tiene chunk iteraciones. Precaución, añade cierta sobrecarga.

  - `schedule(guided, chunk)` - distribución en tiempo de ejecución, apropiado si se desconoce el el tiempo de ejecución de las iteraciones o su número.

    Comienza con un bloque largo. El tamaño del bloque se va reduciendo (num iteraciones restantes / num threads), no más pequeño que el chunk excepto la última. Precaución, sobrecarga extra, pero menos que dynamic.

  - `schedule(runtime)` -  el tipo de distribución se fija en ejecución. El tipo de depende de la variable de control run-sched-var.

### 5. Clasificación de las funciones de la biblioteca OpenMP

Funciones para acceder al entorno de ejecución de OpenMP:

- Funciones para usar sincronización con cerrojos:
  - V2.5 omp_init_lock(), omp_destroy_lock(), omp_set_lock(), omp_unset_lock(), omp_test_lock() 
  - V3.0: omp_destroy_nest_lock, omp_set_nest_lock, omp_unset_nest_lock, omp_test_nest_lock 
- Funciones para obtener tiempos de ejecución:
  - omp_get_wtime (), omp_get_wtick()

### 6. Funciones para obtener el tiempo de ejecución

Compilar con -lrt para incluir librería real time (no siempre es necesario)

![image-20220615004524572](/home/clara/.config/Typora/typora-user-images/image-20220615004524572.png)



------

## Seminario 4 - Optimización de código en arquitecturas ILP

### 1. Cuestiones generales sobre la optimización

Usualmente la optimización de una aplicación se realiza al final del proceso, si queda tiempo. Esperar al final para optimizar dificulta el proceso de optimización. Es un error programar la aplicación sin tener en cuenta la arquitectura o arquitecturas en las que se va a ejecutar. 

En el caso de que no se satisfagan las restricciones de tiempo, no es correcto optimizar eliminando propiedades y funciones (features) del código. 

Cuando se optimiza código es importante analizar donde se encuentran los cuellos de botella. El cuello de botella más estrecho es el que al final determina las prestaciones y es el que debe evitarse en primer lugar. Se puede optimizar sin tener que acceder al nivel del lenguaje ensamblador (aunque hay situaciones en las que es necesario bajar a nivel de ensamblador).

![image-20220615011031468](/home/clara/.config/Typora/typora-user-images/image-20220615011031468.png)

Un compilador puede ejecutarse utilizando diversas opciones de optimización. Por ejemplo, gcc/g++ dispone de las opciones -O1, - O2, -O3, -Os que proporcionan códigos con distintas opciones de optimización.

### 2. Optimización de la ejecución

#### Unidades de ejecución o funcionales

Es importante tener en cuenta las unidades funcionales de que dispone la microarquitectura para utilizar las instrucciones de la forma más eficaz. 

- La división es una operación costosa y por lo tanto habría que evitarla (con desplazamientos, multiplicaciones, …) o reducir su número.

  ![image-20220615011540104](/home/clara/.config/Typora/typora-user-images/image-20220615011540104.png)

- A veces es más rápido utilizar desplazamientos y sumas para realizar una multiplicación por una constante entera que utilizar la instrucción IMUL.

  ![image-20220615011551042](/home/clara/.config/Typora/typora-user-images/image-20220615011551042.png)

#### Desenrrollado de bucles

Utilizar el desenrollado de bucles para romper secuencias de instrucciones dependientes intercalando otras instrucciones. Ventajas:

- Reduce el número de saltos 
- Aumenta la oportunidad de encontrar instrucciones independientes 
- Facilita la posibilidad de insertar instrucciones para ocultar las latencias. 

La contrapartida es que aumenta el tamaño del código.

![image-20220615011738248](/home/clara/.config/Typora/typora-user-images/image-20220615011738248.png)

#### Código ambiguo

Si el compilador no puede resolver los punteros (código ambiguo) se inhiben ciertas optimizaciones del compilador: 

- Asignar variables durante la compilación 
- Realizar cargas de memoria mientras que un almacenamiento está en marcha 

Si no se utilizan punteros el código es más dependiente de la máquina, y a veces las ventajas de no utilizarlos no compensa. ¿Cómo evitar código ambiguo o sus efectos?: 

- Utilizar variables locales en lugar de punteros 
- Utilizar variables globales si no se pueden utilizar las locales 
- Poner las instrucciones de almacenamiento después o bastante antes de las de carga de memoria.

![image-20220615011857818](/home/clara/.config/Typora/typora-user-images/image-20220615011857818.png)

### 4. Optimización del acceso a memoria

#### Alineamiento de datos

El acceso a un dato que ocupa dos líneas de cache aumenta tiempo de acceso. Tam línea de cache: 32B en Pentium Pro, Pentium II, Pentium III; 64B en Pentium 4, Core …

![image-20220615012202298](/home/clara/.config/Typora/typora-user-images/image-20220615012202298.png)

#### Colisiones en caché

![image-20220615012235819](/home/clara/.config/Typora/typora-user-images/image-20220615012235819.png)

#### Localidad de los accesos

La forma en que se declaren los arrays determina la forma en que se almacenan en memoria. Interesa declararlos según la forma en la que se vaya a realizar el acceso. Ejemplos: Formas óptimas de declaración de variables según el tipo de acceso a los datos:

![image-20220615012301272](/home/clara/.config/Typora/typora-user-images/image-20220615012301272.png)

Intercambiar los bucles para cambiar la forma de acceder a los datos según los almacena el compilador, y para aprovechar la localidad. Ej:

![image-20220615012327690](/home/clara/.config/Typora/typora-user-images/image-20220615012327690.png)

#### Acceso a memoria especulativo

Los 'atascos' (stalls) por acceso a la memoria (load adelanta a store, especulativo) se producen cuando: 

1. Hay una carga (load) 'larga' que sigue a un almacenamiento (store) 'pequeño' alineados en la misma dirección o en rangos de direcciones solapadas. 

   `mov word ptr [ebp],0x10` 

   `mov ecx, dword ptr [ebp]` 

2. Una carga (load) 'pequeña' sigue a un almacenamiento (store) 'largo' en direcciones diferentes aunque solapadas (si están alineadas en la misma dirección no hay problema). 

   `mov dword ptr [ebp-1], eax` 

   `mov ecx,word ptr [ebp]` 

3. Datos del mismo tamaño se almacenan y luego se cargan desde direcciones solapadas que no están alineadas. 

   `mov dword ptr [ebp-1], eax` 

   `mov eax, dword ptr [ebp]`

Para evitarlos: utilizar datos del mismo tamaño y direcciones alineadas y poner los loads tan lejos como sea posible de los stores a la misma área de memoria

#### Precaptación (Prefetch)

El procesador, mediante las correspondientes instrucciones de prefetch, carga zonas de memoria en cache antes de que se soliciten (cuando hay ancho de banda disponible). Hay cuatro tipos de instrucciones de prefetch:

![image-20220615012802547](/home/clara/.config/Typora/typora-user-images/image-20220615012802547.png)

Una instrucción de prefetch carga una línea entera de cache. El aspecto crucial al realizar precaptación es la anticipación con la que se pre-captan los datos. En muchos casos, es necesario aplicar una estrategia de prueba y error. Además, la anticipación óptima puede cambiar según las características del computador (menos portabilidad en el código).

![image-20220615012835628](/home/clara/.config/Typora/typora-user-images/image-20220615012835628.png)

### 5. Optimización de saltos

![image-20220615012544550](/home/clara/.config/Typora/typora-user-images/image-20220615012544550.png)

![image-20220615012556011](/home/clara/.config/Typora/typora-user-images/image-20220615012556011.png)

![image-20220615012608155](/home/clara/.config/Typora/typora-user-images/image-20220615012608155.png)

![image-20220615012614031](/home/clara/.config/Typora/typora-user-images/image-20220615012614031.png)

