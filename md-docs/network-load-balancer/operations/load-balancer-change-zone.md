# Переместить ВМ в целевую группу в новой зоне доступности


Чтобы перенести виртуальные машины за сетевым балансировщиком в целевую группу в другой [зоне доступности](../../overview/concepts/geo-scope.md):

1. [Перенесите](../../compute/operations/vm-control/vm-change-zone.md) виртуальные машины в новую зону доступности.
1. Замените [целевые ресурсы](../concepts/target-resources.md) в целевой группе:

    {% list tabs group=instructions %}
    
    - Консоль управления {#console}
    
      1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [сетевой балансировщик](../concepts/index.md).
      1. Перейдите в сервис **Network Load Balancer**.
      1. На панели слева выберите ![image](../../_assets/console-icons/target.svg) **Целевые группы**.
      1. Выберите нужную [целевую группу](../concepts/target-resources.md).
      1. В блоке **Целевые ресурсы** удалите старые [виртуальные машины](../../compute/concepts/vm.md) и добавьте новые.
    
    - CLI {#cli}
    
      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
      1. Посмотрите описание команды [CLI](../../cli/index.md) для удаления ресурсов из [целевой группы](../concepts/target-resources.md):
    
         ```bash
         yc load-balancer target-group remove-targets --help
         ```
    
      1. [Получите](target-group-list.md#list) список целевых групп [Network Load Balancer](../index.md) в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию.
      1. [Получите](target-group-list.md#get) список целевых ресурсов, привязанных к целевой группе.
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
         region_id: ru-central1
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
          | b0cnd1srghnm******** | rucentrald | enpv51f8lple******** |                | ru-central1-d | [192.168.3.0/24] |
          | e2li9tcgi7ii******** | rucentralb | enpv51f8lple******** |                | ru-central1-b | [192.168.0.0/24] |
          | e9b4a9ksc88k******** | rucentrala | enpv51f8lple******** |                | ru-central1-a | [192.168.1.0/24] |
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
         | fhmkchjddi40******** | sample-vm1 | ru-central1-a | RUNNING | 130.193.**.***  | 192.168.1.9  |
         | fhm13ts43oml******** | sample-vm2 | ru-central1-a | RUNNING | 158.160.***.*** | 192.168.1.32 |
         | epdsj30mndgj******** | sample-vm3 | ru-central1-b | RUNNING | 51.250.***.***  | 192.168.0.7  |
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
    
    - Terraform {#tf}
    
      [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
      
      Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
      
      Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).
    
      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
    
      1. Откройте фрагмент с описанием [целевой группы](../concepts/target-resources.md) в конфигурационном файле Terraform и отредактируйте поля `subnet_id` и `address` в блоке `target`:
    
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
    
      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
    
      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):
    
      ```bash
      yc load-balancer target-group get <имя_целевой_группы>
      ```
    
    - API {#api}
    
      1. Чтобы отключить ресурсы от [целевой группы](../concepts/target-resources.md), воспользуйтесь методом REST API [removeTargets](../api-ref/TargetGroup/removeTargets.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/RemoveTargets](../api-ref/grpc/TargetGroup/removeTargets.md).
      1. Чтобы подключить ресурсы к целевой группе, воспользуйтесь методом REST API [addTargets](../api-ref/TargetGroup/addTargets.md) для ресурса [TargetGroup](../api-ref/TargetGroup/index.md) или вызовом gRPC API [TargetGroupService/AddTargets](../api-ref/grpc/TargetGroup/addTargets.md).
    
    {% endlist %}

1. Если у вас [внутренний сетевой балансировщик](../concepts/specifics.md#nlb-int-routing), и вам необходимо перенести его в подсеть, соответствующую новой зоне доступности виртуальных машин:

    1. [Удалите](listener-remove.md) существующий обработчик трафика балансировщика.
    1. [Добавьте](listener-add.md) новый обработчик трафика для новой зоны доступности.

    IP-адрес сетевого балансировщика изменится.

1. [Убедитесь](check-resource-health.md), что ресурсы целевой группы в новой зоне доступности прошли [проверку состояния](../concepts/health-check.md) и перешли в статус `HEALTHY`.

    Если новые виртуальные машины в течение длительного времени остаются в статусе `UNHEALTHY`, убедитесь, что к ВМ привязаны группы безопасности, разрешающие трафик [проверок состояния](../concepts/health-check.md#target-statuses).