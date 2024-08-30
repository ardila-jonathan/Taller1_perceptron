%% Cargar y Preparar el Dataset de Billetes
% Asegúrate de tener el archivo 'data_banknote_authentication.txt' en el directorio de trabajo
data = readtable('data_banknote_authentication.txt');

% Asumiendo que las columnas son: Variance, Skewness, Curtosis, Entropy, y Class (etiqueta)
X = data{:, 1:end-1};  % Características de entrada
Y = data{:, end};  % Etiquetas de clase

%% Definir proporciones de entrenamiento y prueba
ratios = [0.6, 0.7, 0.8, 0.9];  % 60-40, 70-30, 80-20, 90-10

% Iterar sobre las proporciones de entrenamiento
for i = 1:length(ratios)
    train_ratio = ratios(i);
    test_ratio = 1 - train_ratio;
    
    % División de datos en conjuntos de entrenamiento y prueba
    cv = cvpartition(size(X, 1), 'HoldOut', test_ratio);  % Mantener test_ratio para conjunto de prueba
    X_train = X(training(cv), :);
    Y_train = Y(training(cv));
    X_test = X(test(cv), :);
    Y_test = Y(test(cv));
    
    % Guardar los datasets generados en archivos .mat
    train_file = sprintf('banknote_train_%d.mat', train_ratio*100);
    test_file = sprintf('banknote_test_%d.mat', test_ratio*100);
    save(train_file, 'X_train', 'Y_train');
    save(test_file, 'X_test', 'Y_test');
    
    fprintf('Datasets generados y guardados para proporción %d-%d.\n', train_ratio*100, test_ratio*100);
end

% codigo generaado por chatgpt