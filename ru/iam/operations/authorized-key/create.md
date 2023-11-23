---
title: "Как создать авторизованные ключи в {{ iam-full-name }}"
description: "Следуя данной инструкции, вы сможете создать авторизованные ключи." 
---

# Создание авторизованных ключей

Чтобы создать [авторизованный ключ](../../concepts/authorization/key.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
  1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**. В открывшемся окне:
      1. Скопируйте открытый и закрытый ключи и надежно сохраните. Закрытый ключ не сохраняется в {{ yandex-cloud }}, открытый ключ нельзя будет посмотреть в консоли управления.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.
      
         Также вы можете скачать ключи одним файлом в формате JSON. Для этого нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Создайте авторизованный ключ для сервисного аккаунта `my-robot`:

  ```bash
  yc iam key create --service-account-name my-robot -o my-robot-key.json
  ```

  В случае успеха в файл `my-robot-key.json` будет записан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`).

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

- API

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../api-ref/Key/create.md) для ресурса [Key](../../api-ref/Key/index.md) или вызовом gRPC API [KeyService/Create](../../api-ref/grpc/key_service.md#Create).

  Пример запроса с помощью cURL для метода REST API `create`:

  ```bash
  curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{"serviceAccountId": "<идентификатор_сервисного_аккаунта>"}' \
    https://iam.{{ api-host }}/iam/v1/keys
  ```

  Где:

  * `<IAM-токен>` — IAM-токен пользователя, у которого есть права на создание ключей для указанного сервисного аккаунта.
  * `<идентификатор_сервисного_аккаунта>` — `ID` сервисного аккаунта, для которого создаются ключи.

  В случае успеха в ответе сервера будет указан закрытый ключ (`privateKey`) и идентификатор открытого ключа (`id`). Сохраните эти данные. Получить значение ключа снова будет невозможно.

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

- {{ TF }}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
       * `description` — описание ключа. Необязательный параметр.
       * `key_algorithm` — алгоритм генерации ключа. Необязательный параметр. По умолчанию используется алгоритм `RSA_2048`. Допустимые значения параметра см. в [документации API](../../api-ref/Key/index.md).
       * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Необязательный параметр. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`.

       Пример структуры конфигурационного файла:

       ```
       resource "yandex_iam_service_account_key" "sa-auth-key" {
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         description        = "<описание_ключа>"
         key_algorithm      = "<алгоритм_генерации_ключа>"
         pgp_key            = "<pgp-ключ>"
       }
       ```

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

{% endlist %}

#### Что дальше {#what-is-next}

* [Получите IAM-токен для сервисного аккаунта](../iam-token/create-for-sa.md).