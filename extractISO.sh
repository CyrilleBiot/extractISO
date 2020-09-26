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

FILE=$1
DEST=$2

# Fonction pour les messages à afficher
message () {
	case "$1" in
	  # Usage	
      -help)
         echo "Usage: sh extractISO.sh /chemin/jusque/monFichierFormatISO.iso /dossier/ou/extraire/cette/iso" 
         ;;

      # ISO présente
      -isofound)
		 echo "Une image ISO a bien été trouvée."
		 ;;
     # ISO présente
	  -isonotfound)
		  echo "Aucune image ISO trouvée."
		  echo "Vérifier la présence de celle-ci et la syntaxe de votre paramètre 1"
		  ;;
	  # Rep DEST trouvé, supprimer
	  -dirfound)
	     echo "Le répertoire de destination existe. On le supprime."
	     ;;
	  # Rep DEST,création  
	  -drinotfound)
	     echo "Le répertoire de destination n'existe pas. On le crée."
		 ;;
      *)  # No more options 
      ;;
    esac
}


# Afficher aide
if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    message -1
    exit 0
fi


# Test p7zip / installé ?
if which p7zip > /dev/null; then
    echo "Cool, p7zip est installé."
else
    echo "Il vous faut installer p7zip"
	echo "Soit : # apt install p7zip"
	echo "Soit : $ sudo # apt install p7zip"
	exit 0
fi


# Test de la validité nbre paramètres
if [ $# -ne 2 ]; then
	echo "Nombre de paramètres incorrects."
    message -help
    exit 0
fi


# Test de la présence du fichier ISO
if [ -f "$FILE" ]; then
    message -isofound
else
    message -isonotfound
    exit
fi


# Test du répetoire d'extraction
if [ -d "$DEST" ]; then
	message -dirfound
	rm -rf $DEST
	mkdir $DEST
else 
	message -dirnotfound
	mkdir $DEST
fi

# Extraction de l'ISO
  # On entre dans le répertoire de destination
  cd $2
  # On extrait l'iso
  7z x -y $1
  # On liste son contenu
  ls
