# 1. Definir el archivo
archivo <- "ECGPCG0003.dat"  # Asegúrate de que el archivo esté en tu directorio de trabajo

# 2. Leer los datos binarios del archivo
# Sabemos que cada muestra es un integer de 16 bits (2 bytes), y tenemos 240,000 muestras en total

datos_binarios <- readBin(archivo, what = "integer", n = 240000*2, size = 2, endian = "little")
head(datos_binarios)

ecg <- datos_binarios[seq(1, length(datos_binarios), by = 2)]

fs <- 8000

time <- seq(0, (length(ecg)-1)) / fs

plot(time, ecg, type = "l", main="Señal ECG")


