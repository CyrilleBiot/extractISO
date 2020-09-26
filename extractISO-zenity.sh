#!/bin/sh
#
#__Source : https://github.com/CyrilleBiot/extractISO
#__author__ = "Cyrille BIOT <cyrille@cbiot.fr>"
#__copyright__ = "Copyleft"
#__site__ = "https://cbiot.fr"
#__license__ = "GPL"
#__version__ = "1.0"
#__email__ = "cyrille@cbiot.fr"
#__status__ = "Devel"
#__date__ = "2020/09/26"
#
#

# ====================================================
# Test p7zip / installé ?
if which p7zip > /dev/null; then
    echo "Cool, p7zip est installé."
else
    echo "Il vous faut installer p7zip"
	echo "Soit : # apt install p7zip"
	echo "Soit : $ sudo # apt install p7zip"
	exit 0
fi

# Test zenity / installé ?
if which zenity > /dev/null; then
    echo "Cool, zenity est installé."
else
    echo "Il vous faut installer zenity"
	echo "Soit : # apt install zenity"
	echo "Soit : $ sudo # apt install zenity"
	exit 0
fi
# ====================================================


# Lancement de zenity / Fenetre d'accueil
  zenity  --info --title="Extraction d'ISO" --text="Juste un extracteur d ISO vers un répertoire.


            Etape 1 : choisir son ISO.


            Etape 2 : Séléctionner répertoire de destination


	    Source : https://github.com/CyrilleBiot/extractISO 

            Mail : cyrille@cbiot.fr" --width=600

		 
# Recuperation de l'iso
  FILE=$(zenity --file-selection --file-filter='Image ISO (.iso) | *.iso' --title="Selectionnez votre image ISO")
  echo "Fichier ISO sélectionné : $FILE"

# Localication du dossier de destination
  DEST=$(zenity --file-selection --directory --title="Sélectionner le répertoire de detination")
  echo "Repertoire de destination : $DEST"

# Test du répetoire d'extraction
  if [ -d "$DEST" ]; then
	echo "Le dossier existe, on le vide."
	rm -rf $DEST
	mkdir $DEST
  else 
	echo "Le dossier n'existe pas, on le crée."
	mkdir $DEST
  fi

# Extraction de l'ISO
  # On entre dans le répertoire de destination
  cd $DEST
  # On extrait l'iso
  7z x -y $FILE
  # On liste son contenu
  ls

