## -*- texinfo -*-
## @node analyzeErrorsF
## @deftypefn {Function} {} analyzeErrorsF(path, maxiter, fs)
## PRE: Existen los archivos puntajes_ajuste.csv y puntajes_test.csv en el directorio `path`.
## POST: Genera una única figura con dos gráficos:
## - Error de ajuste para los distintos valores de \(f\).
## - Error de prueba para los distintos valores de \(f\).
## La figura se guarda como .ofig y .png.
## @end deftypefn
function x = analyzeErrorsF(path, maxiter, fs)

    if nargin < 3
        error("Se requieren al menos 3 argumentos: path, maxiter, fs");
    end

    % Inicialización de matrices para almacenar errores
    errorsAjuste = zeros(maxiter, length(fs));
    errorsTest = zeros(maxiter, length(fs));

    % Iterar sobre valores de f
    for i = 1:length(fs)
        f = fs(i);
        fprintf("Calculando para f=%d...\n", f);

        % Llamar a alternatingMinimization con el valor actual de f
        [P, Q, errAjuste, errTest] = alternatingMinimization(path, maxiter, f, 1);

        % Guardar los errores
        errorsAjuste(:, i) = errAjuste;
        errorsTest(:, i) = errTest;
    end

    % Crear figura única con dos subplots
    figure('Visible', 'off');

    % Gráfico 1: Error de ajuste
    subplot(1, 2, 1);

    for i = 1:length(fs)
        plot(1:maxiter, errorsAjuste(:, i), 'DisplayName', sprintf("f=%d", fs(i)), 'LineWidth', 1.5);
        hold on;
    end

    title("Convergencia del Error de Ajuste");
    xlabel("Iteraciones");
    ylabel("ECM");
    legend("show");
    grid on;

    % Gráfico 2: Error de prueba
    subplot(1, 2, 2);

    for i = 1:length(fs)
        plot(1:maxiter, errorsTest(:, i), 'DisplayName', sprintf("f=%d", fs(i)), 'LineWidth', 1.5);
        hold on;
    end

    title("Convergencia del Error de Prueba");
    xlabel("Iteraciones");
    ylabel("ECM");
    legend("show");
    grid on;

    % Guardar la figura
    outputName = "convergencia_errores";
    saveas(gcf, sprintf("%s.ofig", outputName));
    print(sprintf("%s.png", outputName), "-dpng", "-r300");
    close(gcf);

    fprintf("Figura combinada guardada como %s.ofig y %s.png.\n", outputName, outputName);
    x = 1;
end
