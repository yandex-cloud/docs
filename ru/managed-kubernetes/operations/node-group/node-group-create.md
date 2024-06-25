# Создание группы узлов


[Группа узлов](../../concepts/index.md#node-group) — это группа виртуальных машин с одинаковой конфигурацией в [кластере {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), на которых запускаются пользовательские контейнеры.

Перед тем как создавать группу узлов, [создайте](../kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ managed-k8s-name }} и убедитесь, что в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) достаточно [свободных ресурсов](../../concepts/limits.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [node-group-create](../../../_includes/managed-kubernetes/node-group-create.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы узлов {{ managed-k8s-name }}:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Укажите параметры группы узлов {{ managed-k8s-name }} в команде создания (в примере приведены не все доступные параметры):

     ```bash
     {{ yc-k8s }} node-group create \
       --allowed-unsafe-sysctls <имена_небезопасных_параметров_ядра> \
       --cluster-name <имя_кластера> \
       --cores <количество_vCPU> \
       --core-fraction <гарантированная_доля_vCPU> \
       --daily-maintenance-window <настройки_окна_обновлений> \
       --disk-size <размер_хранилища_ГБ> \
       --disk-type <тип_хранилища> \
       --fixed-size <фиксированное_количество_узлов_в_группе> \
       --location <настройки_размещения_хостов_кластера> \
       --memory <количество_ГБ_RAM> \
       --name <имя_группы_узлов> \
       --network-acceleration-type <тип_ускорения_сети> \
       --network-interface security-group-ids=[<идентификаторы_групп_безопасности>],subnets=[<имена_подсетей>],ipv4-address=<способ_назначения_IP-адреса> \
       --platform-id <идентификатор_платформы> \
       --container-runtime containerd \
       --preemptible \
       --public-ip \
       --template-labels <облачные_метки_группы_узлов> \
       --version <версия_{{ k8s }}_на_узлах_группы> \
       --node-name <шаблон_имени_узлов> \
       --node-taints <taint-политики> \
       --container-network-settings pod-mtu=<значение_MTU_для_подов_группы>
     ```

     Где:
     * `--allowed-unsafe-sysctls` — разрешение на использование узлами группы {{ managed-k8s-name }} [небезопасных параметров ядра](../../concepts/index.md#node-group), через запятую.
     * `--cluster-name` — имя [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster), в котором будет создана группа узлов.
     * `--cores` — количество vCPU для узлов {{ managed-k8s-name }}.
     * `--core-fraction` — [гарантированная доля vCPU](../../../compute/concepts/performance-levels.md) для узлов {{ managed-k8s-name }}.
     * `--daily-maintenance-window` — настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates).
     * `--disk-size` — [размер диска](../../../compute/concepts/disk.md#maximum-disk-size) узла {{ managed-k8s-name }}.
     * `--disk-type` — [тип диска](../../../compute/concepts/disk.md#disks_types) узла {{ managed-k8s-name }}: `network-nvme` или `network-hdd`.
     * Тип масштабирования:

       * `--fixed-size` — фиксированное количество узлов в группе узлов {{ managed-k8s-name }}.
       * `--auto-scale` — настройки [автоматического масштабирования кластера {{ managed-k8s-name }}](../../concepts/node-group/cluster-autoscaler.md):

         * `min` — минимальное количество узлов в группе.
         * `max` — максимальное количество узлов в группе.
         * `initial` — начальное количество узлов в группе.

       Тип масштабирования нельзя изменить после создания группы узлов.

     * `--location` — [зона доступности](../../../overview/concepts/geo-scope.md), [сеть](../../../vpc/concepts/network.md#network) и [подсеть](../../../vpc/concepts/network.md#subnet), в которых будут расположены узлы {{ managed-k8s-name }}. Можно указать несколько вариантов.

       Если в одной команде передать параметры `--location`, `--network-interface` и `--public-ip`, [возникнет ошибка](../../qa/troubleshooting.md#conflicting-flags). Расположение группы узлов {{ managed-k8s-name }} достаточно указать в `--location` или `--network-interface`.

       {% include [assign-public-ip-addresses](../../../_includes/managed-kubernetes/assign-public-ip-addresses.md) %}

     * `--memory` — количество памяти для узлов {{ managed-k8s-name }}.
     * `--name` — имя группы узлов {{ managed-k8s-name }}.
     * `--network-acceleration-type` — выбор типа [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
       * `standard` — без ускорения.
       * `software-accelerated` — программно-ускоренная сеть.

       {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

     * `--network-interface` — настройки сети:

       {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %}

     * `--platform-id` — [платформа](../../../compute/concepts/vm-platforms.md) для узлов {{ managed-k8s-name }}.
     * `--container-runtime` — среда запуска контейнеров [containerd](https://containerd.io/).
     * `--preemptible` — флаг, который указывается, если виртуальные машины должны быть [прерываемыми](../../../compute/concepts/preemptible-vm.md).
     * `--public-ip` — флаг, который указывается, если группе узлов {{ managed-k8s-name }} требуется [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).
     * `--template-labels` — [облачные метки группы узлов](../../../resource-manager/concepts/labels.md) в формате `<имя_метки>=<значение_метки>`. Можно указать несколько меток через запятую.
     * `--version` — версия {{ k8s }} на узлах группы {{ managed-k8s-name }}.
     * `--node-name` — шаблон имени узлов {{ managed-k8s-name }}. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

       {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

     * `--node-taints` — [taint-политики](../../concepts/index.md#taints-tolerations) {{ k8s }}. Можно указать несколько политик.
     * `--container-network-settings` — значение [MTU](https://ru.wikipedia.org/wiki/Maximum_transmission_unit) для сетевых соединений с подами группы. Настройка не применима для кластеров с контроллерами сетевых политик Calico или Cilium.

     Результат:

     ```text
     done (1m17s)
     id: catpl8c44kii********
     cluster_id: catcsqidoos7********
     ...
         start_time:
           hours: 22
         duration: 36000s
     ```

  1. Чтобы добавить метаданные для узлов, используйте параметр `--metadata` или `--metadata-from-file`.

        {% include [connect-metadata-list](../../../_includes/managed-kubernetes/connect-metadata-list.md) %}

        {% note warning %}

        {% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

        {% endnote %}

        Добавьте метаданные одним из способов:

        * С помощью `--metadata`: укажите одну или несколько пар `ключ=значение`, разделенных запятыми.

            {% include [metadata-key-explicit](../../../_includes/managed-kubernetes/metadata-key-explicit.md) %}

        * С помощью `--metadata-from-file`: укажите одну или несколько пар `ключ=путь_к_файлу_со_значением`, разделенных запятыми.

            {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

        {% include [node-group-metadata-postponed-update-note](../../../_includes/managed-kubernetes/node-group-metadata-postponed-update-note.md) %}

  1. Чтобы указать [группу размещения](../../../compute/concepts/placement-groups.md) для узлов {{ managed-k8s-name }}:
     1. Получите список групп размещения с помощью команды `yc compute placement-group list`.
     1. Передайте имя или идентификатор группы размещения во флаге `--placement group` при создании группы узлов {{ managed-k8s-name }}:

        ```bash
        {{ yc-k8s }} node-group create \
        ...
          --placement-group <имя_или_идентификатор_группы_размещения>
        ```

- {{ TF }} {#tf}

  Чтобы создать [группу узлов {{ managed-k8s-name }}](../../concepts/index.md#node-group):

  1. В каталоге с [файлом описания кластера](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) создайте конфигурационный файл, содержащий параметры новой группы узлов {{ managed-k8s-name }}.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       cluster_id = yandex_kubernetes_cluster.<имя_кластера>.id
       name       = "<имя_группы_узлов>"
       ...
       instance_template {
         name       = "<шаблон_имени_узлов>"
         platform_id = "<платформа_для_узлов>"
         network_acceleration_type = "<тип_ускорения_сети>"
         container_runtime {
           type = "containerd"
         }
         labels {
           "<имя_метки>"="<значение_метки>"
         }
         ...
       }
       ...
       scale_policy {
         <настройки_масштабирования_группы_узлов>
       }
     }
     ```

     Где:
     * `cluster_id` — идентификатор [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).
     * `name` — имя группы узлов {{ managed-k8s-name }}.
     * `instance_template` — параметры узлов {{ managed-k8s-name }}:
       * `name` — шаблон имени узлов {{ managed-k8s-name }}. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

         {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

       * `platform_id` — [платформа](../../../compute/concepts/vm-platforms.md) для узлов {{ managed-k8s-name }}.
       * `network_acceleration_type` — тип [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
         * `standard` — без ускорения.
         * `software-accelerated` — программно-ускоренная сеть.

         {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

       * `container_runtime`, `type` — среда запуска контейнеров [containerd](https://containerd.io/).
       * `labels` — [облачные метки группы узлов](../../../resource-manager/concepts/labels.md). Можно указать несколько меток через запятую.
       * `scale_policy` — настройки масштабирования. 

         Тип масштабирования нельзя изменить после создания группы узлов.

     {% note warning %}

     Файл с описанием группы узлов {{ managed-k8s-name }} должен находиться в одном каталоге с [файлом описания кластера](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

     {% endnote %}

     * Чтобы создать группу с фиксированным количеством узлов, добавьте блок `fixed_scale`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         ...
         scale_policy {
           fixed_scale {
             size = <количество_узлов_в_группе>
           }
         }
       }
       ```

     * Чтобы создать группу узлов {{ managed-k8s-name }} с [автомасштабированием](../../concepts/node-group/cluster-autoscaler.md), добавьте блок `auto_scale`:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         ...
         scale_policy {
           auto_scale {
             min     = <минимальное_количество_узлов_в_группе_узлов>
             max     = <максимальное_количество_узлов_в_группе_узлов>
             initial = <начальное_количество_узлов_в_группе_узлов>
           }
         }
       }
       ```

     * Чтобы добавить метаданные для узлов, передайте их в параметре `instance_template.metadata`.

        {% include [connect-metadata-list](../../../_includes/managed-kubernetes/connect-metadata-list.md) %}

        {% note warning %}

        {% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

        {% endnote %}

        Добавьте метаданные одним из способов:

        * Укажите одну или несколько пар `ключ=значение`.

            {% include [metadata-key-explicit](../../../_includes/managed-kubernetes/metadata-key-explicit.md) %}

        * Укажите одну или несколько пар `ключ=file(путь_к_файлу_со_значением)`.

            {% include [metadata-key-from-file](../../../_includes/managed-kubernetes/metadata-key-from-file.md) %}

        ```hcl
        resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
          ...
          instance_template {
            metadata = {
              "ключ_1" = "значение"
              "ключ_2" = file("<путь_к_файлу_со_значением>")
              ...
            }
            ...
          }
          ...
        }
        ```

        {% include [node-group-metadata-postponed-update-note](../../../_includes/managed-kubernetes/node-group-metadata-postponed-update-note.md) %}

     * Чтобы добавить [DNS-записи](../../../dns/concepts/resource-record.md):

       {% include [node-name](../../../_includes/managed-kubernetes/tf-node-name.md) %}

     Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).
  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте группу узлов {{ managed-k8s-name }}.

     {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API {#api}

  Воспользуйтесь методом API [create](../../api-ref/NodeGroup/create.md) и передайте в запросе:
  * Идентификатор [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) в параметре `clusterId`. Его можно получить со [списком кластеров {{ managed-k8s-name }} в каталоге](../kubernetes-cluster/kubernetes-cluster-list.md#list).
  * [Конфигурацию группы узлов {{ managed-k8s-name }}](../../concepts/index.md#config) в параметре `nodeTemplate`.
  * Тип [ускорения сети](../../../compute/concepts/software-accelerated-network.md) в параметре `nodeTemplate.networkSettings.type`.

    {% include [note-software-accelerated-network](../../../_includes/managed-kubernetes/note-software-accelerated-network.md) %}

  * Среду запуска контейнеров [containerd](https://containerd.io/) в параметре `nodeTemplate.containerRuntimeSettings.type`.
  * [Облачные метки группы узлов](../../../resource-manager/concepts/labels.md) в параметре `nodeTemplate.labels`.
  * [Настройки масштабирования](../../concepts/autoscale.md#ca) в параметре `scalePolicy`.
  
    Тип масштабирования нельзя изменить после создания группы узлов.
  * [Настройки размещения](../../../overview/concepts/geo-scope.md) группы узлов {{ managed-k8s-name }} в параметрах `allocationPolicy`.
  * Настройки окна [обновлений](../../concepts/release-channels-and-updates.md#updates) в параметрах `maintenancePolicy`.
  * Список изменяемых настроек в параметре `updateMask`.

    {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

  * Чтобы узлы использовали [нереплицируемые диски](../../../compute/concepts/disk.md#disks_types), передайте значение `network-ssd-nonreplicated` для параметра `nodeTemplate.bootDiskSpec.diskTypeId`.

    Размер нереплицируемых дисков можно менять только с шагом 93 ГБ. Максимальный размер такого диска — 4 ТБ.

    {% include [Нереплицируемый диск не имеет резервирования](../../../_includes/managed-kubernetes/nrd-no-backup-note.md) %}

  * Чтобы разрешить использование узлами группы {{ managed-k8s-name }} [небезопасных параметров ядра](../../concepts/index.md#node-group), передайте их имена в параметре `allowedUnsafeSysctls`.

  * Чтобы задать [taint-политики](../../concepts/index.md#taints-tolerations), передайте их значения в параметре `nodeTaints`.

  * Чтобы задать шаблон имени узлов {{ managed-k8s-name }}, передайте его в параметре `nodeTemplate.name`. Для уникальности имени шаблон должен содержать хотя бы одну переменную:

    {% include [node-name](../../../_includes/managed-kubernetes/node-name.md) %}

  * Чтобы добавить метаданные для узлов, передайте их в параметре `nodeTemplate.metadata`.

    {% include [connect-metadata-list](../../../_includes/managed-kubernetes/connect-metadata-list.md) %}

    {% note warning %}

    {% include [node-group-metadata-warning](../../../_includes/managed-kubernetes/node-group-metadata-warning.md) %}

    {% endnote %}

    Добавьте метаданные, указав одну или несколько пар `ключ=значение`, разделенных запятыми.

    {% include [metadata-key-explicit](../../../_includes/managed-kubernetes/metadata-key-explicit.md) %}

    {% include [node-group-metadata-postponed-update-note](../../../_includes/managed-kubernetes/node-group-metadata-postponed-update-note.md) %}

  * Чтобы добавить [DNS-записи](../../../dns/concepts/resource-record.md), передайте их настройки в параметре `nodeTemplate.v4AddressSpec.dnsRecordSpecs`. В [FQDN](../../../glossary/fqdn.md) записи DNS можно использовать шаблон с переменными для имени узлов `nodeTemplate.name`.

{% endlist %}

Процесс создания группы узлов {{ managed-k8s-name }} может занять несколько минут в зависимости от количества узлов.

{% include [node-vm-explained-short](../../../_includes/managed-kubernetes/node-vm-explained-short.md) %}

{% include [node-vm-manipulation-warning](../../../_includes/managed-kubernetes/node-vm-manipulation-warning.md) %}

## Примеры {#examples}

Создайте группу узлов для кластера {{ managed-k8s-name }} с тестовыми характеристиками:

* Имя — `k8s-demo-ng`.
* Описание — `Test node group`.
* Шаблон имени узлов — `test-{instance.short_id}-{instance_group.id}`.
* [Кластер {{ k8s }}](../../concepts/index.md#kubernetes-cluster) — укажите [идентификатор](../kubernetes-cluster/kubernetes-cluster-list.md) существующего кластера, например `{{ cluster-id }}`.
* [Версия {{ k8s }}](../../concepts/release-channels-and-updates.md) на узлах группы — `1.29`.
* [Платформа](../../../compute/concepts/vm-platforms.md) для узлов — `standard-v3`.
* Количество vCPU для узлов — два.
* [Гарантированная доля vCPU](../../../compute/concepts/performance-levels.md) — 50%.
* [Размер диска](../../../compute/concepts/disk.md#maximum-disk-size) — 64 ГБ.
* [Тип диска](../../../compute/concepts/disk.md#disks_types) — `network-ssd`.
* Количество узлов — один.
* Количество узлов, которое сервис {{ managed-k8s-name }} может создать в группе при ее [обновлении](../../concepts/release-channels-and-updates.md#node-group), — не более трех.
* Количество узлов, которое сервис может удалить из группы при ее обновлении, — не более одного.
* Объем RAM — два ГБ.
* Время для [обновления](../../concepts/release-channels-and-updates.md#updates) — в период с 22:00 до 08:00 UTC.
* Тип [ускорения сети](../../../compute/concepts/software-accelerated-network.md) — `standard` (без ускорения).
* Сетевые настройки:
  * [Идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md), например `{{ security-group }}`.
  * [Идентификатор подсети](../../../vpc/operations/subnet-get-info.md), например `e9bj3s90g9hm********`.
  * Назначение узлам публичного и внутреннего IP-адресов — включено.
* [{{ k8s }}-метка](../../concepts/index.md#node-labels) — `node-label1=node-value1`.
* [Taint-политика](../../concepts/index.md#taints-tolerations) {{ k8s }} — `taint1=taint-value1:NoSchedule`.
* [Ресурсная метка {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md), которая назначается ВМ, — `template-label1=template-value1`.
* Разрешение на использование [небезопасных параметров ядра](../../concepts/index.md#config) — включено. Добавлены параметры `kernel.msg*` и `net.core.somaxconn`.
* ВМ, которая является единственным узлом группы, — [прерываемая](../../../compute/concepts/preemptible-vm.md).

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните следующую команду:

  ```bash
  {{ yc-k8s }} node-group create \
    --name k8s-demo-ng \
    --description 'Test node group' \
    --node-name test-{instance.short_id}-{instance_group.id} \
    --cluster-id {{ cluster-id }} \
    --version 1.29 \
    --platform-id standard-v3 \
    --cores 2 \
    --core-fraction 50 \
    --disk-size 64 \
    --disk-type network-ssd \
    --fixed-size 1 \
    --max-expansion 3 \
    --max-unavailable 1 \
    --memory 2 \
    --daily-maintenance-window 'start=22:00,duration=10h' \
    --network-acceleration-type standard \
    --network-interface security-group-ids={{ security-group }},subnets=e9bj3s90g9hm********,ipv4-address=nat \
    --node-labels node-label1=node-value1 \
    --node-taints taint1=taint-value1:NoSchedule \
    --template-labels template-label1=template-value1 \
    --allowed-unsafe-sysctls='kernel.msg*,net.core.somaxconn' \
    --preemptible
  ```

- {{ TF }}

  1. Разместите конфигурационный файл для группы узлов в каталоге с [файлом описания кластера](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

      ```hcl
      resource "yandex_kubernetes_node_group" "k8s-demo-ng" {
        name        = "k8s-demo-ng"
        description = "Test node group"
        cluster_id  = "{{ cluster-id }}"
        version     = "1.29"
        instance_template {
          name = "test-{instance.short_id}-{instance_group.id}"
          platform_id = "standard-v3"
          resources {
            cores         = 2
            core_fraction = 50
            memory        = 2
          }
          boot_disk {
            size = 64
            type = "network-ssd"
          }
          network_acceleration_type = "standard"
          network_interface {
            security_group_ids = ["{{ security-group }}"]
            subnet_ids         = ["e9bj3s90g9hm********"]
            nat                = true
          }
          scheduling_policy {
            preemptible = true
          }
        }
        scale_policy {
          fixed_scale {
            size = 1
          }
        }
        deploy_policy {
          max_expansion   = 3
          max_unavailable = 1
        }
        maintenance_policy {
          auto_upgrade = true
          auto_repair  = true
          maintenance_window {
            start_time = "22:00"
            duration   = "10h"
          }
        }
        node_labels = {
          node-label1 = "node-value1"
        }
        node_taints = ["taint1=taint-value1:NoSchedule"]
        labels = {
          "template-label1" = "template-value1"
        }
        allowed_unsafe_sysctls = ["kernel.msg*", "net.core.somaxconn"]
      }

  1. Проверьте корректность конфигурационного файла.

      {% include [terraform-create-cluster-step-2](../../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте группу узлов {{ managed-k8s-name }}.

      {% include [terraform-create-cluster-step-3](../../../_includes/mdb/terraform-create-cluster-step-3.md) %}

{% endlist %}
