function W_corr = corregir_forma1(W, X, Yd)
    W_corr = W + Yd * X;
end