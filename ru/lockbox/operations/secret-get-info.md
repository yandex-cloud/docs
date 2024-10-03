---
title: Как получить информацию о секрете в {{ lockbox-full-name }}
---

# Получить информацию о секрете, его содержимом и правах доступа

Вы можете получить подробную [информацию о секрете](#secret-info), [содержимое секрета](#secret-contents), а также [просмотреть права доступа к секрету](#secret-access).

## Получить информацию о секрете {#secret-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит [секрет](../concepts/secret.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. В меню слева выберите **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
    1. Нажмите на имя нужного секрета.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [секрете](../concepts/secret.md):

      ```bash
      yc lockbox secret get --help
      ```

  1. Получите информацию о секрете, указав его имя или идентификатор:

      ```bash
      yc lockbox secret get <имя_секрета>
      ```

     Результат:

      ```text
      id: e6qi98vtdva1********
      folder_id: b1go79qlt1tp********
      created_at: "2023-11-03T15:28:18.909Z"
      name: test-secret
      kms_key_id: abj765aos682********
      status: ACTIVE
      current_version:
        id: e6q7nvojsgmk********
        secret_id: e6qi98vtdva1********
        created_at: "2023-11-03T15:28:18.909Z"
        status: ACTIVE
        payload_entry_keys:
          - example-key
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [секрете](../concepts/secret.md) с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_lockbox_secret" "my_secret" {
       secret_id = "<идентификатор_секрета>"
     }

     output "current_version" {
       value = data.yandex_lockbox_secret.my_secret.current_version
     }
     ```

     Где:
     * `data "yandex_lockbox_secret"` — описание секрета в качестве источника данных:
       * `secret_id` — идентификатор секрета.
     * `output "current_version"` — выходная переменная, которая содержит информацию о текущей версии секрета:
       * `value` — возвращаемое значение.

     Вместо `current_version` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_lockbox_secret` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_lockbox_secret).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     current_version = tolist([
       {
         "created_at" = "2024-03-27T02:45:05Z"
         "description" = ""
         "destroy_at" = ""
         "id" = "e6qo5a6imnm0********"
         "payload_entry_keys" = tolist([
           "key",
         ])
         "secret_id" = "e6qnva6ntl66********"
         "status" = "ACTIVE"
       },
     ])
     ```

- API {#api}

  Чтобы получить информацию о [секрете](../concepts/secret.md), воспользуйтесь методом REST API [get](../api-ref/Secret/get.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Get](../api-ref/grpc/secret_service.md#Get).

{% endlist %}

## Получить содержимое секрета {#secret-contents}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. В меню слева выберите **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
    1. Нажмите на имя нужного секрета.
    1. В разделе **{{ ui-key.yacloud.lockbox.label_secret-versions-section }}** нажмите на нужную версию секрета.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения содержимого секрета:

      ```bash
      yc lockbox payload get --help
      ```

  1. Получите содержимое секрета, указав его имя или идентификатор:

      ```bash
      yc lockbox payload get <имя_или_идентификатор_секрета>
      ```

     Результат:

      ```text
      version_id: e6q7nvojsgmk********
      entries:
        - key: example-key
          text_value: example-value
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить содержимое секрета с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_lockbox_secret_version" "my_secret_version" {
       secret_id  = "<идентификатор_секрета>"
       version_id = "<идентификатор_версии>"
     }

     output "my_secret_entries" {
       value = data.yandex_lockbox_secret_version.my_secret_version.entries
     }
     ```

     Где:
     * `data "yandex_lockbox_secret_version"` — описание секрета в качестве источника данных:
       * `secret_id` — идентификатор секрета.
       * `version_id` — идентификатор версии секрета. Необязательный параметр. По умолчанию используется текущая версия секрета.
     * `output "my_secret_entries"` — выходная переменная, которая хранит содержимое секрета:
       * `value` — возвращаемое значение.

     Более подробно о параметрах источника данных `yandex_lockbox_secret_version` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_lockbox_secret_version).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     my_secret_entries = [
       {
         key        = "example-key"
         text_value = "example-value"
       },
       {
         key        = "example-key"
         text_value = "example-value"
       },
     ]
     ```

- API {#api}

  Чтобы получить содержимое секрета, воспользуйтесь методом REST API [get](../api-ref/Payload/get.md) для ресурса [Payload](../api-ref/Payload/index.md) или вызовом gRPC API [PayloadService/Get](../api-ref/grpc/payload_service.md#Get).

{% endlist %}

## Просмотреть права доступа к секрету {#secret-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. В меню слева выберите **{{ ui-key.yacloud.lockbox.label_section-secrets }}**.
    1. Нажмите на имя нужного секрета.
    1. На панели слева выберите раздел ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра прав доступа к секрету:

      ```bash
      yc lockbox secret list-access-bindings --help
      ```

  1. Просмотрите права доступа к секрету, указав его имя или идентификатор:

      ```bash
      yc lockbox secret list-access-bindings <имя_или_идентификатор_секрета>
      ```

     Результат:

      ```text
      +---------+---------------+----------------------+
      | ROLE ID | SUBJECT TYPE  |      SUBJECT ID      | 
      +---------+---------------+----------------------+
      | viewer  | federatedUser | ajej2i98kcjd******** | 
      +---------+---------------+----------------------+
      ```

- API {#api}

  Чтобы посмотреть права доступа к секрету, воспользуйтесь методом REST API [ListAccessBindings](../api-ref/Secret/listAccessBindings.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/ListAccessBindings](../api-ref/grpc/secret_service.md#ListAccessBindings).

{% endlist %}