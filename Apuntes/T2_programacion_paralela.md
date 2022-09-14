# AC 21/22 - Tema 2: Programación paralela

## 1. Introducción

En este capítulo abordaremos los siguientes temas relacionados con la programación paralela:

1. Las herramientas existentes para escribir código paralelo y el trabajo extra que implica para las herramientas y el programador la paralelización
2. Las estructuras típicas de flujos de instr en códigos paralelos
3. Cómo evaluar las prestaciones del código paralelo implementado y qué prestaciones se pueden esperar



## 2. Herramientas de programación paralela

### 2.1. Trabajo a realizar por las herramientas de programación paralela o por el programador

La programación paralela requiere que la herramienta de programación utilizada, el programador o ambos realicen el siguiente trabajo, no requerido en la programación secuencial:

- **Localización del paralelismo implícito** en una aplicación, es decir, descomponer la aplicación en unidades de cómputo independientes, o **tareas**. 

  Es recomendable terminar la descomposición con un grafo dirigido en el que los vértices sean tareas y los arcos dependencias entre ellas. Nos permitirá ver fácilmente el número máximo de tareas que se pueden ejecutar en paralelo, o **grado de paralelismo** (número de flujos de instr o procesadores máximo necesario para la paralelización).

- **Asignación de las tareas o carga de trabajo** a flujos de instrucciones, y asignación de flujos de instr a procesadores. No suele ser rentable usar más flujos que procesadores. Los flujos pueden estar asociados a los procesadores previa asignación. La asignación puede ser:

  - Estática o dinámica

    - Con una asignación estática el reparto de tareas es siempre el mismo; mientras que con la dinámica el reparto puede variar y solo se conoce al final de la ejecución.

      La asignación dinámica implica código extra y sincronización/comunicación entre hebras, lo cual introduce retardos adicionales. Pero es la única opción cuando no conocemos el número de tareas previamente.

  - Implícita (herramienta) o explícita (programador)

- **Comunicación/sincronización** entre los flujos de instr. Los flujos tienen que colaborar, enviarse los resultados que producen... 

![image-20220611115212949](/home/clara/.config/Typora/typora-user-images/image-20220611115212949.png)

Las herramientas permiten, de forma implícita (lo hace la herramienta) o explícita (lo hace el programador), las siguientes **LABORES**:

1. Localizar/Detectar paralelismo, o sea, descomponer la aplicación en tareas independientes (*decomposition*).
2. Asignar las tareas, la carga de trabajo (instr+datos) a flujos (*scheduling*).
3. Crear y terminar flujos de instr, o enrolar y desenrolar en un grupo flujos previamente creados.
4. Comunicar/Sincronizar flujos de instr.
5. Asignar flujos de instr a unidades de procesamiento (*mapping*).

La última labor la puede hacer el SO o el hardware, depende del sistema



### 2.2. Nivel de abstracción en que sitúan al programador las herramientas

Cuanto mayor sea el nivel de abstracción, menos labores de las enunciadas anteriormente dependerán del programador. Hay herramientas que permiten escoger el nivel de abstracción. La labor más difícil para la herramienta es la primera, localizar el paralelismo. Cuantas más labores haga el programador, mayores prestaciones se pueden llegar a conseguir si el programador conoce la arquitectura del sistema de cómputo.

Las herramientas de paralelismo se pueden clasificar según su nivel de abstracción, de menos a más:

- **Compiladores paralelos:**  Ej. compiladores de Intel. Generan código paralelo a partir de código secuencial. El programador sólo tiene que implementar el código secuencial, no realiza ninguna de las labores previas.
- **Lenguajes paralelos y APIs de funciones y directivas:** en este nivel, el programador debe al menos detectar el paralelismo (labor 1). El programador no hace el reparto (labor 2), y pueden librar al programador de asignar flujos a procesadores (labor 5), saber como se crean/terminan flujos (labor 3) o detalles de comunicación y sincronización (labor 4).
  - Lenguajes paralelos, como Occam, Ada, Java; tienen construcciones específicas y bibliotecas de funciones. Requieren un compilador exclusivo.
  - APIs de func y directivas, como OpenMP, OpenACC; constan de directivas y una biblioteca de funciones que se añaden a un compilador de un lenguaje secuencial normal, como C/C++ o Fortran.
- **APIs de funciones:** Ej. pthreads, MPI. Consisten en una biblioteca de funciones que se añaden a un compilador de lenguaje secuencial. El programador debe hacer explícitamente la asignación de tareas (labor 1), y participar en todas las labores menos, probablemente, la última.
- **Lenguajes paralelos para arquitecturas de propósito específico:** ej. CUDA. Consisten en construcciones de lenguaje y bibliotecas de funciones. Requieren un compilador exclusivo. El programador debe particiapar en todas las labores excepto, probablemente, la última; y debe tener concimientos mayores sobre la arquitectura de destino para poder escribir el código paralelo.



### 2.3. Estilos de programación paralela

Cada herramienta ofrece al programador un modelo de programación particular. Las arquitecturas paralelas se caracterizan por el estilo de prog más cercano a su implementación hardware: paso de msjs para multicomputadores (Ej. MPI); variables compartidas para multiprocesadores y núcleos multithread (Ej. OpenMP); y paralelismo de datos para procesadores que ejecutan una instr en paralelo en múltiples unidades de procesamiento (SIMD, Single Instr Multiple Data) (Ej. HPF). Teniendo eso en cuenta, es fácil ver qué caracteriza a cada uno de estos modelos de programación:

- **Paso de mensajes:** el programador debe tener en cuenta que los flujos de instr no comparten memoria, cada uno de ellos tiene su espacio de direcciones en particular. La herramienta debe ofrecer medios para copiar datos de un espacio de direcciones a otro
- **Variables compartidas:** como los flujos comparten memoria, la información puede pasarse a través de variables. La herramienta debe ofrecer (si no lo hace ya implícitamente) medios para sincronizar los flujos con el fin de que las comunicaciones a través de variables no tengan problemas: la sincronización debe conseguir que el consumidor de un dato lo lea después de que el productor lo escriba en la variable compartida, no antes.
- **Paralelismo de datos:** el programador debe tener en cuenta que todos los flujos de datos ejecutan a la vez la misma instr con datos distintos.



### 2.4. Comunicación/Sincronización en herramientas de programación paralela

Las herramientas de comunicación implementan comunicación uno-a-uno, es decir, envío de datos desde un emisor hasta un receptor. También pueden ofrecer comunicaciones colectivas de distinto tipo, que evitan tener que implementar estas comunicaciones con múltiples envíos uno-a-uno.

Las comunicaciones colectivas se pueden clasificar así:

- **Comm uno-a-todos:** uno envía y todos reciben (el que envía puede estar incluido con los que reciben). Difusión o dispersión (*Broadcast, Scatter*).
- **Comm todos-a-uno:** todos envían y uno recibe (el que recibe puede estar incluido con los que envían). Acumulación o reducción (*Gather, Reduction*).
- **Comm todos-a-todos:** todos difunden (*all-broadcast*), todos dispersan (*all-scatter*)
- **Comm múltiples uno-a-uno:** permutaciones (rotación, barajar...), todos los flujos envían a uno y todos reciben de uno, desplazamientos...
- **Comm colectivas compuestas de varias de las anteriores:**
  - Todos combinan (*all reduction*)
  - Recorrido (*scan*)
  - Barreras (*barrier*)
    - Punto en el código en el que todos los flujos se esperan entre sí. Cuando todos llegan a la barrera, continuan a la vez con la ejecución. Se compone de una reducción y una difusión.

![image-20220612102129298](/home/clara/.config/Typora/typora-user-images/image-20220612102129298.png)

## 3. Estructuras de procesoso o tareas en códigos paralelos

Analizando la estructura o grafo de las tareas y de los flujos de instr de los códigos paralelos, podemos ver ciertos patrones que se repiten. En un programa paralelo puede haber varias estructuras. Las estructuras más comunes son:

- **Descomposición del dominio y Maestro-Esclavo:** el trabajo a realizar por cada proceso se determina dividiendo las estructuras de datos de entrada o las de salida en trozos, tantos como flujos (descomposición del dominio), y luego cada flujo  gestiona sus tareas y reporta el resultado a una hebra master.

  - Si el flujo se divide en entradas, el trabajo a asignar al flujo i será el que utilice las entradas del flujo i.
  - Si el flujo se divide en salidas, el trabajo a asignar al flujo i será el que genere las salidas del trozo i.

  ![image-20220612104023287](/home/clara/.config/Typora/typora-user-images/image-20220612104023287.png)

- **Cauce segmentado (*pipeline*):** se utiliza cuando se aplica a un flujo de datos de entrada la misma secuencia de instrucciones, una detrás de otra, como una cadena de montaje.

- **Divide y vencerás:** se usa cuando el problema a resolver se puede dividir en subtareas que son instancias más pequeñas del problema original, de forma que combinando los resultados de las subtareas se resuelve el problema original. Las subtareas también se pueden dividir en subtareas, dando lugar a una estructura en forma de árbol. 

  ![image-20220612104030193](/home/clara/.config/Typora/typora-user-images/image-20220612104030193.png)



## 4. Evaluación de prestaciones

Tras escribir un código paralelo, hay que comprobar que se cumplen los requisitos de tiempo. Para evaluar las prestaciones del código, se evalua su tiempo de respuesta (desde el inicio de ejecución hasta obtener los resultados).

Un estudio de escalabilidad analiza en qué medida aumentan las prestaciones del código conforme aumenta el número de procesadores. La ganancia en prestaciones (o ganancia en velocidad) se calcula:

> S(num procesadores) = Prestaciones(num procesadores) / Prestaciones(1 procesador) 
>
> S(num procesadores) = tiempo ej. secuencial/ tiempo ej. paralelo con p procesadores = Ts / Tp(1)

El tiempo de ejecución en paralelo se calcula:

> Tp(p, tam problema n) = Tiempo calculo paralelo(p, n) + Tiempo de sobrecarga/overhead (p, n)

![image-20220612111747739](/home/clara/.config/Typora/typora-user-images/image-20220612111747739.png)

En el mejor caso se esperaría obtener un tiempo de ejecución del tiempo secuencial, dividido entre el número de procesadores. Para llegar a este tiempo, se debe...

1. Poder repartir todo el código entre los procesadores disponibles, sea cual sea este número (paralelismo ilimitado)
2. Hacer el reparto asignando a cada procesador la misma cantidad de trabajo (carga equilibrada)
3. No añadir sobrecarga

La escalabilidad en tal caso sería lineal (en rojo en la figura anterior). En la práctica, la curva de escalabilidad no será una línea recta, pero puede acercarse para un rango de p. Por lo general, la ganancia está debajo de la ideal por...

1. Una fracción f no es paralelizable
2. El reparto de trabajo no está equilibrado
3. Existe sobrecarga no despreciable

La ganancia además deja de crecer a partir de un cierto número de p (en verde en la figura), de hecho si añadimos demasiados podemos generar mucha sobrecarga y afectar negativamente al rendimiento (azul en la figura). 

Pero incluso si el grado de paralelismo es ilimitado y la sobrecarga no existe, **la ganancia está limitada** (caso b, segunda fila de la tabla), porque la limita la fracción no paralelizable f, que se mantendrá siempre constante. El tiempo de ejecución nunca podrá ser menor que el tiempo de ejecución secuencial de ese fragmento no paralelizable.

> 1/fracción no paralelizable = tiempo secuencial / (f no paral. * tiempo secuencial)

La ley de Amdahl (fórmula en la segunda fila de la tabla) dice que la ganancia de prestaciones que se puede conseguir aplicando paralelismo está limitada por la fracción no paralelizable del mismo. Ahmdal da una visión pesimista (la ganancia es limitada) porque no creía en la viabilidad del paralelismo masivo pero, en la práctica, la fracción de codigo secuencial no paralelizable **se puede reducir si aumenta mucho el tamaño del problema** - Aumentando el tamaño se mejora la calidad de los resultados. Esto nos lleva a pensar que la paralelización de un código puede tener dos objetivos:

- Disminuir el tiempo de ejecución (nuestro enfoque hasta ahora)
- Aumentar el tamaño del problema a resolver para mejorar la calidad del resultado

Si el objetivo al aumentar p es mejorar la calidad de los resultados mediante aumento de tamaño y no el tiempo, se puede obtener una ganancia de prestaciones que **no está limitada** y depende linealmente de p:

> S(p) = Ts / Tp = (f · Tp + p · (1-f) · Tp) / Tp = f + p·(1-f) = Ts / (f * Ts + ( ((1+f)*Ts) / p  ) )

Esta expresión es la **ganancia estable**, de Gustafson. Mientras que Amdahl asume que el Ts se mantendrá constante aun si incrementamos la p, concluyendo pues que la ganancia está limitada por la f, Gustafson mantiene cte el Tp y muestra que la ganancia puede crecer con pendiente constante relativa al número de procesadores p.

Para evaluar en qué medida se aproximan [las prestaciones que ofrece una máquina para un programa paralelo] a las [prestaciones máximas que idealmente ofrecería esa máquina, según su num de procesadores], se usa la siguiente expresión de **eficiencia**:

> E(p) = prestaciones(p, n) / (p * prestaciones(1, n)) = S(p) / p
>
> > S(p) = tiempo ej. secuencial/ tiempo ej. paralelo con p procesadores = Ts / Tp(p)