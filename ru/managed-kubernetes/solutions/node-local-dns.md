# Настройка NodeLocal DNS Cache

Чтобы снизить нагрузку по DNS-запросам в кластере {{ k8s }}, включите NodeLocal DNS Cache. Функция доступна в кластерах Kubernetes версии 1.18 и выше.

По умолчанию поды отправляют запросы к [сервису](../concepts/service.md) `kube-dns`. В поле `nameserver` в `/etc/resolv.conf` установлено значение `ClusterIp` сервиса `kube-dns`. Для того, чтобы установить соединение с `ClusterIP`, используется iptables или IPVS.

При включении NodeLocal DNS Cache в кластере разворачивается [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/). На каждом узле начинает работу кэширующий агент (под `node-local-dns`). Поды пользователя теперь отправляют запросы к агенту на своем узле.

Если запрос в кэше агента, он возвращает прямой ответ. В ином случае создается TCP-соединение с `kube-dns` `ClusterIP`. По умолчанию кэширующий агент делает cache-miss запросы к `kube-dns` для зоны кластера `cluster.local`.

С помощью такого плана удается избежать правил DNAT, [connection tracking](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#motivation) и ограничений по [количеству соединений](../../vpc/concepts/limits.md#vpc-limits). Подробнее о NodeLocal DNS Cache смотрите в [документации](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md).

Чтобы настроить кэширование запросов DNS, выполните следующие действия:

## Подготовьте окружение {#prepare}

1. Создайте ресурсы.

    Для выполнения сценария вам понадобятся облачная сеть и подсеть, а также сервисный аккаунт.  Вы можете использовать существующие ресурсы или создать новые.

    {% cut "Как создать ресурсы" %}

    1. Создайте [облачную сеть](../../vpc/operations/network-create.md).
    1. Создайте в облачной сети [подсеть](../../vpc/operations/subnet-create.md).
    1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `editor`.

    {% endcut %}

1. Создайте кластер {{ k8s }} и группу узлов.

    Вы можете использовать уже работающий кластер и группу узлов {{ k8s }} или создать новые. Убедитесь, что в поле **Версия Kubernetes** выбрана версия 1.18 или выше.

    {% cut "Как создать кластер {{ k8s }} и группу узлов" %}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Создайте кластер {{ k8s }}:

    ```bash
    yc managed-kubernetes cluster create \
    --name node-local-dns \
    --service-account-name <имя сервисного аккаунта> \
    --node-service-account-name <имя сервисного аккаунта> \
    --public-ip \
    --zone ru-central1-a \
    --network-name <имя облачной сети>
    ```

    Результат выполнения:

    ```text
    done (7m21s)
    ...
    ```

    Создайте группу узлов:

    ```bash
    yc managed-kubernetes node-group create \
    --name node-group \
    --cluster-name node-local-dns \
    --location zone=ru-central1-a \
    --public-ip \
    --fixed-size 3
    ```

    Результат выполнения:

    ```text
    done (2m43s)
    ...
    ```

    {% endcut %}

1. Настройте kubectl.

    Чтобы запускать команды для кластера {{ k8s }}, установите и настройте консоль управления kubectl.

    {% cut "Как настроить kubectl" %}

    Установите {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

    Добавьте учетные данные кластера {{ k8s }} в конфигурационный файл kubectl:

    ```bash
    yc managed-kubernetes cluster get-credentials --external --name node-local-dns
    ```

    Результат выполнения:

    ```text
    Context 'node-local-dns' was added as default to kubeconfig '/home/<ваш домашний каталог>/.kube/config'.
    ...
    ```

    {% endcut %}

## Настройте DaemonSet {#daemonset}

### Загрузите шаблон спецификации {#download-spec}

Вы можете скачать [шаблон спецификации](https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/dns/nodelocaldns/nodelocaldns.yaml) вручную или с помощью команды:

```bash
wget https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/dns/nodelocaldns/nodelocaldns.yaml
```

### Замените переменные в шаблоне {#variables}

Шаблон содержит конфигурацию NodeLocal DNS Cache. Чтобы изменить конфигурацию под свои нужды, используйте 5 переменных:
* `__PILLAR__DNS__DOMAIN__`
  Зона кластера Kubernetes (`cluster.local` по умолчанию).
* `__PILLAR__LOCAL__DNS__`
  Адрес `link-local`, на котором будет слушать NodeLocal DNS Cache. Рекомендуется использовать адрес из диапазонов 169.254.0.0/16 для IPv4 или fd00::/8 для IPv6.
* `__PILLAR__DNS__SERVER__`
  Адрес `ClusterIp` [сервиса](../concepts/service.md) `kube-dns`. Запросы с пользовательских подов по этому адресу также будут направляться к NodeLocal DNS Cache с помощью правил iptables.
* `__PILLAR__CLUSTER__DNS__`
  Сервер upstream для запросов внутри зоны кластера. При запуске NodeLocal DNS Cache создается новый сервис `kube-dns-upstream` с `ClusterIp`. С помощью этого адреса можно получить доступ к `kube-dns`, минуя кэширующий агент. Переменная должна быть заполнена автоматически.
* `__PILLAR__UPSTREAM__SERVERS__`
  Серверы upstream для запросов вне зоны кластера. Переменная должна быть заполнена автоматически из `configmap` сервиса `kube-dns`.

Установите следующие значения:
* `__PILLAR__DNS__DOMAIN__`: `cluster.local`.
* `__PILLAR__LOCAL__DNS__`: `169.254.20.10`.
* `__PILLAR__DNS__SERVER__`: `ClusterIp` сервиса `kube-dns`.

Для этого произведите автозамену в текстовом редакторе или с помощью команды:

```bash
domain=cluster.local
localdns=169.254.20.10
kubedns=$(kubectl get svc kube-dns -n kube-system -o jsonpath={.spec.clusterIP})

sed -i "s/__PILLAR__LOCAL__DNS__/$localdns/g; s/__PILLAR__DNS__DOMAIN__/$domain/g; s/__PILLAR__DNS__SERVER__/$kubedns/g" nodelocaldns.yaml
```

### Запустите NodeLocal DNS Cache {#startup}

Для запуска NodeLocal DNS Cache используйте команду:

```bash
kubectl create -f nodelocaldns.yaml
```
Результат выполнения:

```text
serviceaccount/node-local-dns created
service/kube-dns-upstream created
configmap/node-local-dns created
daemonset.apps/node-local-dns created
service/node-local-dns created
```

Чтобы убедиться, что [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) развернут успешно, выполните команду:
```bash
kubectl get ds -l  k8s-app=node-local-dns -n kube-system
```
Результат выполнения:

```text
NAME             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
node-local-dns   3         3         3       3            3           <none>          24m
```

### Измените конфигурацию NodeLocal DNS Cache {#configure}

Чтобы изменить конфигурацию, отредактируйте соответствующий `configmap`. Например, чтобы включить логи DNS-запросов для зоны `cluster.local`, выполните следующие шаги:

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

    Результат выполнения:

    ```text
    configmap/node-local-dns edited
    ```

Обновление конфигурации может занять несколько минут.

### Выполните DNS-запросы {#dns-queries}

Чтобы выполнить [тестовые запросы](https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#create-a-simple-pod-to-use-as-a-test-environment), используйте под с утилитами диагностики DNS.

1. Запустите под:

    ```bash
    kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
    ```
    Результат выполнения:

    ```text
    pod/dnsutils created
    ```

1. Убедитесь, что под в состоянии `Running`:

    ```bash
    kubectl get pods dnsutils
    ```
    Результат выполнения:

    ```text
    NAME       READY   STATUS    RESTARTS   AGE
    dnsutils   1/1     Running   0          26m
    ```

1. Подключитесь к поду и выполните запросы:

    ```text
    kubectl exec -i -t dnsutils -- sh

    # dig +short @169.254.20.10 www.com
    # dig +short @10.96.128.2 example.com
    # nslookup kubernetes.default
    ```
    После запуска `node-local-dns` правила iptables настраиваются так, что по обоим адресам (10.96.128.2:53 и 169.254.20.10:53) отвечает [local DNS](https://github.com/kubernetes/enhancements/blob/master/keps/sig-network/1024-nodelocal-cache-dns/README.md#iptables-notrack).

    К `kube-dns` можно обращаться по новому адресу, `ClusterIp` сервиса `kube-dns-upstream`. Этот адрес может понадобиться, чтобы настроить forward (перенаправление) запросов.

    Результат выполнения:

    ```text
    # dig +short @169.254.20.10 www.com
    52.128.23.153
    # dig +short @10.96.128.2 example.com
    93.184.216.34
    # nslookup kubernetes.default
    Server:         10.96.128.2
    Address:        10.96.128.2#53
    
    Name:   kubernetes.default.svc.cluster.local
    Address: 10.96.128.1
    
    ```

### Проверьте логи {#check-logs}

Для проверки логов используйте команду:

```bash
kubectl logs --namespace=kube-system -l k8s-app=node-local-dns -f
```

Чтобы остановить вывод лога на экран, нажмите ___Ctrl + C___.

Результат выполнения:

```text
...
[INFO] 10.112.128.7:50527 - 41658 "A IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 106 0.000097538s
[INFO] 10.112.128.7:44256 - 26847 "AAAA IN kubernetes.default.svc.cluster.local. udp 54 false 512" NOERROR qr,aa,rd 147 0.057075876s
...
```

### Остановите DaemonSet {#stop-daemonset}

Чтобы выключить DaemonSet NodeLocal DNS Cache, выполните:

```bash
kubectl delete -f nodelocaldns.yaml
```
Результат выполнения:

```text
serviceaccount "node-local-dns" deleted
service "kube-dns-upstream" deleted
configmap "node-local-dns" deleted
daemonset.apps "node-local-dns" deleted
service "node-local-dns" deleted
```

