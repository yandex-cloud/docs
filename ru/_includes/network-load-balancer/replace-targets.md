{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [сетевой балансировщик](../../network-load-balancer/concepts/index.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **{{ ui-key.yacloud.load-balancer.target-group.label_list }}**.
  1. Выберите нужную [целевую группу](../../network-load-balancer/concepts/target-resources.md).
  1. В блоке **{{ ui-key.yacloud.load-balancer.target-group.label_targets-section-title }}** удалите старые [виртуальные машины](../../compute/concepts/vm.md) и добавьте новые.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для удаления ресурсов из [целевой группы](../../network-load-balancer/concepts/target-resources.md):

     ```bash
     yc load-balancer target-group remove-targets --help
     ```

  1. [Получите](../../network-load-balancer/operations/target-group-list.md#list) список целевых групп [{{ network-load-balancer-name }}](../../network-load-balancer/) в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию.
  1. [Получите](../../network-load-balancer/operations/target-group-list.md#get) список целевых ресурсов, привязанных к целевой группе.
  1. Удалите старые [виртуальные машины](../../compute/concepts/vm.md) из целевой группы:

     ```bash
     yc load-balancer target-group remove-targets <идентификатор_целевой_группы> \
       --target subnet-id=<идентификатор_подсети_ВМ_1>,address=<внутренний_IP-адрес_ВМ_1> \
       --target subnet-id=<идентификатор_подсети_ВМ_2>,address=<внутренний_IP-адрес_ВМ_2> \
       ...
       --target subnet-id=<идентификатор_подсети_ВМ_n>,address=<внутренний_IP-адрес_ВМ_n>
     ```

     Где:
     * `<идентификатор_целевой_группы>` — идентификатор целевой группы, из которой требуется удалить целевые ресурсы.
     * `--target` — параметры ресурса в целевой группе:
       * `subnet-id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet) удаляемого целевого ресурса.
       * `address` — [внутренний IP-адрес](../../vpc/concepts/address.md#internal-addresses) удаляемого целевого ресурса.

     Результат:

     ```text
     done (4s)
     id: enplckhtn77s********
     folder_id: b1gt6g8ht345********
     created_at: "2023-10-16T10:42:18Z"
     name: sample-tg
     region_id: {{ region-id }}
     targets:
     ```

  1. Посмотрите описание команды CLI для подключения ресурсов к целевой группе:

     ```bash
     yc load-balancer target-group add-targets --help
     ```

  1. Получите список подсетей в каталоге по умолчанию:

     ```bash
     yc vpc subnet list
     ```

     Результат:

      ```text
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      |          ID          |    NAME    |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE       |
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      | b0cnd1srghnm******** | rucentrald | enpv51f8lple******** |                | {{ region-id }}-d | [192.168.3.0/24] |
      | e2li9tcgi7ii******** | rucentralb | enpv51f8lple******** |                | {{ region-id }}-b | [192.168.0.0/24] |
      | e9b4a9ksc88k******** | rucentrala | enpv51f8lple******** |                | {{ region-id }}-a | [192.168.1.0/24] |
      +----------------------+------------+----------------------+----------------+---------------+------------------+
      ```

  1. Получите список ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance list
     ```

     Результат:

     ```text
     +----------------------+------------+-------------------+---------+-----------------+--------------+
     |          ID          |    NAME    |      ZONE ID      | STATUS  |   EXTERNAL IP   | INTERNAL IP  |
     +----------------------+------------+-------------------+---------+-----------------+--------------+
     | fhmkchjddi40******** | sample-vm1 | {{ region-id }}-a | RUNNING | 130.193.**.***  | 192.168.1.9  |
     | fhm13ts43oml******** | sample-vm2 | {{ region-id }}-a | RUNNING | 158.160.***.*** | 192.168.1.32 |
     | epdsj30mndgj******** | sample-vm3 | {{ region-id }}-b | RUNNING | 51.250.***.***  | 192.168.0.7  |
     +----------------------+------------+-------------------+---------+-----------------+--------------+
     ```

  1. Подключите ресурсы к целевой группе:

     ```bash
     yc load-balancer target-group add-targets <идентификатор_целевой_группы> \
       --target subnet-id=<идентификатор_подсети_ВМ_1>,address=<внутренний_IP-адрес_ВМ_1> \
       --target subnet-id=<идентификатор_подсети_ВМ_2>,address=<внутренний_IP-адрес_ВМ_2>
       ...
       --target subnet-id=<идентификатор_подсети_ВМ_n>,address=<внутренний_IP-адрес_ВМ_n>
     ```

     Где:
     * `<идентификатор_целевой_группы>` — идентификатор целевой группы, в которую требуется добавить целевые ресурсы.
     * `--target` — параметры ресурса в целевой группе:
       * `subnet-id` — идентификатор подсети добавляемого целевого ресурса.
       * `address` — внутренний IP-адрес добавляемого целевого ресурса.

     Результат:

     ```text
     done (4s)
     id: enplckhtn77s********
     folder_id: b1gt6g8ht345********
     ...
         address: 192.168.1.32
       - subnet_id: e9b4a9ksc88k********
         address: 192.168.1.9
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте фрагмент с описанием [целевой группы](../../network-load-balancer/concepts/target-resources.md) в конфигурационном файле {{ TF }} и отредактируйте поля `subnet_id` и `address` в блоке `target`:

     {% cut "Пример описания целевой группы" %}

     ```hcl
     resource "yandex_lb_target_group" "foo" {
       name        = "<имя_целевой_группы>"
       target {
         subnet_id = "<идентификатор_подсети>"
         address   = "<внутренний_IP-адрес_ресурса_1>"
       }
       target {
         subnet_id = "<идентификатор_подсети>"
         address   = "<внутренний_IP-адрес_ресурса_2>"
       }
     }
     ```

     {% endcut %}

  {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```bash
  yc load-balancer target-group get <имя_целевой_группы>
  ```

- API {#api}

  1. Чтобы отключить ресурсы от [целевой группы](../../network-load-balancer/concepts/target-resources.md), воспользуйтесь методом REST API [removeTargets](../../network-load-balancer/api-ref/TargetGroup/removeTargets.md) для ресурса [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/RemoveTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/removeTargets.md).
  1. Чтобы подключить ресурсы к целевой группе, воспользуйтесь методом REST API [addTargets](../../network-load-balancer/api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../../network-load-balancer/api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/AddTargets](../../network-load-balancer/api-ref/grpc/TargetGroup/addTargets.md).

{% endlist %}