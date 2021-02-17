# lab05 - Usernamespace_basics
.
## Přehled
Snaha o nastavení linux/container user namespace, abych dokázal omezit /přístup k image/a běžícím kontejnerům z host-a/ naivni myšlenka, kt. jsem měl při zakládání této laboratoře -- aktuální upravená: abych dokázal oddělit procesy běžící na kontejneru a HOST-ovi pod odlišnými účty (root vs. un-root).
.
## Předpoklady
Nejdříve je nutné tuto vlastnost zapnout explicitně na docker deamon, což je proces, který spravuje celý docker ekosystém na HOST počítači. Po přečtění několika příspěvků, k čemu je linux namespace a jeho konkrétní submnožina user-namespace dobrá, jsem to zkusil nastavit, ale nevěděl jsem jak (tušil jsem, že na WIN to asi nepůjde, viz. linux namespace), ale pak jsem dohledal oficiální microsoft dokumentaci, že flag --userns-remap pro nastavení této vlastnosti nepodporuje (překvapivě :)).
.
## Poznámky
... prostože na WIN to nejde nastavit, ještě si něco kolem linux namespace něco pročtu, bude se to pak hodit na DEV prostředí, kde už linux na HOSTovi je.

## Závěr
Tzn. že na HOST počítači, který je Windows tato vlastnost nelze spustit/nastavit a provozovat.
.
## Zdroje

### Oficiální
* https://docs.docker.com/engine/security/userns-remap/
* https://success.docker.com/article/introduction-to-user-namespaces-in-docker-engine
* https://docs.docker.com/engine/reference/commandline/dockerd/#on-windows << obsahuje výčet flagů, kt. lze nahodit na docker deamon-voi (bohužel userns-remap tam není, je nutné zkoušet na HOST-ovi s linuxem/neexistuje žádná windows emulace)
* https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon#configure-docker-with-a-configuration-file


### Ostatní

* https://runnable.com/docker/securing-your-docker-system
* https://medium.com/@ewindisch/on-the-security-of-containers-2c60ffe25a9e

#### cgroup a namespaces
* https://stackoverflow.com/questions/34820558/difference-between-cgroups-and-namespaces
* https://www.linux.com/audience/devops/hardening-docker-hosts-user-namespaces/
* https://www.linux.com/news/understanding-and-securing-linux-namespaces/
* https://itnext.io/chroot-cgroups-and-namespaces-an-overview-37124d995e3d
* https://sysadmincasts.com/episodes/14-introduction-to-linux-control-groups-cgroups
* https://echorand.me/posts/docker-user-namespacing-remap-system-user/
* https://www.slideshare.net/jpetazzo/anatomy-of-a-container-namespaces-cgroups-some-filesystem-magic-linuxcon
* https://endocode.com/blog/2016/01/22/linux-containers-and-user-namespaces/
* https://leftasexercise.com/2018/04/12/docker-internals-process-isolation-with-namespaces-and-cgroups/
* https://opensource.com/article/19/10/namespaces-and-containers-linux
* https://www.toptal.com/linux/separation-anxiety-isolating-your-system-with-linux-namespaces

* https://integratedcode.us/2015/10/13/user-namespaces-have-arrived-in-docker/
* https://medium.com/@kasunmaduraeng/docker-namespace-and-cgroups-dece27c209c7
* https://www.cloudsigma.com/manage-docker-resources-with-cgroups/
* https://codezup.com/docker-container-namespacing-control-groups/
* https://www.jujens.eu/posts/en/2017/Jul/02/docker-userns-remap/ << HOT, nastaveni docker volumes dle namespaces
* https://washraf.gitbooks.io/the-docker-ecosystem/content/Chapter%201/Section%203/Control%20Groups.html
* https://docs.oracle.com/en/operating-systems/oracle-linux/docker/docker-service-namespace.html
* https://docs.oracle.com/cd/E37670_01/E75728/html/ch04s13.html
* https://www.docker.com/sites/default/files/WP_IntrotoContainerSecurity_08.19.2016.pdf << stazene v /www
* https://www.thegeekdiary.com/how-to-configure-network-namespaces-in-docker-containers/
* https://network-insight.net/2016/03/hands-on-docker-networking-and-namespaces/

#### access
* https://devops.stackexchange.com/questions/1116/how-to-prohibit-access-to-internals-of-docker-container
* https://www.sumologic.com/blog/securing-docker-containers/
* https://blog.container-solutions.com/docker-security-admin-controls-2
* https://www.stackrox.com/post/2017/08/hardening-docker-containers-and-hosts-against-vulnerabilities-a-security-toolkit/
* https://engineering.linkedin.com/blog/2016/08/don_t-let-linux-control-groups-uncontrolled
