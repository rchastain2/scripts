
# TextAdept Bash installer

Bash script for installing *TextAdept* under Linux.

Clones *TextAdept* repository, builds the application and creates two shortcuts: one on the desktop, the other in the applications menu.

The downloaded files stay where they are. The git repository is cloned in a folder with a timestamp in its name.

## Usage

```bash
sh install-textadept.sh
```

The **-d** option allowes to choose where the git repository will be cloned.

```bash
sh install-textadept.sh -d ~/Applications
```

By default it is cloned in the current directory.
