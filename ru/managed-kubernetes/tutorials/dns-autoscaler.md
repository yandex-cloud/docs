---
title: "Как выполнить автоматическое масштабирование DNS по размеру кластера {{ managed-k8s-full-name }}"
description: "Следуя данному руководству, вы сможете выполнить автоматическое масштабирование DNS по размеру кластера {{ managed-k8s-full-name }}." 
---

# Автоматическое масштабирование DNS по размеру кластера


В {{ managed-k8s-name }} поддерживается автоматическое масштабирование сервиса [DNS](../../glossary/dns.md). В [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) работает приложение `kube-dns-autoscaler`, которое регулирует количество реплик CoreDNS в зависимости от:
* Количества [узлов](../concepts/index.md#node-group) в кластере {{ managed-k8s-name }}.
* [Количества ядер (vCPU)](../../compute/concepts/performance-levels.md) в кластере {{ managed-k8s-name }}.

Количество реплик рассчитывается [с помощью формул](#parameters).

Чтобы автоматизировать масштабирование DNS:
1. [{#T}](#configure-autoscaler).
1. [{#T}](#test-autoscaler).

Если автоматическое масштабирование потеряло актуальность, [отключите его](#disable-autoscaler).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте ресурсы {{ managed-k8s-name }}:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

     1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер {{ managed-k8s-name }}.
        * Группа узлов {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для создания кластера и группы узлов {{ managed-k8s-name }}.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Укажите в файле конфигурации [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
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

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Настройте kube-dns-autoscaler {#configure-autoscaler}

### Убедитесь, что приложение работает {#verify-app}

Проверьте [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) в [пространстве имен](../concepts/index.md#namespace) `kube-system`:

```bash
kubectl get deployment --namespace=kube-system
```

Результат:

```text
NAME                 READY  UP-TO-DATE  AVAILABLE  AGE
...
kube-dns-autoscaler  1/1    1           1          52m
```

### Определите параметры масштабирования {#parameters}

[Под](../concepts/index.md#pod) `kube-dns-autoscaler` периодически запрашивает у сервера {{ k8s }} данные о количестве узлов и ядер в кластере {{ managed-k8s-name }}. На основании этих данных выполняется расчет количества реплик CoreDNS.

Возможны два вида расчета:
* Linear (линейный режим).
* Ladder (ступенчатая функция).

Подробнее о расчетах см. в [документации cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

В этом примере рассмотрен режим `linear`, в котором расчет выполняется по формуле:

```text
replicas = max( ceil( cores * 1/coresPerReplica ) , ceil( nodes * 1/nodesPerReplica ) )
```

Где:
* `coresPerReplica` — параметр конфигурации, количество реплик CoreDNS на каждое ядро (vCPU) кластера {{ managed-k8s-name }}.
* `nodesPerReplica` — параметр конфигурации, количество реплик CoreDNS на каждый узел (Node) кластера {{ managed-k8s-name }}.
* `cores` — фактическое количество ядер (vCPU) в кластере {{ managed-k8s-name }}.
* `nodes` — фактическое количество узлов (Node) в кластере {{ managed-k8s-name }}.
* `ceil` — функция округления дроби до целого.
* `max` — функция определения максимума из двух значений.

Дополнительный параметр `preventSinglePointFailure` актуален, если в кластере {{ managed-k8s-name }} больше одного узла. Когда параметр установлен в `true`, минимальное количество реплик DNS равно двум.

Также можно определить параметры конфигурации `min` и `max`, которые задают минимальное и максимальное количество реплик CoreDNS в кластере {{ managed-k8s-name }}:

```text
replicas = min(replicas, max)
replicas = max(replicas, min)
```

Подробнее о расчете см. в документации [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

### Измените конфигурацию {#edit-config}

1. Проверьте текущие параметры.

   В этом примере создана группа узлов {{ managed-k8s-name }} `node-group-1` с параметрами:
   * Количество узлов {{ managed-k8s-name }} — `3`.
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

   Результат:

   ```bash
   NAME                      READY  STATUS   RESTARTS  AGE
   ...
   coredns-7c********-4dmjl  1/1    Running  0         128m
   coredns-7c********-n7qsv  1/1    Running  0         134m
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

### Измените размер кластера {{ managed-k8s-name }} {#resize-cluster}

Создайте вторую группу узлов {{ managed-k8s-name }} с помощью команды:

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

Теперь в кластере {{ managed-k8s-name }} 5 узлов с 20 ядрами. Рассчитайте количество реплик:

```text
replicas = max( ceil( 20 * 1/4 ), ceil( 5 * 1/2 ) ) = 5
```

### Проверьте изменения в количестве реплик CoreDNS {#inspect-changes}

Выполните команду:

```bash
kubectl get pods -n kube-system
```

Результат:

```text
NAME                      READY  STATUS   RESTARTS  AGE
...
coredns-7c********-7l8mc  1/1    Running  0         3m30s
coredns-7c********-n7qsv  1/1    Running  0         3h20m
coredns-7c********-pv9cv  1/1    Running  0         3m40s
coredns-7c********-r2lss  1/1    Running  0         49m
coredns-7c********-s5jgz  1/1    Running  0         57m
```

### Настройте уменьшение количества узлов {{ managed-k8s-name }} {#reduce-nodes}

По умолчанию {{ k8s-ca }} не уменьшает количество узлов в группе узлов {{ managed-k8s-name }} с автоматическим масштабированием, если на этих узлах присутствуют поды из пространства имен `kube-system` под управлением контроллеров репликаций приложений [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) или [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), например, поды CoreDNS. В этом случае количество узлов {{ managed-k8s-name }} в группе не может стать меньше числа подов CoreDNS.

Чтобы разрешить уменьшение числа узлов {{ managed-k8s-name }}, сконфигурируйте для них объект [PodDisruptionBudget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/), в котором есть возможность останавливать до двух подов CoreDNS одновременно:

```bash
kubectl create poddisruptionbudget <имя_pdb> \
  --namespace=kube-system \
  --selector k8s-app=kube-dns \
  --min-available=2
```

Результат:

```text
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: <имя_pdb>
spec:
  minAvailable: 2
  selector:
    matchLabels:
      k8s-app: kube-dns
```

## Отключите масштабирование {#disable-autoscaler}

Обнулите количество реплик в [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) приложения `kube-dns-autoscaler`:

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
```

## Удалите созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

{% list tabs group=instructions %}

- Вручную {#manual}

  [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

- {{ TF }} {#tf}

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
