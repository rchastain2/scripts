
# Script pour l'installation de TextAdept sous Linux

Script Bash qui télécharge *TextAdept* à partir du dépôt git, le compile et crée deux raccourcis : l'un sur le bureau, l'autre dans le menu des applications.

Les fichiers téléchargés restent où ils sont. Le dépôt git est cloné dans un dossier avec un nom unique.

## Utilisation

```bash
sh install-textadept.sh
```

L'option **-d** permet de choisir l'emplacement de l'installation (l'endroit où sera cloné le dépôt git).

```bash
sh install-textadept.sh -d ~/Applications
```

Par défaut le dossier est créé dans le répertoire courant.
