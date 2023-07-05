$source = "$env:USERPROFILE\Documents\Github\es-theme-HEXA"
$exclusions = @("_inc", "resources", "default", "template", "_hexaCustom", "_support")
$destinations = @(
    "$env:USERPROFILE\Documents\Github\es-theme-HEXA-HANDHELD",
    "$env:USERPROFILE\Documents\Github\es-theme-RCBX",
    "$env:USERPROFILE\Documents\Github\es-theme-batocer-club-reloaded",
    "$env:USERPROFILE\Documents\Github\es-theme-butterfly",
    "$env:USERPROFILE\Documents\Github\es-theme-comicscrap",
    "$env:USERPROFILE\Documents\Github\es-theme-ComicScrapV2"
)

$missingFolders = @{}

Get-ChildItem -Path $source -Directory |
    Where-Object { $exclusions -notcontains $_.Name } |
    ForEach-Object {
        $folder = $_.Name

        foreach ($destination in $destinations) {
            if (-not (Test-Path -Path (Join-Path -Path $destination -ChildPath $folder))) {
                if (-not $missingFolders[$destination]) {
                    $missingFolders[$destination] = @()
                }

                $missingFolders[$destination] += $folder
            }
        }
    }

foreach ($destination in $missingFolders.Keys) {
    Write-Output "Les dossiers suivants sont manquants dans l'emplacement $destination :"
    $missingFolders[$destination] | ForEach-Object {
        Write-Output " - $_"
    }
}

# Pause before exiting
Write-Output "Appuyez sur une touche pour continuer..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
