%% ARCHIVO EJEMPLO DE MUESTREO DE DATASET 
% En este script se muestra el procedimiento para conseguir la división del 
% dataset en los grupos de entrenamiento y test. Para ello se va a utilizar la 
% base de datos Iris, es una de las base de datos más conocida que se encuentran 
% en la literatura de reconocimiento de patrones. 
% 
% Esta base de datos, recolectada durante varios años por Edgar Anderson fue 
% utilizada para demostrar que estas medidas podrían utilizarse para diferenciar 
% entre especies de plantas iris. Contiene 3 clases de 50 casos cada una, donde 
% cada clase se refiere a un tipo de planta iris.
% 
% Una clase es linealmente separable de los otras 2; estas últimas no son linealmente 
% separables entre sí.
% 
% Los atributos son:
%% 
% # Longitud del sépalo en cm (Sepal.Length)
% # Ancho del sépalo en cm (Sepal.Width)
% # Longitud del pépalo en cm (Petal.Length)
% # Ancho del pépalo en cm (Pepal.Width)
% # Clase (Species):
%% 
% * Iris Setosa
% * Iris Versicolour
% * Iris Virginica
%% 
% 

clear all
close all
clc

load iris.dat
No_examples=length(iris)
%% 
% Se establece aleatoriamente a partir de la semilla el orden de los 150 datos. 
% Con esto se mezcla el dataset para obtener fácilmente una muestra aleatorio 
% del mismo que contenga todas las clases.

rng(2021)
ind=randperm(No_examples);
%% *DIVISIÓN DE LOS DATOS DE ENTRENAMIENTO Y TEST (60-40)*
% Inicialmente se calulan el número de muestras de entrenamiento y test.

No_examples_train60=0.6*No_examples
No_examples_test40=0.4*No_examples
%% 
% *Creación del Dataset de entrenamiento (60% del Dataset total)*

iris_train60=iris(ind(1:No_examples_train60),:)
%% 
% *Creación del Dataset de Test  (40% del Dataset total)*

iris_test40=iris(ind(No_examples_train60+1:end),1:4)
iris_testclass40=iris(ind(No_examples_train60+1:end),5)
%% *DIVISIÓN DE LOS DATOS DE ENTRENAMIENTO Y TEST (70-30)*
% Inicialmente se calulan el número de muestras de entrenamiento y test.

No_examples_train70=0.7*No_examples
No_examples_test30=0.3*No_examples
%% 
% *Creación del Dataset de entrenamiento (70% del Dataset total)*

iris_train70=iris(ind(1:No_examples_train70),:)
%% 
% *Creación del Dataset de Test  (30% del Dataset total)*

iris_test30=iris(ind(No_examples_train70+1:end),:)
%% *DIVISIÓN DE LOS DATOS DE ENTRENAMIENTO Y TEST (80-20)*
% Inicialmente se calulan el número de muestras de entrenamiento y test.

No_examples_train80=0.8*No_examples
No_examples_test20=0.2*No_examples
%% 
% *Creación del Dataset de entrenamiento (80% del Dataset total)*

iris_train80=iris(ind(1:No_examples_train80),:)
%% 
% *Creación del Dataset de Test  (20% del Dataset total)*

iris_test20=iris(ind(No_examples_train80+1:end),:)
%% *DIVISIÓN DE LOS DATOS DE ENTRENAMIENTO Y TEST (90-10)*
% Inicialmente se calculan el número de muestras de entrenamiento y test.

No_examples_train90=0.9*No_examples
No_examples_test10=0.1*No_examples
%% 
% *Creación del Dataset de entrenamiento (90% del Dataset total)*

iris_train90=iris(ind(1:No_examples_train90),:)
%% 
% *Creación del Dataset de Test  (10% del Dataset total)*

iris_test10=iris(ind(No_examples_train90+1:end),:)