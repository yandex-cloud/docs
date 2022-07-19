# Настройка Node Local DNS для контроллера сетевых политик Cilium

Из этой статьи вы узнаете, как настроить локальный DNS для [контроллера сетевых политик Cilium](../concepts/network-policy.md#cilium) с помощью [Local Redirect Policy](https://docs.cilium.io/en/v1.9/gettingstarted/local-redirect-policy/).

Чтобы настроить локальный DNS в кластере {{ k8s }}:
1. [Подготовьте спецификации для Node Local DNS и Local Redirect Policy](#create-manifests).
1. [Создайте тестовое окружение](#create-test-environment).
1. [Проверьте работу Node Local DNS](#test-nodelocaldns).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер](kubernetes-cluster/kubernetes-cluster-create.md) {{ k8s }} со следующими настройками:
   1. **Релизный канал**: `RAPID`.
   1. В блоке **Сетевые настройки кластера** выберите опцию **Включить туннельный режим**.
1. [Создайте группу узлов](node-group/node-group-create.md) любой подходящей вам конфигурации.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Узнайте IP-адрес сервиса `kube-dns`:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
   ```

## Подготовьте спецификации для Node Local DNS и Local Redirect Policy {#create-manifests}

1. Создайте файл `node-local-dns.yaml`. В настройках DaemonSet `node-local-dns` укажите IP-адрес сервиса `kube-dns`:

   `node-local-dns.yaml`

   ```yaml
   ---
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: node-local-dns
     namespace: kube-system
     labels:
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: kube-dns-upstream
     namespace: kube-system
     labels:
       k8s-app: kube-dns
       kubernetes.io/name: "KubeDNSUpstream"
   spec:
     ports:
     - name: dns
       port: 53
       protocol: UDP
       targetPort: 53
     - name: dns-tcp
       port: 53
       protocol: TCP
       targetPort: 53
     selector:
       k8s-app: kube-dns
   ---
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: node-local-dns
     namespace: kube-system
     labels:
   data:
     Corefile: |
       cluster.local:53 {
         errors
         cache {
           success 9984 30
           denial 9984 5
         }
         reload
         loop
         bind 0.0.0.0
         forward . __PILLAR__CLUSTER__DNS__ {
           prefer_udp
         }
         prometheus :9253
         health
       }
       in-addr.arpa:53 {
         errors
         cache 30
         reload
         loop
         bind 0.0.0.0
         forward . __PILLAR__CLUSTER__DNS__ {
           prefer_udp
         }
         prometheus :9253
       }
       ip6.arpa:53 {
         errors
         cache 30
         reload
         loop
         bind 0.0.0.0
         forward . __PILLAR__CLUSTER__DNS__ {
           prefer_udp
         }
         prometheus :9253
       }
       .:53 {
         errors
         cache 30
         reload
         loop
         bind 0.0.0.0
         forward . __PILLAR__UPSTREAM__SERVERS__ {
           prefer_udp
         }
         prometheus :9253
       }
   ---
   apiVersion: apps/v1
   kind: DaemonSet
   metadata:
     name: node-local-dns
     namespace: kube-system
     labels:
       k8s-app: node-local-dns
   spec:
     updateStrategy:
       rollingUpdate:
         maxUnavailable: 10%
     selector:
       matchLabels:
         k8s-app: node-local-dns
     template:
       metadata:
         labels:
           k8s-app: node-local-dns
         annotations:
           prometheus.io/port: "9253"
           prometheus.io/scrape: "true"
       spec:
         priorityClassName: system-node-critical
         serviceAccountName: node-local-dns
         dnsPolicy: Default # Don't use cluster DNS.
         tolerations:
         - key: "CriticalAddonsOnly"
           operator: "Exists"
         - effect: "NoExecute"
           operator: "Exists"
         - effect: "NoSchedule"
           operator: "Exists"
         containers:
         - name: node-cache
           image: k8s.gcr.io/dns/k8s-dns-node-cache:1.17.0
           resources:
             requests:
               cpu: 25m
               memory: 5Mi
           args: [ "-localip", "169.254.20.10,<IP-адрес сервиса kube-dns>", "-conf", "/etc/Corefile", "-upstreamsvc", "kube-dns-upstream", "-skipteardown=true", "-setupinterface=false", "-setupiptables=false" ]
           securityContext:
             privileged: true
           ports:
           - containerPort: 53
             name: dns
             protocol: UDP
           - containerPort: 53
             name: dns-tcp
             protocol: TCP
           - containerPort: 9253
             name: metrics
             protocol: TCP
           livenessProbe:
             httpGet:
               path: /health
               port: 8080
             initialDelaySeconds: 60
             timeoutSeconds: 5
           volumeMounts:
           - mountPath: /run/xtables.lock
             name: xtables-lock
             readOnly: false
           - name: config-volume
             mountPath: /etc/coredns
           - name: kube-dns-config
             mountPath: /etc/kube-dns
         volumes:
         - name: xtables-lock
           hostPath:
             path: /run/xtables.lock
             type: FileOrCreate
         - name: kube-dns-config
           configMap:
             name: kube-dns
             optional: true
         - name: config-volume
           configMap:
             name: node-local-dns
             items:
               - key: Corefile
                 path: Corefile.base
   ```

1. Создайте файл `node-local-dns-lrp.yaml`:

   {% cut "node-local-dns-lrp.yaml" %}

   ```yaml
   ---
   apiVersion: "cilium.io/v2"
   kind: CiliumLocalRedirectPolicy
   metadata:
     name: "nodelocaldns"
     namespace: kube-system
   spec:
     redirectFrontend:
       serviceMatcher:
         serviceName: kube-dns
         namespace: kube-system
     redirectBackend:
       localEndpointSelector:
         matchLabels:
           k8s-app: node-local-dns
       toPorts:
         - port: "53"
           name: dns
           protocol: UDP
         - port: "53"
           name: dns-tcp
           protocol: TCP
   ```

   {% endcut %}

1. Создайте ресурсы для Node Local DNS:

   ```bash
   kubectl apply -f node-local-dns.yaml
   ```

   Результат:

   ```text
   serviceaccount/node-local-dns created
   service/kube-dns-upstream created
   configmap/node-local-dns created
   daemonset.apps/node-local-dns created
   ```

1. Создайте ресурсы для Local Redirect Policy:

   ```bash
   kubectl apply -f node-local-dns-lrp.yaml
   ```

   Результат:

   ```text
   ciliumlocalredirectpolicy.cilium.io/Node Local DNS created
   ```

## Создайте тестовое окружение {#create-test-environment}

Для проверки работы локального DNS в кластере будет запущен [под](../concepts/index.md#pod) `nettool`, содержащий в себе пакет сетевых утилит `dnsutils`.
1. Запустите под `nettool`:

   ```bash
   kubectl run nettool --image {{ registry }}/yc/demo/network-multitool -- sleep infinity
   ```

1. Убедитесь, что под перешел в состояние `Running`:

   ```bash
   kubectl get pods
   ```

1. Выясните, на каком узле кластера {{ k8s }} развернут под `nettool`:

   ```bash
   kubectl get pod nettool -o wide
   ```

   Имя узла указано в столбце `NODE`, например:

   ```text
   NAME     READY  STATUS   RESTARTS  AGE  IP         NODE        NOMINATED NODE  READINESS GATES
   nettool  1/1    Running  0         23h  10.1.0.68  <имя узла>  <none>          <none>
   ```

1. Узнайте IP-адрес пода, на котором развернут Node Local DNS:

   ```bash
   kubectl get pod -o wide -n kube-system | grep 'node-local.*<имя узла>'
   ```

   Результат:

   ```text
   node-local-dns-gv68c  1/1  Running  0  26m  <IP-адрес пода>  <имя узла>  <none>  <none>
   ```

## Проверьте работу Node Local DNS {#test-nodelocaldns}

Для проверки работы локального DNS с пода `nettool` будут выполнены несколько DNS-запросов. При этом будут изменяться метрики количества DNS-запросов на поде, обслуживающем Node Local DNS.
1. Узнайте значение метрик для DNS-запросов до начала проверки:

   ```bash
   kubectl exec -ti nettool -- curl http://<IP-адрес пода>:9253/metrics | grep coredns_dns_requests_total
   ```

   Результат:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="cluster.local."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="in-addr.arpa."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="other",zone="ip6.arpa."} 1
   ```

1. Выполните DNS-запросы:

   ```bash
   kubectl exec -ti nettool -- nslookup kubernetes && \
   kubectl exec -ti nettool -- nslookup kubernetes.default && \
   kubectl exec -ti nettool -- nslookup ya.ru
   ```

   Результат (IP-адреса могут отличаться):

   ```text
   Name:   kubernetes.default.svc.cluster.local
   Address: 10.2.0.1

   Server:         10.2.0.2
   Address:        10.2.0.2#53

   Name:   kubernetes.default.svc.cluster.local
   Address: 10.2.0.1

   Server:         10.2.0.2
   Address:        10.2.0.2#53

   Non-authoritative answer:
   Name:   ya.ru
   Address: 87.250.250.242
   Name:   ya.ru
   Address: 2a02:6b8::2:242
   ```

1. Убедитесь, что значения метрик увеличились:

   ```bash
   kubectl exec -ti nettool -- curl http://<IP-адрес пода>:9253/metrics | grep coredns_dns_requests_total
   ```

   Результат:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="A",zone="."} 3
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="A",zone="cluster.local."} 6
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="AAAA",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://0.0.0.0:53",type="AAAA",zone="cluster.local."} 2
   ...
   ```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите кластер {{ k8s }}](kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если для доступа к кластеру или узлам использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.