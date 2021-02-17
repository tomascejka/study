---------------
WARN
---------------
* https://12factor.net/ << PRECIST
* https://en.wikipedia.org/wiki/Twelve-Factor_App_methodology
* https://kubernetes.io/docs/tutorials/kubernetes-basics/
* kubernetes cluster potrebuje IMAGE dostupne z externiho docker registry - tzn. na UAT/PROD bude muset existovat drive nez ma smysl instalovat K8 cluster
	- https://github.com/ondrejsika/docker-training#own-docker-registry
* overit pametove naroky aplikace, pak nastavit v Deployments/Resources
* pripravit si testy, ktere overi, ze funguje multi-thread chovani je v poradku - anti-deadlock testy
* vycisti K8 cluster - kubectl get deploy,svc,rs,po
* tool pro zatez"
	- https://httpd.apache.org/docs/2.4/programs/ab.html
	- https://rieckpil.de/howto-simple-load-testing-with-apache-benchmark/
	- https://www.petefreitag.com/item/689.cfm
	- https://diamantidis.github.io/2020/07/15/load-testing-with-apache-bench

Co musi bezet po celou dobu pri K8 training-u:
* minikube start << cluster s jednim NODE
* kubectl proxy << ?? PROSIM KOMENT ??, divat se do kontejneru z lokalu
* minikube dashboard << nahled na cluster via GUI
* pak spusit tyto yml:
	- kubectl apply -f 04_02_deployment.yml
	- kubectl apply -f .\service.yml
	- pak v firefox: 
		- http://127.0.0.1:8001/api/v1/namespaces/default/services/example/proxy/
* (dle potreby)kubectl port-forward pod/simple-hello-world 8000:80 << port-forwarding (vhodne na DEVu)
* pak muzes mit console (powershell/microsoft-shell/shell apod) 
	- v kt. spoustit kubectl prikazy 
	- tzn. ovladani master/worker NODE
	- zde je misto, kde si hrajes s clusterem

* zdroje:
	- stepan.vrany - https://blog.vrany.dev/
	- marek.bartik - 
	- https://kubernetespodcast.com/

* udelat doporuceni na twitter/linkedin
--

K8 komponenty:
* bezi na masterech:
* Api Server - aka Zookeeper
* Controller Manager/Scheduler - mastering pod-u a cluster-u overuje stav a snazi si jej nastavit do pozad. stavu

* na clientech bezi:
- Kubelet
- KubeProxy - pro LB/forward traficku z/ven do clusteru

K8 zdroje:
* Pod - nejmensi stavebni blok (1 nebo vice kontaineru)
	- nemaji stabilni sitovy interface
* Deployment
	- managuje POD-y, update POD-u
	- nemaji stabilni sitovy interface
* Service 
	- maji stabilni sitovy interface (IP, DNS)
	- vidi sitove na jednotlive POD-y
* Ingress
	- LBbalancing, Proxy - expose IP adres
* Others - na slide, viz. https://sika.link/k8s-slides
--

Nástroje:
- kubectl
- helm 
	- package manager
	- template manifesty, deployment management
	- umozni rychlejsi setup prostredi
- minikube - spusteni localniho kubernetes pro vyvoj
- kubeadm - pro spravu clusteru
--

Nastroj pro ovladani k8 clusteru
* https://github.com/ondrejsika/kubernetes-training#kube-ps1
* https://github.com/ondrejsika/kubernetes-training#kubectx--kubens

--

Dashboard
* https://github.com/kubernetes/dashboard
* instralace na PROD - http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=default
--

Prikaz
* kubectl describe no minikube << statistika clusteru
* https://skaffold.dev/ -- nastroj pro k8 deployment
* kubectl describe -f 01_pod.yml 
	- popise to dany POD
* spusteni neco v POD-u
	- https://github.com/ondrejsika/kubernetes-training#exec-connect-pod
	- pripoji se do POD-u do prniho kontajneru, tzn. nginx/debian bash
	- kubectl exec -ti multi-container-pod -- bash
* logy
	- kubectl logs multi-container-pod nginx
	- kouka na logy a je nutne koukat pres containers/name


### POD - 1. pokus - 01_pod.yml
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get -f 01_pod.yml
Error from server (NotFound): pods "simple-hello-world" not found
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl apply -f 01_pod.yml
pod/simple-hello-world created
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get -f 01_pod.yml
NAME                 READY   STATUS              RESTARTS   AGE
simple-hello-world   0/1     ContainerCreating   0          5s
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get -f 01_pod.yml
NAME                 READY   STATUS    RESTARTS   AGE
simple-hello-world   1/1     Running   0          14s
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get po
NAME                 READY   STATUS    RESTARTS   AGE
simple-hello-world   1/1     Running   0          34s
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> curl http://127.0.0.1:8001/api/v1/namespaces/default/pods/simple-hello-world/proxy/
Hello World from Go! simple-hello-world
--

### POD - 2. pokus - 02_pod.yml
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl apply -f 02_pod.yml
pod/multi-container-pod created
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get po
NAME                  READY   STATUS              RESTARTS   AGE
multi-container-pod   0/2     ContainerCreating   0          6s
simple-hello-world    1/1     Running             0          25m
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get po
NAME                  READY   STATUS              RESTARTS   AGE
multi-container-pod   0/2     ContainerCreating   0          11s
simple-hello-world    1/1     Running             0          25m
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get po -w
NAME                  READY   STATUS              RESTARTS   AGE
multi-container-pod   0/2     ContainerCreating   0          17s
simple-hello-world    1/1     Running             0          25m
multi-container-pod   2/2     Running             0          26s
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get po
NAME                  READY   STATUS    RESTARTS   AGE
multi-container-pod   2/2     Running   0          38s
simple-hello-world    1/1     Running   0          25m
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> kubectl get -f 02_pod.yml
NAME                  READY   STATUS    RESTARTS   AGE
multi-container-pod   2/2     Running   0          99s
PS D:\Study\skoleni.sika\kubernetes\kubernetes-training> curl http://127.0.0.1:8001/api/v1/namespaces/default/pods/multi-container-pod/proxy/
Thu Jan 28 09:56:13 UTC 2021
--

### Zapnul jsem port-forward proxy
	- $ kubectl port-forward pod/simple-hello-world 8000:80
	- tzn. komunikace z prohlizece na 8000 ale interne v cluster-u jede na 80
	- MUSI BEZET po celou dobu hrani-si s clusterem
--

### POD
* https://kubernetes.io/docs/concepts/workloads/pods/
* https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/
* https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/
* https://kubernetes.io/docs/tasks/configure-pod-container/
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

#### POD spousteni/pripojit k NODU
zdroj - https://github.com/ondrejsika/kubernetes-training#assigning-pods-to-nodes

* POD - je kontejner
* NODE - je VM v kt. bezi K8 Cluster
* viz. nodename.yml
* kubectl get no --show-labels, info o clusteru
* omezeni POD-u, aby bezel na konkretnim NODE (aby X/pod bezelo NEKDE na Z/node)
--

#### Taints a Tolerations
* nastudovat, vhodne pro maintance
* migrace na jiny VM (aka migrace VM) - PODy potrebuji presunout/ne je stopnout a tim o ne prijit (napr. logy)
* nastudovat master/worker node!!!!

### ReplicaSet
* sprava node, drzi jejich pocet, tzn. kubectl delete
* dale to zaridi, ze kdyz node skonci na technickou chybu a K8 cluster jej "znici" (chrani zbytek cluster-u), tak ReplicaSet "z druhe strany" opet tento NODE nahradi novy NODE-em, aplikace znova nastartuje!!!

### Service
* https://kubernetes.io/docs/concepts/services-networking/
* https://kubernetes.io/docs/concepts/services-networking/service/
* https://kubernetes.io/docs/concepts/services-networking/connect-applications-service/
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
--

### Deployment
* https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
* https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/
* https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/
* tohle je spravne misto pro spravu resource - ReplicaSet, Service, Pod jsou pro konfiguraci resourcu, ale ne pro ovladani, tzn. az na urovni Deployemnt je vhodne ovladat cluster K8
* kubectl apply -f 04_01_deployment.yml && kubectl rollout status deployment hello-world 
* 'kubectl rollout status' -  to zaridi, ze aplikace odpovida po celou dobu nasazeni
* zkus nastavit koukat via 
	- watch: kubectl get deploy,rs,po
	- watch: curl http://127.0.0.1:8001/api/v1/namespaces/default/services/example/proxy/
	- kazde v jinem okne a pak je mozne sledovat vyvoj v clusteru a vyvoj via GUI (release vice versi najednou - upgrade)
* jak provest rollback:
	- viz. https://github.com/ondrejsika/kubernetes-training#rollback-rolloutv1/namespaces/default/services/example/proxy/
	- kubectl rollout undo deploy hello-world
	- zmeny lze sledovat - kubectl rollout history deploy hello-world
	- vypis REVISION a CHANGE-CAUSE tak posledni radka je prave nasazena v clusteru
* https://github.com/ondrejsika/kubernetes-training#deployment-strategies
* takze pisu vse krome ReplicaSet
* vhodne pro nestavove aplikace, webove FE

Ladeni issue
* kubectl describe node/xxx vypise to problem, kdyz vidim v kubectl get po ve Status Pending a neprepina se do stavu Running

### StatefulSet
- viz. https://github.com/ondrejsika/kubernetes-training#create-statefulset
- pro aplikace co si drzi stav
- pro stavove aplikace
- napr. database, jms (rabbit-mq)
- pro koukani na StatefulSet via Service, vytvarime tzv. Headless Service, viz. https://github.com/ondrejsika/kubernetes-training#headless-service
- nemaji ReplicaSet, v chodu je udrzuje samotny cluster

### DeamonSet
* https://github.com/ondrejsika/kubernetes-training#create-daemonset
* udrzujou jeden POD na jednom NODE
* vhodne pro LB, monitoring server,proxy

### Job
* viz. job.yml v /training-kubernetes
* https://kubernetes.io/docs/tasks/job/
* https://kubernetes.io/docs/concepts/workloads/controllers/job/

### CronJob
* viz. cronjob.yml v /training-kubernetes
* https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/
* https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/

### Sitarina

#### Node port
* je to na tomto PORT-u
* a konkretni IP pod-u
* a to neni vhodne pro DNS - toto jeste neni co chceme vystavovat
* https://github.com/ondrejsika/kubernetes-training#create-service-nodeport
	- exposuje na konkretnim node

#### Loadbalancer
* https://github.com/ondrejsika/kubernetes-training#create-loadbalancer-service-public-cloud-only
* timto lze exposnout Service
* proxy a to si rozdelovat az Kubernetes
* musim pouzit Service/Type=Loadbalancer, ClusterIP
* v pripade public IP je to nutnost
* v pripade private IP staci komponenta Service (plati tehdy, pokud client bezi v te same siti)

#### Ingress
* https://github.com/ondrejsika/kubernetes-training#create-ingress
* https://kubernetes.io/docs/concepts/services-networking/ingress/
* https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
* https://www.ibm.com/cloud/blog/kubernetes-ingress
* je to reverzni proxy - neni to router

* minikube addons enable ingress (nutnost)
	- PS C:\Users\tomas.cejka.STYRAX> minikube addons enable ingress
	- * After the addon is enabled, please run "minikube tunnel" and your ingress resources would be available at "127.0.0.1"
	* Verifying ingress addon...
	* The 'ingress' addon is enabled
* ve skoleni viz. ingress-traefik.yml

Dalsi odkazy k sitarine
* https://blog.getambassador.io/kubernetes-ingress-nodeport-load-balancers-and-ingress-controllers-6e29f1c44f2d
* https://thenewstack.io/kubernetes-ingress-for-beginners/
--

# Vse dohromady
* https://github.com/ondrejsika/kubernetes-training#deploy-application-multiple-deployments-and-services
* kubectl get po -A -l project=counter
* kubectl get po -A
* minikube service counter
* jak stavet FE, backend + redis
--

-- 2021-01-29 ---------------------------------------------------------------------------------------------------------------

### Init containers
* https://github.com/ondrejsika/kubernetes-training#initcontainers
* https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
* slouzi pro init stav, spousti se pres POD-y
* naco? PRAVIDLO: 
	- cekani na zavislosti, 
	- cekat - zda database pojede, 
	- stazeni konfigurace, 
	- sestaveni klicu - securitas
* pokud pravidlo neni splnen - tak navazany POD nepujde spustit
* definuje se v templates/spec/initContainers, pockam se startem nez najede redis
	- redis:2345
	- -t
	- "60"
--

### Namespace
* https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/
* https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/
* k cemu jsou, oddeluji:
	- cluster jeden na vse (lze to)
	- cluster rozdelit dle namespace 
		- na urovni prostedi: DEV,UAT,PROD
		- na urovni aplikaci: Search module, Modify module apod.
		- na urovni architetury: Monitoring, Proxy
* kubectl api-resource, zjistim, zda Resource jde namespaceovat
* deploye do namespace 
	- kubectl apply -f 07_counter.yml -n counter << deploy do namespace
	- kubectl config set-context $(kubectl config current-context) --namespace=counter << switch
	- kubectl get pods -n counter << prohlidnout si namespace
	- kubectl delete ns counter << kdyz smaze namespace, samze resource v nem nalinkovane
	- dobre pro zkouseni, hrani si, vytvorit si namespace a odladit si v nem reseni
	- viz. 
		- napr. https://kubernetes.io/docs/concepts/policy/resource-quotas/#object-count-quota
#### Resource Quotas
* omezuje namespace v ramci clusteru, na urovni Resource (pod-y), Hardware (pamet, cpu) a mnoho dalsich viz. dokumentace
* https://kubernetes.io/docs/concepts/policy/resource-quotas/
* https://github.com/ondrejsika/kubernetes-training#resource-quotas
* viz. resourcequota.yml
* Jak sledovat a ladit:
	* resourcequota.yml << definujes limity, viz. https://kubernetes.io/docs/concepts/policy/resource-quotas/#object-count-quota
	* pak 
		- kubectl apply -f 01_pod.yml && kubectl apply -f 04_02_deployment.yml
		- kubectl apply -f webservices.yml << a tohle upadne, protoze limity na namespace
	* kubectl describe -f resourcequota.yml << hezky vypise, co je v namespace jiz pouzite a popr. VOLNE!!! lze si stim hrat


Dulezite prikazy
* https://kubernetes.io/docs/reference/kubectl/overview/
* kubectl apply -f
* kubectl get all
* kubectl describe po {imageName}
* kubectl get namespaces
* kubectl get pods -A
* kubectl delete all --all
* kubectl delete all --all -n {namespace}
* kubectl logs wordpress-6b485cb5bb-nmpmh -n wp << zjisti podName via kubectl get po -n wp, sloupec Name, a nezapomen na Namespace jinak se do logu nepodivas

### Storage a Volumes
* https://github.com/ondrejsika/kubernetes-training#storage--volumes
* https://kubernetes.io/docs/concepts/storage/
* nejjednodusi volume jsou Storages:
	- Store on disk, viz
		- Empty dir volumes are stored in /var/lib/kubelet/pods/<pod uid>/volumes/kubernetes.io~empty-dir
		- viz. kubectl apply -f emptydir.yml
	- Store in memory
		- kubectl apply -f emptydir_memory.yml
		- pro nejake rychle/jednoduche operace

#### PersistenVolume(Claim)
* https://github.com/ondrejsika/kubernetes-training#persistentvolume--persistentvolumeclaim
* viz. 
	- kubectl apply -f pvc_default.yml
	- kubectl delete -f pvc_default.yml
	- kubectl delete pvc/redis << smazani nejake konkretni storage
	- kubectl apply -f pvc_default.yml -n counter << pripojeni k namespace counter
* prohlizeni viz. kubectl get pv,pvc
* StorageClass/PersistenVolume muze byt pripojeni pouze k jednomu NODE
	- kubectl get pv
	- Status udava: Available/Bound
* rucni vytvareni volume, 
    - viz. pvc_nfs.yml, 
	- info https://github.com/ondrejsika/kubernetes-training#create-pv
	- dalsi mozne typy ulozist, viz. https://kubernetes.io/docs/concepts/storage/storage-classes/#provisioner
	- pouziti/namoutovani k NODE
		- viz. pvc_mount_example.yml, tzn. propojeni s NODE
		- v pripade, ze mam funkcni PVC (403 http, kdyz tam pridam index.html a pak se vrati obsah html napr. pro presentaci), pak se mohu podivat via http://127.0.0.1:8001/api/v1/namespaces/default/services/nginx/proxy/
		- pak lze hrat se souborem, napr. takto: kubectl cp index_zmeneny.html {podeName}:/usr/share/nginx/html/index.html
* blobStorage/filesystem, blobStorage je vhodny pro databasi - jedna instance nad jednim NODE-m
* jedno reseni via. https://longhorn.io/ (nejde to v minikube)
	- jde to vyresit pripojeni se na demo/remote cluster viz. https://github.com/ondrejsika/kubernetes-training#connect-my-demo-cluster
	- funguje to tak, ze ten engine/Longhorn pouziva mista na NODE

### ConfigMaps a Secrets
* https://github.com/ondrejsika/kubernetes-training#configmaps--secrets
* viz. kubectl apply -f 11_secret.yml
* https://kubernetes.io/docs/concepts/configuration/configmap/
* https://kubernetes.io/docs/concepts/configuration/secret/
* kubectl get secrets, cm

### Config
* https://github.com/ondrejsika/kubernetes-training#config

### RBAC v K8
* definice prava v K8 via ServiceAccount, Role a Binding-y
* https://kubernetes.io/docs/reference/access-authn-authz/rbac/
* https://github.com/ondrejsika/kubernetes-training#rbac
* viz. 14_admin.yml
* prikazy:
	- kubectl api-resources -o wide
	- kubectl get sa -A << list service account
	- kubectl get no << seznam NODE/clusteru
	- kubectl get clusterrole << seznam roli
	- kubectl describe clusterrole system:node << vycet co muze role system:none
	- jsem schopne se zeptat na, co mam pristup
		- kubectl auth can-i get po
		- kubectl auth can-i --as system:anonymous get po
	- vytvoreni admin cluster: kubectl apply -f 14_admin.yml\
	- kubectl describe -f .\14_admin.yml
		Name:                admin-user
		Namespace:           kube-system
		Labels:              <none>
		Annotations:         <none>
		Image pull secrets:  <none>
		Mountable secrets:   admin-user-token-qkmgn
		Tokens:              admin-user-token-qkmgn
		Events:              <none>


		Name:         admin-user
		Labels:       <none>
		Annotations:  <none>
		Role:
		  Kind:  ClusterRole
		  Name:  cluster-admin
		Subjects:
		  Kind            Name        Namespace
		  ----            ----        ---------
		  ServiceAccount  admin-user  kube-system
    -  kubectl --as system:serviceaccount:kube-system:admin-user get no
* praxe: 
	- vytvorim namepsace a dam uzivatelum roli admin pouze na tento na tento namespace
	- 16_namespace_admin.yml
	- prepinani kontextu, napr. na admina 
		- kubectl --kubeconfig=config config use-context admin
	- defineje se via rules, viz. 16_namespace_admin.yml:
  		- apiGroups: ["*"]
    	- resources: ["*"]
        - verbs: ["*"]
    - jake role lze dohledat via: kubectl api-resources -o wide
--

## Liveness a Readiness Probes
* https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/
* https://github.com/ondrejsika/kubernetes-training#liveness--readiness-probes
* Liveness
	 - restartuje ji
* Readiness:
	- slouzi pro node, kdyz ma problem se spojenim k DB - POD neni mrtvy, jenom ma problem s requesty (nema problem s pameti)
	- resim/pocitam concurrent-con - kdyz zjistim, ze uz nestiham, tak reknu K8 ze nezvladam
	- pocitani je v appce (kolik mam http/otevrenych spojeni)
	- vyhodi z LB/neposila na ni traffic a pak ji vrati zpet do cluster-u
--

## Metriky
* https://github.com/ondrejsika/kubernetes-training#resource-consumption-kubectl-top
* minikube addons enable metrics-server

## Autoscaling/Horizontal Pod Autoscaler
* musi byt zapnute Metriky, viz. kapitola vyse
* https://github.com/ondrejsika/kubernetes-training#resource-consumption-kubectl-top
* kubectl apply -f 04_01_deployment.yml
* hpa_v1.yml
* kubectl run ab --image=ondrejsika/ab --rm -ti -- ab -c 4 -n 100000 http://hpav1-web/
* chvili trva nez to nastruje, metrics server je nutne aby bezel z nich K8 pocita statistiky
	- kubectl top pods -A musi najet tato tabulka

# Helm
* https://github.com/ondrejsika/kubernetes-training#helm
* https://helm.sh/
* https://helm.sh/docs/
* https://ondrej-sika.cz/blog/helm3/
* helm musi byt nainstalovany - mam dodej, jak se to dela
* pro templatovani konfiguraku pro K8, placeholders v konfiguracich!!!!

Pouziti
* helm repo add stable https://charts.helm.sh/stable
* helm repo update
--

CI/CD
* do CI si hodis konfiguracni file
--

## Wordpress demo

Logy:
* kubectl logs wordpress-6b485cb5bb-nmpmh -n wp
* AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.6. Set the 'ServerName' directive globally to suppress this message
--

Reseni:
	- https://stackoverflow.com/questions/58608264/communication-wordpress-inside-kubernetes-and-external-mysql-server-mysql-con
	- http://127.0.0.1:8001/api/v1/namespaces/wp/services/wordpress/proxy/wp-login.php?redirect_to=http%3A%2F%2F127.0.0.1%3A8001%2Fwp-admin%2F&reauth=1
		- a pak v logu vidim problem AH00558
		- v stackoverflow vidim reseni aka: 
			- kubectl port-forward pod/simple-hello-world 8000:80
			- zjisti si tedy pod wordpressu
				- kubectl get all -n wp << localne na mem minikube v namespace wp
				- vidi pod/Name: pod/wordpress-6b485cb5bb-nmpmh
				- kubectl port-forward pod/wordpress-6b485cb5bb-nmpmh 8000:80
				- https://devtidbits.com/2019/11/02/customise-wordpress-on-docker/
		- nakonec wordpress funguje,ale nejde mi login
--

Zdroje
* https://skaffold.dev/, programovani, kt. se automaticky deployue do K8
* https://www.cncf.io/
* https://www.cncf.io/sandbox-projects/
* https://12factor.net/ << PRECIST
* https://github.com/microsoft/terminal << nastroj pro lepsi praci s konsoli v W10
* https://docs.google.com/presentation/d/1K_HV0T89DUf6dGWnJWgrfmpTrsx96TMxJuFby_9TrUk/edit#slide=id.p