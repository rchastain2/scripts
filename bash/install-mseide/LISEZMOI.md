
# Script pour l'installation de MSEide sous Linux

Script Bash qui télécharge *MSEide+MSEgui* à partir d'un dépôt git, compile *MSEide* et crée deux raccourcis vers *MSEide* : l'un sur le bureau, l'autre dans le menu des applications.

Les fichiers téléchargés restent où ils sont. Le dépôt git est cloné dans un dossier avec un nom unique. Les raccourcis contiennent une option pour demander à *MSEide* d'utiliser son propre fichier de configuration. Le but de cette façon de faire est de pouvoir installer un nombre indéfini de versions de *MSEide+MSEgui*, qui n'entrent en conflit, ni les unes avec les autres, ni avec une éventuelle version installée dans les règles de l'art sur le système.

## Utilisation

```bash
sh install-mseide.sh
```

L'option **-d** permet de choisir l'emplacement de l'installation (l'endroit où sera cloné le dépôt git).

```bash
sh install-mseide.sh -d ~/Applications
```

Par défaut le dossier est créé dans le répertoire courant.

L'option **-b** permet de choisir une branche.

```bash
sh install-mseide.sh -b maint
```

Par défaut, le script installe la branche *main* du [dépôt maintenu par Fred van Stappen](https://codeberg.org/fredvs/mseide-msegui.git).

Le seul autre choix disponible dans la version initiale du script est la branche *maint* (pour maintenance) du [dépôt maintenu par moi](https://codeberg.org/rchastain/mseide-msegui). Cette branche contient le projet dans l'état où Martin Schreiber l'a laissé, avec seulement les modifications nécessaires pour la compatibilité avec Free Pascal 3.2 ; alors que la branche maintenue par Fred contient d'autres corrections, des nouveautés (par exemple la possibilité d'utiliser *BGRABitmap*) et une compatibilité avec Free Pascal 3.3.
<!--
## Configuration de MSEide

Au premier lancement de MSEide, vous devez aller dans **Settings/Configure MSEide** et renseigner la variable *MSEDIR*.
-->
