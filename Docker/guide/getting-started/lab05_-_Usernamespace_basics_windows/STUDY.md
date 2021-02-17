# User Namespaces guide

## Přehled
Potřebuji velmi rychle proplynout, alespoň v základní rovině do "user namespaces" v docker (základ leží v linux/kernel namespace). Klíčová slova pro tento dokument: __user namespaces__, __docker__, __privilege-escalation attack__.

### Průběh studia (TRWTD)
... o tom, jak hluboko má znalost daného tématu/myšlenky dosahuje ("how deep the rabbit hole goes", [zdroj](https://en.wikipedia.org/wiki/Red_pill_and_blue_pill#Overview))

* __[T]ODO__ - nemám nastudováno, abych o tom mohl mluvit, natož nad tím něco "dalšího" vymýšlel
* __[R]EAD__ - nutné si přečíst další zdroje/odkazy k tématu
* __[W]RITE__ - nutné si udělat poznámky k danému zdroji/tématu
* __[T]EST__ - zkusit si to "osahat" (ideálně laboratorně opakovatelným postupem - systém laboratoří používám na studium Docker)
* __[D]ONE__ - finální stav (myšlenka/téma) merge výše uvedených stavů, tzn. myšlenka: přečtena/nastudována, sepsány poznámky a otestována v laboratoři (ideální stav)

## Úvod

* (TODO) dostuduj si linux/kernel namespace (např. [zdroj](https://www.man7.org/linux/man-pages/man7/user_namespaces.7.html)) << pro dokonalé pochopení, jak to celé funguje na pozadí, kámo!
* (WRITE) user namespaces v docker - oficiální dokumentace/blog. příspěvky (viz. kapitola Zdroje níže)
* (TODO) laboratoř pro zkoušení, nutné zprovoznit na linux OS hostovi, na windows (to pochopitelně nejde... než jsem pochopil základní myšlenku, viz. kernel namespace filozofie)

### Základy
Základní myšlenka, kterou jsem hledal, abych pochopil téma *user namespace* v docker, je vyjádřena takto ([zdroj](https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-user-namespace-options)):

> container processes running as the root user will have expected administrative privilege (with some restrictions) inside the container but will effectively be mapped to an unprivileged uid on the host.

...tzn., oddělením root-ovksých uživatelkých kont mezi kontejnerem a host-em lze zamezit tzv. "__privilege-escalation attack__".

### Invazivní povaha
Vlastnost *user namespace* je globální změna (flag na deamon-ovi, nikoli na specifických images/kontainerech) a má invazivní povahu (nelze ji jednoduše zapnout/vypnout a naopak - viz. následky níže). Nicméně tato vlastnost lze eventuálně vypínat pro jednotlivé kontainery, viz. [zdroj](https://docs.docker.com/engine/security/userns-remap/#disable-namespace-remapping-for-a-container) s tím, že je nutné dořešit následky, např. namoutované zdroje z host-a a popř. jiné další issue (viz. [zdroj](https://docs.docker.com/engine/security/userns-remap/#user-namespace-known-limitations)).

#### Přemapování namoutovaných složek
Naivní (ale bezpečný) ideál je, aby původ vzešel z [buildtime](https://docs.docker.com/engine/reference/commandline/build/) kontainer-u - tzn. je [vytvoří](https://docs.docker.com/engine/reference/builder/#add)/[zkopíruje](https://docs.docker.com/engine/reference/builder/#copy)/vytvoří skriptem v [Dockerfile](https://docs.docker.com/engine/reference/builder/) anebo z runtime [run](https://docs.docker.com/engine/reference/commandline/run/), [exec](https://docs.docker.com/engine/reference/commandline/exec/) kontaineru, tzn. od uživatel z kontainer-u (pak mají by default správné právo čtení/zápis atributy). Dopady: Podívám-li se na to rolí vývojáře, tak mě sežere ("Na co jsme tam ty mount-y složek tedy zaváděli?"), že bude muset lézt do kontaineru a měnit statickou věc v konfiguraci app. server-u "zevnitř". Odpovědí, je to na DEV-u nezapínat (zde je žádoucí, aby vývojář měl volnou ruku), ale na TEST/PROD již ano (ale nyní jsme v situaci, že je nutné si to "osahat" - takže kde to zapneme?? protože neumím zaručit vyřešením všech následku "kombinovaného prostředí", kde to nahodím a vypnu to u PES kontejnerů a budeme muset řešit nějaké BREAK_NECK issue a blokovat vývoj).

### Proč user namespace používat
Předvedu velmi zjednodušeně __privilege-escalation-attack__ (bez vstupního stavu uživatel. kt. provádí útok) a jeho cíl útoku: *budu chtít "na-kouknout a změnit (ano, tak budu drzý)" do adresáře ```/etc``` na host-ovi*.

```bash
# Run a container and mount host1's /etc onto /root/etc
$ docker run --rm -v /etc:/root/etc -it ubuntu

# Make some change on /root/etc/hosts
root@34ef23438542:/# vi /root/etc/hosts

# Exit from the container
root@34ef23438542:/# exit

# Check /etc/hosts
$ cat /etc/hosts
```
__Figure 1__ - Omrknutí/změna souboru `/etc/hosts`, detaily viz. [zdroj](https://coderwall.com/p/s_ydlq/using-user-namespaces-on-docker)

## Použití user namespaces
Vlastnost není [instalátorem](https://www.docker.com/products/docker-desktop "Docker Desktop") zapnutá a je nutné ji dodatečně [zapnout](https://docs.docker.com/engine/security/userns-remap/#enable-userns-remap-on-the-daemon "Enable userns-remap on dockerd") na docker [deamon-ovi](https://docs.docker.com/engine/reference/commandline/dockerd/ "dockerd") `dockerd`.

#### Nastavení dockerd
Jedná se o flag `--userns-remap`, který lze použít různě (user,uid, nebo user:group), viz. [odkaz](https://docs.docker.com/engine/security/userns-remap/#enable-userns-remap-on-the-daemon). Nastavení flag-u `--userns-remap` se dá provést ve skriptu (záleží na linux distribuci), kt. deamon-a spouští anebo konfiguračním souborem. 

Docker deamon `dockerd` lze konfigurovat i externím konfiguračním souborem, který si lze napsat sám a umístit si do svého adresáře (viz. `--config-file`) - jeho podoba a umístění viz. [odkaz](https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-configuration-file "dockerd configuration file reference").

Dále je nutné zmínit, že nastavení se odvíji od linux distribuce (ve zkratce: nelze nahodit pouze jeden flag, ale nutné připravit i mapovací soubor pro user konta - a to se např. týká CentOS).

TODO - tipy, jak to provést v CentOS, viz. 
* https://docs.oracle.com/cd/E37670_01/E75728/html/ol-docker-userns-remap.html << __HOT__,tento mi přijde nejblíže CentOS konfiguraci

Další pro detailní načtení:
* https://www.jujens.eu/posts/en/2017/Jul/02/docker-userns-remap/
* https://jtreminio.com/blog/running-docker-containers-as-current-host-user/
* https://blog.yadutaf.fr/2016/04/14/docker-for-your-users-introducing-user-namespace/
* https://gist.github.com/mjuric/c519d470eac60b08de5ed735ff5a2ef9
* https://linuxize.com/post/how-to-install-and-use-docker-on-centos-7/
* https://medium.com/better-programming/running-a-container-with-a-non-root-user-e35830d1f42a




### Zdroje
1. https://success.docker.com/article/introduction-to-user-namespaces-in-docker-engine
2. https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html#rule-2---set-a-user
3. https://security.stackexchange.com/questions/152978/is-it-possible-to-escalate-privileges-and-escaping-from-a-docker-container
4. https://coderwall.com/p/s_ydlq/using-user-namespaces-on-docker