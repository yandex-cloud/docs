---
title: Как настроить сервис метаданных виртуальной машины
description: Следуя данной инструкции, вы сможете задать настройки сервиса метаданных виртуальной машины.
---

# Настроить параметры сервиса метаданных ВМ

Настроить параметры [сервиса метаданных](../../concepts/vm-metadata.md#metadata-formats) виртуальной машины можно при ее [создании](../index.md#vm-create) или [изменении](../vm-control/vm-update.md).

Чтобы настроить параметры сервиса метаданных ВМ:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ.
  1. Задайте настройки сервиса метаданных:

     ```bash
     yc compute instance update <идентификатор_ВМ> \
       --metadata-options gce-http-endpoint=enabled
     ```

     Где `--metadata-options` — параметр, устанавливающий настройки сервиса метаданных виртуальной машины. Возможные значения:
     * `gce-http-endpoint` — параметр управляет доступом к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`.
     * `gce-http-token` — параметр управляет доступом к получению через метаданные Google Compute Engine [IAM-токена](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, подключенного к ВМ. Возможные значения: `enabled`, `disabled`.

     Подробнее см. в разделе [{#T}](../../concepts/vm-metadata.md#metadata-formats).

  Чтобы настроить параметры сервиса метаданных ВМ при создании, аналогичным образом используйте параметр `--metadata-options` в [команде](../../../cli/cli-ref/compute/cli-ref/instance/create.md) `yc compute instance create`.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. Откройте файл конфигурации {{ TF }} и задайте параметр `metadata_options` в описании ВМ:

     ```hcl
     ...
     resource "yandex_compute_instance" "test-vm" {
       ... 
       metadata_options {
         gce_http_endpoint    = 0
         gce_http_token       = 0
       }
       ...
     }
     ...
     ```

     Где:
     * `yandex_compute_instance` — описание ВМ:
       * `metadata_options` — параметры метаданных:
         * `gce_http_endpoint` — параметр управляет доступом к метаданным с использованием формата Google Compute Engine. Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.
         * `gce_http_token` — параметр управляет доступом к получению через метаданные Google Compute Engine [IAM-токена](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, подключенного к ВМ. Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.

       Подробнее см. в разделе [{#T}](../../concepts/vm-metadata.md#metadata-formats).

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы с заданными настройками. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc compute instance get <имя_ВМ>
     ```

- API {#api}

  При создании ВМ воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

  При изменении ВМ воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md).

{% endlist %}