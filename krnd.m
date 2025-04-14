function X = krnd(v, scale, m, n)
gamma_samples = gamrnd(v, scale / v, m, n);
X = raylrnd(sqrt(gamma_samples / 2));
end
