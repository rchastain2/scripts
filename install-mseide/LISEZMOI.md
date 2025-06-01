
# Script pour l'installation de MSEide sous Linux

Script Bash qui télécharge *MSEide+MSEgui* à partir d'un dépôt git, compile *MSEide* et crée deux raccourcis (vers *MSEide*) : l'un sur le bureau, l'autre dans le menu des applications.

Les fichiers téléchargés (et compilés) restent où ils sont. Le dépôt git est cloné dans un dossier avec un nom unique. Les raccourcis contiennent une option pour demander à *MSEide* d'utiliser son propre fichier de configuration. Le but de cette façon de faire est de pouvoir installer un nombre indéfini de versions de *MSEide+MSEgui*, qui n'entrent en conflit, ni les unes avec les autres, ni avec une éventuelle version installée dans les règles de l'art sur le système.

## Utilisation

```bash
sh install_mseide.sh
```

L'option **-d** permet de choisir l'emplacement de l'installation (l'endroit où sera cloné le dépôt git). Par défaut le dossier est créé dans le répertoire courant.

```bash
sh install_mseide.sh -d ~/Applications
```

L'option **-b** permet de choisir une branche. Par défaut, le script clone la branche *main* du [dépôt maintenu par Fred van Stappen](https://codeberg.org/fredvs/mseide-msegui.git).

```bash
sh install_mseide.sh -b maint
```

## Configuration de MSEide

Au premier lancement de MSEide, vous devez aller dans **Settings/Configure MSEide** et renseigner la variable *MSEDIR*.
