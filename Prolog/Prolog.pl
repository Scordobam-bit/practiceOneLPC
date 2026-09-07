% Samuel Córdoba & Camilo Gómez
% Hechos

% Reglas
is_divisor(Number, Divisor) :-
    Divisor < Number,                   % Verifica que el divisor sea menor que el número
    0 is Number mod Divisor.            % Comprueba que la división sea exacta (residuo cero)

code_id(Number, Sum) :-
    findall(Divisor, (between(1, Number, Divisor), is_divisor(Number, Divisor)), Divisors), % Genera y almacena todos los divisores exactos
    sum_list(Divisors, Sum).            % Suma los divisores obtenidos

category(CategoryNumber, administrative) :-
    code_id(CategoryNumber, Sum),       % Calcula la suma de divisores del número de categoría
    Sum > CategoryNumber.               % Clasifica como abundante si la suma es mayor

category(CategoryNumber, engineering) :-
    code_id(CategoryNumber, Sum),       % Calcula la suma de divisores del número de categoría
    Sum =:= CategoryNumber.             % Clasifica como perfecto si la suma es igual

category(CategoryNumber, humanities) :-
    code_id(CategoryNumber, Sum),       % Calcula la suma de divisores del número de categoría
    Sum < CategoryNumber.               % Clasifica como deficiente si la suma es menor

parity(Number, even) :-
    0 is Number mod 2.                  % Determina si el número es par

parity(Number, odd) :-
    1 is Number mod 2.                  % Determina si el número es impar

student_id(Code, Output) :-
    Code >= 26201001,                   % Valida el límite inferior del código de estudiante
    Code =< 29299999,                   % Valida el límite superior del código de estudiante
    PeriodCode is Code // 100000,       % Extrae los dígitos correspondientes al periodo
    PeriodCode >= 262,                  % Valida que el periodo inicial sea correcto
    PeriodCode =< 292,                  % Valida que el periodo final sea correcto
    PeriodCode mod 10 >= 1,             % Valida el número de semestre mínimo
    PeriodCode mod 10 =< 2,             % Valida el número de semestre máximo
    CategoryNumber is (Code // 1000) mod 100, % Extrae los dígitos de la categoría
    CategoryNumber >= 1,                % Valida el valor mínimo de la categoría
    CategoryNumber =< 99,               % Valida el valor máximo de la categoría
    ConsecutiveNumber is Code mod 1000, % Extrae el número consecutivo de admisión
    ConsecutiveNumber >= 1,             % Valida el consecutivo mínimo
    ConsecutiveNumber =< 999,           % Valida el consecutivo máximo
    Year is 2000 + (PeriodCode // 10),  % Calcula el año académico a partir del periodo
    Semester is PeriodCode mod 10,      % Obtiene el semestre académico
    category(CategoryNumber, Category), % Obtiene la categoría académica según los divisores
    parity(Code, Parity),               % Obtiene la paridad del código completo
    format(string(Output), "~w-~w ~w num~w ~w", [Year, Semester, Category, ConsecutiveNumber, Parity]). % Formatea la salida final

% Construcción de la función principal
main :-
    process,                            % Ejecuta la rutina secundaria
    halt.                               % Finaliza la ejecución del programa

% Construcción de un proceso secundario
process :-
    student_id(26276002, Output1),      % Procesa el primer código de prueba
    write(Output1), nl,                 % Imprime el resultado y salta de línea
    student_id(27128112, Output2),      % Procesa el segundo código de prueba
    write(Output2), nl,                 % Imprime el resultado y salta de línea
    student_id(27206025, Output3),      % Procesa el tercer código de prueba
    write(Output3), nl,                 % Imprime el resultado y salta de línea
    student_id(28124236, Output4),      % Procesa el cuarto código de prueba
    write(Output4), nl,                 % Imprime el resultado y salta de línea
    student_id(28299115, Output5),      % Procesa el quinto código de prueba
    write(Output5), nl.                 % Imprime el resultado y salta de línea

% Ejecución de la funcion principal
:- main.                               % Dispara la ejecución del programa