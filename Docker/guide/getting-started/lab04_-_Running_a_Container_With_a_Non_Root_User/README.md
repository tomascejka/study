# lab04 - Running_a_Container_With_a_Non_Root_User
.
## Přehled
Cílem je zajistit, že spuštění kontainer z buildované image lze omezit na konrétní uživatelské konto, kt. vznikne ve fázi `docker build`, tzn. je explicitně definován v `Dockerfile` souboru.
.
## Předpoklady
No nejdřív se to jevilo jako komplexní úloha (pomíchal jsem si [rootless](https://docs.docker.com/engine/security/rootless/) (nová feature s nativní používáním [user namespace](https://docs.docker.com/engine/security/userns-remap/) vespod)), ale pak jsem se dozvěděl, že docker už to umí (nativně) pomocí instrukce USER (viz. [odkaz](https://docs.docker.com/engine/reference/builder/#user))
.
## Poznámky
Upravil jsem defaultní skripty v `/bin` (`build.bat` a `run.bat`), abych dokázal ověřit cíl jednoduše. Cíl lze ověřit takto:

```bash
# spust build.bat a vyber volbu [2]
build.bat

# pote spust container a vyber volbu [2]
run.bat

# nyni container bezi v detached modu/spust skript a vyber volbu [1]
# to spusti interaktivni konsili a bash v bezicim kontaineru...
check.bat

# v bash konsoli over bezici procesy a uvidis, kdo je majitelem/spoustecem procesu
bash> ps aux

# vystupem napr. bude (dulezita je informace ve sloupci USER;
# hodnota je stejna, jako v Dockerfile.rootless instrukci USER):
bash-5.0$ ps aux
PID   USER     TIME  COMMAND
    1 appuser   0:00 ping www.google.com
    6 appuser   0:00 bash
   11 appuser   0:00 ps aux

```

Pro ověření / důkaz sporem (vše budeme dělat pod `root` účtem) lze spustit výše uvedený postup s rozdílem, že v `build.bat`/`run.bat` zvolíme volbu 1 (v obouch skriptech) další postup je stejný a ve sloupci USER (`ps aux`) bude akorát vidět uživatel `root`. Pro ověření, že o vytvořeném uživateli se můžeme ještě přesvědčit takto `cat /etc/passwd` a najít si příslušné `username`, kt. jsem definovali v instrukci `USER` v `Dockerfile`.

## Závěr
Lze jednoduše dosáhnout běžícího kontaineru, kt. nemusím být pro root účtem. A to použítím nativní instrukce `USER` v `Dockerfile` (v kombinaci vytvořením uživatele a skupiny - bacha příkazy se liší dle distribuce, kt. používáš). Dále pak je nutné volat příkaz `docker run` s parametrem `-u` (za níž uvedeneš hodnotu v USER instrukci) - pak máš jistotu, že kontainer běží pod specifickým uživatelským kontem.
.
## Zdroje

### Oficiální
* https://docs.docker.com/engine/reference/builder/#user
* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
* https://docs.docker.com/engine/security/rootless/ << HOT, ale experimental feature

### Ostatní
* https://medium.com/better-programming/running-a-container-with-a-non-root-user-e35830d1f42a << HOT, je tam použití zajímavý přístup via `gosu` (v entrypoint.sh, vysvětlující, jak spouštět mongodb pouze a jenom uživatelem nikoli root-em)
