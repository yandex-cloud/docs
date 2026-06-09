# Изменение сервисного аккаунта

Вы можете изменить имя и описание сервисного аккаунта. Через API {{ yandex-cloud }} также можно назначить [метки](../../../resource-manager/concepts/labels.md) на сервисный аккаунт.

Если вы хотите изменить роли сервисного аккаунта, обратитесь к [инструкции](assign-role-for-sa.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить сервисный аккаунт:

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В строке с нужным сервисным аккаунтом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.iam.folder.service-accounts.button_action-edit }}**.
  1. Измените имя сервисного аккаунта.

     Требования к формату имени:
      
     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Измените описание сервисного аккаунта.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить сервисный аккаунт:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием сервисного аккаунта.
     Пример описания сервисного аккаунта в конфигурации {{ TF }}:

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```bash
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```bash
     yc iam service-account list
     ```

- API {#api}

  Чтобы изменить сервисный аккаунт, воспользуйтесь методом REST API [update](../../api-ref/ServiceAccount/update.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Update](../../api-ref/grpc/ServiceAccount/update.md).

{% endlist %}