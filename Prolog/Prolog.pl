% Samuel Cordoba & Camilo Gomez
% Hechos

% Reglas
is_divisor(Number, Divisor) :-
    Divisor < Number,                   % Verifica que el divisor sea menor que el numero
    0 is Number mod Divisor.            % Comprueba que la division sea exacta (residuo cero)

code_id(Number, Sum) :-
    findall(Divisor, (between(1, Number, Divisor), is_divisor(Number, Divisor)), Divisors), % Genera y almacena todos los divisores exactos
    sum_list(Divisors, Sum).            % Suma los divisores obtenidos

category(CategoryNumber, administrative) :-
    code_id(CategoryNumber, Sum),       % Calcula la suma de divisores del numero de categoria
    Sum > CategoryNumber, !.            % Clasifica como abundante si la suma es mayor

category(CategoryNumber, engineering) :-
    code_id(CategoryNumber, Sum),       % Calcula la suma de divisores del numero de categoria
    Sum =:= CategoryNumber, !.          % Clasifica como perfecto si la suma es igual

category(CategoryNumber, humanities) :-
    code_id(CategoryNumber, Sum),       % Calcula la suma de divisores del numero de categoria
    Sum < CategoryNumber, !.            % Clasifica como deficiente si la suma es menor

parity(Number, even) :-
    0 is Number mod 2.                  % Determina si el numero es par

parity(Number, odd) :-
    1 is Number mod 2.                  % Determina si el numero es impar

student_id(Code, Output) :-
    Code >= 26200001,                   % Valida el limite inferior del codigo de estudiante
    Code =< 29299999,                   % Valida el limite superior del codigo de estudiante
    PeriodCode is Code // 100000,       % Extrae los digitos correspondientes al periodo
    PeriodCode >= 262,                  % Valida que el periodo inicial sea correcto
    PeriodCode =< 292,                  % Valida que el periodo final sea correcto
    PeriodCode mod 10 >= 1,             % Valida el numero de semestre minimo
    PeriodCode mod 10 =< 2,             % Valida el numero de semestre maximo
    CategoryNumber is (Code // 1000) mod 100, % Extrae los digitos de la categoria
    CategoryNumber >= 1,                % Valida el valor minimo de la categoria
    CategoryNumber =< 99,               % Valida el valor maximo de la categoria
    ConsecutiveNumber is Code mod 1000, % Extrae el numero consecutivo de admision
    ConsecutiveNumber >= 1,             % Valida el consecutivo minimo
    ConsecutiveNumber =< 999,           % Valida el consecutivo maximo
    Year is 2000 + (PeriodCode // 10),  % Calcula el año académico a partir del periodo
    Semester is PeriodCode mod 10,      % Obtiene el semestre académico
    category(CategoryNumber, Category), % Obtiene la categoria académica segun los divisores
    parity(ConsecutiveNumber, Parity),   % Obtiene la paridad segun el numero consecutivo
    format(string(Output), "~w-~w ~w num~w ~w", [Year, Semester, Category, ConsecutiveNumber, Parity]). % Formatea la salida final

% Construccion de la funcion principal
main :-
    process.                            % Ejecuta la rutina secundaria

% Construccion de un proceso secundario
process :-
    write("Ingrese el codigo o escriba 'salir':"), nl, % Solicita la entrada al usuario
    read_line_to_string(user_input, Input),            % Lee la entrada como cadena
    (   Input == "salir" ->                            % Condicional para salir del bucle
        write("Programa Terminado."), nl,
        halt
    ;   number_string(Code, Input),                    % Convierte la cadena a numero
        student_id(Code, Output) ->                    % Analiza el codigo ingresado
        write(Output), nl,
        process
    ;   write("Codigo Invalido."), nl,                  % Maneja codigos invalidos
        process
    ).

% Ejecucion de la funcion principal
:- main.                               % Dispara la ejecucion del programa
