clear all;
close all;
clc;

% Definir datasets
X = [1 1 1 1 1 1 1 1;
     -1 -1 -1 -1 1 1 1 1;
     -1 -1 1 1 -1 -1 1 1;
     -1 1 -1 1 -1 1 -1 1];

Yd = [-1 1 1 1 1 1 1 1];

num_entradas = size(X, 1); % Cambiar el número de entradas a 8
num_muestras = length(Yd);

% Definir pesos
W = 0.5 * ones(1, num_entradas);

Yr = zeros(1, num_muestras); % Inicialización del vector de salidas

% Definir variables de iteración
Iter = 0;
umbral = 0;
ciclo = true;
a = 0.1;

while ciclo || Iter < 40 % Cambiar la condición del ciclo
    for i = 1:num_muestras
        % Suma ponderada de todas las entradas
        Suma_pon = sum(W .* X(:, i)');
        
        % Función de activación
        if Suma_pon >= umbral
            Yr(i) = max(Yd);
        else
            Yr(i) = min(Yd);
        end
        
        % Cálculo del error
        error = Yd(i) - Yr(i)
        
        if error ~= 0
            % Corrección de pesos
            % W = corregir_forma1(W, X(:, i)', Yd(i)); % Descomentar y definir si usas forma1
            W = corregir_forma2(W, X(:, i)', Yd(i),Yr(i)); % Descomentar y definir si usas forma2
            % W = corregir_forma3(W, X(:, i)', Yd(i),Yr(i), a); % Descomentar y definir si usas forma3
        end
    end
    
    % Verificación de convergencia
    if Ok==num_muestras
        ciclo = false;
    end
    Iter = Iter + 1;
end
fprintf('Convergencia alcanzada después de %d iteraciones\n', Iter);
disp(W)