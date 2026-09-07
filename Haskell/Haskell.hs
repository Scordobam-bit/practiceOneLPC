-- 1. DESCOMPOSICIÓN DEL CÓDIGO

numeroConsecutivo :: Int -> Int
numeroConsecutivo codigo = mod codigo 1000

categoriaCodigo :: Int -> Int
categoriaCodigo codigo = mod (div codigo 1000) 100

periodo :: Int -> Int
periodo codigo = div codigo 100000

anioPeriodo :: Int -> Int
anioPeriodo periodo = 2000 + div periodo 10

semestre :: Int -> Int
semestre periodo = mod periodo 10

-- 2. SUMA ALICUA

divisores :: Int -> [Int]
divisores categoriaCodigo = divisoresAux categoriaCodigo 1

divisoresAux :: Int -> Int -> [Int]
divisoresAux categoriaCodigo candidato 
    | candidato == categoriaCodigo = []
    | mod categoriaCodigo candidato == 0 = candidato : divisoresAux categoriaCodigo (candidato + 1)
    | otherwise = divisoresAux categoriaCodigo (candidato +1)

sumaAlicua :: [Int] -> Int
sumaAlicua [] = 0
sumaAlicua (x:xs) = x + sumaAlicua xs

-- 3. CLASIFICACION SUMA ALICUA

clasificar :: Int -> String
clasificar categoriaCodigo 
    | sumaAlicua (divisores categoriaCodigo) > categoriaCodigo = "Administrative"
    | sumaAlicua (divisores categoriaCodigo) == categoriaCodigo = "Engineering"
    | otherwise = "Humanities"

-- 4. EVEN ODD

paridad :: Int -> String
paridad numeroConsecutivo 
    | numeroConsecutivo `mod`  2 == 0 = "even"
    | otherwise = "odd"

-- 5. VALIDACION DE CODIGO 

codigoValido :: Int -> Bool
codigoValido codigo = 
    codigo >= 26200001 &&
    codigo <= 29299999 &&
    ((periodo codigo) `mod` 10 == 1 ||
    (periodo codigo) `mod` 10 == 2) &&
    numeroConsecutivo codigo /= 0

-- 6. IMPRESION

descripcion :: Int -> String 
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

    if entrada == "salir"
        then putStrLn "Programa Terminado."
        else do
            let codigo = read entrada :: Int
            
            if codigoValido codigo
                then putStrLn (descripcion codigo)
                else putStrLn "Código Inválido."

            main

    
    