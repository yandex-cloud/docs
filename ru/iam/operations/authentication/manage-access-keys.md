---
title: Как управлять статическими ключами доступа в {{ iam-full-name }}
description: Из статьи вы узнаете, как создавать и удалять статические ключи доступа в {{ iam-full-name }} через консоль управления, CLI и API сервиса.
---

# Управление статическими ключами доступа

[Часть сервисов](../../concepts/authorization/access-key.md#supported-services) {{ yandex-cloud }} поддерживает аутентификацию с помощью [статических ключей доступа](../../concepts/authorization/access-key.md).

Статические ключи доступа создаются для [сервисных аккаунтов](../../concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

## Создать статический ключ доступа {#create-access-key}

Чтобы создать статический ключ доступа сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт, для которого вы хотите создать статический ключ доступа.
  1. На панели сверху нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания статического ключа доступа:

      ```bash
      yc iam access-key create --help
      ```

  1. Выберите сервисный аккаунт, например `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```
  1. Создайте ключ доступа для сервисного аккаунта `my-robot`:

      ```bash
      yc iam access-key create --service-account-name my-robot
      ```

      Результат:

      ```text
      access_key:
        id: aje6t3vsbj8l********
        service_account_id: ajepg0mjt06s********
        created_at: "2018-11-22T14:37:51Z"
        key_id: 0n8X6WY6S24N********
      secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI********
      ```

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Повторно получить значение ключа будет невозможно.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        description        = "<описание_ключа>"
        pgp_key            = "keybase:keybaseusername"
        output_to_lockbox  {
          secret_id             = "<идентификатор_секрета_Lockbox>"
          entry_for_access_key  = "<ключ_секрета_для_идентификатора_статического_ключа>"
          entry_for_secret_key  = "<ключ_секрета_для_секретного_ключа>"
        }
      }
     ```

     Где:

     * `service_account_id` — идентификатор сервисного аккаунта. Обязательный параметр.
     * `description` — описание ключа. Необязательный параметр.
     * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Необязательный параметр. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`.

     * `output_to_lockbox` — описание [секрета](../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, в который будут сохранены секретные значения ключа, во избежание их возможной утечки через файл состояния `terraform.tfstate`. Необязательный параметр. Вложенные параметры:
         * `secret_id` — идентификатор секрета {{ lockbox-full-name }}, в который будут сохранены идентификатор ключа и секретный ключ. Секрет должен быть [пользовательского типа](../../../lockbox/concepts/secret.md#secret-type).
         * `entry_for_access_key` — ключ секрета, который будет присвоен сохраняемому значению идентификатора статического ключа доступа.
         * `entry_for_secret_key` — ключ секрета, который будет присвоен сохраняемому значению секретного ключа.

     Более подробную информацию о параметрах ресурса `yandex_iam_service_account_static_access_key` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
         
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

     1. Подтвердите создание статического ключа доступа: введите в терминал слово `yes` и нажмите **Enter**.

        Если при создании ключа возникли ошибки, {{ TF }} на них укажет.
        При успешном создании ключа {{ TF }} запишет его в свою конфигурацию, но не покажет пользователю. В терминал будет выведен только id созданного ключа.

        Проверить появление ключа у сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
         
        ```bash
        yc iam access-key list --service-account-name=<имя_сервисного_аккаунта>
        ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../awscompatibility/api-ref/grpc/AccessKey/create.md).

{% endlist %}

### Примеры {#examples}

#### Добавить описание при создании {#add-description}

Добавьте описание при создании ключа доступа.

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam access-key create \
    --service-account-name my-robot \
    --description "this key is for my bucket"
  ```

- {{ TF }} {#tf}

  ```hcl
  resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
    service_account_id = "<идентификатор_сервисного_аккаунта>"
    description        = "this key is for my bucket"
    pgp_key            = "BIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+x....."
  }
  ```

- API {#api}

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{
        "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
        "description": "this key is for my bucket"
    }' \
    https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
  ```

{% endlist %}

## Удалить статический ключ доступа {#delete-access-key}

Чтобы удалить статический ключ доступа сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите нужный сервисный аккаунт.
  1. В блоке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_service-account-keys }}** в строке с ключом, который нужно удалить, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete-api-key }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список статических ключей доступа сервисного аккаунта, указав его имя:

     ```bash
     yc iam access-key list \
       --service-account-name <имя_сервисного_аккаунта>
     ```

     Результат:

     ```text
     +----------------------+----------------------+----------------------+
     |          ID          |  SERVICE ACCOUNT ID  |        KEY ID        |
     +----------------------+----------------------+----------------------+
     | aje8bdtqec6l******** | ajeedllrkjma******** | R9JK04o1Dfaf******** |
     | ajegqpa91bta******** | ajeedllrkjma******** | cWXGkDoBRho5******** |
     +----------------------+----------------------+----------------------+
     ```

  1. Удалите статический ключ доступа, указав его идентификатор:

     ```bash
     yc iam access-key delete <идентификатор_ключа>
     ```

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Откройте файл конфигурации {{ TF }} и удалите секцию с описанием статического ключа доступа.

        Пример описания статического ключа доступа в конфигурации {{ TF }}:

        ```hcl
        resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          description        = "<описание_ключа>"
          pgp_key            = "keybase:keybaseusername"
          output_to_lockbox  {
            secret_id             = "<идентификатор_секрета_Lockbox>"
            entry_for_access_key  = "<ключ_секрета_для_идентификатора_статического_ключа>"
            entry_for_secret_key  = "<ключ_секрета_для_секретного_ключа>"
          }
        }
        ```

        Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).

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

        1. Подтвердите создание или удаление ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы или удалены все требуемые ресурсы. Проверить появление ресурсов и их настройки или удаление ресурсов можно в [консоли управления]({{ link-console-main }}), а также с помощью команды CLI:

        ```bash
        yc iam access-key list --service-account-id <идентификатор_сервисного_аккаунта>
        ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../awscompatibility/api-ref/AccessKey/delete.md) для ресурса [AccessKey](../../awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Delete](../../awscompatibility/api-ref/grpc/AccessKey/delete.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/authorization/access-key.md)
* [Настройка инструментов для работы с {{ objstorage-name }}](../../../storage/tools/index.md)
* [{#T}](../sa/assign-role-for-sa.md)
* [{#T}](../../tutorials/static-key-in-lockbox/index.md)