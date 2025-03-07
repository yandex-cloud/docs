---
title: Как управлять авторизованными ключами в {{ iam-full-name }}
description: Из статьи вы узнаете, как создавать и удалять авторизованные ключи в {{ iam-full-name }} через консоль управления, CLI и API сервиса.
---

# Управление авторизованными ключами

[Авторизованный ключ](../../concepts/authorization/key.md) — это ключ с неограниченным сроком жизни, использующийся для [получения](../iam-token/create-for-sa.md#via-cli) [IAM-токена](../../concepts/authorization/iam-token.md) сервисного аккаунта: закрытая часть авторизованного ключа используется для формирования [JSON Web Token](https://tools.ietf.org/html/rfc7519) (JWT), который затем обменивается на [IAM-токен](../../concepts/authorization/iam-token.md).

Авторизованные ключи создаются для [сервисных аккаунтов](../../concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

## Создать авторизованный ключ {#create-authorized-key}

Чтобы создать авторизованный ключ сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервисный аккаунт.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
   1. В открывшемся списке выберите сервисный аккаунт, для которого вы хотите создать авторизованный ключ.
   1. На панели сверху нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
   1. Выберите алгоритм шифрования, при необходимости задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**. В открывшемся окне:
       1. Скопируйте открытую и закрытую части ключа и надежно сохраните. Закрытая часть ключа не сохраняется в {{ yandex-cloud }} и получить ее повторно будет невозможно. Открытую часть ключа нельзя будет посмотреть в консоли управления.

           Также вы можете скачать ключи одним файлом в формате JSON. Для этого нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.
       1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания авторизованного ключа:

      ```bash
      yc iam key create --help
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

  1. Создайте авторизованный ключ для сервисного аккаунта `my-robot`:

      ```bash
      yc iam key create \
        --service-account-name my-robot \
        -o my-robot-key.json
      ```

      В случае успеха в файл `my-robot-key.json` будет сохранен созданный авторизованный ключ.

      Пример файла с ключом:

      ```json
      {
         "id": "lfkoe35hsk58********",
         "service_account_id": "ajepg0mjt06s********",
         "created_at": "2019-03-20T10:04:56Z",
         "key_algorithm": "RSA_2048",
         "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
         "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
      }
      ```

      Скопируйте открытую и закрытую части ключа (значения полей `public_key` и `private_key`) и надежно сохраните. Закрытая часть ключа не сохраняется в {{ yandex-cloud }} и получить ее повторно будет невозможно.

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       ```
       resource "yandex_iam_service_account_key" "sa-auth-key" {
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         description        = "<описание_ключа>"
         key_algorithm      = "<алгоритм_генерации_ключа>"
         pgp_key            = "<pgp-ключ>"
         output_to_lockbox  {
           secret_id             = "<идентификатор_секрета_Lockbox>"
           entry_for_private_key = "<ключ_секрета>"
         }
       }
       ```

       Где:
       * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
       * `description` — описание ключа. Необязательный параметр.
       * `key_algorithm` — алгоритм генерации ключа. Необязательный параметр. По умолчанию используется алгоритм `RSA_2048`. Допустимые значения параметра см. в [документации API](../../api-ref/Key/index.md).
       * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Необязательный параметр. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`.
       * `output_to_lockbox` — описание [секрета](../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, в который будет сохранено секретное значение ключа, во избежание его возможной утечки через файл состояния `terraform.tfstate`. Необязательный параметр. Вложенные параметры:
           * `secret_id` — идентификатор секрета {{ lockbox-full-name }}, в который будет сохранена закрытая часть авторизованного ключа. Секрет должен быть [пользовательского типа](../../../lockbox/concepts/secret.md#secret-type).
           * `entry_for_private_key` — ключ секрета, который будет присвоен сохраняемому значению закрытой части авторизованного ключа.

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_key).

    1. Проверьте корректность конфигурационных файлов.

       1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
       1. Выполните проверку с помощью команды:

          ```
          terraform plan
          ```

       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

       1. Если в конфигурации нет ошибок, выполните команду:

          ```
          terraform apply
          ```

       1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

       После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}), а также с помощью команды CLI:

       ```
       yc iam key list --service-account-id <идентификатор_сервисного_аккаунта>
       ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Key/create.md) для ресурса [Key](../../api-ref/Key/index.md) или вызовом gRPC API [KeyService/Create](../../api-ref/grpc/Key/create.md).

  Пример запроса с помощью cURL для метода REST API `create`:

  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{"serviceAccountId": "<идентификатор_сервисного_аккаунта>"}' \
    https://iam.{{ api-host }}/iam/v1/keys
  ```

  Где:

  * `<IAM-токен>` — IAM-токен пользователя, у которого есть права на создание ключей для указанного сервисного аккаунта.
  * `<идентификатор_сервисного_аккаунта>` — [идентификатор](../sa/get-id.md) сервисного аккаунта, для которого создаются ключи.

  В случае успеха в ответе сервера будут указаны открытая (`publicKey`) и закрытая (`privateKey`) части авторизованного ключа. Сохраните эти данные. Повторно получить значение закрытого ключа будет невозможно.

  Пример ответа сервера:

  ```json
  {
      "key": {
          "createdAt": "2018-10-30T15:55:00+00:00",
          "description": "",
          "id": "lfkoe35hsk58********",
          "keyAlgorithm": "RSA_2048",
          "publicKey": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
          "serviceAccountId": "ajepg0mjt06s********"
      },
      "privateKey": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
  }
  ```

{% endlist %}

## Удалить авторизованный ключ {#delete-authorized-key}

Чтобы удалить авторизованный ключ сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите нужный сервисный аккаунт.
  1. В блоке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_keys }}** в строке с ключом, который нужно удалить, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_action-delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список авторизованных ключей для определенного сервисного аккаунта, указав его имя:

     ```bash
     yc iam key list \
       --service-account-name <имя_сервисного_аккаунта>
     ```

     Результат:

     ```text
     +----------------------+-------------------------------------+-----------+---------------------+
     |          ID          |               SUBJECT               | ALGORITHM |     CREATED AT      |
     +----------------------+-------------------------------------+-----------+---------------------+
     | ajeave7oktut******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:14:22 |
     | ajeb794igb80******** | serviceAccount:ajeedllrkjma******** | RSA_2048  | 2022-03-13 20:06:13 |
     +----------------------+-------------------------------------+-----------+---------------------+
     ```

  1. Удалите авторизованный ключ, указав его идентификатор:

     ```bash
     yc iam key delete <идентификатор_ключа>
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите секцию с описанием авторизованного ключа.

      Пример описания авторизованного ключа в конфигурации {{ TF }}:

      ```
      resource "yandex_iam_service_account_key" "sa-auth-key" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        description        = "<описание_ключа>"
        key_algorithm      = "<алгоритм_генерации_ключа>"
        pgp_key            = "<pgp-ключ>"
        output_to_lockbox  {
          secret_id             = "<идентификатор_секрета_Lockbox>"
          entry_for_private_key = "<ключ_секрета>"
        }
      }
      ```

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_key).

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
      yc iam key list --service-account-id <идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/Key/delete.md) для ресурса [Key](../../api-ref/Key/index.md) или вызовом gRPC API [KeyService/Delete](../../api-ref/grpc/Key/delete.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/authorization/key.md)
* [{#T}](../iam-token/create-for-sa.md)
