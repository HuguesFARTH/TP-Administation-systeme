# TP 4 - Gestion des paquets

## Exercice 1. Commandes de base

Pour mettre à jour le système on peut utiliser deux commandes différentes: `apt full-upgrade` ou `apt-get dist-upgrade`.
On souhaite maintenant mettre à jour les applications: 
* `apt-get update` permet de récupérer la liste des paquets.
* `apt-get upgrade` met à jour les différents programmes ayant un mise-à-jour disponible.
L'utilisation de `-y` permet d'accepter automatiquement l'installation
On peut créer un alias de cas commandes qu'on nommera `maj` : 
```bash
alias maj="apt full-upgrade -y && apt update && apt upgrade -y"
```

Si l'on souhaite récupérer les dernières installations de la machine, la combinaison de commande suivant permet d'obtenir les 5 dernières:
```bash
cat /var/log/dpkg.log | grep "install " | tail -n 5
```

On veut maintenant compter le nombre de paquets installés: ```bash
┌──(root㉿DESKTOP-NDDQU00)-[/mnt/c/Users/hugue/Documents/wsl_exports]
└─# dpkg -l | wc -l
423

┌──(root㉿DESKTOP-NDDQU00)-[/mnt/c/Users/hugue/Documents/wsl_exports]
└─# apt list --installed | wc -l

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

419
```
Cette différence peut s'expliquer 

Le fichier dpkg.log contiens uniquement les logs, il est volatile et demande une 