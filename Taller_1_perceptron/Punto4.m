clear all;
close all;
clc;

% Cargar el dataset de Iris que viene por defecto en MATLAB
load fisheriris
% se carga este archivo que proporciona matlab ya que el de la carpeta no
% pude ejecutarlo

% Asignar las variables de entrada (características) y salida (clase)
X = meas;  % Características: longitud y ancho de sépalo y pétalo
Y = species;  % Etiquetas de clase: Setosa, Versicolor, Virginica

% Convertir las etiquetas de clase a valores numéricos para simplificar
Y_numeric = grp2idx(Y);  

% Dividir en proporciones de entrenamiento y prueba
datasets = {0.6, 0.7, 0.8, 0.9};  % Proporciones de entrenamiento

% Definir valores de alpha a probar
alpha_values = [0.01, 0.05, 0.1, 0.5, 1.0];

% Recorrer diferentes proporciones de entrenamiento
for d = 1:length(datasets)
    train_ratio = datasets{d};
    test_ratio = 1 - train_ratio;
    
    % División de datos en conjuntos de entrenamiento y prueba
    cv = cvpartition(Y_numeric, 'Holdout', test_ratio);
    X_train = X(training(cv), :);
    Y_train = Y_numeric(training(cv));
    X_test = X(test(cv), :);
    Y_test = Y_numeric(test(cv));
    
    fprintf('Proporción de entrenamiento: %.0f-%.0f\n', train_ratio*100, test_ratio*100);
    
    % Probar diferentes modelos
    for alpha = alpha_values
        fprintf('Probando con α = %.2f\n', alpha);
        
        % Modelo 1: Perceptrón Simple
        W = rand * ones(1, size(X_train, 2)); % Inicializar pesos aleatorios
        umbral = 0.5;
        max_iter = 100; % Número máximo de iteraciones
        [W_trained, errors] = train_perceptron(X_train, Y_train, W, umbral, alpha, max_iter);
        
        % Evaluar modelo
        Y_pred = predict_perceptron(X_test, W_trained, umbral);
        accuracy = mean(Y_pred == Y_test);
        fprintf('Perceptrón - Precisión: %.2f%%\n', accuracy * 100);
        
        % (Agregar otros modelos de la misma forma)
        % Modelo 2: Regresión Logística, Modelo 3: SVM, etc.
    end
end

% Función para entrenar un perceptrón simple
function [W, errors] = train_perceptron(X, Y, W, umbral, alpha, max_iter)
    errors = [];
    for iter = 1:max_iter
        error_count = 0;
        for i = 1:size(X, 1)
            Y_pred = sum(W .* X(i, :)) >= umbral;
            error = Y(i) - Y_pred;
            if error ~= 0
                W = W + alpha * error * X(i, :);
                error_count = error_count + 1;
            end
        end
        errors = [errors, error_count];
        if error_count == 0
            break;
        end
    end
end

% Función para predecir usando el perceptrón entrenado
function Y_pred = predict_perceptron(X, W, umbral)
    Y_pred = sum(X * W', 2) >= umbral;
end
