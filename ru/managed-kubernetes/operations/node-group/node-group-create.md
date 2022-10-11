# Создание группы узлов

Чтобы создать [группу узлов](../../concepts/index.md#node-group), сначала [создайте кластер {{ k8s }}](../kubernetes-cluster/kubernetes-cluster-create.md).

## Создайте группу узлов {#node-group-create}

{% list tabs %}

- Консоль управления

  {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы узлов:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Укажите параметры группы узлов в команде создания (в примере приведены не все доступные параметры):

     ```bash
     {{ yc-k8s }} node-group create \
       --allowed-unsafe-sysctls=<имена небезопасных параметров ядра, через запятую> \
       --cluster-name <имя кластера> \
       --cores <количество vCPU> \
       --core-fraction <гарантированная доля vCPU> \
       --daily-maintenance-window <настройки окна обновлений> \
       --disk-size <размер хранилища в ГБ> \
       --disk-type <тип хранилища: network-nvme или network-hdd> \
       --fixed-size <фиксированное количество узлов в группе> \
       --location <настройки размещения хостов кластера> \
       --memory <количество ГБ RAM> \
       --name <имя группы узлов> \
       --network-acceleration-type <standard или software-accelerated> \
       --network-interface security-group-ids=[<идентификаторы групп безопасности>],subnets=[<имена подсетей>],ipv4-address=<nat или auto> \
       --platform-id <идентификатор платформы> \
       --container-runtime <среда запуска контейнеров> \
       --preemptible \
       --public-ip \
       --version <версия {{ k8s }} на узлах группы> \
       --node-taints <метки taint-политик>
     ```

     Где:
     * `--allowed-unsafe-sysctls` — разрешение на использование узлами группы [небезопасных параметров ядра](../../concepts/index.md#node-group), через запятую.
     * `--cluster-name` — имя [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster), в котором будет создана группа узлов.
     * `--cores` — количество vCPU для узлов.
     * `--core-fraction` — [гарантированная доля vCPU](../../../compute/concepts/performance-levels.md) для узлов.
     * `--daily-maintenance-window` — настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates).
     * `--disk-size` — [размер диска](../../../compute/concepts/disk.md#maximum-disk-size) узла.
     * `--disk-type` — [тип диска](../../../compute/concepts/disk.md#disks_types) узла.
     * `--fixed-size` — количество узлов в группе узлов.
     * `--location` — [зона доступности](../../../overview/concepts/geo-scope.md), [сеть](../../../vpc/concepts/network.md#network) и [подсеть](../../../vpc/concepts/network.md#subnet), в которых будут расположены узлы. Можно указать несколько вариантов.
     * `--memory` — количество памяти для узлов.
     * `--name` — имя группы узлов.
     * `--network-acceleration-type` — выбор типа [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
       * `standard` — без ускорения.
       * `software-accelerated` — программно-ускоренная сеть.
     * `--network-interface` — настройки сети:

       {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

     * `--platform-id` — [платформа](../../../compute/concepts/vm-platforms.md) для узлов.
     * `--container-runtime` — [среда запуска контейнеров](../../concepts/index.md#config), `docker` или `containerd`.

       {% include [containerd-k8s-version-note](../../../_includes/managed-kubernetes/containerd-k8s-version-note.md) %}

     * `--preemptible` — флаг, который указывается, если виртуальные машины должны быть [прерываемыми](../../../compute/concepts/preemptible-vm.md).
     * `--public-ip` — флаг, который указывается, если группе узлов требуется [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).
     * `--version` — версия {{ k8s }} на узлах группы.
     * `--node-taints` — метки [taint-политик](../../concepts/index.md#taints-tolerations) {{ k8s }}. Можно указать несколько меток.

     {% include [user-data](../../../_includes/managed-kubernetes/user-data.md) %}

     Результат выполнения команды:

     ```bash
     done (1m17s)
     id: catpl8c44kiibp20u4f3
     cluster_id: catcsqidoos7tq0513us
     ...
         start_time:
           hours: 22
         duration: 36000s
     ```

  1. Чтобы указать [группу размещения](../../../compute/concepts/placement-groups.md) для узлов:
     1. Получите список групп размещения с помощью команды `yc compute placement-group list`.
     1. Передайте имя или идентификатор группы размещения в параметре `--placement group` при создании группы узлов:

        ```bash
        {{ yc-k8s }} node-group-create \
        ...
          --placement-group <имя или идентификатор группы размещения>
        ```

- {{ TF }}

  Чтобы создать [группу узлов](../../concepts/index.md#node-group):
  1. В каталоге с [файлом описания кластера](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) создайте конфигурационный файл, содержащий параметры новой группы узлов:
     * Имя группы узлов.
     * Идентификатор [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) в параметре `cluster_id`.
     * [Платформу](../../../compute/concepts/vm-platforms.md) для узлов.
     * Настройку [среды запуска контейнеров](../../concepts/index.md#config) в параметре `container_runtime`.

       {% include [containerd-k8s-version-note](../../../_includes/managed-kubernetes/containerd-k8s-version-note.md) %}

     * Настройки масштабирования в блоке `scale_policy`.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя кластера>.id
       ...
       instance_template {
         platform_id = "<платформа для узлов>"
         container_runtime {
          type = "<среда запуска контейнеров>"
         }
         ...
       }
       ...
       scale_policy {
         <настройки масштабирования группы узлов>
       }
     }
     ```

     Где:
     * `имя группы узлов` – имя группы узлов.
     * `cluster_id` – идентификатор [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster).
     * `platform_id` – [платформа](../../../compute/concepts/vm-platforms.md) для узлов.
     * `scale_policy` – настройки масштабирования.

     {% note warning %}

     Файл с описанием группы узлов должен находиться в одном каталоге с [файлом описания кластера](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

     {% endnote %}

     * Чтобы создать группу с фиксированным количеством узлов, добавьте блок `fixed_scale`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
         ...
         scale_policy {
           fixed_scale {
             size = <количество узлов в группе>
           }
         }
       }
       ```

     * Чтобы создать группу с [автомасштабированием](../../concepts/node-group/cluster-autoscaler.md), добавьте блок `auto_scale`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
         ...
         scale_policy {
           auto_scale {
             min     = <минимальное количество узлов в группе>
             max     = <максимальное количество узлов в группе>
             initial = <начальное количество узлов в группе>
           }
         }
       }
       ```

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

  Воспользуйтесь методом API [create](../../api-ref/NodeGroup/create.md) и передайте в запросе:
  * Идентификатор [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) в параметре `clusterId`. Его можно получить со [списком кластеров в каталоге](../kubernetes-cluster/kubernetes-cluster-list.md#list).
  * [Конфигурацию группы узлов](../../concepts/index.md#config) в параметре `nodeTemplate`.
  * [Среду запуска контейнеров](../../concepts/index.md#config) в параметре `nodeTemplate.containerRuntimeSettings.type`.

    {% include [containerd-k8s-version-note](../../../_includes/managed-kubernetes/containerd-k8s-version-note.md) %}

  * [Настройки масштабирования](../../concepts/autoscale.md#ca) в параметре `scalePolicy`.
  * [Настройки размещения](../../../overview/concepts/geo-scope.md) группы узлов в параметрах `allocationPolicy`.
  * Настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates) в параметрах `maintenancePolicy`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

  Чтобы узлы использовали [нереплицируемые диски](../../../compute/concepts/disk.md#disks_types), передайте значение `network-ssd-nonreplicated` для параметра `nodeTemplate.bootDiskSpec.diskTypeId`.

  Размер нереплицируемых дисков можно менять только с шагом 93 ГБ. Максимальный размер такого диска — 4 ТБ.

  {% include [Нереплицируемый диск не имеет резервирования](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

  Чтобы разрешить использование узлами группы [небезопасных параметров ядра](../../concepts/index.md#node-group), передайте их имена в параметре `allowedUnsafeSysctls`.

  Чтобы задать метки [taint-политик](../../concepts/index.md#taints-tolerations), передайте их значения в параметре `nodeTaints`.

{% endlist %}

{% note alert %}

После создания группы узлов в {{ compute-full-name }} появится одна или несколько ВМ с автоматически сгенерированными именами. Не изменяйте имена ВМ, принадлежащих кластеру {{ managed-k8s-name }}. Это приведет к нарушению работы группы узлов и всего кластера.

{% endnote %}