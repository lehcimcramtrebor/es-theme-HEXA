# Obtenez le chemin d'où le script est exécuté
$CurrentFolderPath = Get-Location

# Obtenez le chemin du bureau de l'utilisateur actuel
$DesktopPath = [Environment]::GetFolderPath("Desktop")

# Nom du dossier à créer
$FolderName = "Theme structure by Helmic"

# Chemin complet du nouveau dossier
$NewFolderPath = Join-Path -Path $DesktopPath -ChildPath $FolderName

# Vérifiez si le dossier existe déjà sur le bureau
$Suffix = 1
while(Test-Path -Path $NewFolderPath)
{
    # Si le dossier existe, ajoutez un suffixe numérique
    $NewFolderPath = Join-Path -Path $DesktopPath -ChildPath ($FolderName + " " + $Suffix)
    $Suffix++
}

# Créez le nouveau dossier
New-Item -Path $NewFolderPath -ItemType Directory -Force | Out-Null

# Copiez récursivement le contenu du dossier d'où le script est exécuté vers le nouveau dossier
# Excluez les dossiers "us" et "jp" lors de la première copie
Get-ChildItem -Path $CurrentFolderPath -Recurse |
Where-Object { $_.FullName -ne $PSCommandPath -and $_.FullName -notmatch '\\us\\' -and $_.FullName -notmatch '\\jp\\' } |
Copy-Item -Destination {Join-Path -Path $NewFolderPath -ChildPath $_.Name} -Recurse -Force

# Déplacez chaque fichier dans un nouveau dossier avec le même nom (sans extension)
Get-ChildItem -Path $NewFolderPath -File |
ForEach-Object {
    $NewDir = Join-Path -Path $NewFolderPath -ChildPath $_.BaseName
    New-Item -Path $NewDir -ItemType Directory -Force | Out-Null
    Move-Item -Path $_.FullName -Destination $NewDir -Force
}

# Liste des dossiers à traiter
$SubFolders = @("us", "jp")

foreach ($folder in $SubFolders) {
    # Chemin du sous-dossier
    $SubFolderPath = Join-Path -Path $NewFolderPath -ChildPath $folder

    # Vérifiez si le sous-dossier existe
    if (Test-Path -Path $SubFolderPath) {
        # Déplacez chaque fichier dans le dossier correspondant à la racine, dans un sous-dossier avec le même nom que le sous-dossier d'origine
        Get-ChildItem -Path $SubFolderPath -File |
        ForEach-Object {
            $DestDir = Join-Path -Path $NewFolderPath -ChildPath $_.BaseName
            $DestDir = Join-Path -Path $DestDir -ChildPath $folder
            New-Item -Path $DestDir -ItemType Directory -Force | Out-Null
            Move-Item -Path $_.FullName -Destination $DestDir -Force
        }

        # Si le sous-dossier est vide, supprimez-le
        if (!(Get-ChildItem -Path $SubFolderPath)) {
            Remove-Item -Path $SubFolderPath -Force
        }
    }
}

# Rest of your script...

# Liste des suffixes
$Suffixes = @("-ca", "-de", "-es", "-fr", "-it", "-nl", "-pt", "-us", "-en", "-engb", "-eu", "-e", "-w", "-uk", "-s", "-f", "-d", "-i", "-gr", "-no", "-sw", "-se", "-pl", "-jp", "-j", "-br", "-ru", "-r", "-kr", "-cn", "-as", "-tw", "-c", "-fc", "-in", "-wor", "-wr", "-fre", "-ger", "-ch", "-hk", "-ptbr")

# Parcourir chaque dossier
Get-ChildItem -Path $NewFolderPath -Directory |
ForEach-Object {
    # Vérifier si le nom du dossier se termine par un suffixe
    foreach ($suffix in $Suffixes) {
        if ($_.Name.EndsWith($suffix)) {
            # Nom du dossier sans suffixe
            $FolderNameWithoutSuffix = $_.Name.Substring(0, $_.Name.Length - $suffix.Length)

            # Vérifier si le dossier sans suffixe existe
            $FolderWithoutSuffixPath = Join-Path -Path $NewFolderPath -ChildPath $FolderNameWithoutSuffix
            if (Test-Path -Path $FolderWithoutSuffixPath) {
                # Fusionner le dossier avec le dossier sans suffixe
                Get-ChildItem -Path $_.FullName -Recurse |
                Move-Item -Destination $FolderWithoutSuffixPath -Force
            }

            # Supprimer le dossier maintenant vide
            Remove-Item -Path $_.FullName -Force

            # Sortir de la boucle une fois qu'un suffixe correspondant a été trouvé
            break
        }
    }
}


# Parcourir chaque fichier dans chaque sous-dossier
Get-ChildItem -Path $NewFolderPath -File -Recurse |
ForEach-Object {
    # Nom de fichier actuel sans extension
    $CurrentFileNameWithoutExtension = $_.BaseName

    # Suffixe du nom de fichier actuel
    $CurrentFileNameSuffix = ""

    # Vérifier si le nom du fichier se termine par un suffixe
    foreach ($suffix in $Suffixes) {
        if ($CurrentFileNameWithoutExtension.EndsWith($suffix)) {
            # Le suffixe du nom de fichier actuel est le suffixe trouvé
            $CurrentFileNameSuffix = $suffix

            # Nom de fichier actuel sans suffixe
            $CurrentFileNameWithoutExtension = $CurrentFileNameWithoutExtension.Substring(0, $CurrentFileNameWithoutExtension.Length - $suffix.Length)

            # Sortir de la boucle une fois qu'un suffixe correspondant a été trouvé
            break
        }
    }

    # Nouveau nom de fichier
    $NewFileName = "logo" + $CurrentFileNameSuffix + $_.Extension

    # Chemin complet du nouveau fichier
    $NewFilePath = Join-Path -Path $_.Directory.FullName -ChildPath $NewFileName

    # Renommer le fichier
    Rename-Item -Path $_.FullName -NewName $NewFilePath -Force
}

$UserInput = Read-Host "Voulez-vous créer tous les fichiers 'theme.xml' maintenant? (O/N)"

if ($UserInput -eq "O" -or $UserInput -eq "o") {
    # Créez un fichier 'theme.xml' dans chaque dossier à la racine
    Get-ChildItem -Path $NewFolderPath -Directory |
    ForEach-Object {
        # Chemin complet du nouveau fichier
        $NewFilePath = Join-Path -Path $_.FullName -ChildPath "theme.xml"

        # Contenu du fichier
        $FileContent = @"
<?xml version="1.0" encoding="UTF-8"?>

<theme>

	<formatVersion>7</formatVersion>

    <include>./../theme.xml</include>

	<variables><region.priority region="eu"/>

		<!--<system.manufacturer>manufacturer</system.manufacturer>-->

		<!--<system.fullName>name</system.fullName>-->

		<!--<system.releaseYearOrNull>2023</system.releaseYearOrNull>-->

		<!--<desc>description</desc>-->
		
		<!--<desc lang="fr">description</desc>-->

	</variables>

</theme>
"@

        # Créez le nouveau fichier avec le contenu
        $FileContent | Out-File -FilePath $NewFilePath -Encoding utf8
    }

    Write-Host "Les fichiers 'theme.xml' ont été créés."
} else {
    Write-Host "Pas de création de fichiers 'theme.xml'. Le script se termine."
}

# Pause à la fin pour permettre à l'utilisateur de voir les erreurs
Read-Host "Appuyez sur Entrée pour continuer..."
