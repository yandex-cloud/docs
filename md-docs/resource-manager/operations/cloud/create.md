# Создание нового облака

[После регистрации](../../../billing/quickstart/index.md#create_billing_account) в Yandex Cloud и создания [организации](../../../organization/concepts/organization.md) вы создадите свое первое [облако](../../concepts/resources-hierarchy.md#cloud). Если вам потребуется дополнительное облако, вы сможете создать его, следуя этой же инструкции.

{% note info %}

При создании облака вы автоматически получите роль [владельца](../../concepts/resources-hierarchy.md#owner) в этом облаке.

{% endnote %}

Чтобы создать облако:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что [платежный аккаунт](../../../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md#create_billing_account) или попросите вашего администратора назначить вам роль `billing.accounts.member` на платежный аккаунт.
  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужную [организацию](../../../organization/concepts/organization.md).
  1. Справа от названия организации нажмите ![image](../../../_assets/console-icons/ellipsis.svg).
  1. Выберите ![image](../../../_assets/console-icons/plus.svg) **Создать облако**.
  
     ![create-cloud1](../../../_assets/resource-manager/create-cloud-1.png)
  
  1. Введите имя [облака](../../concepts/resources-hierarchy.md#cloud). Требования к имени:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
  1. (Опционально) Добавьте метку облака.
  1. Нажмите кнопку **Создать**.
  
     ![create-cloud2](../../../_assets/resource-manager/create-cloud-2.png)

- CLI {#cli}

  {% note info %}

  Чтобы создать новое облако с помощью Yandex Cloud CLI, [привяжите](../../../cli/operations/profile/manage-properties.md#set) организацию к [профилю CLI](../../../cli/operations/profile/profile-list.md).

  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Посмотрите описание команды для создания облака:

      ```bash
      yc resource-manager cloud create --help
      ```

  1. Если у вас еще нет привязанной организации, привяжите организацию, в которой вы хотите создать облако, к профилю CLI:

      ```bash
      yc config set organization-id <идентификатор_организации>
      ```

      Где `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой вы создаете облако.

  1. Выполните команду, чтобы создать облако:

      ```bash
      yc resource-manager cloud create \
        --name <имя_облака> \
        --billing-account-id <идентификатор_платежного_аккаунта>
      ```

      Где:

      * `--name` – имя создаваемого облака. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.
      * `--billing-account-id` – идентификатор [платежного аккаунта](../../../billing/concepts/billing-account.md), к которому будет привязано создаваемое облако.

          Идентификатор платежного аккаунта можно узнать в [интерфейсе Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) в блоке **Информация об аккаунте** на странице нужного платежного аккаунта.

      Результат:

      ```text
      done (4s)
      id: b1gbi30tq0m9********
      created_at: "2024-12-10T09:25:22Z"
      name: my-new-cloud
      organization_id: bpfaidqca8vd********
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% note warning %}

  Обязательно привяжите облако к платежному аккаунту, чтобы сделать облако активным. Создаваемое облако будет находиться в статусе `Creating`, пока к нему не будет привязан платежный аккаунт. Для привязки облака к платежному аккаунту используйте ресурс `yandex_billing_cloud_binding` с указанием идентификатора облака в поле `cloud_id`.

  {% endnote %}

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      # Создание облака

      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "<имя_облака>"
        organization_id = "<идентификатор_организации>"
      }

      # Привязка облака к платежному аккаунту

      resource "yandex_billing_cloud_binding" "mycloud" {
        billing_account_id = "<идентификатор_платежного_аккаунта>"
        cloud_id           = yandex_resourcemanager_cloud.cloud1.id
      }
      ```

      Где:

      * `name` — имя облака. Требования к имени:
      
        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.
        
      * `organization_id` — [идентификатор](../../../organization/operations/organization-get-id.md) организации. Terraform позволяет создать облако только для существующей организации.
      * `billing_account_id` — идентификатор [платежного аккаунта](../../../billing/concepts/billing-account.md), к которому будет привязано создаваемое облако.

          [Идентификатор платежного аккаунта](../../../billing/concepts/billing-account.md#billing-account-id) можно узнать в [интерфейсе Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) в блоке **Информация об аккаунте** на странице нужного платежного аккаунта.
      * `cloud_id` — [идентификатор](get-id.md) облака, которое будет привязано к платежному аккаунту.

      Более подробную информацию о параметрах ресурсов `yandex_resourcemanager_cloud` и `yandex_billing_cloud_binding` в Terraform, см. в [документации провайдера](../../../terraform/index.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
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
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  После этого в организации будет создано облако, привязанное к платежному аккаунту. Проверить облако и его параметры можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc resource-manager cloud list
    ```

- API {#api}

  Чтобы создать облако, воспользуйтесь методом REST API [create](../../api-ref/Cloud/create.md) для ресурса [Cloud](../../api-ref/Cloud/index.md) или вызовом gRPC API [CloudService/Create](../../api-ref/grpc/Cloud/create.md).

{% endlist %}


#### См. также {#see-also}

* [Переименование облака](update.md)
* [Настройка прав доступа к облаку](set-access-bindings.md)
* [Переключение на другое облако](switch-cloud.md)
* [Создание каталога](../folder/create.md)
* [Платежный аккаунт](../../../billing/concepts/billing-account.md)