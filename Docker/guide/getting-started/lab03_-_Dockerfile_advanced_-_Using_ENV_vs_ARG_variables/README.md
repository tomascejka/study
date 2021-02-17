# lab03 - Dockerfile advanced - Using ENV vs ARG variables
Jak pak je to s proměnnými a jejich použití v Dockerfile během sestavení image a poté v době, když spouštím kontejner.
.
## Přehled
Chtěl bych tedy si vyjasnit použití a význam `Dockerfile` instrukcí jako jsou `ENV` a `ARG`. Cílem je několik ukázek, jak proměnnou lze definovat, a použít během fáze `docker build` a poté v `docker run` fázi.
.
## Předpoklady
Již funkční `Dockerfile` s minimální množinou instrukcí, stačí `FROM` a `ENTRYPOINT`/`CMD`. 
.
## Poznámky
Nejdříve než začnu laborovat s instrukcemi je nutné si vyjasnit některé detaily.

### Platnost instrukcí
Rozdíl mezi `ARG` a `ENV`  instrukcemi je viditelnost/použitelnost:
* `ARG` 
  * je viditelný v build-time (sestavení a vytvoření image) 
  * a je překrytelný (pouze a jenom v `docker build` fázi, viz níže) pomocí docker CLI 
* `ENV` 
  * je dostupný jak v build-time, tak i v runtime (sestavení/vytvoření image, ale i při spouštění kontejneru) 
  * ale je překrytelný (pouze a jenom v `docker run` fázi, viz níže) pomocí docker CLI
* lze použít workaround, aby se platnost proměnné "prodloužila", a to tak, že si `ARG` nasetujete do `ENV`; používa se pro tzv. `default` hodnoty

### Použití v docker CLI
Obě instrukce mají v docker CLI paramater, kterým je lze překrýt v dané fázi (build/run):
* `ARG` je možné překrýt tímto způsobem (`--build-arg`): `docker build --build-arg VAR_NAME=6` 
* `ENV` je možné překrýt takto (`-e`): `docker run -e "env_var_name=another_value"`

### Pro ENV lze použít i env soubor
Další způsob, jak překrýt ENV proměnné v Dockerfile je použití soubor takto (`--env-file`): `docker run --env-file=envfile`. Soubor a jeho obsah by měl obsahovat proměnné v takovémto formátu

```bash
env_var_name=another_value
```

Veškeré variace zvládnu v jednom `Dockerfile`, mrkněte do něj a uvidíte všechny případy, kt. davají smysl. Pokud Vás napadnou další prosím ozvěte rád je sem přidám.

Cíle lze tedy dosáhnout zbuildováním a vytvořením image a poté opakovanými pokusy s různými vstupy spouštět run.bat, který Vám tyto volby poskytne. Tzn. lze jej dosáhnou takto:

```bash
# build image, deklaruje COUNT=3 (aka default), tzn. ping bude zavolat prave 3x
build.bat

# pote spustit kontejner s parametrem 1 (interaktivne bez BASH konsole) a pote je
# nutne vybrat, jakym zpusobem bude prekryta (nás cíl) ENV typu COUNT (run.bat Vas k tomu vyzve)
#   * 1 - ze pouzije parameter; COUNT=1
#   * 2 - ze pouzije soubor; COUNT=5
#   * zadny - k prekryti nedojde pouzije se default z Dockerfile; COUNT=3
run.bat 1
```

.
## Závěr
Proměnné via `ARG` jsem nezkoušel (nějak důkladně), resp. zkoušel jsem `echo` v `dockerfile` a sledoval v konsoli, jak pro každý `RUN echo ${COUNT}` vytvoří docker layer a vypíše číslo (velmi drahé/neekonomické ta layer, tak jsem to z `dockerfile` odstranil) a zaměřil jsem pouze a jenom `ENV` (protože ty mají přesah do runtime/kontaineru). Vše v podstatě shrnuje tento obrázek:
![ARG vs ENV cheatsheet](www/docker_environment_build_args_overview.png)
ARG vs ENV cheatsheet - [zdroj](https://vsupalov.com/docker-arg-env-variable-guide/) 
.
## Zdroje

### Oficiální
* https://docs.docker.com/engine/reference/builder/#arg
* https://docs.docker.com/engine/reference/builder/#env
* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#env

### Ostatní
* https://vsupalov.com/docker-arg-env-variable-guide/
* https://vsupalov.com/docker-arg-vs-env/
