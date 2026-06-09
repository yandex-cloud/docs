# Редактировать пул пользователей


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.  
  1. В строке с нужным [пулом пользователей](../../concepts/user-pools.md) нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **Изменить**.
  1. Задайте новое имя или описание пула пользователей.

      Имя должно быть уникальным в организации и соответствовать требованиям:

      * длина — от 1 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Задайте новый [домен](../../concepts/domains.md), который будет использоваться, если к пулу не привязаны другие домены.
  1. Добавьте или удалите метки.
  1. Измените данные, доступные для редактирования пользователями на портале [Мой аккаунт](../../concepts/my-account.md).
  1. В поле **{{ ui-key.yacloud_org.form.userpool.caption.session-lifetime }}** измените период времени, в течение которого будут действительны [сессии](../../concepts/sessions.md) пользователя и не будет требоваться повторная аутентификация в {{ org-full-name }}.
  1. Нажмите **{{ ui-key.yacloud_org.actions.save-changes }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для редактирования [пула пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool update --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp userpool update <идентификатор_пула> \
       --userpool-name <название_пула> \
       --description <описание_пула> \
       --default-subdomain <домен_по_умолчанию> \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:
     
     * `--userpool-name` — новое название пула пользователей. Название должно быть уникальным в рамках организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `--description` — новое описание пула пользователей.
     * `--labels` — новый список [меток](../../../resource-manager/concepts/labels.md). Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл {{ TF }} и измените параметры [пула пользователей](../../concepts/user-pools.md):

     ```hcl
     resource "yandex_organizationmanager_idp_userpool" "example_userpool" {
       organization_id   = "<идентификатор_организации>"
       name              = "<название_пула>"
       description       = "<описание_пула>"
       default_subdomain = "<домен_по_умолчанию>"
       labels            = {
         <ключ> = "<значение>"
       }
       user_settings {
          allow_edit_self_contacts = <true_или_false>
          allow_edit_self_info = <true_или_false>
          allow_edit_self_login = <true_или_false>
          allow_edit_self_password = <true_или_false>
       }
     }
     ```

     Где:

     * `name` — новое название пула пользователей. Название должно быть уникальным в рамках организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `description` — новое описание пула пользователей.
     * `default_subdomain` — новый [домен](../../concepts/domains.md) по умолчанию. Будет использоваться, если к пулу не привязаны другие домены.
     * `labels` — новый список [меток](../../../resource-manager/concepts/labels.md).
     * `user_settings` — доступные для изменения пользовательские данные на портале [Мой аккаунт](../../concepts/my-account.md). Включает следующие опции:
       * `allow_edit_self_contacts` — изменение контактной информации.
       * `allow_edit_self_info` — изменение персональных данных.
       * `allow_edit_self_login` — изменение логина.
       * `allow_edit_self_password` — изменение пароля.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_userpool` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_userpool).

  1. Примените изменения:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} обновит все требуемые ресурсы. Проверить изменения можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc organization-manager idp userpool get <идентификатор_пула>
     ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.Update](../../idp/api-ref/Userpool/update.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Update](../../idp/api-ref/grpc/Userpool/update.md).

{% endlist %}