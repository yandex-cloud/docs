# Автоматическое масштабирование DNS по размеру кластера

В {{ managed-k8s-name }} поддерживается автоматическое масштабирование сервиса DNS. В [кластере {{ k8s }}](../concepts/index.md#kubernetes-cluster) работает приложение `kube-dns-autoscaler`, которое регулирует количество реплик CoreDNS в зависимости от:
* количества [узлов](../concepts/index.md#node-group) в кластере;
* [количества ядер (vCPU)](../../compute/concepts/performance-levels.md) в кластере.

Количество реплик рассчитывается [с помощью формул](#parameters).

Чтобы автоматизировать масштабирование DNS:
1. [{#T}](#configure-autoscaler).
1. [{#T}](#test-autoscaler).

Если автоматическое масштабирование потеряло актуальность, [отключите его](#disable-autoscaler).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте ресурсы {{ k8s }}:

   {% list tabs %}

   - Вручную

     1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

     1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

     1. [Настройте группы безопасности кластера и группы узлов](../operations/connect/security-groups.md). [Группа безопасности](../../vpc/concepts/security-groups.md) кластера должна разрешать входящие подключения к портам `443` и `6443`.

   - С помощью {{ TF }}

     1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
         * Группа безопасности по умолчанию и правила, необходимые для работы кластера:
           * Правила для служебного трафика.
           * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` (через порты 443 и 6443).
         * Кластер {{ managed-k8s-name }}.
         * Группа узлов {{ managed-k8s-name }}.
         * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для создания кластера и группы узлов {{ managed-k8s-name }}.
     1. Укажите в файле конфигурации [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
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

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Настройте kube-dns-autoscaler {#configure-autoscaler}

### Убедитесь, что приложение работает {#verify-app}

Проверьте [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) в [пространстве имен](../concepts/index.md#namespace) `kube-system`:

```bash
kubectl get deployment --namespace=kube-system
```

Результат выполнения команды:

```text
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
...
kube-dns-autoscaler  1/1    1           1          52m
```

### Определите параметры масштабирования {#parameters}

[Под](../concepts/index.md#pod) `kube-dns-autoscaler` периодически запрашивает у сервера {{ k8s }} данные о количестве узлов и ядер в кластере. На основании этих данных выполняется расчет количества реплик CoreDNS.

Возможны два вида расчета:
* Linear (линейный режим).
* Ladder (ступенчатая функция).

Подробнее о расчетах см. в [документации cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

В этом примере рассмотрен режим `linear`, в котором расчет выполняется по формуле:

```text
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

```text
replicas = min(replicas, max)
replicas = max(replicas, min)
```

Подробнее о расчете см. в документации [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

### Измените конфигурацию {#edit-config}

1. Проверьте текущие параметры.

   В этом примере создана группа узлов `node-group-1` с параметрами:
   * Количество узлов — `3`.
   * Количество ядер (vCPU) — `12`.

   По умолчанию установлен режим `linear` и следующие параметры масштабирования:
   * `coresPerReplica` — `256`.
   * `nodesPerReplica` — `16`.
   * `preventSinglePointFailure` — `true`.

   ```text
   replicas = max( ceil( 12 * 1/256 ), ceil( 3 * 1/16 ) ) = 1
   ```

   Параметр `preventSinglePointFailure` установлен в `true`, поэтому количество реплик CoreDNS будет равно двум.

   Чтобы проверить информацию о подах `coredns`, выполните команду:

   ```bash
   kubectl get pods -n kube-system
   ```

   Результат выполнения команды:

   ```bash
   NAME                      READY  STATUS   RESTARTS  AGE
   ...
   coredns-7c646474c9-4dmjl  1/1    Running  0         128m
   coredns-7c646474c9-n7qsv  1/1    Running  0         134m
   ```

1. Задайте новые параметры.

   Измените конфигурацию следующим образом:
   * `coresPerReplica`: `4`.
   * `nodesPerReplica`: `2`.
   * `preventSinglePointFailure`: `true`.

   ```text
   replicas = max( ceil( 12 * 1/4 ), ceil( 3 * 1/2 ) ) = 3
   ```

   Чтобы передать параметры приложению `kube-dns-autoscaler`, отредактируйте соответствующий [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) с помощью команды:

   ```bash
   kubectl edit configmap kube-dns-autoscaler --namespace=kube-system
   ```

   Откроется текстовый редактор с конфигурацией `kube-dns-autoscaler`. Измените строку с параметрами:

   ```text
   linear: '{"coresPerReplica":4,"nodesPerReplica":2,"preventSinglePointFailure":true}'
   ```

   Сохраните изменения. На экране отобразится результат операции:

   ```text
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

Результат выполнения команды:

```text
done (2m43s)
...
```

Теперь в кластере 5 узлов с 20 ядрами. Рассчитайте количество реплик:

```text
replicas = max( ceil( 20 * 1/4 ), ceil( 5 * 1/2 ) ) = 5
```

### Проверьте изменения в количестве реплик CoreDNS {#inspect-changes}

Выполните команду:

```bash
kubectl get pods -n kube-system
```

Результат выполнения команды:

```text
NAME                      READY  STATUS   RESTARTS  AGE
...
coredns-7c646474c9-7l8mc  1/1    Running  0         3m30s
coredns-7c646474c9-n7qsv  1/1    Running  0         3h20m
coredns-7c646474c9-pv9cv  1/1    Running  0         3m40s
coredns-7c646474c9-r2lss  1/1    Running  0         49m
coredns-7c646474c9-s5jgz  1/1    Running  0         57m
```

## Отключите масштабирование {#disable-autoscaler}

Обнулите количество реплик в [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) приложения `kube-dns-autoscaler`:

```bash
kubectl scale deployment --replicas=0 kube-dns-autoscaler --namespace=kube-system
```

Результат выполнения команды:

```text
deployment.apps/kube-dns-autoscaler scaled
```

Проверьте результат с помощью команды:

```bash
kubectl get rs --namespace=kube-system
```

Результат выполнения команды:

```text
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
...
kube-dns-autoscaler  0/0    0           0          3h53m
```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

{% list tabs %}

- Вручную

  [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

- С помощью {{ TF }}

  Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):
  1. В терминале перейдите в директорию с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-cluster.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-cluster.tf`, будут удалены.

{% endlist %}