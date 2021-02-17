# Docker studijní průvodce
Již dlouho sním o postupu, jak studovat komplexní věc efektivně s průkazným usilím (s možností se kdykoli a opakovaně k téma/problému vrátit) a nebrat si DEV prostředí projektu jako rukojmí. Komplexní věc zkoumáš nějaký čas a jseš/budeš neustále přerušován/odváděn od tématu zkoumání a tvé testovací prostředí bude, tzv. hnít /kde si přestal?, co si nastavil?, co si udělal, resp. neudělal - jakou kombinaci si testoval?/ - (nadšení upadá - výsledky v nedohlednu). Dovolím si na chvíli býti více popisný...

## Motiv
Základem je rozebrat téma/myšlenku a uzaknout je do laboratorního prostředí a poslední stav v laboratoři je "vytesán do kamene" (Dockerfile jsem nastavil s těmtio instrukcemi a lze to spustit tímto skriptem a ... (interrupt/skype call ...) jdu řešit jiný projekt/zkoumání končí, pozítří se vracím a vím, co mám dělat - stojím v README.md v konkrétní laboratoři a vím current/last state). Samodokumentující výzkum - končíš s vyřešením tématem/problémem a zároveň jej umíš dokázat/opakovaně (názorně i offlinem via README.md, tzn. kopií laboratoře vzniká pro někoho jiného studnice znalostí - share knowledge). Největším zlem dokumentací/wikin a podobných zdrojů je neaktuálnost (v naší branži tzn. že téma nejde už pustit - a téma je tedy neprůkazné).

## Důsledky
Zkoumání stojí čas / peníze, a proto je důležitá ta průkaznost/opakovatelnost simulace ==> investované usilí je popsané /neměli bychom ideálně se dopustit - resp. klidně se znovu dospustíme, ale nyní existuje možnost si ověřit (nejenom podívat/vygoogolit/ale i hlavně spustit), protože ... v této laboratoři je o tom důkaz a lze to spustit/ověřit/. Řikejte si tomu jak chcete: knowledgeBase, wikina atd. Pro mě je to něco víc (to je o čem sním) ale živá instance, kde si problém umím znovu nasimulovat, popř. event. upravit k novému stavu/času (např. vyšla nová verse java/wildlfy apod.).

## Základních principy
Vše dělej maximálně jednoduše - opakovaně na svým krokem přemýšlej, zda jde udělat jednoduše /zaměř se na cíl tématu/.

Téma zkoumání:
* dokaž jej a to opakovaně (pravidelně zapisuj --> current state)
* závěr zadokumentuj (--> final state)
* (nepovinné) skriptuj vše od samotného počátku (vrátí se ti to)
... povede to k jedné věci /téma může být sice komplexní/, ale budeš pracovat jednoduše. Věř, že na začátku budeš velmi neefektivní - čas se z tebe stane minimilistický borec, žádné téma nebude překážkou.

---------------------------------------------------------------------------------------------------------------
Pozn. nikomu dalé uvedený postup nevnucuji - pouze nabízím alternativu - ke které jsem došel praxí, aneb
jak studovat efektivně komplexní věc (dosaď si své téma).
---------------------------------------------------------------------------------------------------------------

## Pravidla
Základem každého výzkumu (dále jen laboratoř) je pár jednoduchých pravidel, každá laboratoř:
1. má svou složku, název: číslo a velmi krátký název (popisné a unikátní).
2. má jasný cíl: ověřitelný výstup; ideálně znovuopakovatelný (opakování je "víteco")
3. má dokumentaci - popiš cestu k cíli (ideálně od abstraktu k atomické pitvě), ale minimalistickou formou (elaborát odrazuje/nevede čtenáře/tzn. tvého studenta)
4. pomáhame si skripty k dosažení cíli (nesmí však zakrývat detail cíle - ideálně)

## Laboratoř
Je studijní projekt, a bude mít tuto základní strukturu (```tree /F```)

```bash
Project
│   .dockerignore
│   Dockerfile
│   README.txt
├───bin
│    | build.bat
|    | check.bat
|    | clean.bat
│    | global-variables.bat
|    | remove.bat
|    | run.bat
├───resources
|    | *.*
├───temp
└───www
```

### Popis adresářů/souborů v laboratoři
- `bin` obecný adresář pro různé binárky (aktuálně pro spouštěcí docker/image flow příkazů)
- `build.bat` sestavi - docker image s nazvem a ulozi jej do lokalniho docker registry
- `clean.bat` - uklízí lokální registr (bacha:
   - `clean.bat 1` spouští `docker system prune -a`, 
   - `clean.bat` spouští `docker system prune`.
- `global-variables.bat` - obsahuje promenne pro bat skripty (s parametrem vypise obsah vsech promennych, napr. `global-variables.bat 1`)
- `run.bat` - sestavi docker image s nazvem a vytvori instanci kontainer z dane image (s parametrem 1 spusti detached container, 1 spusti container interaktivne, 2 spusti container interaktivne a jeste ti poskytne bash konsoli v kontaineru)
- `/resources` - pro různé zdroje, kt. používám a chci je použít v docker build/run fázích (nesmí být v .dockerignore)
- `/temp` - je pro ruznorode/docasne aktivity
- `/www` - pro ruzne studijni zdroje

... je možné použít skript, který za Vás výše uvedené vytvoří, viz. `cl.bat` /cl.sh v linuxu/ s jedinou výjimkou (verse 1.00) neumím vytvářet v `cl.bat` jiné bat soubory (takže je nutné si vzít ty v `/temp`).

#### Skripty v /bin
Faktem je, že tě nechci odstiňovat od `docker cli api` (viz pravidlo 4), ale pro začátek tě "neštvat psaním tunou příkazů v consoli". Postupem času, jak se budeš nořit do hloubky vědění, zjistíš, že si je chceš psát sám (cílem je tě pouze navést na tuto cestu) resp. doporučuji si napsat své skripty dle povahy/záměru laboratoře. V tomto momentě, je pak možné zapnout "NIGHTMARE mode" v cl.bat (ten už nebude výše uvedené skripty do laboratoře kopírovat, tože si je napíšeš sám :)).

#### Bacha `clean.bat` maže docker registry

<b>VAROVANI</b>
Když něco studuji/bádám - tak si vždy promažu lokální registr image docker-u a to kompletně celou (zbydou tam pracovní image, kt. používá nástroj Docker Desktop). Technicky se spouští příkaz `docker system prune -a` (via skript `clean.bat 1`). Vzhledem jak docker funguje (že si chybějící image dotahá) by to nemuselo nikomu vadit - ale zmiňuji to, aby to nepřekvapilo! 

Pokud s tím nesouhlasíš: pak <b>NEPOUŽÍVEJ `clean.bat` skript</b>!!!

Pozn. na závěr - je to o nastavení workflow, jak budeš pracovat s laboratoří.

### Práce s laboratoří
Cílem je jednoduchost a neštvat uživatele balastem (např. `console command hell`) při studium záměru/tématu.

#### Vytvoření laboratoře
Spuštěním `cl.bat` vytvoříte laboratoř (čísluji od 0 a paduji zleva na 2 pozice, doufám, že 99 laboratoří je dost :)), poté je nutné změnit v `global-variable.bat` lokální proměnnou (`regName`) unikatní hodnotou přes všechny/i budoucí laboratoře (např. já používám pattern-u s tím, že incrementuji pouze číslo nakonci, tzn. `tc_lab1`, `tc_lab2` apod.).

#### Další kroky
Doporučuji použít skripty v `/bin` (alespoň pro začátek), které Vám pomohou se základními a opakujícími se úlohami: vyčištěním prostředí (lokálního registry) via `clean.bat`, zbuildování nové image (nové změny v dockerfile/skriptech v něm použitých apod.) via. `build.bat` a poté spuštění kontejneru via `run.bat`. S těmito skripty byste si měli vystačit na počáteční laborování s dockerfile/compose soubory apod. 

#### Defaultní workflow
Většinou (otestoval jsem na sobě) používám tento postup.
1. nejdříve přejmenuji proměnou `regName` v `global-variables.bat`
2. spustím vždy `clean.bat 1` (BACHA MAŽU TÍM KOMPLETNĚ LOKÁLNÍ DOCKER IMAGE REGISTRY), lze vynechat (pak je nutná vícepráce v CLI)
3. pak `build.bat`
4. a poté `run.bat`
5. a nyní ověřuji cíl/myšlenku pro danou laboratoř (např. zkoumání co je uvnitř kontejneru apod.)
6. v případě chyby/nesplnění cíle - provádím účelové změny (abych cíle dosáhl) a opakuji postup 3-5

ad 5 je velmi různorodý, např. je možné mrknout dovnitř běžícího kontaineru, nebo si prohlédnout výslednou image apod. Pro tyto účely jsem připravil `check.bat` (opět pro začátek pomůže, pak si jej přepiš/nepoužívej) - technicky používá `exec`/`inspect` příkazy z `docker CLI API`.

## Poznámky
Uvítám jakoukoli kritiku a připomínky - cokoli by práci s laboratoří zefektivnilo velmi vřele uvítám.

## TODO
Budu to migrovat na linux, tzn. upravit všechny README a připravit skripty pro bash.

```bash
mkdir myproject && cd myproject
echo "hello" > hello
echo -e "FROM busybox\nCOPY /hello /\nRUN cat /hello" > Dockerfile
docker build -t helloapp:v1 .
```
Figure 1 - Dockerfile z console, [zdroj](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#understand-build-context)

## Zdroje
* https://github.com/IBM/docker101