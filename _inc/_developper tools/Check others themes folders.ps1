$source = "$env:USERPROFILE\Documents\Github\es-theme-HEXA"
$exclusions = @("_inc", "resources", "default", "template", "_hexaCustom", "_support")
$destinations = @(
    "$env:USERPROFILE\Documents\Github\es-theme-HEXA-HANDHELD",
    "$env:USERPROFILE\Documents\Github\es-theme-RCBX",
    "$env:USERPROFILE\Documents\Github\es-theme-batocer-club-reloaded",
    "$env:USERPROFILE\Documents\Github\es-theme-comicscrap",
    "$env:USERPROFILE\Documents\Github\es-theme-ComicScrapV2"
)

Get-ChildItem -Path $source -Directory |
    Where-Object { $exclusions -notcontains $_.Name } |
    ForEach-Object {
        $folder = $_.Name
        $missingIn = @()

        foreach ($destination in $destinations) {
            if (-not (Test-Path -Path (Join-Path -Path $destination -ChildPath $folder))) {
                $missingIn += $destination
            }
        }

        if ($missingIn) {
            Write-Output "Le dossier $folder est manquant dans les emplacements suivants :"
            $missingIn | ForEach-Object {
                Write-Output " - $_"
            }
        }
    }

# Pause before exiting
Write-Output "Appuyez sur une touche pour continuer..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
