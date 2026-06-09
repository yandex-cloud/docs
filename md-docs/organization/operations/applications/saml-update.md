# Изменить SAML-приложение в {{ org-full-name }}


Управлять SAML-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

## Измените базовые настройки приложения {#update-basic-settings}

Чтобы изменить базовые настройки [SAML-приложения](../../concepts/applications.md#saml):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-name_d22aF }}** измените имя приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          * длина — от 1 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-description_cjpok }}** измените описание приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-labels_uT2D2 }}** добавьте новые [метки](../../../resource-manager/concepts/labels.md) с помощью кнопки **{{ ui-key.yacloud.component.label-set.button_add-label }}**. Чтобы удалить существующую метку, используйте значок ![xmark](../../../_assets/console-icons/xmark.svg).
    
  1. В блоке **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.section-service-provider_5d85k }}**:

     1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите уникальный идентификатор поставщика услуг (Service Provider). Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-full-name }}.
     1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите URL-адрес, на который {{ org-full-name }} будет отправлять SAML-ответ. Чтобы указать несколько адресов, нажмите **{{ ui-key.yacloud_org.organization.apps.SamlAppAcsUrlsField.add-acs-url_eMunC }}**. ACS URL должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).
     1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** укажите адрес, по которому поставщик удостоверений отправляет SAML-ответ после успешного выхода пользователя из системы.
     1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-signature-mode_ipXQ7 }}** укажите элементы SAML-ответа, которые будут подписываться электронной подписью:

       * `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-assertions_thJgN }}` — только передаваемые атрибуты пользователя;
       * `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response_x7SKD }}` — весь SAML-ответ целиком;
       * `{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.signature-mode-response-and-assertions_u2j6T }}` — целиком весь SAML-ответ и (отдельно) передаваемые атрибуты.

  1. (Опционально) Активируйте опцию **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.field-request-signing }}**, чтобы принимать только запросы, подписанные одним из добавленных сертификатов. Добавьте сертификаты:

     1. Нажмите **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.add-cert-action }}**.
     1. В открывшемся окне выберите способ добавления и прикрепите файл или укажите текст вашего сертификата.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

     Для работы функциональности требуется загрузить сертификат с открытым ключом, полученный у поставщика услуг, который будет использоваться для проверки подписи.

  1. (Опционально) Активируйте опцию **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encrypt-response }}**, чтобы SAML-ответ шифровался с помощью выбранного сертификата:

     1. Выберите **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encode-data-algo }}** и **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encode-key-algo }}**.
     1. Добавьте сертификат:

        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.add-cert-action }}**.
        1. В открывшемся окне выберите способ добавления и прикрепите файл или укажите текст вашего сертификата.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

     Для работы функциональности требуется загрузить сертификат с открытым ключом, полученный у поставщика услуг, который будет использоваться для шифрования.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения SAML-приложения:

     ```bash
     yc organization-manager idp application saml application update --help
     ```
  
  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application update \
       --id <идентификатор_приложения> \
       --new-name <имя_приложения> \
       --description <описание_приложения> \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:

     * `--id` — идентификатор SAML-приложения. Обязательный параметр.
     * `--new-name` — новое имя SAML-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `--description` — новое описание SAML-приложения.
     * `--labels` — новый список [меток](../../../resource-manager/concepts/labels.md). Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

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

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле новые параметры SAML-приложения:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<новое_имя_приложения>"
       description     = "<новое_описание_приложения>"
       labels          = {
         "<ключ>" = "<значение>"
       }
     }
     ```

     Где:

     * `name` — новое имя SAML-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       * длина — от 1 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `description` — новое описание SAML-приложения.
     * `labels` — новые [метки](../../../resource-manager/concepts/labels.md).

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

## Измените конфигурацию поставщика услуг {#update-sp}

Чтобы изменить конфигурацию поставщика услуг в SAML-приложении:

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

  1. Посмотрите описание команды CLI для изменения конфигурации поставщика услуг:

     ```bash
     yc organization-manager idp application saml application update --help
     ```

  1. Выполните команду:

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

  1. Опишите в конфигурационном файле новые параметры конфигурации поставщика услуг:

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
     ```

     Где:

     * `entity_id` — новый уникальный идентификатор поставщика услуг (Service Provider). Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-full-name }}.
     * `acs_urls` — новые URL-адреса, на которые {{ org-full-name }} будет отправлять SAML-ответ. ACS URL должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).
     * `signature_mode` — новые элементы SAML-ответа, которые будут подписываться электронной подписью. Возможные значения:
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

## Измените сертификат ключа проверки электронной подписи {#update-cert}

Сертификат ключа проверки электронной подписи для SAML-приложения автоматически выпускается при создании приложения сроком на пять лет.

В любой момент вы можете выпустить любое количество новых сертификатов ключа проверки электронной подписи для SAML-приложения. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_manage_certs }}** и в открывшемся окне:

      1. Нажмите кнопку **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.action-generate-new-certificate }}**. В результате будет создан новый сертификат, который отобразится в списке.
      1. Чтобы активировать новый сертификат, в строке с этим сертификатом включите опцию **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.table.column-active }}**.

          {% note warning %}
          
          В SAML-приложении активным может быть только один сертификат: при активации нового сертификата текущий сертификат становится неактивным. После активации нового сертификата не забудьте [загрузить](saml-create.md#setup-sp) его в настройки интеграции приложения на стороне поставщика услуг.
          
          {% endnote %}

      1. Чтобы скачать новый сертификат, в строке с этим сертификатом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.common.download }}**.
      1. Чтобы удалить сертификат, в строке с этим сертификатом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, после чего подтвердите удаление. Удалить можно только неактивный сертификат.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.close }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания нового сертификата:

     ```bash
     yc organization-manager idp application saml signature-certificate create --help
     ```

  1. Создайте новый сертификат:

     ```bash
     yc organization-manager idp application saml signature-certificate create \
       --application-id <идентификатор_приложения>
     ```

     Где:

     * `--application-id` — идентификатор SAML-приложения.

     Результат:

     ```text
     id: ajeq9jfrmc5t********
     application_id: ek0o663g4rs2********
     created_at: "2025-10-21T10:14:17.861652377Z"
     ```

     Сохраните идентификатор сертификата — он потребуется для активации сертификата.

  1. Посмотрите список сертификатов приложения:

     ```bash
     yc organization-manager idp application saml signature-certificate list \
       --application-id <идентификатор_приложения>
     ```

  1. Активируйте новый сертификат:

     ```bash
     yc organization-manager idp application saml signature-certificate update \
       --id <идентификатор_сертификата> \
       --active true
     ```

     Где:

     * `--id` — идентификатор сертификата, полученный при создании.
     * `--active` — установите `true` для активации сертификата.

     {% note warning %}
     
     В SAML-приложении активным может быть только один сертификат: при активации нового сертификата текущий сертификат становится неактивным. После активации нового сертификата не забудьте [загрузить](saml-create.md#setup-sp) его в настройки интеграции приложения на стороне поставщика услуг.
     
     {% endnote %}

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле ресурс для создания нового сертификата:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_signature_certificate" "cert" {
       application_id = "<идентификатор_приложения>"
       name           = "<имя_сертификата>"
     }
     ```

     Где:

     * `application_id` — идентификатор SAML-приложения.
     * `name` — имя сертификата.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_signature_certificate` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_signature_certificate).

  1. Создайте ресурс:

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

  1. Чтобы активировать новый сертификат, добавьте его в конфигурацию SAML-приложения, указав идентификатор сертификата в описании ресурса `yandex_organizationmanager_idp_application_saml_application` в блоке `signature_certificate_ids`.
  
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

  Воспользуйтесь методом REST API [SignatureCertificate.Create](../../idp/application/saml/api-ref/SignatureCertificate/create.md) для ресурса [SignatureCertificate](../../idp/application/saml/api-ref/SignatureCertificate/index.md) или вызовом gRPC API [SignatureCertificateService/Create](../../idp/application/saml/api-ref/grpc/SignatureCertificate/create.md).

{% endlist %}

## Измените атрибуты пользователей и групп {#update-attributes}

Чтобы изменить атрибуты, которые будут передаваться из {{ org-full-name }} поставщику услуг:

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

## Измените список пользователей и групп приложения {#users-and-groups}

Измените список пользователей вашей [организации](../../concepts/organization.md), которые могут аутентифицироваться во внешнем приложении с помощью SAML-приложения:

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

#### См. также {#see-also}

* [{#T}](saml-create.md)
* [{#T}](saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)