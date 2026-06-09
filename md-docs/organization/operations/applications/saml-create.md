# Создать SAML-приложение в {{ org-full-name }}


Чтобы пользователи вашей [организации](../../concepts/organization.md) могли аутентифицироваться во внешних приложениях с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../concepts/applications.md#saml) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне поставщика услуг.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
      1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          * длина — от 1 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

          1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания SAML-приложения:

     ```bash
     yc organization-manager idp application saml application create --help
     ```

  1. Создайте SAML-приложение:

     ```bash
     yc organization-manager idp application saml application create \
       --organization-id <идентификатор_организации> \
       --name <имя_приложения> \
       --description <описание_приложения> \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать SAML-приложение. Обязательный параметр.
     * `--name` — имя SAML-приложения. Обязательный параметр. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `--description` — описание SAML-приложения. Необязательный параметр.
     * `--labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: saml-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

     Сохраните значение поля `id`, оно понадобится для настройки приложения.

  1. (Опционально) Получите информацию о сертификатах приложения:

     ```bash
     yc organization-manager idp application saml signature-certificate list \
       --application-id <идентификатор_приложения>
     ```

     При создании SAML-приложения автоматически создается сертификат для проверки подписи SAML-ответов.

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры SAML-приложения:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"
       description     = "<описание_приложения>"
       labels          = {
         "<ключ>" = "<значение>"
       }
     }
     ```

     Где:

     * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать SAML-приложение. Обязательный параметр.
     * `name` — имя SAML-приложения. Обязательный параметр. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

         * длина — от 1 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.

     * `description` — описание SAML-приложения. Необязательный параметр.
     * `labels` — список [меток](../../../resource-manager/concepts/labels.md). Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

   При создании SAML-приложения автоматически создается сертификат для проверки подписи SAML-ответов.

- API {#api}

  Воспользуйтесь методом REST API [Application.Create](../../idp/application/saml/api-ref/Application/create.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Create](../../idp/application/saml/api-ref/grpc/Application/create.md).

{% endlist %}

## Настройте приложение {#setup-application}

Чтобы настроить интеграцию внешнего приложения с созданным SAML-приложением в {{ org-full-name }}, выполните настройки на стороне поставщика услуг и на стороне {{ org-full-name }}.

### Задайте настройки интеграции на стороне поставщика услуг {#setup-sp}

Значения настроек интеграции, которые нужно задать на стороне поставщика услуг, доступны на странице с информацией о приложении в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}/apps).

В зависимости от возможностей вашего поставщика услуг вы можете выполнить необходимые настройки вручную или автоматически, загрузив файл с метаданными или указав URL с метаданными:

{% list tabs %}

- Настройка вручную

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значения параметров, которые необходимо задать на стороне поставщика услуг:

      * `Issuer / IdP EntityID` — уникальный идентификатор, используемый для приложения. Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-full-name }}.
      * `Login URL` — адрес, на который поставщик услуг будет отправлять запросы для аутентификации пользователя.
      * `Logout URL` — адрес, на который поставщик услуг будет отправлять SAML-запрос при выходе пользователя из системы.

  1. Скачайте сертификат приложения в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, нажав кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}**.
  1. На стороне поставщика услуг настройте интеграцию с SAML-приложением {{ org-full-name }}, указав скопированные параметры и добавив скачанный сертификат. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- Файл с метаданными

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит значения всех необходимых настроек и сертификат, который используется для проверки подписи SAML-ответов. Загрузите скачанный файл на стороне поставщика услуг, если ваш поставщик услуг поддерживает конфигурирование приложения с помощью файла с метаданными. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

- URL с метаданными

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение поля **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}**.

      По ссылке доступны значения всех необходимых настроек и сертификат, который используется для проверки подписи SAML-ответов. Укажите полученную ссылку в настройках на стороне поставщика услуг, если ваш поставщик услуг поддерживает конфигурирование приложения с помощью URL с метаданными. При необходимости обратитесь к документации или в службу поддержки вашего поставщика услуг.

{% endlist %}

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

Прежде чем настраивать SAML-приложение на стороне {{ org-full-name }}, получите необходимые значения настроек у вашего поставщика услуг. Затем перейдите к настройкам SAML-приложения в {{ org-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
     
     1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите уникальный идентификатор поставщика услуг (Service Provider).
     
         Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-full-name }}.
     1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите URL-адрес, на который {{ org-full-name }} будет отправлять SAML-ответ.
     
         Если ваш поставщик услуг вместо ACS URL использует ACS-индексы, в дополнение к ACS URL вы можете задать полученное на стороне поставщика услуг значение индекса.
     
         При необходимости воспользуйтесь кнопкой **{{ ui-key.yacloud_org.organization.apps.SamlAppAcsUrlsField.add-acs-url_eMunC }}**, чтобы указать несколько URL/индексов ACS.
     
         {% note info %}
         
         Если в настройках поля **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** для одного из URL-адресов вы указали индекс, то индексы также должны быть указаны и для всех остальных URL-адресов.
         
         {% endnote %}
     
     1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** выберите элементы SAML-ответа, которые будут подписываться электронной подписью:
     
         * `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-assertions_thJgN }}` — будут подписываться только передаваемые атрибуты. Значение по умолчанию.
         * `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response_x7SKD }}` — будет подписываться весь SAML-ответ целиком.
         * `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response-and-assertions_u2j6T }}` — будут подписываться как целиком весь SAML-ответ, так и (отдельно) передаваемые атрибуты.
         
         {% note warning %}
         
         Режим подписи, заданный для SAML-приложения на стороне {{ org-full-name }}, должен соответствовать режиму подписи, заданному на стороне поставщика услуг.
         
         {% endnote %}
     
     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для настройки SAML-приложения:

     ```bash
     yc organization-manager idp application saml application update --help
     ```

  1. Выполните команду для настройки параметров поставщика услуг:

     ```bash
     yc organization-manager idp application saml application update \
       --id <идентификатор_приложения> \
       --sp-entity-id <идентификатор_поставщика_услуг> \
       --acs-urls <URL>[,<URL>] \
       --signature-mode <режим_подписи>
     ```

     Где:

     * `--id` — идентификатор SAML-приложения. Обязательный параметр.
     * `--sp-entity-id` — уникальный идентификатор поставщика услуг (Service Provider). Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-full-name }}.
     * `--acs-urls` — URL-адрес или несколько адресов через запятую, на которые {{ org-full-name }} будет отправлять SAML-ответ. ACS URL должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).
     * `--signature-mode` — элементы SAML-ответа, которые будут подписываться электронной подписью. Возможные значения:
       * `assertion_only` — только передаваемые атрибуты пользователя;
       * `response_only` — весь SAML-ответ целиком;
       * `response_and_assertion` — целиком весь SAML-ответ и (отдельно) передаваемые атрибуты.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: saml-app
     organization_id: bpf2c65rqcl8********
     sp_entity_id: https://example.com/saml
     acs_urls:
       - url: https://example.com/saml/acs
     signature_mode: RESPONSE_AND_ASSERTION
     group_claims_settings:
       group_distribution_type: NONE
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры настройки SAML-приложения:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"

       service_provider = {
         entity_id = "<идентификатор_поставщика_услуг>"
         acs_urls  = [
           {
             url = "URL"
           }
         ]
         security_settings = {
           signature_mode = "RESPONSE_AND_ASSERTIONS"
         }
       }
     }
     ```

     Где:

     * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать SAML-приложение. Обязательный параметр.
     * `entity_id` — уникальный идентификатор поставщика услуг (Service Provider). Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-full-name }}.
     * `acs_urls` — список URL-адресов, на которые {{ org-full-name }} будет отправлять SAML-ответ. ACS URL должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).
     * `signature_mode` — элементы SAML-ответа, которые будут подписываться электронной подписью. Возможные значения:
       * `ASSERTION_ONLY` — только передаваемые атрибуты пользователя;
       * `RESPONSE_ONLY` — весь SAML-ответ целиком;
       * `RESPONSE_AND_ASSERTION` — целиком весь SAML-ответ и (отдельно) передаваемые атрибуты.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

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

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../idp/application/saml/api-ref/Application/update.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../idp/application/saml/api-ref/grpc/Application/update.md).

{% endlist %}

### Настройте атрибуты пользователей и групп {#setup-attributes}

Вы можете настроить атрибуты, которые будут передаваться из {{ org-full-name }} поставщику услуг:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}**.
  1. Чтобы добавить атрибут групп пользователей, в правом верхнем углу страницы нажмите кнопку ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** задайте имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_group_attribute_value_oxrpu }}** выберите одно из значений:

          * `{{ ui-key.yacloud_org.organization.apps.field_group_all_uY9US }}` — в SAML-ответе в значение данного поля будут включены все [группы](../../concepts/groups.md), в которые входит пользователь.
          
              Максимальное количество передаваемых в этом поле групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп. 
          * `{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}` — в SAML-ответе в значение данного поля из всех групп, в которые входит пользователь, будут включены только те группы, которые явно заданы на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** SAML-приложения.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы добавить дополнительные атрибуты пользователей, в правом верхнем углу страницы нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** задайте имя атрибута, уникальное для вашего приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** выберите одно из значений:

          * `SubjectClaims.sub` — [идентификатор](../users-get.md) пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_id }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `aje0fapf84ofj57q1r0b`.
          * `SubjectClaims.preferred_username` — уникальный логин пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.user.caption.username }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ivanov@example-federation.ru`.
          * `SubjectClaims.name` — полное имя пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_user }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иванов Иван`.
          * `SubjectClaims.given_name` — имя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-givenname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иван`.
          * `SubjectClaims.family_name` — фамилия. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-familyname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иванов`.
          * `SubjectClaims.email` — адрес электронной почты. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-email }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ivanov@example-company.ru`.
          * `SubjectClaims.phone_number` — номер телефона. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-phone }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `+74951234567`.
          * `SubjectClaims.company_name` — название компании. Значение поля соответствует значению, отображаемому в поле **Название компании** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ООО «Праздник»`.
          * `SubjectClaims.department` — название подразделения. Значение поля соответствует значению, отображаемому в поле **Подразделение** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Отдел АСУ`.
          * `SubjectClaims.job_title` — название должности. Значение поля соответствует значению, отображаемому в поле **Должность** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Разработчик`.
          * `SubjectClaims.employee_id` — цифровой код пользователя из кадровой системы компании. Значение поля соответствует значению, отображаемому в поле **Табельный номер** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `08012`.
          
          {% note info %}
          
          Любое из этих значений атрибутов вы можете добавлять более одного раза под разными именами.
          
          {% endnote %}

      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы изменить имеющийся атрибут, нажмите на строку с нужным атрибутом и в открывшемся окне:
  
      1. Измените имя и/или значение атрибута.

          Для атрибута `NameID`, в котором передается идентификатор пользователя, можно изменить формат и значение. Список доступных значений в поле **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** зависит от выбранного формата. При изменении формата значение атрибута изменяется автоматически на значение по умолчанию для этого формата.
          
          Возможные форматы и значения атрибута:
          
          * `{{ ui-key.yacloud_org.organization.apps.NameIdAttributeFormDialog.field_nameId_email_mqNDG }}` — идентификатор пользователя передается в формате адреса электронной почты. Доступные значения:
              * `SubjectClaims.preferred_username` — значение по умолчанию при переключении на этот формат.
          
                  Уникальность и неизменяемость передаваемого идентификатора не гарантируется: в одной организации могут быть два пользователя с одинаковым идентификатором `preferred_username`. Например: [федеративный](../../../iam/concepts/users/accounts.md#saml-federation) пользователь и [локальный](../../../iam/concepts/users/accounts.md#local) пользователь могут иметь одинаковое значение этого атрибута.
          
                  Если идентификатор `preferred_username` федеративного пользователя задан не в формате адреса электронной почты, к передаваемому идентификатору будет автоматически добавлен суффикс `@<идентификатор_федерации_удостоверений>`, чтобы привести его к такому формату.
              * `SubjectClaims.email` — адрес электронной почты пользователя.
          
          * `{{ ui-key.yacloud_org.organization.apps.NameIdAttributeFormDialog.field_nameId_persistent_kZU3P }}` — идентификатор пользователя передается в формате [идентификатора](../users-get.md) пользователя [организации](../../concepts/organization.md). При этом передаваемое значение гарантированно уникальное и неизменяемое. Доступные значения:
              * `SubjectClaims.sub` — значение по умолчанию при переключении на этот формат.
              * `SubjectClaims.external_id` — внешний идентификатор пользователя.
              * `SubjectClaims.employee_id` — табельный номер сотрудника.
          * `urn:oasis:names:tc:SAML:2.0:nameid-format:transient` — идентификатор пользователя передается в значении идентификатора текущей [сессии](../../concepts/sessions.md) пользователя. Значение этого идентификатора изменяется в зависимости от используемой сессии и не может применяться для однозначной идентификации пользователя.
          
              Формат `urn:oasis:names:tc:SAML:2.0:nameid-format:transient` нельзя задать в настройках атрибута `NameID` явно: идентификатор пользователя в этом формате передается в SAML-ответе только в том случае, если этот формат был явно запрошен в SAML-запросе.
          
          {% note warning %}
          
          Если SAML-запрос со стороны поставщика услуг содержит явное указание формата, в котором ожидается значение идентификатора пользователя `NameID`, то в SAML-ответе значение будет отправлено в том формате, который указан в SAML-запросе. При этом значение формата, заданное в настройках {{ org-full-name }}, будет проигнорировано.
          
          {% endnote %}
      
      1. Нажмите кнопку **{{ ui-key.yacloud.common.update }}**.
  1. Чтобы удалить имеющийся атрибут пользователя или группы, в строке с этим атрибутом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, после чего подтвердите удаление.

      {% note info %}

      Удалять можно любые атрибуты, кроме обязательного атрибута `NameID`.

      {% endnote %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для добавления атрибута:

     ```bash
     yc organization-manager idp application saml attribute create --help
     ```

  1. Чтобы добавить атрибут пользователя, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute create \
       --application-id <идентификатор_приложения> \
       --name <имя_атрибута> \
       --value <значение_атрибута>
     ```

     Где:

     * `--application-id` — идентификатор SAML-приложения.
     * `--name` — имя атрибута, уникальное для вашего приложения.
     * `--value` — значение атрибута. Возможные значения:

       * `SubjectClaims.sub` — [идентификатор](../users-get.md) пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_id }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `aje0fapf84ofj57q1r0b`.
       * `SubjectClaims.preferred_username` — уникальный логин пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.user.caption.username }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ivanov@example-federation.ru`.
       * `SubjectClaims.name` — полное имя пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_user }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иванов Иван`.
       * `SubjectClaims.given_name` — имя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-givenname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иван`.
       * `SubjectClaims.family_name` — фамилия. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-familyname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иванов`.
       * `SubjectClaims.email` — адрес электронной почты. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-email }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ivanov@example-company.ru`.
       * `SubjectClaims.phone_number` — номер телефона. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-phone }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `+74951234567`.
       * `SubjectClaims.company_name` — название компании. Значение поля соответствует значению, отображаемому в поле **Название компании** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ООО «Праздник»`.
       * `SubjectClaims.department` — название подразделения. Значение поля соответствует значению, отображаемому в поле **Подразделение** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Отдел АСУ`.
       * `SubjectClaims.job_title` — название должности. Значение поля соответствует значению, отображаемому в поле **Должность** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Разработчик`.
       * `SubjectClaims.employee_id` — цифровой код пользователя из кадровой системы компании. Значение поля соответствует значению, отображаемому в поле **Табельный номер** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `08012`.
       
       {% note info %}
       
       Любое из этих значений атрибутов вы можете добавлять более одного раза под разными именами.
       
       {% endnote %}

  1. Чтобы добавить атрибут групп пользователей, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute create \
       --application-id <идентификатор_приложения> \
       --name <имя_атрибута_групп> \
       --value <значение_атрибута_групп>
     ```

     Где:

     * `--name` — имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
     * `--value` — значение атрибута групп. Возможные значения:

       * `{{ ui-key.yacloud_org.organization.apps.field_group_all_uY9US }}` — в SAML-ответе в значение данного поля будут включены все [группы](../../concepts/groups.md), в которые входит пользователь.
       
           Максимальное количество передаваемых в этом поле групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп. 
       * `{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}` — в SAML-ответе в значение данного поля из всех групп, в которые входит пользователь, будут включены только те группы, которые явно заданы на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** SAML-приложения.

  1. Чтобы изменить атрибут, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute update \
       --id <идентификатор_атрибута> \
       --name <новое_имя_атрибута> \
       --value <новое_значение_атрибута>
     ```

  1. Чтобы удалить атрибут, выполните команду:

     ```bash
     yc organization-manager idp application saml attribute delete <идентификатор_атрибута>
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле атрибуты SAML-приложения:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"

       attribute_mapping = {
         name_id  = {
           format = "EMAIL"
         }

         attributes = [{
           name  = "email"
           value = "SubjectClaims.email"
         }, {
           name  = "firstName"
           value = "SubjectClaims.given_name"
         }, {
           name  = "lastName"
           value = "SubjectClaims.family_name"
         }]
       }

       group_claims_settings = {
         group_attribute_name    = "<имя_атрибута_групп>"
         group_distribution_type = "ALL_GROUPS"
       }
     }
     ```

     Где:

     * `organization_id` — [идентификатор организации](../organization-get-id.md), в которой нужно создать SAML-приложение. Обязательный параметр.
     * `name` — имя SAML-приложения. Обязательный параметр.
     * `attributes` — список атрибутов, которые будут передаваться из {{ org-full-name }} поставщику услуг. Каждый атрибут содержит:
       * `name` — имя атрибута, уникальное для вашего приложения.
       * `value` — значение атрибута. Возможные значения:

         * `SubjectClaims.sub` — [идентификатор](../users-get.md) пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_id }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `aje0fapf84ofj57q1r0b`.
         * `SubjectClaims.preferred_username` — уникальный логин пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.user.caption.username }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ivanov@example-federation.ru`.
         * `SubjectClaims.name` — полное имя пользователя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.entity.group.label_user }}** в списке пользователей организации в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иванов Иван`.
         * `SubjectClaims.given_name` — имя. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-givenname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иван`.
         * `SubjectClaims.family_name` — фамилия. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-familyname }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Иванов`.
         * `SubjectClaims.email` — адрес электронной почты. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-email }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ivanov@example-company.ru`.
         * `SubjectClaims.phone_number` — номер телефона. Значение поля соответствует значению, отображаемому в поле **{{ ui-key.yacloud_org.page.user.field_user-phone }}** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `+74951234567`.
         * `SubjectClaims.company_name` — название компании. Значение поля соответствует значению, отображаемому в поле **Название компании** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `ООО «Праздник»`.
         * `SubjectClaims.department` — название подразделения. Значение поля соответствует значению, отображаемому в поле **Подразделение** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Отдел АСУ`.
         * `SubjectClaims.job_title` — название должности. Значение поля соответствует значению, отображаемому в поле **Должность** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `Разработчик`.
         * `SubjectClaims.employee_id` — цифровой код пользователя из кадровой системы компании. Значение поля соответствует значению, отображаемому в поле **Табельный номер** в разделе **{{ ui-key.yacloud_org.page.user.title_personal-info }}** на странице с информацией о пользователе в интерфейсе {{ org-full-name }} в {{ cloud-center }}. Например: `08012`.
         
         {% note info %}
         
         Любое из этих значений атрибутов вы можете добавлять более одного раза под разными именами.
         
         {% endnote %}

     * `group_claims_settings` — параметры атрибутов групп пользователей:
       * `group_attribute_name` — имя атрибута групп пользователей. Имя атрибута должно быть уникальным для вашего приложения.
       * `group_distribution_type` — значение атрибута групп. Возможные значения: 
         * `ASSIGNED_GROUPS` — в SAML-ответе в значение данного поля из всех групп, в которые входит пользователь, будут включены только те группы, которые явно заданы на вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** SAML-приложения.
         * `ALL_GROUPS` — в SAML-ответе в значение данного поля будут включены все [группы](../../concepts/groups.md), в которые входит пользователь.

             Максимальное количество передаваемых в этом поле групп — 1&nbsp;000. Если количество групп, в которые входит пользователь, превышает это число, на сторону поставщика услуг будет передана только первая тысяча групп. 

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

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

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../idp/application/saml/api-ref/Application/update.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../idp/application/saml/api-ref/grpc/Application/update.md).

{% endlist %}

Убедитесь, что добавленные атрибуты также добавлены в настройки интеграции SAML-приложения на стороне поставщика услуг и корректно обрабатываются им.

### Настройте пользователей и группы {#users-and-groups}

Чтобы пользователи вашей организации могли аутентифицироваться во внешнем приложении с помощью SAML-приложения {{ org-full-name }}, необходимо явно добавить в SAML-приложение нужных пользователей и/или [группы пользователей](../../concepts/groups.md):

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
  1. Чтобы добавить в SAML-приложение пользователя или группу пользователей:

      1. Нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
      1. В открывшемся окне выберите нужного пользователя или группу пользователей.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Чтобы удалить пользователя или группу пользователей из SAML-приложения:

      1. В списке пользователей и групп в строке с нужным пользователем или группой нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      1. Подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите [идентификатор пользователя](../users-get.md) или [группы пользователей](../group-get-id.md).

  1. Чтобы добавить в приложение пользователя или группу пользователей:
   
     1. Посмотрите описание команды CLI для добавления пользователей в приложение:
   
        ```bash
        yc organization-manager idp application saml application add-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application saml application add-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя_или_группы>
        ```
   
        Где:
   
        * `--id` — идентификатор приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

  1. Чтобы удалить пользователя или группу пользователей из приложения:

     1. Посмотрите описание команды CLI для удаления пользователей из приложения:
   
        ```bash
        yc organization-manager idp application saml application remove-assignments --help
        ```
   
     1. Выполните команду:
   
        ```bash
        yc organization-manager idp application saml application remove-assignments \
          --id <идентификатор_приложения> \
          --subject-id <идентификатор_пользователя_или_группы>
        ```
   
        Где:
   
        * `--id` — идентификатор SAML-приложения.
        * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
   
        Результат:
   
        ```text
        assignment_deltas:
          - action: REMOVE
            assignment:
              subject_id: ajetvnq2mil8********
        ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры SAML-приложения с пользователями и группами:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application_assignment" "example_assignment" {
       application_id = "<идентификатор_SAML-приложения>"
       subject_id     = "<идентификатор_пользователя_или_группы>"
     }
     ```

     Где:

     * `application_id` — идентификатор SAML-приложения.
     * `subject_id` — идентификатор пользователя или группы пользователей, которые будут иметь доступ к SAML-приложению. Чтобы получить идентификатор пользователя, воспользуйтесь [инструкцией](../users-get.md). Чтобы получить идентификатор группы пользователей, воспользуйтесь [инструкцией](../group-get-id.md).

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application_assignment` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application_assignment).

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

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.UpdateAssignments](../../idp/application/saml/api-ref/Application/updateAssignments.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/UpdateAssignments](../../idp/application/saml/api-ref/grpc/Application/updateAssignments.md).

{% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с поставщиком услуг, выполните аутентификацию во внешнем приложении от имени одного из добавленных в приложение пользователей.

#### См. также {#see-also}

* [{#T}](saml-update.md)
* [{#T}](saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)