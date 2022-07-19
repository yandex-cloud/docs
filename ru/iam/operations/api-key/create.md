# Создание API-ключа

Это инструкция по созданию [API-ключа](../../concepts/authorization/api-key.md) для [сервисного аккаунта](../../concepts/users/service-accounts.md). _API-ключ_ — секретный ключ, используемый для упрощенной авторизации в API {{ yandex-cloud }}.

Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

Чтобы создать API-ключ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите на вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите пункт **Создать API-ключ**.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. Сохраните идентификатор и секретный ключ.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания API-ключа:

      ```bash
      yc iam api-key create --help
      ```

  1. Выберите сервисный аккаунт, например `my-robot`:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```

  1. Создайте API-ключ для сервисного аккаунта `my-robot` и запишите ответ в файл:

      ```bash
      yc iam api-key create --service-account-name my-robot > api-key.yaml
      ```

      В ответе в свойстве `secret` будет содержаться API-ключ:

      ```
      api_key:
        id: ajeke74kbp5bfq7m6ka2
        service_account_id: ajepg0mjt06siuj65usm
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHsssT5ICtm
      ```

      О том, как передать ключ в запросе, читайте в документации [сервисов](../../concepts/authorization/api-key.md#supported-services), которые поддерживают такой способ авторизации.

- API

  1. [Узнайте идентификатор сервисного аккаунта](../sa/get-id.md).
  1. Создайте API-ключ с помощью метода [create](../../api-ref/ApiKey/create.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md):

      ```bash
      export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $IAM_TOKEN" \
        -d "{ \"serviceAccountId\": \"$SERVICEACCOUNT_ID\" }" \
        https://iam.{{ api-host }}/iam/v1/apiKeys
      ```

- {{ TF }}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    1. Добавьте в конфигурационный файл параметры ресурса:

       * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
       * `description` — описание ключа. Необязательный параметр.
       * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Необязательный параметр. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`.

       Пример структуры конфигурационного файла:

       ```
       resource "yandex_iam_service_account_api_key" "sa-api-key" {
         service_account_id = "<идентификатор сервисного аккаунта>"
         description        = "<описание ключа>"
         pgp_key            = "<pgp-ключ>"
       }
       ```

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_api_key).

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
       yc iam key list --service-account-id <идентификатор сервисного аккаунта>
       ```

{% endlist %}

## Примеры {#examples}

### Добавить описание при создании {#add-description}

Чтобы было проще найти API-ключ не зная его идентификатора, добавьте описание при создании:

{% list tabs %}

- CLI

  ```bash
  yc iam api-key create --service-account-name my-robot \
    --description "this API-key is for my-robot"
  ```

- API

  ```bash
  export SERVICEACCOUNT_ID=aje6o61dvog2h6g9a33s
  export IAM_TOKEN=CggaATEVAgA...
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"description\": \"this API-key is for my-robot\"
    }" \
    https://iam.{{ api-host }}/iam/v1/apiKeys
  ```

- {{ TF }}

    1. Добавьте в конфигурационный файл параметры ресурса:

       * `service_account_id` — идентификатор сервисного аккаунта. Обязательный параметр.
       * `description` — описание ключа. Необязательный параметр.

       {% cut "Пример добавления описания при создании API-ключа сервисного аккаунта с помощью {{ TF }}" %}

         ```
         resource "yandex_iam_service_account_api_key" "sa-api-key" {
           service_account_id = "aje82upckiqhi3943ekr"
           description        = "this API-key is for my-robot"
         }
         ```

       {% endcut %}

       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iam_service_account_api_key).

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

       После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

#### Что дальше {#what-is-next}

* [Узнайте, какие сервисы поддерживают API-ключи](../../concepts/authorization/api-key.md#supported-services).
