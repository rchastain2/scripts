
# Script pour l'installation d'Eschecs sous Linux

Script Bash qui télécharge le code source du programme *Eschecs* à partir du dépôt git, le compile et crée des raccourcis pour le lancement de l'application (un sur le bureau, un autre dans le menu des applications).

## Utilisation

```bash
sh install-eschecs.sh
```

L'option **-d** permet de choisir l'emplacement de l'installation (l'endroit où sera cloné le dépôt git).

```bash
sh install-eschecs.sh -d ~/Applications
```

Par défaut le dossier est créé dans le répertoire courant.
