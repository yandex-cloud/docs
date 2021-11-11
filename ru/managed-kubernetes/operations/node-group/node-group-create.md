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
       --preemptible \
       --public-ip \
       --version <версия {{ k8s }} на узлах группы>
     ```

     Где:
     * `--allowed-unsafe-sysctls` — разрешение на использование узлами группы [небезопасных параметров ядра](../../concepts/index.md#node-group), через запятую.
     * `--cluster-name` — имя кластера {{ k8s }}, в котором будет создана группа узлов.
     * `--cores` — количество vCPU для узлов.
     * `--core-fraction` — [гарантированная доля vCPU](../../../compute/concepts/performance-levels.md) для узлов.
     * `--daily-maintenance-window` — настройки окна обновлений.
     * `--disk-size` — [размер диска](../../../compute/concepts/disk.md#maximum-disk-size) узла.
     * `--disk-type` — [тип диска](../../../compute/concepts/disk.md#disks_types) узла.
     * `--fixed-size` — количество узлов в группе узлов.
     * `--location` — [зона доступности](../../../overview/concepts/geo-scope.md), [сеть](../../../vpc/concepts/network.md#network) и [подсеть](../../../vpc/concepts/network.md#subnet), в которых будут расположены узлы. Можно указать несколько вариантов.
     * `--memory` — количество памяти для узлов.
     * `--name` — имя группы узлов.
     * `--network-acceleration-type` — выбор типа [ускорения сети](../../../compute/concepts/software-accelerated-network.md):
        * `standard` — без ускорения;
        * `software-accelerated` — программно-ускоренная сеть.
     * `--network-interface` — настройки сети:

         {% include [network-interface](../../../_includes/managed-kubernetes/cli-network-interface.md) %} 

     * `--platform-id` — [платформа](../../../compute/concepts/vm-platforms.md) для узлов.
     * `--preemptible` — флаг, который указывается, если ВМ должны быть [прерываемыми](../../../compute/concepts/preemptible-vm.md). 
     * `--public-ip` — флаг, который указывается, если группе узлов требуется [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses).
     * `--version` — версия {{ k8s }} на узлах группы.

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

- Terraform

  В разделе [{#T}](../kubernetes-cluster/kubernetes-cluster-create.md) вы создали кластер {{ k8s }} с помощью Terraform. Используйте тот же файл `.tf` конфигурации для создания группы узлов в кластере.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать. Вы можете добавить несколько записей одновременно.
     * `yandex_kubernetes_node_group` — параметры группы узлов:
       * `cluster_id` — идентификатор кластера {{ k8s }}, в котором будет создана группа узлов.
       * `name` — имя группы узлов {{ k8s }}.
       * `description` — описание группы узлов.
       * `version` — версия {{ k8s }} для группы узлов.
     * `labels` — [набор меток](node-label-management.md) для группы узлов:
       * `key` — значения меток.
     * `instance_template` — описание ВМ для группы узлов:
       * `platform_id` — [платформа](../../../compute/concepts/vm-platforms.md) для группы узлов.
       * `network_interface` — настройки сетевого интерфейса:
         * `nat` — флаг, который включает NAT для вычислительных экземпляров группы узлов.
         * `subnet_ids` — идентификаторы подсетей.
       * `resources` — ресурсы, доступные ВМ:
         * `memory` — объем RAM.
         * `cores` — количество ядер vCPU.
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных  образов](../../../compute/operations/images-with-pre-installed-software/get-list.md).
         * `size` — размер диска узла Гб. Минимальный размер: 64 Гб.
         * `type` — тип диска.
     * `scheduling_policy` — настройка политики планирования:
        * `preemptible` — флаг, который указывает, что будут созданы прерываемые ВМ.
     * `scale_policy` — настройки [политики масштабирования](../../../compute/concepts/instance-groups/policies/scale-policy.md):
       * `fixed_scale` — ключ определяет группу ВМ фиксированного размера.
       * `size` — количество ВМ в группе.
     * `allocation_policy` — настройки [политики распределения](../../../compute/concepts/instance-groups/policies/allocation-policy.md):
       * `location` — повторяющееся поле, указывающее зоны доступности (сети и подсети), которые будут использоваться группой узлов.
         * `zone` — зона доступности.
     * `maintenance_policy`— настройки политики обновлений:
       * `auto_upgrade` — флаг, который указывает, можно ли автоматически обновить группу узлов.
       * `auto_repair` — флаг, который указывает, можно ли [автоматически восстановить](../../../compute/concepts/instance-groups/autohealing.md) группу узлов. На текущей момент не поддерживается.
       * `maintenance_window` — настройки окна технического обслуживания. С их помощью вы можете указать предпочтительное время начала проведения операций по техническому обслуживанию узлов кластера (например, можно выбрать время, когда кластер наименее нагружен запросами). Укажите в параметрах `day`,`start_time` и `duration`: день, время начала и продолжительность технического обслуживания.

         Чтобы указать интервал времени суток, для всех дней должен укажите только два поля: `start_time` и `duration`.

         Чтобы разрешить обслуживание только в определенные дни недели, укажите все поля. Для каждого дня недели допускается только один временной интервал.

     ```hcl
     resource "yandex_kubernetes_node_group" "my_node_group" {
       cluster_id  = "${yandex_kubernetes_cluster.zonal_cluster_resource_name.id}"
       name        = "MyNodes"
       description = "MyNodes description"
       version     = "1.17"

       labels = {
         "key" = "value"
       }
       instance_template {
         platform_id = "standard-v2"
         network_interface {
           nat        = true
           subnet_ids = ["${yandex_vpc_subnet.subnet_resource_name.id}"]
         }
         resources {
           memory = 2
           cores  = 2
         }
         boot_disk {
           type = "network-hdd"
           size = 64
         }
         scheduling_policy {
           preemptible = false
         }
       }
       scale_policy {
         fixed_scale {
           size = 1
         }
       }
       allocation_policy {
         location {
           zone = "ru-central1-a"
         }
       }
       maintenance_policy {
         auto_upgrade = true
         auto_repair  = true
         maintenance_window {
           day        = "monday"
           start_time = "15:00"
           duration   = "3h"
         }
         maintenance_window {
           day        = "friday"
           start_time = "10:00"
           duration   = "4h30m"
         }
       }
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, смотрите в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Выполните проверку с помощью команды:

     ```bash
     terraform plan
     ```

     Результат выполнения команды:

     ```
     Refreshing Terraform state in-memory prior to plan...
     The refreshed state will be used to calculate this plan, but will not be
     persisted to local or remote state storage.
     ...
     Note: You didn't specify an "-out" parameter to save this plan, so Terraform
     can't guarantee that exactly these actions will be performed if
     "terraform apply" is subsequently run.
     ```

     В терминале будет выведен список ресурсов с параметрами. Это проверочный этап, ресурсы не будут созданы. Если в конфигурации есть ошибки, Terraform на них укажет.

     {% note alert %}

     Все созданные с помощью Terraform ресурсы тарифицируются. Внимательно проверьте план.

     {% endnote %}

  1. Чтобы создать ресурсы, выполните команду:

     ```bash
     terraform apply
     ```

     Результат выполнения команды:

     ```
     An execution plan has been generated and is shown below.
     Resource actions are indicated with the following symbols:
     + create
     ...
     Terraform will perform the actions described above.
     Only 'yes' will be accepted to approve.

     Enter a value:
     ```

  1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**:

     ```bash
     Enter a value: yes
     ```

  1. Проверьте ресурсы и их настройки в [консоли управления]({{ link-console-main }}).

- API

  Чтобы создать группу узлов, воспользуйтесь методом [create](../../api-ref/NodeGroup/create.md) для ресурса [NodeGroup](../../api-ref/NodeGroup). Чтобы разрешить использование узлами группы [небезопасных параметров ядра](../../concepts/index.md#node-group), передайте их имена в параметре `allowedUnsafeSysctls`.

{% endlist %}