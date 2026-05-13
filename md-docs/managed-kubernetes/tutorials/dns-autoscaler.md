# Автоматическое масштабирование DNS по размеру кластера


В Managed Service for Kubernetes поддерживается автоматическое масштабирование сервиса [DNS](../../glossary/dns.md). В [кластере Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) работает приложение `kube-dns-autoscaler`, которое регулирует количество реплик CoreDNS в зависимости от:
* Количества [узлов](../concepts/index.md#node-group) в кластере Managed Service for Kubernetes.
* [Количества ядер (vCPU)](../../compute/concepts/performance-levels.md) в кластере Managed Service for Kubernetes.

Количество реплик рассчитывается [с помощью формул](#parameters).

Чтобы автоматизировать масштабирование DNS:

1. [Настройте kube-dns-autoscaler](#configure-autoscaler).
1. [Проверьте масштабирование](#test-autoscaler).

Если автоматическое масштабирование потеряло актуальность, [отключите его](#disable-autoscaler).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../pricing.md)).
* Плата за каждую ВМ (узлы кластера и ВМ для управления кластером без публичного доступа): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес для узлов кластера (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Создайте ресурсы Managed Service for Kubernetes:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Создайте группы безопасности](../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     1. [Создайте кластер](../operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes. При создании укажите группы безопасности, подготовленные ранее.
        
        Если вы планируете работать с кластером в пределах сети Yandex Cloud, выделять кластеру публичный IP-адрес не нужно. Для подключений извне предоставьте кластеру публичный адрес.

     1. [Создайте группу узлов](../operations/node-group/node-group-create.md). Выделите ей публичный адрес, чтобы предоставить доступ в интернет и возможность скачивать Docker-образы и компоненты. Укажите группы безопасности, подготовленные ранее.

   - Terraform {#tf}

     1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
     1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
     1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера Managed Service for Kubernetes [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер Managed Service for Kubernetes.
        * Группа узлов Managed Service for Kubernetes.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для создания кластера и группы узлов Managed Service for Kubernetes.
        * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

     1. Укажите в файле конфигурации [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
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

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../operations/connect/index.md#kubectl-connect).

   Если для кластера не предоставлен публичный адрес и `kubectl` настроен через внутренний адрес кластера, выполняйте команды `kubectl` на ВМ Yandex Cloud, находящейся в одной сети с кластером.

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

[Под](../concepts/index.md#pod) `kube-dns-autoscaler` периодически запрашивает у сервера Kubernetes данные о количестве узлов и ядер в кластере Managed Service for Kubernetes. На основании этих данных выполняется расчет количества реплик CoreDNS.

Возможны два вида расчета:
* Linear (линейный режим).
* Ladder (ступенчатая функция).

Подробнее о расчетах см. в [документации cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

В этом примере рассмотрен режим `linear`, в котором расчет выполняется по формуле:

```text
replicas = max( ceil( cores * 1/coresPerReplica ) , ceil( nodes * 1/nodesPerReplica ) )
```

Где:
* `coresPerReplica` — параметр конфигурации, количество реплик CoreDNS на каждое ядро (vCPU) кластера Managed Service for Kubernetes.
* `nodesPerReplica` — параметр конфигурации, количество реплик CoreDNS на каждый узел (Node) кластера Managed Service for Kubernetes.
* `cores` — фактическое количество ядер (vCPU) в кластере Managed Service for Kubernetes.
* `nodes` — фактическое количество узлов (Node) в кластере Managed Service for Kubernetes.
* `ceil` — функция округления дроби до целого.
* `max` — функция определения максимума из двух значений.

Дополнительный параметр `preventSinglePointFailure` актуален, если в кластере Managed Service for Kubernetes больше одного узла. Когда параметр установлен в `true`, минимальное количество реплик DNS равно двум.

Также можно определить параметры конфигурации `min` и `max`, которые задают минимальное и максимальное количество реплик CoreDNS в кластере Managed Service for Kubernetes:

```text
replicas = min(replicas, max)
replicas = max(replicas, min)
```

Подробнее о расчете см. в документации [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#calculation-of-number-of-replicas).

### Измените конфигурацию {#edit-config}

1. Проверьте текущие параметры.

   В этом примере создана группа узлов Managed Service for Kubernetes `node-group-1` с параметрами:
   * Количество узлов Managed Service for Kubernetes — `3`.
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

### Измените размер кластера Managed Service for Kubernetes {#resize-cluster}

Создайте вторую группу узлов Managed Service for Kubernetes с помощью команды:

```bash
yc managed-kubernetes node-group create \
  --name node-group-2 \
  --cluster-name dns-autoscaler \
  --location zone=ru-central1-a \
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

Теперь в кластере Managed Service for Kubernetes 5 узлов с 20 ядрами. Рассчитайте количество реплик:

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

### Настройте уменьшение количества узлов Managed Service for Kubernetes {#reduce-nodes}

По умолчанию Cluster Autoscaler не уменьшает количество узлов в группе узлов Managed Service for Kubernetes с автоматическим масштабированием, если на этих узлах присутствуют поды из пространства имен `kube-system` под управлением контроллеров репликаций приложений [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) или [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), например, поды CoreDNS. В этом случае количество узлов Managed Service for Kubernetes в группе не может стать меньше числа подов CoreDNS.

Чтобы разрешить уменьшение числа узлов Managed Service for Kubernetes, сконфигурируйте для них объект [PodDisruptionBudget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/), в котором есть возможность останавливать до двух подов CoreDNS одновременно:

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

  [Удалите кластер Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).

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