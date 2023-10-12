# Настройка NodeLocal DNS Cache

Чтобы снизить нагрузку по [DNS-запросам](../../glossary/dns.md) в [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster), включите NodeLocal DNS Cache. 

{% note tip %}

Если кластер {{ managed-k8s-name }} содержит более 50 [узлов](../concepts/index.md#node-group), используйте [автоматическое масштабирование DNS](dns-autoscaler.md).

{% endnote %}

По умолчанию [поды](../concepts/index.md#pod) отправляют запросы к [сервису](../concepts/service.md) `kube-dns`. В поле `nameserver` в `/etc/resolv.conf` установлено значение `ClusterIp` сервиса `kube-dns`. Для того, чтобы установить соединение с `ClusterIP`, используется [iptables](https://ru.wikipedia.org/wiki/Iptables) или [IP Virtual Server](https://en.wikipedia.org/wiki/IP_Virtual_Server).

При включении NodeLocal DNS Cache в кластере {{ managed-k8s-name }} разворачивается [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). На каждом узле {{ managed-k8s-name }} начинает работу кеширующий агент (под `node-local-dns`). Поды пользователя теперь отправляют запросы к агенту на своем узле {{ managed-k8s-name }}.

Если запрос в кеше агента, он возвращает прямой ответ. В ином случае создается TCP-соединение с `kube-dns` `ClusterIP`. По умолчанию кеширующий агент делает cache-miss запросы к `kube-dns` для [DNS-зоны](../../dns/concepts/dns-zone.md) кластера {{ managed-k8s-name }} `cluster.local`.

С помощью такого плана удается избежать правил DNAT, [connection tracking](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation) и ограничений по [количеству соединений](../../vpc/concepts/limits.md#vpc-limits). Подробнее о NodeLocal DNS Cache смотрите в [документации](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md).

Чтобы настроить кеширование запросов DNS:
1. [{#T}](#install).
1. [{#T}](#configure).
1. [{#T}](#dns-queries).
1. [{#T}](#check-logs).

## Перед началом работы {#before-you-begin}

### Создайте инфраструктуру {#create-infrastructure}

{% list tabs %}

- Вручную

  1. Создайте [облачную сеть](../../vpc/operations/network-create.md) и [подсеть](../../vpc/operations/subnet-create.md).
  1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) `editor`.
  1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../operations/node-group/node-group-create.md) с параметрами:
     * [Версия {{ k8s }}](../concepts/release-channels-and-updates.md) — 1.20 или выше.
     * Публичный доступ в интернет.

- С помощью {{ TF }}

  1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и укажите значения параметров.
  1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-node-local-dns.tf](https://github.com/yandex-cloud/examples/blob/master/tutorials/terraform/managed-kubernetes/k8s-node-local-dns.tf). В файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Группа безопасности](../../vpc/concepts/security-groups.md) и [правила](../operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}:
       * Правила для служебного трафика.
       * Правила для доступа к API {{ k8s }} и управления кластером {{ managed-k8s-name }} с помощью `kubectl` через порты 443 и 6443.
     * Кластер {{ managed-k8s-name }}.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и [группы узлов {{ managed-k8s-name }}](../concepts/index.md#node-group).
  1. Укажите в файле конфигурации:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версии {{ k8s }}](../concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
     * CIDR кластера {{ managed-k8s-name }}.
     * Имя сервисного аккаунта кластера {{ managed-k8s-name }}.
  1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Подготовьте окружение {#prepare-env}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Узнайте [IP-адрес](../../vpc/concepts/address.md) сервиса `kube-dns`:

   ```bash
   kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP}
   ```

## Установите NodeLocal DNS {#install}

{% list tabs %}


- С помощью {{ marketplace-full-name }}

  Установите [NodeLocal DNS](/marketplace/products/yc/node-local-dns) с помощью {{ marketplace-name }}, как описано в [инструкции](../operations/applications/node-local-dns.md#marketplace-install).


- Вручную

  1. Создайте файл `node-local-dns.yaml`. В настройках DaemonSet `node-local-dns` укажите IP-адрес сервиса `kube-dns`:

     {% cut "node-local-dns.yaml" %}

     ```yaml
     # Copyright 2018 The {{ k8s }} Authors.
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
     # Modified for {{ yandex-cloud }} Usage
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
     # A headless service is a service with a service IP but instead of load-balancing it will return the IPs of our associated Pods.
     # We use this to expose metrics to Prometheus.
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

## Измените конфигурацию NodeLocal DNS Cache {#configure}

Чтобы изменить конфигурацию, отредактируйте соответствующий `configmap`. Например, чтобы включить логи DNS-запросов для зоны `cluster.local`.
1. Выполните команду:

   ```bash
   kubectl -n kube-system edit configmap node-local-dns
   ```

1. Добавьте строку `log` в конфигурацию зоны `cluster.local`:

   ```text
   ...
   apiVersion: v1
   data:
   Corefile: |
   cluster.local:53 {
     log
     errors
     cache {
       success 9984 30
       denial 9984 5
     }
   ...
   ```

1. Сохраните изменения.

   Результат:

   ```text
   configmap/node-local-dns edited
   ```

Обновление конфигурации может занять несколько минут.

## Выполните DNS-запросы {#dns-queries}

Чтобы выполнить [тестовые запросы](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment), используйте под с утилитами диагностики DNS.
1. Запустите под:

   ```bash
   kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
   ```

   Результат:

   ```text
   pod/dnsutils created
   ```

1. Убедитесь, что под перешел в состояние `Running`:

   ```bash
   kubectl get pods dnsutils
   ```

   Результат:

   ```text
   NAME      READY  STATUS   RESTARTS  AGE
   dnsutils  1/1    Running  0         26m
   ```

1. Подключитесь к поду:

   ```bash
   kubectl exec -i -t dnsutils -- sh
   ```

1. Получите IP-адрес локального DNS-кеша:

   ```bash
   nslookup kubernetes.default
   ```

   Результат:

   ```text
   Server:         <IP-адрес_kube-dns>
   Address:        <IP-адрес_kube-dns>#53

   Name:   kubernetes.default.svc.cluster.local
   Address: 10.96.128.1
   ```

1. Выполните запросы:

   ```bash
   dig +short @169.254.20.10 www.com
   dig +short @<IP-адрес_сервиса_kube-dns> example.com
   ```

   Результат:

   ```text
   # dig +short @169.254.20.10 www.com
   52.128.23.153
   # dig +short @<IP-адрес_kube-dns> example.com
   93.184.216.34
   ```

   После запуска `node-local-dns` правила iptables настраиваются так, что по обоим адресам (`<IP-адрес_сервиса_kube-dns>:53` и `169.254.20.10:53`) отвечает [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack).

   К `kube-dns` можно обращаться по новому адресу, `ClusterIp` сервиса `kube-dns-upstream`. Этот адрес может понадобиться, чтобы настроить перенаправление (forwarding) запросов.

## Проверьте логи {#check-logs}

Выполните команду:

```bash
kubectl logs --namespace=kube-system -l k8s-app=node-local-dns -f
```

Чтобы остановить вывод лога на экран, нажмите **Ctrl** + **C**.

Результат:

```text
...
[INFO] 10.112.128.7:50527 - 41658 "A IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 106 0.000097538s
[INFO] 10.112.128.7:44256 - 26847 "AAAA IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 147 0.057075876s
...
```

## Остановите DaemonSet {#stop-daemonset}

Чтобы выключить DaemonSet NodeLocal DNS Cache, выполните команду:

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

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:
1. Удалите кластер {{ managed-k8s-name }}.

   {% list tabs %}

   - Вручную

     [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

   - С помощью {{ TF }}

     1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
     1. Удалите конфигурационный файл `k8s-node-local-dns.tf`.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `k8s-node-local-dns.tf`, будут удалены.

   {% endlist %}

1. Если для доступа к кластеру {{ managed-k8s-name }} или узлам использовались статические [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses), освободите и [удалите](../../vpc/operations/address-delete.md) их.