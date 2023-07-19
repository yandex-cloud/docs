# Создание статических ключей доступа

Это инструкция по созданию [статических ключей доступа](../../concepts/authorization/access-key.md) для [сервисного аккаунта](../../concepts/users/service-accounts.md).

Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

Чтобы создать статический ключ доступа:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В верхней части экрана перейдите на вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI

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
      | aje9sda1ufvq******** | blabla           | bla bla bla is my description |
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

  1. Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова будет невозможно.

- API

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../api-ref/AccessKey/create.md) для ресурса [AccessKey](../../api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../api-ref/grpc/access_key_service.md#Create).

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = "<идентификатор_сервисного_аккаунта>"
       description        = "<описание_ключа>"
       pgp_key            = "keybase:keybaseusername"
       }
     ```

     Где:

     * `service_account_id` — идентификатор сервисного аккаунта. Обязательный параметр.
     * `description` — описание ключа. Необязательный параметр.
     * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Необязательный параметр. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`.

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

{% endlist %}

## Примеры {#examples}

### Добавить описание при создании {#add-description}

Добавьте описание при создании ключа доступа.

{% list tabs %}

- CLI

  ```bash
  yc iam access-key create --service-account-name my-robot \
    --description "this key is for my bucket"
  ```

- API

  ```bash
  curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer <IAM-TOKEN>" \
    -d '{
        "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
        "description": "this key is for my bucket"
    }' \
    https://iam.{{ api-host }}/iam/aws-compatibility/v1/accessKeys
  ```

- {{ TF }}

  ```hcl
  resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "<идентификатор_сервисного_аккаунта>"
  description        = "this key is for my bucket"
  pgp_key            = "BIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+x....."
  }
  ```

{% endlist %}

#### Что дальше {#what-is-next}

* [Настроить инструменты для работы с {{ objstorage-name }}](../../../storage/tools/).
* [{#T}](assign-role-for-sa.md).
