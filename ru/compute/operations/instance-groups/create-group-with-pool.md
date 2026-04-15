---
title: Создать группу виртуальных машин с привязкой к пулу резервов ВМ
description: Из статьи вы узнаете, как создать группу виртуальных машин {{ compute-full-name }} с привязкой к пулу резервов ВМ.
---

# Создать группу с виртуальными машинами из пула резервов {{ compute-full-name }}


{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

{% include [reserved-pools-intro](../../../_includes/compute/reserved-pools-intro.md) %}

Вы можете использовать пулы резервов для [групп ВМ](../../concepts/instance-groups/index.md). Это обеспечивает гарантированную доступность ресурсов для ВМ группы.

{% include [pool-restrictions](../../_includes_service/pool-restrictions.md) %}

Пулы резервов ВМ создаются в конкретных зонах доступности. Чтобы автоматизировать распределение ВМ мультизональной группы в пулах резервов ВМ конкретной зоны доступности, используйте [переменные в шаблоне ВМ](../../concepts/instance-groups/variables-in-the-template.md).

Подробнее читайте на странице [{#T}](../../concepts/reserved-pools.md).

## Создать группу в одной зоне доступности с ВМ из пула резервов этой зоны {#single-zone}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого группа будет управлять ВМ, с ролью [compute.admin](../../security/index.md#compute-admin).
1. [Создайте](../../operations/reserved-pools/create-reserved-pool.md) пул резервов ВМ с конфигурацией, которую вы хотите использовать для ВМ группы.

    {% include [reserved-pools-configuration-for-groups](../../../_includes/compute/reserved-pools-configuration-for-groups.md) %}

1. Создайте группу ВМ:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
              - zone_id: {{ region-id }}-a
          ```

          Где:
          * `service_account_id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), созданного ранее.
          * `network_id` — [идентификатор сети](../../../vpc/operations/network-get-info.md).
          * `subnet_ids` — [идентификатор подсети](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids` — [идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md).
          * `reserved_instance_pool_id` — [идентификатор](../../cli-ref/reserved-instance-pool/list.md) пула резервов ВМ, созданного ранее.
          * `zone_id` — зона доступности.

          Подробнее о параметрах группы ВМ читайте на странице [{#T}](../../concepts/instance-groups/specification.md).

      1. Примените спецификацию, для этого в терминале выполните команду:

          ```bash
          yc compute instance-group create \
            --file specification.yaml
          ```

          Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

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
              zones = ["{{ region-id }}-a"]
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

          Подробнее о параметрах группы ВМ читайте на странице [{#T}](../../concepts/instance-groups/specification.md).

      1. Создайте группу ВМ:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Подробнее о ресурсе `yandex_compute_instance_group` читайте в [справочнике {{ TF }}](../../../terraform/resources/compute_instance_group.md).

    - API {#api}

      Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

      Для указания пула резервов используйте параметр `instanceTemplate.reservedInstancePoolId` (`instance_template.reserved_instance_pool_id`).

    {% endlist %}

## Создать группу в трех зонах доступности с ВМ из пулов резервов каждой зоны {#multi-zone}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого группа будет управлять ВМ, с ролью [compute.admin](../../security/index.md#compute-admin).
1. [Создайте](../../operations/reserved-pools/create-reserved-pool.md) пулы резервов ВМ в трех зонах доступности с конфигурацией, которую вы хотите использовать для ВМ группы.

    {% include [reserved-pools-configuration-for-groups](../../../_includes/compute/reserved-pools-configuration-for-groups.md) %}

1. Создайте группу ВМ:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. Создайте файл `specification.yaml` со спецификацией группы ВМ, например:

          ```yaml
          name: first-fixed-group
          service_account_id: <идентификатор_сервисного_аккаунта>
          variables:
            - key: pool_{{ region-id }}-a
              value: <идентификатор_пула_резервов_в_зоне_a>
            - key: pool_{{ region-id }}-b
              value: <идентификатор_пула_резервов_в_зоне_b>
            - key: pool_{{ region-id }}-d
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
              - zone_id: {{ region-id }}-a
              - zone_id: {{ region-id }}-b
              - zone_id: {{ region-id }}-d
          ```

          Где:
          * `service_account_id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), созданного ранее.
          * `network_id` — [идентификатор сети](../../../vpc/operations/network-get-info.md).
          * `subnet_ids` — [идентификаторы подсетей](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids` — [идентификатор группы безопасности](../../../vpc/operations/security-group-get-info.md).
          * `variables` — пользовательские переменные с [идентификаторами пулов резервов ВМ](../../cli-ref/reserved-instance-pool/list.md) в разных зонах доступности.
          * `reserved_instance_pool_id` — идентификаторы пулов резервов ВМ, которые будут получены в результате подстановки [системной переменной](../../concepts/instance-groups/variables-in-the-template.md#first-stage) `instance.zone_id` (зона доступности конкретной ВМ) и [пользовательских переменных](../../concepts/instance-groups/variables-in-the-template.md#second-stage), заданных в параметре `variables`.
          * `zone_id` — зоны доступности.

          Подробнее о параметрах группы ВМ читайте на странице [{#T}](../../concepts/instance-groups/specification.md).

      1. Примените спецификацию, для этого в терминале выполните команду:

          ```bash
          yc compute instance-group create \
            --file specification.yaml
          ```

          Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. Опишите в конфигурационном файле параметры группы ВМ:

          ```hcl
          resource "yandex_compute_instance_group" "ig-1" {
            name                = "fixed-group"
            service_account_id  = "<идентификатор_сервисного_аккаунта>"

            # Переменные для пулов резервов ВМ
            variables = {
              pool_{{ region-id }}-a = "<идентификатор_пула_резервов_в_зоне_a>"
              pool_{{ region-id }}-b = "<идентификатор_пула_резервов_в_зоне_b>"
              pool_{{ region-id }}-d = "<идентификатор_пула_резервов_в_зоне_d>"
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
              zones = ["{{ region-id }}-a", "{{ region-id }}-b", "{{ region-id }}-d"]
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

          Подробнее о параметрах группы ВМ читайте на странице [{#T}](../../concepts/instance-groups/specification.md).

      1. Создайте группу ВМ:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Подробнее о ресурсе `yandex_compute_instance_group` читайте в [справочнике {{ TF }}](../../../terraform/resources/compute_instance_group.md).

    - API {#api}

      Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

      Для указания пула резервов используйте параметр `instanceTemplate.reservedInstancePoolId` (`instance_template.reserved_instance_pool_id`).

      Переменные задаются в параметре `variables`.

    {% endlist %}

### См. также {#see-also}

* [{#T}](../../concepts/instance-groups/index.md)
* [{#T}](../../concepts/reserved-pools.md)
* [{#T}](../../concepts/instance-groups/variables-in-the-template.md)
