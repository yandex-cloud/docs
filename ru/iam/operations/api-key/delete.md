---
title: Удаление API-ключа
description: Следуя данной инструкции, вы сможете удалить API-ключ.
---

# Удаление API-ключа

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. В списке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}** найдите API-ключ, который нужно удалить.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке ключа.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete-api-key }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Получите список с идентификаторами `ID` API-ключей для конкретного сервисного аккаунта. В параметре `--service-account-name` укажите имя сервисного аккаунта:

        ```bash
        yc iam api-key list --service-account-name <имя_сервисного_аккаунта>
        ```

        Результат:

        ```text
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | ajenhvftf77r******** | 2022-03-13 21:15:40 |
        | ajeq610sgh05******** | 2022-03-13 21:14:43 |
        +----------------------+---------------------+
        ```

        По умолчанию для поиска сервисного аккаунта используется каталог, указанный в профиле CLI. Вы можете указать другой каталог с помощью флага `--folder-name` или `--folder-id`.

    1. Удалите старый API-ключ. Вместо `<идентификатор>` укажите идентификатор API-ключа:

        ```bash
        yc iam api-key delete <идентификатор>
        ```

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием API-ключа.

        Пример описания API-ключа в конфигурации {{ TF }}:

        ```hcl
        resource "yandex_iam_service_account_api_key" "sa-api-key" {
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            description        = "<описание_ключа>"
            pgp_key            = "<pgp-ключ>"
        }
        ```

    1. Удалите запись с информацией о ресурсе.

        Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_api_key).

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

            ```bash
            terraform plan
            ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

            ```bash
            terraform apply
            ```

        1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}), а также с помощью команды CLI:

        ```bash
        yc iam key list --service-account-id <идентификатор_сервисного_аккаунта>
        ```

- API {#api}

  Удалите API-ключ с помощью метода REST API [delete](../../api-ref/ApiKey/delete.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md):

    ```bash
    export APIKEY_ID=ajeke74kbp5b********
    export IAM_TOKEN=CggaATEVAgA...
    curl -X DELETE -H "Authorization: Bearer $IAM_TOKEN" \
        https://iam.{{ api-host }}/iam/v1/apiKeys/$APIKEY_ID
    ```
   Также API-ключ можно удалить с помощью gRPC API [ApiKeyService/Delete](../../api-ref/grpc/api_key_service.md#Delete).

{% endlist %}
