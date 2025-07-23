# Parámetros para el directorio a procesar y el modelo a usar
param (
    [Parameter(Mandatory=$false,Position=0)]
    [Alias("d")]
    [string]$Directory,
    
    [Parameter(Mandatory=$false,Position=1)]
    [Alias("m")]
    [ValidateSet("base", "tiny", "small", "medium", "turbo")]
    [string]$Model,

    [Parameter(Mandatory=$false)]
    [switch]$Help
)

# Mostrar ayuda si se especifica el parámetro -Help
if ($Help) {
    Write-Host "Uso: .\Script.ps1 [-Directory|-d <ruta>] [-Model|-m <modelo>] [-Help]"
    Write-Host ""
    Write-Host "Descripción:"
    Write-Host "    Este script procesa archivos MP4 en un directorio y genera subtítulos SRT usando Whisper."
    Write-Host ""
    Write-Host "Parámetros:"
    Write-Host "    -Directory, -d    Ruta al directorio que contiene los archivos MP4 (obligatorio)"
    Write-Host "    -Model, -m       Modelo de Whisper a utilizar (obligatorio)"
    Write-Host "                     Valores permitidos: base, tiny, small, medium, turbo"
    Write-Host "    -Help, -h           Muestra este mensaje de ayuda"
    Write-Host ""
    Write-Host "Ejemplo:"
    Write-Host "    .\Script.ps1 -Directory 'C:\Videos' -Model 'base'"
    exit
}

# Validar parámetros obligatorios si no se está mostrando la ayuda
if (-not $Directory) {
    Write-Host "Error: El parámetro -Directory es obligatorio cuando no se usa -Help"
    Write-Host "Use -Help para ver las instrucciones de uso"
    exit 1
}

if (-not $Model) {
    Write-Host "Error: El parámetro -Model es obligatorio cuando no se usa -Help"
    Write-Host "Use -Help para ver las instrucciones de uso"
    exit 1
}

# Valida si existe algun archivo on extension .mp4 en el directorio actual o en subdirectorios y deja comentario en cada caso
function Test-Mp4FileExists {
    param (
        [string]$Path
    )
    $mp4Files = Get-ChildItem -Path $Path -Recurse -Filter *.mp4 -ErrorAction SilentlyContinue
    return $mp4Files.Count -gt 0
}


# valida si en este o en otro subdirectorio existe un archivo con extension .srt
function Test-SrtFileExists {
    param (
        [string]$Path
    )
    $srtFiles = Get-ChildItem -Path $Path -Recurse -Filter *.srt -ErrorAction SilentlyContinue
    return $srtFiles.Count -gt 0
}

# si se identifica un archivo .mp4 y no se identifica algun archivo .srt en el mismo directorio ejecuta el siguiente comando

function Invoke-Mp4Files {
    param (
        [string]$Path
    )
    
    $mp4Files = Get-ChildItem -Path $Path -Recurse -Filter *.mp4 -ErrorAction SilentlyContinue
    
    foreach ($mp4File in $mp4Files) {
        $srtFile = Join-Path -Path $mp4File.DirectoryName -ChildPath ($mp4File.BaseName + ".srt")
        
        if (-not (Test-Path -Path $srtFile)) {
            Write-Host "No se encontró un archivo .srt para el archivo: $($mp4File.FullName)"
            Write-Host ""
            Write-Host "Generando transcripción para: $($mp4File.DirectoryName)\$($mp4File.Name)"
            Write-Host ""
            # Avisa que directorio y que modelo se utilizará en esta tarea
            Write-Host "Transcribiendo el archivo '$($mp4File.Name)' usando el modelo: '$Model'."
            Write-Host ""
            # Ejecuta whisper especificando el directorio de salida y el modelo seleccionado
            whisper "$($mp4File.FullName)" --fp16=False --language Spanish --model $Model --output_format srt --output_dir "$($mp4File.DirectoryName)"
            # Transcripción completada
            Write-Host "Transcripción completada para: $($mp4File.Name)"
            Write-Host ""
            # Transcripcion  guardada en el siguiente directorio
            Write-Host "Transcripción guardada en: $($mp4File.DirectoryName)"
        } else {
            Write-Host ""
            Write-Host "El archivo $($mp4File.Name) ya tiene un archivo .srt asociado".
            Write-Host ""
        }
    }
}

# Invoca la función para procesar archivos .mp4 en el directorio especificado
Invoke-Mp4Files -Path $Directory
