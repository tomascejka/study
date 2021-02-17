# lab02 - Dockerfile advanced - CMD vs ENTRYPOINT

## Přehled
Cílem této laboratoře je ověřit rozdíly mezi CMD a ENTRYPOINT příkazy v dockerfile.

## Předpoklady
Ideálně (v laboratoři si vystačíme i např. `ping` příkazem) nějaký velmi triviální bash skript, který budeme spouštět via výše uvedené dockerfile instrukce `CMD`/`ENTRYPOINT` (mrkni na `resources/entrypoint.sh`, bacha ověř si (než dáš SAVE) ve svém editoru, že používáš řádkování UNIX-u, jinak ti nepůjde skript pak v container-u spustit!).

## Poznámky
Cílem je pochopit, jak používat instrukce CMD/ENTRYPOINT. Jsou si rovnoceni a do jisté míry dělají totéž - spustí process (dle zápisu v exec/shell formátu). V `Dockerfile` jsou na posledních řádcích možnosti/variace, jak si vyzkoušet různé varianty zápisu `CMD`/`ENTRYPOINT` instrukcí. Stačí vždy po změně varianty provést `build.bat` a spustit `run.bat` (s/bez parametru, záleží na variantě - viz. popisky v `Dockerfile`) .

Např.
```batch
build.bat
run.bat 1
```

## Závěr
Můj závěr je takový, že se vyplatí používat jejich kombinaci (v exec formátu), kdy `ENTRYPOINT` definuji skript, kt.
bude spuštěn a `CMD` definuji parametry pro tento skript.

## Zdroje

### Oficiální nebo doporučené
* https://docs.docker.com/engine/reference/builder/#entrypoint
* https://docs.docker.com/engine/reference/builder/#cmd
* http://www.johnzaccone.io/entrypoint-vs-cmd-back-to-basics/ << HOT, od základu k atomizaci k pochopení dostačující/popisné

### Ostatní
* http://www.johnzaccone.io/entrypoint-vs-cmd-back-to-basics << entrypoint vs. cmd
* https://thenewstack.io/docker-basics-how-to-use-dockerfiles/#
* https://devopscube.com/run-scripts-docker-arguments/
* https://success.docker.com/article/use-a-script-to-initialize-stateful-container-data
* https://www.youtube.com/watch?v=C1GE07UEFDo << HOT, vysvetluje na mysql docker, jak zprovoznit komplexni entrypoint skript