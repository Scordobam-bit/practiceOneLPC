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

--codigoValido :: Int -> Bool
--codigoValido codigo = 
  --  codigo >= 10000000 && codigo <= 99999999

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
    putStrLn "Ingrese un código:"
    entrada <- getLine
    let codigo = read entrada :: Int
    putStrLn (descripcion codigo)