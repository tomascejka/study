# Minimalistic docker guide
Inspirováno od JH (README file u jednotlivých dockerfile souborů).

## Vytvoření image
docker build -t [repoName]/[imgName][:tag] .

## Spuštění container-u (vytvoření instance image)
docker run -d -p [outPort]:[inPort] --name [containerName] [repoName]/[imgName][:tag]

## Zkoumání kontaineru
docker exec -it [containerId] bash
docker top [containerId]
docker stats [containerId ...]

## Ostatní

### Kopírování souborů (z containeru na hosta)
Zdroje:
- https://medium.com/@gchudnov/copying-data-between-docker-containers-26890935da3f
- https://stackoverflow.com/questions/22049212/copying-files-from-docker-container-to-host

#### z kontejneru na hosta
$ docker cp [containerId]:/file/path/within/container /host/path/target

#### z hosta do kontejeneru (priklad vcetne vytvoreni adresar)
$ docker exec -i [containerId] sh -c ‘mkdir -p /home/dir1'
$ docker exec -i [containerId] sh -c 'cat > /home/dir1/test.txt' < ./test.txt