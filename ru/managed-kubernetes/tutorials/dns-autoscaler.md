# Автоматическое масштабирование DNS по размеру кластера

В {{ managed-k8s-name }} поддерживается автоматическое масштабирование сервиса DNS. В кластере работает приложение `kube-dns-autoscaler` под управлением контроллера [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/). Приложение регулирует количество реплик CoreDNS по [формулам](#parameters) в зависимости от:
* количества узлов в кластере;
* количества ядер (vCPU) в кластере.

В данном сценарии вы отредактируете конфигурацию `kube-dns-autoscaler` и увидите изменения в [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) службы DNS.

Чтобы настроить масштабирование, выполните следующие действия:
1. [Подготовьте окружение](#prepare).
1. [Настройте kube-dns-autoscaler](#configure-autoscaler).
1. [Проверьте масштабирование](#test-autoscaler).

Если не требуется изменять количество реплик CoreDNS соразмерно кластеру, [отключите масштабирование](#disable-autoscaler).

## Подготовьте окружение {#prepare}

1. Создайте ресурсы.

   Для выполнения сценария вам понадобятся облачная сеть и подсеть, а также сервисный аккаунт. Вы можете использовать существующие ресурсы или создать новые.

   {% cut "Как создать ресурсы" %}

   1. Создайте [облачную сеть](../../vpc/operations/network-create.md).
   1. Создайте в облачной сети [подсеть](../../vpc/operations/subnet-create.md).
   1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `editor`.

   {% endcut %}

1. Создайте кластер {{ k8s }} и группу узлов.

   Вы можете использовать уже работающий кластер и группу узлов {{ k8s }} или создать новые.

   {% cut "Как создать кластер {{ k8s }} и группу узлов" %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Создайте кластер {{ k8s }}:

      ```bash
      yc managed-kubernetes cluster create \
        --name dns-autoscaler \
        --service-account-name <имя сервисного аккаунта> \
        --node-service-account-name <имя сервисного аккаунта> \
        --public-ip \
        --zone {{ region-id }}-a \
        --network-name <имя облачной сети>
        ```

      Результат:

      ```text
      done (7m21s)
      ...
      ```

   1. Создайте группу узлов:

      ```bash
      yc managed-kubernetes node-group create \
        --name node-group-1 \
        --cluster-name dns-autoscaler \
        --location zone={{ region-id }}-a \
        --public-ip \
        --fixed-size 3 \
        --cores 4 \
        --core-fraction 5
      ```

      Результат:

      ```text
      done (2m43s)
      ...
      ```

   {% endcut %}

1. Настройте kubectl.

   Чтобы запускать команды для кластера {{ k8s }}, установите и настройте консоль управления kubectl.

   {% cut "Как настроить kubectl" %}

   1. Установите {{ k8s }} CLI [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).
   1. Добавьте учетные данные кластера {{ k8s }} в конфигурационный файл kubectl:

      ```bash
      yc managed-kubernetes cluster get-credentials --external --name dns-autoscaler
      ```

      Результат:

      ```text
      Context 'dns-autoscaler' was added as default to kubeconfig '/home/<ваш домашний каталог>/.kube/config'.
      ...
      ```

   {% endcut %}

## Настройте kube-dns-autoscaler {#configure-autoscaler}

### Проверьте запуск {#check-startup}

Чтобы убедиться, что приложение работает, проверьте [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) в пространстве имен `kube-system`.

Для этого выполните команду:

```bash
kubectl get deployment --namespace=kube-system
```

Результат:

```text
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
...
kube-dns-autoscaler  1/1    1           1          52m
...
```

### Определите параметры масштабирования {#parameters}

Под `kube-dns-autoscaler` периодически запрашивает у сервера Kubernetes данные о количестве узлов и ядер в кластере. На основании этих данных выполняется расчет количества реплик CoreDNS.

Возможны два вида расчета:
* Linear (линейный режим).
* Ladder (ступенчатая функция).

В режиме linear расчет выполняется по формуле:

```
replicas = max( ceil( cores * 1/coresPerReplica ) , ceil( nodes * 1/nodesPerReplica ) )
```

Где:

* `coresPerReplica` — параметр конфигурации, количество реплик CoreDNS на каждое ядро (vCPU) кластера.
* `nodesPerReplica` — параметр конфигурации, количество реплик CoreDNS на каждый узел (Node) кластера.
* `cores` — фактическое количество ядер (vCPU) в кластере.
* `nodes` — фактическое количество узлов (Node) в кластере.
* `ceil` — функция округления дроби до целого.
* `max` — функция определения максимума из двух значений.

Дополнительный параметр `preventSinglePointFailure` актуален, если в кластере больше одного узла. Когда параметр установлен в `true`, минимальное количество реплик DNS равно двум.

Также можно определить параметры конфигурации `min` и `max`, которые задают минимальное и максимальное количество реплик CoreDNS в кластере:

```
replicas = min(replicas, max)
replicas = max(replicas, min)
```

Подробнее о расчете см. в документации [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

### Измените конфигурацию {#edit-config}

Чтобы сконфигурировать масштабирование, выполните следующие шаги:
1. Проверьте текущие параметры.

   В данном сценарии создана группа узлов `node-group-1`. Количество узлов — 3, количество ядер (vCPU) — 12.

   По умолчанию установлен режим `linear` и следующие параметры масштабирования:
   * `coresPerReplica`: `256`.
   * `nodesPerReplica`: `16`.
   * `preventSinglePointFailure`: `true`.

   ```
   replicas = max( ceil( 12 * 1/256 ), ceil( 3 * 1/16 ) ) = 1
   ```

   Параметр `preventSinglePointFailure` установлен в `true`, поэтому количество реплик CoreDNS будет равно двум.

   Чтобы проверить информацию о подах `coredns`, выполните команду:

   ```bash
   kubectl get pods -n kube-system
   ```

   Результат:

   ```bash
   NAME                      READY  STATUS   RESTARTS  AGE
   ...
   coredns-7c646474c9-4dmjl  1/1    Running  0         128m
   coredns-7c646474c9-n7qsv  1/1    Running  0         134m
   ...
   ```

1. Задайте новые параметры.

   Измените конфигурацию следующим образом:
   * `coresPerReplica`: `4`.
   * `nodesPerReplica`: `2`.
   * `preventSinglePointFailure`: `true`.

   ```
   replicas = max( ceil( 12 * 1/4 ), ceil( 3 * 1/2 ) ) = 3
   ```

   Чтобы передать параметры приложению `kube-dns-autoscaler`, отредактируйте соответствующий [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) с помощью команды:

   ```bash
   kubectl edit configmap kube-dns-autoscaler --namespace=kube-system
   ```

   Откроется текстовый редактор с конфигурацией `kube-dns-autoscaler`. Измените строку с параметрами:

   ```
   linear: '{"coresPerReplica":4,"nodesPerReplica":2,"preventSinglePointFailure":true}'
   ```

   Сохраните изменения. На экране отобразится результат операции:

   ```
   configmap/kube-dns-autoscaler edited
   ```

   Приложение `kube-dns-autoscaler` загрузит конфигурацию и масштабирует службу DNS в соответствии с новыми параметрами.

## Проверьте масштабирование {#test-autoscaler}

### Измените размер кластера {#resize-cluster}

Создайте вторую группу узлов с помощью команды:

```bash
yc managed-kubernetes node-group create \
  --name node-group-2 \
  --cluster-name dns-autoscaler \
  --location zone={{ region-id }}-a \
  --public-ip \
  --fixed-size 2 \
  --cores 4 \
  --core-fraction 5
```

Результат:

```text
done (2m43s)
...
```

Теперь в кластере 5 узлов с 20 ядрами. Рассчитайте количество реплик:

```
replicas = max( ceil( 20 * 1/4 ), ceil( 5 * 1/2 ) ) = 5
```

### Проследите изменения в службе DNS {#inspect-changes}

Чтобы проверить количество реплик CoreDNS, выполните команду:

```bash
kubectl get pods -n kube-system
```

Результат:

```text
NAME                      READY  STATUS   RESTARTS  AGE
...
coredns-7c646474c9-7l8mc  1/1    Running  0         3m30s
coredns-7c646474c9-n7qsv  1/1    Running  0         3h20m
coredns-7c646474c9-pv9cv  1/1    Running  0         3m40s
coredns-7c646474c9-r2lss  1/1    Running  0         49m
coredns-7c646474c9-s5jgz  1/1    Running  0         57m
...
```

## Отключите масштабирование {#disable-autoscaler}

Чтобы отключить масштабирование, обнулите количество реплик в [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) приложения `kube-dns-autoscaler`:

```bash
kubectl scale deployment --replicas=0 kube-dns-autoscaler --namespace=kube-system
```

Результат:

```text
deployment.apps/kube-dns-autoscaler scaled
```

Проверьте результат с помощью команды:

```bash
kubectl get rs --namespace=kube-system
```

Результат:

```text
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
...
kube-dns-autoscaler  0/0    0           0          3h53m
...
```