# Postav si své vývojové prostředí
No to je mi panečku výzva... jak na to?

## Zdroje

* http://blog.codepipes.com/containers/docker-for-java-big-picture.html << HOT, k zamysleni
* https://itnext.io/run-kubernetes-on-your-machine-7ee463af21a2 << jak rozjet K8 lokalně
* https://medium.com/@lucjuggery << zajímavý blog o K8 a docker

### Obecně jak postavit prostředí
* https://nrempel.com/how-to-create-a-docker-development-environment/ << jak postavit DEV prostredi v linuxu s manage shell skriptem
* https://blog.atulr.com/docker-local-environment/ << další jak postavit DEV
* https://medium.com/phytochemia-tech-blog/how-docker-can-improve-your-development-environments-731cdfda0b9a

### Jak reagovat v Docker na změny v kódu
* https://vsupalov.com/rebuilding-docker-image-development/ << je nutný rebuild po změně kodu - ne, a jak na to
* https://hackernoon.com/efficient-development-with-docker-and-docker-compose-e354b4d24831 << HOT, java local docker env s tim, ze zmena provede mvn install a spusti jar (ja bych potreboval zmeneny kod zbuildovat do war a ten predeployovat via http://eradman.com/entrproject/ ent prikaz)

### Rozjet to v compose má smysl (poskladej si DEV jak lego)
* https://github.com/docker/awesome-compose HOT, obsahuje mnoho různorodých přepřipravených compose projektů
* https://medium.com/softonic-eng/docker-compose-from-development-to-production-88000124a57c << jak pracovat s compose file pres ruzna prostredi

### GUI v docker (budu potrebovat pro IDE)
* https://stackoverflow.com/questions/47955823/docker-run-desktop-environment?noredirect=1&lq=1 << jak na GUI v docker
* https://blog.jessfraz.com/post/docker-containers-on-the-desktop/ << HOT, jak na GUI v docker

### IDE v docker
* https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1 << jak postavit prenostitelne IDE (vim/tmux)
* https://training.play-with-docker.com/java-debugging-netbeans/ << jak postavit Netbeans v docker
* http://mvpjava.com/docker-java-development-environment/ << jak rozjet Netbeans IDE v docker
* https://www.docker.com/blog/spring-boot-development-docker/ << v clanku se zminuji o remote debug via docker/compose v kooperaci
* https://github.com/docker/labs/tree/master/developer-tools/java-debugging << dalsi clanek o remote debug beziciho kontejneru
* https://www.veracode.com/blog/secure-development/docker-and-javaopts << nastaveni JAVA_OPTS
* https://spacevim.org/use-vim-as-a-java-ide/ << HOT,spacevim pro java

### Ostatní
* https://vitalflux.com/docker-start-java-8-or-java-7-dev-environment-with-a-single-script/ << jak lokalně výřešit dvě verse java pomoci docker
