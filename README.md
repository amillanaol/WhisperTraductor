# WhisperTranslator

Herramienta desarrollada en PowerShell que permite escanear un directorio con archivos
multimedia y generar transcripcion con el mismo nombre del archivo encontrado de
manera automatizada utilizando Whisper AI.

## Requisitos Previos

- Windows PowerShell 7
- [Whisper AI](https://github.com/openai/whisper) instalado y configurado en el sistema
- Python (requerido para Whisper AI)

## Instalación

1. Clona este repositorio o descarga el archivo `WispherTranslator.ps1`
2. Asegúrate de tener Whisper AI instalado en tu sistema
3. El script está listo para ser ejecutado

## ¿Como utilizar esta herramienta?

El script se puede ejecutar desde PowerShell con los siguientes parámetros:

```powershell
.\WispherTranslator.ps1 [-Directory <ruta_directorio>] [-Model <modelo>] [-Extension
<extensión>]
```

### Parámetros

- `-Directory` o `-d`: Ruta al directorio que contiene los archivos de video
  - Valor por defecto: carpeta `inputs` en el directorio actual
- `-Model` o `-m`: Modelo de Whisper a utilizar
  - Valores permitidos: `base`, `tiny`, `small`, `medium`, `turbo`
  - Valor por defecto: `tiny`
- `-Extension` o `-e`: Extensión de los archivos a procesar
  - Valores permitidos: `mp4`, `mkv`, `webm`
  - Valor por defecto: `mp4`
- `-Help`: Muestra el mensaje de ayuda con instrucciones de uso

### Ejemplos de Uso

1. Ejecutar con valores por defecto (carpeta `inputs`, modelo tiny, archivos mp4):

```powershell
.\WispherTranslator.ps1
```

2. Procesar archivos MKV usando el modelo base:

```powershell
.\WispherTranslator.ps1 -Directory "C:\Videos" -Model "base" -Extension "mkv"
```

3. Procesar archivos WEBM usando un modelo más preciso:

```powershell
.\WispherTranslator.ps1 -d "C:\Videos" -m "medium" -e "webm"
```

4. Ver la ayuda:

```powershell
.\WispherTranslator.ps1 -Help
```

## Funcionamiento

1. El script busca recursivamente todos los archivos del formato especificado (mp4,
   mkv o webm) en el directorio indicado
2. Por cada archivo de video encontrado:
   - Verifica si ya existe un archivo .srt asociado
   - Si no existe, genera la transcripción usando Whisper AI
   - Guarda la transcripción en formato .srt en el mismo directorio que el archivo
     de video.
3. Muestra mensajes de progreso durante el proceso.

## Notas

- Las transcripciones se generan en español por defecto
- Los archivos .srt se crean en el mismo directorio que los archivos de video
- Si ya existe un archivo .srt para un video, el script lo saltará para evitar trabajo
duplicado
- El script utiliza valores por defecto para facilitar su uso: carpeta `inputs`,
modelo tiny y archivos con formato mp4

## LICENSE

- Este proyecto utiliza [Whisper](https://github.com/openai/whisper), un modelo de
transcripción de OpenAI, bajo la licencia MIT.
