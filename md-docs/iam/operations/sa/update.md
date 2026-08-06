[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > [Пошаговые инструкции](../index.md) > [Сервисные аккаунты](index.md) > Изменение сервисного аккаунта

# Изменение сервисного аккаунта

Вы можете изменить имя и описание сервисного аккаунта. Через API Yandex Cloud также можно назначить [метки](../../../resource-manager/concepts/labels.md) на сервисный аккаунт.

Чтобы задать или изменить срок жизни аккаунта, используйте параметр `--expires-at`. По истечении срока жизни система автоматически [заблокирует](../../concepts/users/service-accounts.md#sa-suspend) его.

Если вы хотите изменить роли сервисного аккаунта, обратитесь к [инструкции](assign-role-for-sa.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить сервисный аккаунт:

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В строке с нужным сервисным аккаунтом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Измените имя сервисного аккаунта.

     Требования к формату имени:
      
     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Измените описание сервисного аккаунта.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Чтобы изменить сервисный аккаунт:

  1. Посмотрите описание команды изменения сервисного аккаунта:

      ```bash
      yc iam service-account update --help
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

  1. Измените параметры сервисного аккаунта, например имя и описание:

      ```bash
      yc iam service-account update my-robot \
        --new-name my-service-account \
        --description "this is my service account"
      ```
      
      Требования к формату имени:
      
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить сервисный аккаунт:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием сервисного аккаунта.
     Пример описания сервисного аккаунта в конфигурации Terraform:

     ```hcl
     ...
     resource "yandex_iam_service_account" "sa" {
       name        = "my-robot"
       description = "this is new description"
      }
     ...
     ```
  1. Проверьте конфигурацию командой:
     ```bash
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```text
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
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение сервисного аккаунта можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc iam service-account list
     ```

- API {#api}

  Чтобы изменить сервисный аккаунт, воспользуйтесь методом REST API [update](../../api-ref/ServiceAccount/update.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Update](../../api-ref/grpc/ServiceAccount/update.md).

{% endlist %}

## Примеры {#examples}

### Изменить срок жизни сервисного аккаунта {#update-expires-at}

Укажите новый срок жизни сервисного аккаунта. По истечении срока жизни система автоматически [заблокирует](../../concepts/users/service-accounts.md#sa-suspend) его. Чтобы снять блокировку, обратитесь к [инструкции](suspend-reactivate.md#reactivate).

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam service-account update my-robot \
    --expires-at 2027-01-01T00:00:00Z
  ```

  Значение параметра `--expires-at` задается в формате [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339).

  Чтобы убрать ограничение по сроку жизни, передайте пустое значение:

  ```bash
  yc iam service-account update my-robot \
    --expires-at ""
  ```

- API {#api}

  ```bash
  curl \
    --request PATCH \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM-токен>" \
    --data '{
      "updateMask": "expiresAt",
      "expiresAt": "2027-01-01T00:00:00Z"
    }' \
    https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/<идентификатор_сервисного_аккаунта>
  ```

  Значение поля `expiresAt` задается в формате [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339). Чтобы убрать ограничение по сроку жизни, передайте пустое значение: `"expiresAt": ""`.

{% endlist %}