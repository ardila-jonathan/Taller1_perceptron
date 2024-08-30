function W_corr = corregir_forma2(W, X, Yd, Yr)
    W_corr = W + (Yd - Yr) * X;
end