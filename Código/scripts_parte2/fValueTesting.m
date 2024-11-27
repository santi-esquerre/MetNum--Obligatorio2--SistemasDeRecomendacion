f = [8, 10, 12, 15, 20];
path = "../data/puntajes_ajuste.csv";
maxiter = 50;

for k = 1:length(f)
    clearvars -except f path maxiter k;
    fprintf('Error para f = %d\n', f(1, k));
    [P, Q] = alternatingMinimization(path, maxiter, f(1, k));
end
