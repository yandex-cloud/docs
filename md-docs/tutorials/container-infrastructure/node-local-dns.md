# Настройка NodeLocal DNS Yandex Managed Service for Kubernetes

Чтобы снизить нагрузку по [DNS-запросам](../../glossary/dns.md) в [кластере Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), используйте компонент NodeLocal DNS.

{% note tip %}

Если кластер Managed Service for Kubernetes содержит более 50 [узлов](../../managed-kubernetes/concepts/index.md#node-group), используйте [автоматическое масштабирование DNS](dns-autoscaler.md).

{% endnote %}

{% note warning %}

Если в кластере Managed Service for Kubernetes используется контроллер сетевых политик Cilium, то настройка имеет свои особенности. Воспользуйтесь следующей [инструкцией](../../managed-kubernetes/operations/cilium-node-local-dns.md).

{% endnote %}

NodeLocal DNS является системным компонентом кластера Managed Service for Kubernetes, выполняющим роль локального DNS-кеша на каждом узле.

NodeLocal DNS разворачивается в кластере как [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) с подами `node-local-dns` в пространстве имен `kube-system`. NodeLocal DNS настраивает [iptables](https://ru.wikipedia.org/wiki/Iptables) так, чтобы запросы подов к сервису `kube-dns` перенаправлялись в под `node-local-dns` на этом же узле (локальный кеш):
* Если в кеше есть подходящая запись и ее срок действия не истек, ответ возвращается без обращения к основному DNS-сервису кластера.
* Если в кеше нет записи или ее срок действия истек, запрос пересылается на основной DNS-сервис `kube-dns`.

{% note info %}

DNS-запросы перенаправляются в локальный кеш прозрачно для подов: для этого не нужно изменять файл `/etc/resolv.conf` на поде и перезапускать его. Отключение NodeLocal DNS тоже не требует этих действий.

{% endnote %}

Использование NodeLocal DNS в кластере Managed Service for Kubernetes имеет [ряд преимуществ](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation):
* Уменьшение времени обработки DNS-запросов.
* Снижение объема внутреннего сетевого трафика, что позволяет избежать ограничений по [количеству соединений](../../vpc/concepts/limits.md#vpc-limits).
* Снижение риска сбоев механизма connection tracking (conntrack) за счет уменьшения числа UDP-запросов к DNS-сервису.
* Повышение устойчивости и масштабируемости кластерной DNS-подсистемы.

В этом руководстве вы установите компонент NodeLocal DNS в кластере Managed Service for Kubernetes и проверите его работу с помощью пакета сетевых утилит `dnsutils`. Для этого выполните следующие шаги:

1. [Установите NodeLocal DNS](#install).
1. [Создайте тестовое окружение](#create-test-environment).
1. [Проверьте работу NodeLocal DNS](#test-nodelocaldns).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Мастер Managed Service for Kubernetes ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Узлы кластера Managed Service for Kubernetes: использование вычислительных ресурсов и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Публичные IP-адреса для узлов кластера Managed Service for Kubernetes ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

### Создайте инфраструктуру {#create-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. Создайте [облачную сеть](../../vpc/operations/network-create.md) и [подсеть](../../vpc/operations/subnet-create.md).
  1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent` и `vpc.publicAdmin`.

  1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

      {% note warning %}
      
      От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
      
      {% endnote %}

  1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) с [публичным доступом в интернет](../../managed-kubernetes/operations/node-group/node-group-update.md#node-internet-access) и с группами безопасности, подготовленными ранее.

- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
  1. Скачайте в ту же рабочую директорию файл конфигурации кластера Managed Service for Kubernetes [k8s-node-local-dns.tf](https://github.com/yandex-cloud-examples/yc-mk8s-node-local-dns-cache/blob/main/k8s-node-local-dns.tf). В файле описаны:

     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * Кластер Managed Service for Kubernetes.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и [группы узлов Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#node-group).
     * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. Укажите в файле конфигурации:

     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версии Kubernetes](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов Managed Service for Kubernetes.
     * CIDR кластера Managed Service for Kubernetes.
     * Имя сервисного аккаунта кластера Managed Service for Kubernetes.

  1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте необходимую инфраструктуру:

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

{% note warning %}

Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.

{% endnote %}

### Подготовьте окружение {#prepare-env}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Установите NodeLocal DNS {#install}

{% list tabs group=instructions %}

- Yandex Cloud Marketplace {#marketplace}

  Установите [NodeLocal DNS](https://yandex.cloud/ru/marketplace/products/yc/node-local-dns) с помощью Cloud Marketplace, как описано в [инструкции](../../managed-kubernetes/operations/applications/node-local-dns.md#marketplace-install).

- Вручную {#manual}

  1. Узнайте [IP-адрес](../../vpc/concepts/address.md) сервиса `kube-dns`:

      ```bash
      kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
      ```

  1. Создайте файл `node-local-dns.yaml`. В настройках DaemonSet `node-local-dns` укажите IP-адрес сервиса `kube-dns`:

      {% cut "node-local-dns.yaml" %}

      ```yaml
      # Copyright 2018 The Kubernetes Authors.
      #
      # Licensed under the Apache License, Version 2.0 (the "License");
      # you may not use this file except in compliance with the License.
      # You may obtain a copy of the License at
      #
      #     http://www.apache.org/licenses/LICENSE-2.0
      #
      # Unless required by applicable law or agreed to in writing, software
      # distributed under the License is distributed on an "AS IS" BASIS,
      # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      # See the License for the specific language governing permissions and
      # limitations under the License.
      # Modified for Yandex Cloud Usage
      ---
      apiVersion: v1
      kind: ServiceAccount
      metadata:
        name: node-local-dns
        namespace: kube-system
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
            bind 169.254.20.10 <IP-адрес_сервиса_kube-dns>
            forward . __PILLAR__CLUSTER__DNS__ {
              prefer_udp
            }
            prometheus :9253
            health 169.254.20.10:8080
          }
          in-addr.arpa:53 {
            errors
            cache 30
            reload
            loop
            bind 169.254.20.10 <IP-адрес_сервиса_kube-dns>
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
            bind 169.254.20.10 <IP-адрес_сервиса_kube-dns>
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
            bind 169.254.20.10 <IP-адрес_сервиса_kube-dns>
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
            hostNetwork: true
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
              image: registry.k8s.io/dns/k8s-dns-node-cache:1.17.0
              resources:
                requests:
                  cpu: 25m
                  memory: 5Mi
              args: [ "-localip", "169.254.20.10,<IP-адрес_сервиса_kube-dns>", "-conf", "/etc/Corefile", "-upstreamsvc", "kube-dns-upstream" ]
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
                  host: 169.254.20.10
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
      ---
      # Headless Service has no ClusterIP and returns Pod IPs via DNS.
      # Used for Prometheus service discovery of node-local-dns metrics.
      apiVersion: v1
      kind: Service
      metadata:
        annotations:
          prometheus.io/port: "9253"
          prometheus.io/scrape: "true"
        labels:
          k8s-app: node-local-dns
        name: node-local-dns
        namespace: kube-system
      spec:
        clusterIP: None
        ports:
          - name: metrics
            port: 9253
            targetPort: 9253
        selector:
          k8s-app: node-local-dns
      ```

      {% endcut %}

      {% note warning %}
      
      Приложение работает корректно только с пространством имен `kube-system`.
      
      {% endnote %}

  1. Создайте ресурсы для NodeLocal DNS:

      ```bash
      kubectl apply -f node-local-dns.yaml
      ```

      Результат:

      ```text
      serviceaccount/node-local-dns created
      service/kube-dns-upstream created
      configmap/node-local-dns created
      daemonset.apps/node-local-dns created
      service/node-local-dns created
      ```

  1. Убедитесь, что DaemonSet успешно развернут и запущен:

      ```bash
      kubectl get ds -l k8s-app=node-local-dns -n kube-system
      ```

      Результат:

      ```text
      NAME            DESIRED  CURRENT  READY  UP-TO-DATE  AVAILABLE  NODE SELECTOR  AGE
      node-local-dns  3        3        3      3           3          <none>         24m
      ```

{% endlist %}

## Создайте тестовое окружение {#create-test-environment}

Для проверки работы локального DNS в кластере Managed Service for Kubernetes будет запущен под `nettool`, содержащий в себе пакет сетевых утилит `dnsutils`.

1. Запустите под `nettool`:

   ```bash
   kubectl run nettool --image cr.yandex/yc/demo/network-multitool -- sleep infinity
   ```

1. Убедитесь, что под перешел в состояние `Running`:

   ```bash
   kubectl get pods
   ```

1. Выясните, на каком узле кластера Managed Service for Kubernetes развернут под `nettool`:

   ```bash
   kubectl get pod nettool -o wide
   ```

   Имя узла указано в столбце `NODE`, например:

   ```text
   NAME     READY  STATUS   RESTARTS  AGE  IP         NODE        NOMINATED NODE  READINESS GATES
   nettool  1/1    Running  0         23h  10.1.0.68  <имя_узла>  <none>          <none>
   ```

1. Узнайте IP-адрес пода, на котором развернут NodeLocal DNS:

   ```bash
   kubectl get pod -o wide -n kube-system | grep 'node-local.*<имя_узла>'
   ```

   Результат:

   ```text
   node-local-dns-gv68c  1/1  Running  0  26m  <IP-адрес_пода>  <имя_узла>  <none>  <none>
   ```

## Проверьте работу NodeLocal DNS {#test-nodelocaldns}

Для проверки работы локального DNS с пода `nettool` будут выполнены несколько DNS-запросов. При этом будут изменяться метрики количества DNS-запросов на поде, обслуживающем NodeLocal DNS.

1. Узнайте значение метрик для DNS-запросов до начала проверки:

   ```bash
   kubectl exec -ti nettool -- curl http://<IP-адрес_пода>:9253/metrics | grep coredns_dns_requests_total
   ```

   Результат:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="cluster.local."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="cluster.local."} 18
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="cluster.local."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="in-addr.arpa."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="ip6.arpa."} 1
   ```

   Из результата следует, что NodeLocal DNS принимает DNS-запросы на двух IP-адресах:

   * Адрес, совпадающий с Cluster IP сервиса `kube-dns` (в данном случае `10.96.128.2:53`, значение может отличаться).

     Этот адрес является основным. NodeLocal DNS настраивает iptables так, что запросы к сервису `kube-dns` перенаправляются на под `node-local-dns` на этом же узле.

   * Локальный адрес NodeLocal DNS (`169.254.20.10:53`).

     Этот адрес является резервным. Его можно использовать для прямого обращения к поду `node-local-dns`.

1. Выполните DNS-запросы:

   ```bash
   kubectl exec -ti nettool -- nslookup kubernetes && \
   kubectl exec -ti nettool -- nslookup kubernetes.default && \
   kubectl exec -ti nettool -- nslookup ya.ru
   ```

   Результат (IP-адреса могут отличаться):

   ```text
   Server:         10.96.128.2
   Address:        10.96.128.2#53
   
   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   
   Server:         10.96.128.2
   Address:        10.96.128.2#53
   
   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   
   Server:         10.96.128.2
   Address:        10.96.128.2#53
   
   Non-authoritative answer:
   Name:   ya.ru
   Address: 5.255.255.242
   Name:   ya.ru
   Address: 77.88.44.242
   Name:   ya.ru
   Address: 77.88.55.242
   Name:   ya.ru
   Address: 2a02:6b8::2:242
   ```

1. Повторно получите значения метрик для DNS-запросов:

   ```bash
   kubectl exec -ti nettool -- curl http://<IP-адрес_пода>:9253/metrics | grep coredns_dns_requests_total
   ```

   Результат:

   ```text
   # HELP coredns_dns_requests_total Counter of DNS requests made per zone, protocol and family.
   # TYPE coredns_dns_requests_total counter
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="."} 27
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="A",zone="cluster.local."} 30
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="."} 25
   coredns_dns_requests_total{family="1",proto="udp",server="dns://10.96.128.2:53",type="AAAA",zone="cluster.local."} 26
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="cluster.local."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="in-addr.arpa."} 1
   coredns_dns_requests_total{family="1",proto="udp",server="dns://169.254.20.10:53",type="other",zone="ip6.arpa."} 1
   ```

   Из результата следует, что значения метрик увеличились для адреса сервиса `kube-dns` и не изменились для локального адреса NodeLocal DNS. Это означает, что поды продолжают отправлять DNS-запросы по адресу сервиса `kube-dns`, но теперь эти запросы обрабатываются сервисом NodeLocal DNS.

## Удалите NodeLocal DNS {#stop-daemonset}

{% list tabs group=instructions %}

- Yandex Cloud Marketplace {#marketplace}

  Удалите приложение [NodeLocal DNS](https://yandex.cloud/ru/marketplace/products/yc/node-local-dns), как описано в [инструкции](../../managed-kubernetes/operations/applications/marketplace.md#delete-apps).

- Вручную {#manual}

  Выполните команду:

  ```bash
  kubectl delete -f node-local-dns.yaml
  ```

  Результат:

  ```text
  serviceaccount "node-local-dns" deleted
  service "kube-dns-upstream" deleted
  configmap "node-local-dns" deleted
  daemonset.apps "node-local-dns" deleted
  service "node-local-dns" deleted
  ```

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. Удалите ресурсы в зависимости от способа их создания:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).

    - Terraform {#tf}

        1. В терминале перейдите в директорию с планом инфраструктуры.
        
            {% note warning %}
        
            Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
        
            {% endnote %}
        
        1. Удалите ресурсы:
        
            1. Выполните команду:
        
                ```bash
                terraform destroy
                ```
        
            1. Подтвердите удаление ресурсов и дождитесь завершения операции.
        
            Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

    {% endlist %}

1. Если для доступа к кластеру Managed Service for Kubernetes или узлам использовались статические [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses), освободите и [удалите](../../vpc/operations/address-delete.md) их.