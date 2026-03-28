
# Script pour l'installation de MSEide

Script Bash pour l'installation de MSEide sous Linux. Conçu pour permettre des installations multiples.

L'installation comprend les opérations suivantes :

- Cloner le dépôt *git* de *MSEide+MSEgui*
- Compiler *MSEide*
- Crée un raccourci sur le bureau et un autre dans le menu des applications
- Lancer une première fois *MSEide* pour le configurer

Le dépôt *git* est cloné dans un dossier avec un nom unique.

Les raccourcis contiennent une option obligeant *MSEide* à utiliser son propre fichier de configuration (nommé *mseide.sta* et contenu dans le même dossier que l'exécutable).

## Utilisation

```bash
sh install-mseide.sh
```

L'option **-d** permet de choisir le dossier parent de l'installation.

```bash
sh install-mseide.sh -d ~/Applications
```

Par défaut l'installation se fait dans le répertoire courant.

L'option **-b** permet de choisir une branche.

```bash
sh install-mseide.sh -b maint
```

Par défaut, le script installe la branche *main* du [dépôt maintenu par Fred van Stappen](https://codeberg.org/fredvs/mseide-msegui.git).

L'autre choix disponible est la branche *maint* (pour maintenance) du [dépôt maintenu par moi](https://codeberg.org/rchastain/mseide-msegui).

Cette branche contient le projet dans l'état où Martin Schreiber l'a laissé, avec seulement les modifications nécessaires pour la compatibilité avec la version courante de Free Pascal (*3.2.x*) ; alors que la branche maintenue par Fred contient d'autres corrections, des nouveautés (notamment la possibilité d'utiliser *BGRABitmap*) et la compatibilité avec Free Pascal *3.3.x*.
<!--
## Configuration de MSEide

Au premier lancement de MSEide, vous devez aller dans **Settings/Configure MSEide** et renseigner la variable *MSEDIR*.
-->
