clear all;
close all;
clc;

%Deinir dataseets

X = [1 1 1 1;
     -1 -1 1 1;
     -1 1 -1 1;
     ];

% X = [1 1 1 1 1 1 1 1 ;
%      -1 -1 -1 -1 1 1 1 1;
%      -1 -1 1 1 -1 -1 1 1;
%      -1 -1 -1 1 -1 1 -1 1
%      ];

% X = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ;
%      -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1 1 1 1 1 ;
%      -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1 1 1 1 1 ;
%      -1 -1 1 1 -1 -1 1 1 -1 -1 1 1 -1 -1 1 1;
%      1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 
%      ];

 Yd = [-1 -1 -1 1];
%  Yd = [-1 1 1 1 1 1 1 1];
% Yd = [-1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
% Yd = [-1 1 1 1];

num_entradas = 3;
length(X);
% Definir pesos
num_muestras = length(Yd);
 W = rand * ones(1, num_entradas);
 % W = 0.4 * ones(1, num_entradas);
umbral = 0.5;




Yr = zeros(1, length(Yd));% Inicialización del vector de salidas



% Definir variables de iteracion y demás 

Iter = 0;

ciclo = true;
a = 0.1;
weights_history = [];

while ciclo && Iter < 100
    Ok = 0;
    for i = 1:length(Yd)
        % Suma ponderada de todas las entradas
        Suma_pon = sum(W .* X(:, i)');
        
        % Función de activación
        if Suma_pon >= umbral
            Yr(i) = max(Yd);
        else
            Yr(i) = min(Yd);
        end
        
        % Cálculo del error
        error = Yd(i) - Yr(i);
        
        if error ~= 0
            % corrección de pesos
               % W = corregir_forma1(W, X(:, i)', Yd(i));
               W = corregir_forma2(W, X(:, i)', Yd(i),Yr(i));
             % W = corregir_forma3(W, X(:, i)', Yd(i),Yr(i), a);
        else 
            Ok = Ok+1;
        end
    
    end
    weights_history = [weights_history; error];
    
    if Ok == num_muestras
        ciclo = false;
    end
    Iter = Iter + 1;
end

fprintf('Convergencia alcanzada después de %d iteraciones\n', Iter);
disp(W)