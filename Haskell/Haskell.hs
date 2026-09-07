-- Camilo Gómez & Samuel Córdoba
-- 1. DESCOMPOSICIÓN DEL CÓDIGO

numeroConsecutivo :: Int -> Int --Descomposición de los últimos 3 dígitos
numeroConsecutivo codigo = mod codigo 1000

categoriaCodigo :: Int -> Int --Descomposición de los números que determinan la categoría
categoriaCodigo codigo = mod (div codigo 1000) 100

periodo :: Int -> Int --Descomposición de los primeros 3 dígitos
periodo codigo = div codigo 100000

anioPeriodo :: Int -> Int --A partir de lo 3 digitos anteriores, se determina el año
anioPeriodo periodo = 2000 + div periodo 10

semestre :: Int -> Int --A partir de los 3 digitos anteriores se determina el semestre
semestre periodo = mod periodo 10

-- 2. SUMA ALICUA

divisores :: Int -> [Int] --Obtención de los divisores 
divisores categoriaCodigo = divisoresAux categoriaCodigo 1

divisoresAux :: Int -> Int -> [Int] --Función auxiliar para obtener los divisores
divisoresAux categoriaCodigo candidato 
    | candidato == categoriaCodigo = []
    | mod categoriaCodigo candidato == 0 = candidato : divisoresAux categoriaCodigo (candidato + 1)
    | otherwise = divisoresAux categoriaCodigo (candidato + 1)

sumaAlicua :: [Int] -> Int --Suma de los divisores anteriormente encontrados
sumaAlicua [] = 0
sumaAlicua (x:xs) = x + sumaAlicua xs

-- 3. CLASIFICACION SUMA ALICUA

clasificar :: Int -> String --A partir de la suma alicua se obtienen las categorías 
clasificar categoriaCodigo 
    | sumaAlicua (divisores categoriaCodigo) > categoriaCodigo = "Administrative"
    | sumaAlicua (divisores categoriaCodigo) == categoriaCodigo = "Engineering"
    | otherwise = "Humanities" 

-- 4. EVEN ODD

paridad :: Int -> String --Se calcula la paridad del código
paridad numeroConsecutivo 
    | numeroConsecutivo `mod`  2 == 0 = "even"
    | otherwise = "odd"

-- 5. VALIDACION DE CODIGO 

codigoValido :: Int -> Bool --Se valida que el código sea válido para el análisis
codigoValido codigo = 
    codigo >= 26200001 &&
    codigo <= 29299999 &&
    ((periodo codigo) `mod` 10 == 1 ||
    (periodo codigo) `mod` 10 == 2) &&
    numeroConsecutivo codigo /= 0

-- 6. IMPRESION

descripcion :: Int -> String --Construccion final del análisis
descripcion codigo = show (anioPeriodo (periodo codigo))
    ++ "-" ++
    show (semestre (periodo codigo))
    ++ " " ++ 
    clasificar (categoriaCodigo codigo)
    ++ " num" ++ show (numeroConsecutivo codigo)
    ++ " " ++ (paridad (numeroConsecutivo codigo)) 


-- 7. MAIN

main :: IO ()
main = do
    putStrLn "Ingrese el código o escriba 'salir':"
    entrada <- getLine

    if entrada == "salir" --Bucle infinito hasta que se escriba "salir" para mayor practicidad
        then putStrLn "Programa Terminado."
        else do
            let codigo = read entrada :: Int
            
            if codigoValido codigo --Impresion del análisis dependiendo si el código es válido o no
                then putStrLn (descripcion codigo)
                else putStrLn "Código Inválido."

            main --Bucle del programa

    
    