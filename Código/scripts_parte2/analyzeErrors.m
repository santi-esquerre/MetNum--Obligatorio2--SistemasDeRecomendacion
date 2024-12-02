function x = analyzeErrors(path, maxiter, fs, lambdas)

    outputDir = "./figuras";

    if ~isfolder(outputDir)
        mkdir(outputDir); % Crear el directorio si no existe
    end

    if nargin < 4
        error("Se requieren al menos 4 argumentos: path, maxiter, fs, lambdas");
    end

    % Inicialización de matrices para almacenar errores
    errorsAjuste = zeros(maxiter, length(fs), length(lambdas));
    errorsTest = zeros(maxiter, length(fs), length(lambdas));

    % Iterar sobre valores de f y lambda
    for i = 1:length(fs)

        for j = 1:length(lambdas)
            f = fs(i);
            lambda = lambdas(j);

            % Llamar a alternatingMinimization con parámetros f y lambda
            fprintf("Calculando para f=%d, lambda=%.2f...\n", f, lambda);
            [P, Q, errAjuste, errTest] = tychonoffRegularization(path, maxiter, f, lambda, 1);

            % Guardar los errores
            errorsAjuste(:, i, j) = errAjuste;
            errorsTest(:, i, j) = errTest;
        end

    end

    for j = 1:length(lambdas)
        lambda = lambdas(j);
        figure('Visible', 'off');

        % Graficar errores de ajuste
        subplot(1, 2, 1);

        for i = 1:length(fs)
            plot(1:maxiter, errorsAjuste(:, i, j), 'DisplayName', sprintf("f=%d", fs(i)), 'LineWidth', 1.5);
            hold on;
        end

        title(sprintf("Error de Ajuste (\\lambda=%.2f)", lambda));
        xlabel("Iteraciones");
        ylabel("ECM");
        legend("show");
        grid on;

        % Graficar errores de prueba
        subplot(1, 2, 2);

        for i = 1:length(fs)
            plot(1:maxiter, errorsTest(:, i, j), 'DisplayName', sprintf("f=%d", fs(i)), 'LineWidth', 1.5);
            hold on;
        end

        title(sprintf("Error de Prueba (\\lambda=%.2f)", lambda));
        xlabel("Iteraciones");
        ylabel("ECM");
        legend("show");
        grid on;

        % Guardar la figura
        saveas(gcf, fullfile(outputDir, sprintf("convergencia_lambda%.2f.ofig", lambda)));
        print(fullfile(outputDir, sprintf("convergencia_lambda%.2f.png", lambda)), "-dpng", "-r300");
        close(gcf);
    end

    x = 1;
end
