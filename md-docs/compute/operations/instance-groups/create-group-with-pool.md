[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Создание группы виртуальных машин > Создать группу ВМ с привязкой к пулу резервов ВМ

# Создать группу с виртуальными машинами из пула резервов Yandex Compute Cloud


{% note warning %}

Пулы резервов ВМ тарифицируются: взимается плата за весь свободный объем зарезервированных вычислительных ресурсов ВМ, кластеров GPU и программно ускоренных сетей согласно [правилам тарификации Yandex Compute Cloud](../../pricing.md). Подробнее в разделе [Использование пулов резервов ВМ](../../pricing.md#pool).

{% endnote %}

_Функциональность пулов резервов ВМ находится на [стадии Preview](../../../overview/concepts/launch-stages.md)._

_Пул резервов виртуальных машин_ — это зарезервированная пользователем в заданной [зоне доступности](../../../overview/concepts/geo-scope.md) совокупность вычислительных ресурсов, которые будут гарантированно доступны пользователю для создания в этой зоне доступности [виртуальных машин](../../concepts/vm.md) в определенной [конфигурации](../../concepts/performance-levels.md#available-configurations).

Вы можете использовать пулы резервов для [групп ВМ](../../concepts/instance-groups/index.md). Это обеспечивает гарантированную доступность ресурсов для ВМ группы.

Пулы резервов ВМ несовместимы с [выделенными хостами](../../concepts/dedicated-host.md), [прерываемыми ВМ](../../concepts/preemptible-vm.md) и виртуальными машинами с [уровнем производительности vCPU](../../concepts/performance-levels.md) менее 100%. Кроме того, в настоящее время пулы резервов ВМ не поддерживают [группы размещения](../../concepts/placement-groups.md).

Пулы резервов ВМ создаются в конкретных зонах доступности. Чтобы автоматизировать распределение ВМ мультизональной группы в пулах резервов ВМ конкретной зоны доступности, используйте [переменные в шаблоне ВМ](../../concepts/instance-groups/variables-in-the-template.md).

Подробнее читайте на странице [Пулы резервов виртуальных машин в Compute Cloud](../../concepts/reserved-pools.md).

## Создать группу в одной зоне доступности с ВМ из пула резервов этой зоны {#single-zone}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого группа будет управлять ВМ, с ролью [compute.admin](../../security/index.md#compute-admin).
1. [Создайте](../reserved-pools/create-reserved-pool.md) пул резервов ВМ с конфигурацией, которую вы хотите использовать для ВМ группы.

    {% note info %}
    
    Конфигурация пула резервов ВМ должна соответствовать конфигурации группы ВМ, которую вы хотите создать, в части:
    * [платформы](../../concepts/vm-platforms.md);
    * количества vCPU;
    * объема RAM;
    * [зоны доступности](../../../overview/concepts/geo-scope.md).
    
    Количество ВМ в группе в каждой зоне доступности не должно превышать размер пулов резервов ВМ в этих зонах.
    
    {% endnote %}

1. Создайте группу ВМ:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Создайте файл `specification.yaml` со спецификацией группы ВМ, например:

          ```yaml
          name: first-fixed-group
          service_account_id: <идентификатор_сервисного_аккаунта>
          instance_template:
            platform_id: standard-v4a
            resources_spec:
              memory: 2g
              cores: 2
            boot_disk_spec:
              mode: READ_WRITE
              disk_spec:
                image_id: fd83esfomhq25p2ono90
                type_id: network-hdd
                size: 20g
            network_interface_specs:
              - network_id: <идентификатор_сети>
                primary_v4_address_spec: {}
                subnet_ids:
                  - <идентификатор_подсети>
                security_group_ids:
                  - <идентификатор_группы_безопасности>
            reserved_instance_pool_id: <идентификатор_пула_резервов_ВМ>
          deploy_policy:
            max_unavailable: 1
            max_expansion: 0
          scale_policy:
            fixed_scale:
              size: 3
          allocation_policy:
            zones:
              - zone_id: ru-central1-a
          ```

          Где:
          * `service_account_id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), созданного ранее.
          * `network_id` — [идентификатор сети](../../../vpc/operations/network-get-info.md).
          * `subnet_ids` — [идентификатор подсети](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids` — [идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md).
          * `reserved_instance_pool_id` — [идентификатор](../../cli-ref/reserved-instance-pool/list.md) пула резервов ВМ, созданного ранее.
          * `zone_id` — зона доступности.

          Подробнее о параметрах группы ВМ читайте на странице [Спецификация группы виртуальных машин в формате YAML](../../concepts/instance-groups/specification.md).

      1. Примените спецификацию, для этого в терминале выполните команду:

          ```bash
          yc compute instance-group create \
            --file specification.yaml
          ```

          Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance-group/create.md).

    - Terraform {#tf}

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле параметры группы ВМ:

          ```hcl
          resource "yandex_compute_instance_group" "first-fixed-group" {
            name                = "first-fixed-group"
            service_account_id  = "<идентификатор_сервисного_аккаунта>"

            instance_template {
              platform_id = "standard-v4a"
              resources {
                memory = 2
                cores  = 2
              }

              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = "fd83esfomhq25p2ono90"
                }
              }

              network_interface {
                network_id         = "<идентификатор_сети>"
                subnet_ids         = ["<идентификатор_подсети>"]
                security_group_ids = ["<идентификатор_группы_безопасности>"]
              }

              reserved_instance_pool_id = "<идентификатор_пула_резервов_ВМ>"
            }

            scale_policy {
              fixed_scale {
                size = 3
              }
            }

            allocation_policy {
              zones = ["ru-central1-a"]
            }

            deploy_policy {
              max_unavailable = 1
              max_expansion   = 0
            }
          }
          ```

          Где:
          * `service_account_id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), созданного ранее.
          * `network_id` — [идентификатор сети](../../../vpc/operations/network-get-info.md).
          * `subnet_ids` — [идентификатор подсети](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids` — [идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md).
          * `reserved_instance_pool_id` — [идентификатор](../../cli-ref/reserved-instance-pool/list.md) пула резервов ВМ, созданного ранее
          * `zones` — зона доступности.

          Подробнее о параметрах группы ВМ читайте на странице [Спецификация группы виртуальных машин в формате YAML](../../concepts/instance-groups/specification.md).

      1. Создайте группу ВМ:

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

      Подробнее о ресурсе `yandex_compute_instance_group` читайте в [справочнике Terraform](../../../terraform/resources/compute_instance_group.md).

    - API {#api}

      Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

      Для указания пула резервов используйте параметр `instanceTemplate.reservedInstancePoolId` (`instance_template.reserved_instance_pool_id`).

    {% endlist %}

## Создать группу в трех зонах доступности с ВМ из пулов резервов каждой зоны {#multi-zone}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого группа будет управлять ВМ, с ролью [compute.admin](../../security/index.md#compute-admin).
1. [Создайте](../reserved-pools/create-reserved-pool.md) пулы резервов ВМ в трех зонах доступности с конфигурацией, которую вы хотите использовать для ВМ группы.

    {% note info %}
    
    Конфигурация пула резервов ВМ должна соответствовать конфигурации группы ВМ, которую вы хотите создать, в части:
    * [платформы](../../concepts/vm-platforms.md);
    * количества vCPU;
    * объема RAM;
    * [зоны доступности](../../../overview/concepts/geo-scope.md).
    
    Количество ВМ в группе в каждой зоне доступности не должно превышать размер пулов резервов ВМ в этих зонах.
    
    {% endnote %}

1. Создайте группу ВМ:

    {% list tabs group=instructions %}

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Создайте файл `specification.yaml` со спецификацией группы ВМ, например:

          ```yaml
          name: first-fixed-group
          service_account_id: <идентификатор_сервисного_аккаунта>
          variables:
            - key: pool_ru-central1-a
              value: <идентификатор_пула_резервов_в_зоне_a>
            - key: pool_ru-central1-b
              value: <идентификатор_пула_резервов_в_зоне_b>
            - key: pool_ru-central1-d
              value: <идентификатор_пула_резервов_в_зоне_d>
          instance_template:
            platform_id: standard-v4a
            resources_spec:
              memory: 2g
              cores: 2
            boot_disk_spec:
              mode: READ_WRITE
              disk_spec:
                image_id: fd83esfomhq25p2ono90
                type_id: network-hdd
                size: 20g
            network_interface_specs:
              - network_id: <идентификатор_сети>
                primary_v4_address_spec: {}
                subnet_ids:
                  - <идентификатор_подсети_в_зоне_a>
                  - <идентификатор_подсети_в_зоне_b>
                  - <идентификатор_подсети_в_зоне_d>
                security_group_ids:
                  - <идентификатор_группы_безопасности>
            reserved_instance_pool_id: "{pool_{instance.zone_id}}"
          deploy_policy:
            max_unavailable: 1
            max_expansion: 0
          scale_policy:
            fixed_scale:
              size: 3
          allocation_policy:
            zones:
              - zone_id: ru-central1-a
              - zone_id: ru-central1-b
              - zone_id: ru-central1-d
          ```

          Где:
          * `service_account_id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), созданного ранее.
          * `network_id` — [идентификатор сети](../../../vpc/operations/network-get-info.md).
          * `subnet_ids` — [идентификаторы подсетей](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids` — [идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md).
          * `variables` — пользовательские переменные с [идентификаторами пулов резервов ВМ](../../cli-ref/reserved-instance-pool/list.md) в разных зонах доступности.
          * `reserved_instance_pool_id` — идентификаторы пулов резервов ВМ, которые будут получены в результате подстановки [системной переменной](../../concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретной ВМ) и [пользовательских переменных](../../concepts/instance-groups/variables-in-the-template.md#second-stage), заданных в параметре `variables`.
          * `zone_id` — зоны доступности.

          Подробнее о параметрах группы ВМ читайте на странице [Спецификация группы виртуальных машин в формате YAML](../../concepts/instance-groups/specification.md).

      1. Примените спецификацию, для этого в терминале выполните команду:

          ```bash
          yc compute instance-group create \
            --file specification.yaml
          ```

          Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance-group/create.md).

    - Terraform {#tf}

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

      1. Опишите в конфигурационном файле параметры группы ВМ:

          ```hcl
          resource "yandex_compute_instance_group" "ig-1" {
            name                = "fixed-group"
            service_account_id  = "<идентификатор_сервисного_аккаунта>"

            # Переменные для пулов резервов ВМ
            variables = {
              pool_ru-central1-a = "<идентификатор_пула_резервов_в_зоне_a>"
              pool_ru-central1-b = "<идентификатор_пула_резервов_в_зоне_b>"
              pool_ru-central1-d = "<идентификатор_пула_резервов_в_зоне_d>"
            }

            instance_template {
              platform_id = "standard-v4a"
              resources {
                memory = 2
                cores  = 2
              }

              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = "fd83esfomhq25p2ono90"
                }
              }

              network_interface {
                network_id         = "<идентификатор_сети>"
                subnet_ids         = ["<идентификатор_подсети_в_зоне_a>", "<идентификатор_подсети_в_зоне_b", "<идентификатор_подсети_в_зоне_d>"]
                security_group_ids = ["<идентификатор_группы_безопасности>"]
              }

              # instance.zone_id - системная переменная с идентификатором зоны
              reserved_instance_pool_id = "{pool_{instance.zone_id}}"
            }

            scale_policy {
              fixed_scale {
                size = 3
              }
            }

            allocation_policy {
              zones = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
            }

            deploy_policy {
              max_unavailable = 1
              max_expansion   = 0
            }
          }
          ```

          Где:
          * `service_account_id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), созданного ранее.
          * `network_id` — [идентификатор сети](../../../vpc/operations/network-get-info.md).
          * `subnet_ids` — [идентификаторы подсетей](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids` — [идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md).
          * `variables` — пользовательские переменные с [идентификаторами пулов резервов ВМ](../../cli-ref/reserved-instance-pool/list.md) в разных зонах доступности.
          * `reserved_instance_pool_id` — идентификаторы пулов резервов ВМ, которые будут получены в результате подстановки [системной переменной](../../concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретной ВМ) и [пользовательских переменных](../../concepts/instance-groups/variables-in-the-template.md#second-stage), заданных в параметре `variables`.
          * `zones` — зоны доступности.

          Подробнее о параметрах группы ВМ читайте на странице [Спецификация группы виртуальных машин в формате YAML](../../concepts/instance-groups/specification.md).

      1. Создайте группу ВМ:

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

      Подробнее о ресурсе `yandex_compute_instance_group` читайте в [справочнике Terraform](../../../terraform/resources/compute_instance_group.md).

    - API {#api}

      Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

      Для указания пула резервов используйте параметр `instanceTemplate.reservedInstancePoolId` (`instance_template.reserved_instance_pool_id`).

      Переменные задаются в параметре `variables`.

    {% endlist %}

### Полезные ссылки {#see-also}

* [Концепции Instance Groups](../../concepts/instance-groups/index.md)
* [Пулы резервов виртуальных машин в Compute Cloud](../../concepts/reserved-pools.md)
* [Переменные в шаблоне виртуальной машины](../../concepts/instance-groups/variables-in-the-template.md)