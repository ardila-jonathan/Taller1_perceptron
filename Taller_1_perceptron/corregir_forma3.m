function W_corr = corregir_forma3(W, X, Yd, Yr, a)
    W_corr = W + a * (Yd - Yr) * X;
end