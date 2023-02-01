# TP 3 - Utilisateurs, groupes et permissions

## Exercice 1. Gestion des utilisateurs et des groupes

1. Dans un premier temps, on créé les deux groupes demandés: `dev` et `infra`
```bash
> groupadd dev
> groupadd infra
```

2. Pour créer des utilisateurs, on utilise la commande `useradd`. Les paramètres utilisés permettent de définir le shell par défault de l'utilisateur, ici `-s /bin/bash`, on créé également un fichier home: `-m`
```bash
> useradd -m -s /bin/bash alice 
```
_On remplacera alice par les autres utilisateurs que l'on veut ajouter_

3. La commande `usermod` permet de gérer un utilisateur. On l'utilisera pour ajouter les utilisateurs aux groupes correspondants.
```bash
> usermod -g infra bob
```
_Ici on définit le groupe infra comme étant le groupe primaire de bob primaire (-g infra)._

Une fois les groupes primaire configurés, on supprimer les groupes par défault `delgroup alice`.

4. 
//TODO

5. On utilisera la commande `chgrp` afin d'affecter les groupes correspondant.
```bash
> chgrp -R dev /home/bob
```
_Exemple pour bob. -R permet de reporter cette modification sur l'ensemble des fichiers/dossiers composant /home/bob_

6. Déjà fait dans la question 3.

7. Pour créer les répertoires, on utilise la commande `mkdir`. On souhaite ensuite affecter la permission d'écrire, on utilise la commande `chmod`. On donne les permission d'écriture, lecture et exécutions au groupe correspondant `g=rwx`.
```bash
> chmod g=rwx /home/dev/
```

8. Pour cela on active le `sticky bit`. Il indique que dans ce dossier, seuls le propriétaire d’un fichier, le propriétaire du dossier ou root ont le droit de renommer ou supprimer ce fichier
```bash
> chmod +t /home/dev/
```

9. Non on ne peut pas s'y connecter car on n'a pas encore défini de mot de passe. Le compte est bloque:
```bash
> cat /etc/passwd
alice:!:19389:0:99999:7:::
```
_Le ! indique que le compte n'a pas de mot de passe, il est donc inacessible._

10. Pour l'activation du compte, un utilise la commande `passwd`. Elle permet de renseigner le mot de passe.
```bash
> sudo passwd alice
New password:
Retype new password:
passwd: password updated successfully
> su alice
Password:
```
_On arrive maintenant à se connecter avec l'utilisateur alice_

11. On utilise la commande `id`
```bash
> id alice
uid=1001(alice) gid=1001(dev) groups=1001(dev)
```

12. `getent` nous permet d'intéroger les différentes base de donné du système et de retourner l'entrée correspondante. Ici on cherche 1003 dans `capasswd`.
```bash
> getent passwd 1003
charlie:x:1003:1002::/home/charlie:/bin/bash
```

13. L'uid du groupe dev est `1001`. Il est affiché avec la command `id alice` question 11 comme alice appartient au groupe dev.

14. Même principe que question 12, mais cette fois on interroge la base `group`.

```bash
> getent group 1002
infra:x:1002:dave,charlie,bob
```

15. On ne peut pas retirer charlie du groupe infra comme on a précédement supprimé le groupe charlie comme il s'agit de son groupe primaire
```bash
> deluser charlie infra
deluser: You may not remove the user from their primary group.
```

16.
```bash
> chage -E 2021-06-01 dave -M 90 -m 5 -W 14 -I 30 && chage dave -l
Last password change                                    : Feb 01, 2023
Password expires                                        : May 02, 2023
Password inactive                                       : Jun 01, 2023
Account expires                                         : Jun 01, 2021
Minimum number of days between password change          : 5
Maximum number of days between password change          : 90
Number of days of warning before password expires       : 14
```

17. L'utilisateur root a pour shell `bash`.
```bash
> getent passwd root
root:x:0:0:root:/root:/bin/bash
```

Le compte `nobody` est une sorte d'utilisateur universel, il permet de lancer des programmes ne nécessitant pas de permissions particulières.

## Exercice 2. Gestion des permissions

Si un utilisateur a les droits d'écriture dans un dossier, il peut y créer différents dossiers ou fichiers.
```bash
> mkdir test && touch test/fichier && ls -lR
.:
total 4
drwxr-xr-x 2 kali kali 4096 Feb  1 14:34 test

./test:
total 0
-rw-r--r-- 1 kali kali 0 Feb  1 14:34 fichier
```
Dans l'exemple ci-dessus, on remarque que le fichier et le dossier donnent tous les droits à l'utilisateur les ayant créé, et seulement de lecture aux autres utilisateurs pour le fichier, et lecture/exécution pour le dossier.

L'utilisateur root aura accès à l'ensemble des fichiers/dossier, même une fois toutes les permissions supprimées.
```bash
> cat test/fichier
blabal
blabla
balblabzr
test
fesg
```
_exécuté avec l'utilisateur root_

On se redonne maintenant les droits d'écriture et d'exécution.
```bash
> test/fichier || sudo test/fichier
bash: test/fichier: Permission denied
Hello
```
On remarque que l'utilisateur ne peut toujours pas exécuter le fichier, en effet il manque encore les droit de lecture. Sans surprise l'utilisateur root a un accès total.

On se place dans le dossier test et on se retire les droits de lecture du dossier. On peut toujours exécuter le fichier mais pas lister les éléments du dossier test. On peut également sortir et rentrer dans le dossier.
Le faite de retirer les droits d'écritures empêche globalement de voir les fichiers présent dans le dossier.

