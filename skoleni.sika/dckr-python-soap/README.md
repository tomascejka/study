Zdroje
* https://hub.docker.com/_/python
* https://czsodexo.atlassian.net/browse/IT-15691?focusedCommentId=322520

TL;DR – připravil jsem python program, který se připojují k veřejnému WSDL (který má dva soap11 a soap12 binding-y) a vynutím soap12 binding. Dále jsem zjistil, že knihovna, kterou jsem vybral umí změnit URL dle potřeby (tzn. ignoruje tu WSDL/service/port/soap12:address) a zvenku se dá nastavit jiná (např. na LB). Jinými slovy problémy p. Tiršela jsou řešitelné – knihovnou Zeep.

Píši do mailu – protože to může/nemusí mít výbušný charakter – že javista kecá pythonistovi do rybníčku – ponechám na Vás, co a v jakém množství to předáte SDX. Každopádně si myslím, že pokud se zasekali v jiné knihovně (na netu jsem je našel – asi záleží jakou mají versi Pythonu), tak by jim to mohlo pomoci – a snad by to pomohlo i nám, že bude jeden partner umět komunikovat standardně (bez workaroudnů – však víte jakých, např. šablonování soap zpráv, parsování dle řádek, kt. shodí jiným namespace apod.).

Popis problémů
•	Více soap-bindingů (výběr specifického) – není problém viz. Zeep – non-default-bindings - https://docs.python-zeep.org/en/master/client.html#using-non-default-bindings
•	Změna adresy ve WSDL (viz. service/soap) – není problém viz Zeep – Service Proxy - https://docs.python-zeep.org/en/master/client.html#creating-new-serviceproxy-objects
•	Vše řeším pomocí knihovny - https://docs.python-zeep.org/en/master/index.html

Příběh
Mě hrozně zamrzelo, že python je dehonestován (resp. nějaká knihovna, kterou neznám), že prý SOAP neumí (a je potřeba tento pokus smést ze stolu:  viz. „To jsou bohuzel rizika, na ktere jsme upozornovali a tezko predem rici, kdy a jestli vubec SOAP knihovna v necem pomuze“ ) – a to mne inspirovalo k pokusu si napsat jednoduchý program a otestovat SOAP. Python totiž mám v TODO, jakmile se uklidní rodina (holky vyrostou, že se naučím další jazyk právě python) – takže motivací byla i budoucí  (techno) láska.
--
