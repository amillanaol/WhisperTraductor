# WhisperTranslator

Herramienta desarrollada en PowerShell que permite escanear un directorio con archivos multimedia (.mp4) y generar transcripciones de audio a texto de manera automatizada utilizando Whisper AI.

## Requisitos Previos

- Windows PowerShell
- [Whisper AI](https://github.com/openai/whisper) instalado y configurado en el sistema
- Python (requerido para Whisper AI)

## Instalación

1. Clona este repositorio o descarga el archivo `WispherTranslator.ps1`
2. Asegúrate de tener Whisper AI instalado en tu sistema
3. El script está listo para ser ejecutado

## Uso

El script se puede ejecutar desde PowerShell con los siguientes parámetros:

```powershell
.\WispherTranslator.ps1 -Directory <ruta_directorio> -Model <modelo>
```

### Parámetros

- `-Directory` o `-d`: (Obligatorio) Ruta al directorio que contiene los archivos MP4 a procesar
- `-Model` o `-m`: (Obligatorio) Modelo de Whisper a utilizar
  - Valores permitidos: `base`, `tiny`, `small`, `medium`, `turbo`
- `-Help`: Muestra el mensaje de ayuda con instrucciones de uso

### Ejemplos de Uso

1. Procesar archivos usando el modelo base:
```powershell
.\WispherTranslator.ps1 -Directory "C:\Videos" -Model "base"
```

2. Usar un modelo más preciso:
```powershell
.\WispherTranslator.ps1 -Directory "C:\Videos" -Model "medium"
```

3. Ver la ayuda:
```powershell
.\WispherTranslator.ps1 -Help
```

## Funcionamiento

1. El script busca recursivamente todos los archivos .mp4 en el directorio especificado
2. Por cada archivo .mp4 encontrado:
   - Verifica si ya existe un archivo .srt asociado
   - Si no existe, genera la transcripción usando Whisper AI
   - Guarda la transcripción en formato .srt en el mismo directorio del archivo .mp4
3. Muestra mensajes de progreso durante el proceso

## Notas

- Las transcripciones se generan en español por defecto
- Los archivos .srt se crean en el mismo directorio que los archivos .mp4
- Si ya existe un archivo .srt para un video, el script lo saltará para evitar trabajo duplicado
