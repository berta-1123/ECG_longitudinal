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

#################################

library(pracma)
library(ggplot2)
altura_mggplot2altura_min <- 0.5
dist_min <- fs/2
picos <- findpeaks (ecg, nups = 1, ndowns = 1, minpeakheight = altura_min, minpeakdistance = dist_min)
posiciones <- picos[,2]
amplitudes <- ecg[posiciones]

df_ecg <- data.frame(Tiempo = (1:length(ecg)) / fs, 
                     Amplitud = ecg)

# Crear un dataframe con los picos R
df_picos <- data.frame(Tiempo = posiciones / fs, 
                       Amplitud = amplitudes)

# Graficar la señal ECG con ggplot2
ggplot() +
  geom_line(data = df_ecg, aes(x = Tiempo, y = Amplitud), color = "blue") +  # Señal ECG
  geom_point(data = df_picos, aes(x = Tiempo, y = Amplitud), color = "red", size = 2) +  # Picos R
  labs(title = "Detección de picos R en la señal ECG",
       x = "Tiempo (s)", y = "Amplitud (mV)") +
  theme_minimal()
