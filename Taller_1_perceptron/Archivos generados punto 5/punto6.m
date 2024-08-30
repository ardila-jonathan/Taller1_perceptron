clear all;
close all;
clc;

% Definir proporciones de entrenamiento y prueba
ratios = [60, 70, 80, 90];  % Representan 60-40, 70-30, 80-20, 90-10

% Definir valores de alpha a probar
alpha_values = [0.01, 0.05, 0.1, 0.5, 1.0];

% Definir nombres de modelos a probar
modelos = {'Perceptrón', 'Regresión Logística', 'SVM'};

% Recorrer diferentes proporciones de entrenamiento
for r = 1:length(ratios)
    train_ratio = ratios(r);
    test_ratio = 100 - train_ratio;
    
    % Cargar conjuntos de datos generados
    train_file = sprintf('banknote_train_%d.mat', train_ratio);
    test_file = sprintf('banknote_test_%d.mat', test_ratio);
    load(train_file, 'X_train', 'Y_train');
    load(test_file, 'X_test', 'Y_test');
    
    fprintf('Proporción de entrenamiento: %d-%d\n', train_ratio, test_ratio);
    
    % Probar diferentes modelos
    for alpha = alpha_values
        fprintf('Probando con α = %.2f\n', alpha);
        
        for m = 1:length(modelos)
            modelo = modelos{m};
            fprintf('Modelo: %s\n', modelo);
            
            switch modelo
                case 'Perceptrón'
                    % Inicializar pesos aleatorios
                    W = rand * ones(1, size(X_train, 2));
                    umbral = 0.5;
                    max_iter = 100; % Número máximo de iteraciones
                    [W_trained, errors] = train_perceptron(X_train, Y_train, W, umbral, alpha, max_iter);
                    
                    % Evaluar modelo
                    Y_pred = predict_perceptron(X_test, W_trained, umbral);
                    
                case 'Regresión Logística'
                    % Ajustar modelo de regresión logística
                    B = mnrfit(X_train, categorical(Y_train));
                    Y_pred = mnrval(B, X_test);
                    [~, Y_pred] = max(Y_pred, [], 2);
                    
                case 'SVM'
                    % Ajustar modelo SVM con valor de 'BoxConstraint' basado en alpha
                    SVMModel = fitcsvm(X_train, Y_train, 'KernelFunction', 'linear', 'BoxConstraint', alpha);
                    Y_pred = predict(SVMModel, X_test);
                    
                otherwise
                    error('Modelo no reconocido.');
            end
            
            % Calcular precisión
            accuracy = mean(Y_pred == Y_test);
            fprintf('%s - Precisión con α = %.2f: %.2f%%\n', modelo, alpha, accuracy * 100);
        end
    end
end

% código anterior generado por chatGpt

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
