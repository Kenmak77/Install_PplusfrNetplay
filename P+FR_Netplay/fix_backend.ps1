$basePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$dolphinIni = Join-Path $basePath "User\Config\Dolphin.ini"
$selfPath = $MyInvocation.MyCommand.Path

# --- Nettoyage du fichier Dolphin.ini ---
if (Test-Path $dolphinIni) {
    $content = Get-Content $dolphinIni -Raw

    # Supprime entièrement la section [Analytics] et ses lignes
    $content = $content -replace '(?ms)^\[Analytics\][^\[]*', ''

    # Réécriture propre du fichier en UTF-8 sans BOM
    $utf8 = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($dolphinIni, $content.Trim(), $utf8)
}

# --- Auto-suppression du script ---
Start-Sleep -Seconds 1
Remove-Item -Path $selfPath -Force
