# Аутентификация с помощью Google Workspace

С помощью [федерации удостоверений](../../organization/concepts/add-federation.md) вы можете использовать [Google Workspace](https://workspace.google.com/) для аутентификации пользователей в организации.

Настройка аутентификации состоит из следующих этапов:

1. [Создание и настройка SAML-приложения в Google Workspace](#gworkspace-settings).
1. [Создание и настройка федерации в {{ org-full-name }}](#yc-settings).
1. [Настройка системы единого входа (SSO)](#sso-settings).
1. [Проверка аутентификации](#test-auth).

## Перед началом работы {#before-you-begin}

Чтобы воспользоваться инструкциями в этом разделе, вам понадобится подписка на сервисы Google Workspace и подтвержденный домен, для которого вы будете настраивать SAML-приложение.

## Создание и настройка SAML-приложения в Google Workspace {#gworkspace-settings}

### Создайте SAML-приложение и скачайте сертификат {#create-app}

В роли поставщика удостоверений (IdP) выступает SAML-приложение в Google Workspace. Начните создавать приложение и скачайте сертификат:

1. Зайдите в [консоль администратора Google Workspace](https://admin.google.com/).

1. На панели слева выберите **Мобильные и веб-приложения**.

1. Нажмите **Добавить** → **Добавить пользовательское SAML-приложение**.

1. Ведите название приложения, выберите логотип и нажмите **Продолжить**.

1. На шаге **Сведения о поставщике идентификационной информации Google** указаны данные сервера IdP. Эти данные понадобятся при [настройке федерации {{ org-full-name }}](#yc-settings).

{% note alert %}

Не закрывайте страницу создания приложения в Google Workspace: необходимые данные для настроек на шаге **Сведения о поставщике услуг** будут получены на [следующих этапах](#add-link).

{% endnote %}

## Создание и настройка федерации в {{ org-full-name }} {#yc-settings}

### Создайте федерацию {#create-federation}

Чтобы создать федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-federation](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**. В открывшемся окне:

      1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

      1. При необходимости добавьте описание.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.
  
      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** скопируйте ссылку, указанную в поле **Идентификатор объекта (Entity ID)** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Формат ссылки:

          ```text
          https://accounts.google.com/o/saml2?idpid=<идентификатор_SAML-приложения>
          ```

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** скопируйте ссылку, указанную в поле **URL системы единого входа** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Формат ссылки:

          ```text
          https://accounts.google.com/o/saml2/idp?idpid=<идентификатор_SAML-приложения>
          ```

          В ссылке допустимо использовать только протоколы HTTP и HTTPS.

      1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию. Если вы не включите эту опцию, федеративных пользователей потребуется [добавить вручную](../../organization/operations/add-account.md#add-user-sso).

          Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

      1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.forceAuthn }}**, чтобы задать значение `true` для параметра [ForceAuthn](../../organization/saml/api-ref/Federation/index.md) в запросе аутентификации SAML. При включении этой опции поставщик удостоверений (Identity Provider, IdP) запрашивает у пользователя аутентификацию по истечении сессии в {{ yandex-cloud }}. Необязательный параметр.

      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Посмотрите описание команды создания федерации:

        ```bash
        yc organization-manager federation saml create --help
        ```

    1. Создайте федерацию:

        ```bash
        yc organization-manager federation saml create --name my-federation \
          --organization-id <идентификатор_организации> \
          --auto-create-account-on-login \
          --cookie-max-age 12h \
          --issuer "https://accounts.google.com/o/saml2?idpid=<идентификатор_SAML-приложения>" \
          --sso-url "https://accounts.google.com/o/saml2/idp?idpid=<идентификатор_SAML-приложения>" \
          --sso-binding POST \
          --force-authn
        ```

        Где:

        * `--name` — имя федерации. Имя должно быть уникальным в каталоге.
        
        * `--organization-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации.

        * `--auto-create-account-on-login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `--cookie-max-age` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
        
        * `--issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

            Используйте ссылку, которая указана в поле **Идентификатор объекта** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Это ссылка в формате:

            ```text
            https://accounts.google.com/o/saml2?idpid=<идентификатор_SAML-приложения>
            ```

        * `--sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Используйте ссылку, указанную в поле **URL Системы единого входа** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Формат ссылки:

            ```text
            https://accounts.google.com/o/saml2/idp?idpid=<идентификатор_SAML-приложения>
            ```

            В ссылке допустимо использовать только протоколы HTTP и HTTPS.

        * `--sso-binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

        * `--force-authn` — по истечении сессии в {{ yandex-cloud }} поставщик удостоверений запросит у пользователя повторную аутентификацию. Необязательный параметр.

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле опишите параметры федерации.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_organizationmanager_saml_federation" federation {
        name            = "my-federation"
        organization_id = "<идентификатор_организации>"
        auto_create_account_on_login = "true"
        issuer          = "https://accounts.google.com/o/saml2?idpid=<идентификатор_SAML-приложения>"
        sso_url         = "https://accounts.google.com/o/saml2/idp?idpid=<идентификатор_SAML-приложения>"
        sso_binding     = "POST"
        security_settings {
          encrypted_assertions = "true"
        }
      }
      ```

      Где:

      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `description` — описание федерации.
      * `organization_id` — [идентификатор](../../organization/operations/organization-get-id.md) организации. 
      * `labels` — набор пар меток ключ/значение, которые присвоены федерации. Необязательный параметр.
      * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

          Используйте ссылку, указанную в поле **Идентификатор объекта** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Формат ссылки:

          ```text
          https://accounts.google.com/o/saml2?idpid=<идентификатор_SAML-приложения>
          ```

      * `sso_binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.
      * `sso_url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Скопируйте сюда ссылку, указанную в поле **URL Системы единого входа** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Формат ссылки:

          ```text
          https://accounts.google.com/o/saml2/idp?idpid=<идентификатор_SAML-приложения>
          ```

          В ссылке допустимо использовать только протоколы HTTP и HTTPS.

      * `cookie_max_age` — время в секундах, в течение которого браузер не должен требовать у пользователя повторной аутентификации. Значение по умолчанию `8 часов`. 
      * `auto_create_account_on_login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
      Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

          Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `case_insensitive_name_ids` — зависимость имен пользователей от регистра.
          Если опция включена, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
      * `security_settings` — настройки безопасности федерации: 

          * `encrypted_assertions` — подписывать запросы аутентификации.
            
            Если включить эту опцию, то все запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись.

          * `force-authn` — по истечении сессии в {{ yandex-cloud }} поставщик удостоверений запросит у пользователя повторную аутентификацию. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_organizationmanager_saml_federation` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_saml_federation).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразятся параметры федерации. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Создайте федерацию.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание федерации.

      После этого в указанной организации будет создана федерация. Проверить появление федерации и ее настроек можно в организации в разделе [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}).

- API {#api}

    1. Создайте файл с телом запроса, например `body.json`:

        ```json
        {
          "name": "my-federation",
          "organizationId": "<идентификатор_организации>",
          "autoCreateAccountOnLogin": true,
          "cookieMaxAge":"43200s",
          "issuer": "https://accounts.google.com/o/saml2?idpid=<идентификатор_SAML-приложения>",
          "ssoUrl": "https://accounts.google.com/o/saml2/idp?idpid=<идентификатор_SAML-приложения>",
          "ssoBinding": "POST",
          "securitySettings": {
            "forceAuthn": true
          }
        }
        ```

        Где:
        
        * `name` — имя федерации. Имя должно быть уникальным в каталоге.

        * `organizationId` — [идентификатор](../../organization/operations/organization-get-id.md) организации. 

        * `autoCreateAccountOnLogin` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `cookieMaxAge` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
        
        * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

            Используйте ссылку, указанную в поле **Идентификатор объекта** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Формат ссылки:

            ```text
            https://accounts.google.com/o/saml2?idpid=<идентификатор_SAML-приложения>
            ```
        * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Скопируйте сюда ссылку, указанную в поле **URL Системы единого входа** на странице **Сведения о поставщике услуг идентификации Google** в Google Workspace. Формат ссылки:

            ```text
            https://accounts.google.com/o/saml2/idp?idpid=<идентификатор_SAML-приложения>
            ```

            В ссылке допустимо использовать только протоколы HTTP и HTTPS.

        * `ssoBinding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

        * `forceAuthn` — параметр, который включает принудительную повторную аутентификацию пользователя по истечении сессии в {{ yandex-cloud }}. Необязательный параметр.

    1. Чтобы создать федерацию, воспользуйтесь методом REST API [create](../../organization/saml/api-ref/Federation/create.md) для ресурса [Federation](../../organization/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Create](../../organization/saml/api-ref/grpc/Federation/create.md) и передайте в запросе файл с параметрами запроса.
       
       Пример запроса:
       
       ```bash
       curl \
         --request POST \
         --header "Content-Type: application/json" \
         --header "Authorization: Bearer <IAM-токен>" \
         --data '@body.json' \
         https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations
       ```
       
       Пример ответа:
       
       ```bash
       {
        "done": true,
        "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.organization-manager.v1.saml.CreateFederationMetadata",
         "federationId": "ajeobmje4dgj********"
        }
       ```
       
       В свойстве `federationId` указан идентификатор созданной федерации: сохраните его, он понадобится в дальнейшем.

{% endlist %}

### Добавьте сертификаты {#add-certificate}

При аутентификации у сервиса {{ org-full-name }} должна быть возможность проверить сертификат IdP-сервера. Для этого скачайте сертификат с открытой страницы **Сведения о поставщике услуг идентификации Google** в Google Workspace и добавьте его в созданную федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  
  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
  
  1. Нажмите на строку с федерацией, для которой нужно добавить сертификат.
  
  1. Внизу страницы в блоке **{{ ui-key.yacloud_org.page.federation.section.certificates }}** нажмите кнопку **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.
  
  1. Введите название и описание сертификата.
  
  1. Выберите способ добавления сертификата:
  
      * Чтобы добавить сертификат в виде файла, нажмите **{{ ui-key.yacloud_portal.component.file-input.button_choose }}** и укажите путь к нему.
      * Чтобы вставить скопированное содержимое сертификата, выберите способ **{{ ui-key.yacloud_org.component.form-file-upload.method.manual }}** и вставьте содержимое.
  
  1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.add }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды добавления сертификата:

      ```bash
      yc organization-manager federation saml certificate create --help
      ```

  1. Добавьте сертификат для федерации, указав путь к файлу сертификата:

      ```bash
      yc organization-manager federation saml certificate create --federation-id <ID_федерации> \
        --name "my-certificate" \
        --certificate-file certificate.pem
      ```

- API {#api}

  Воспользуйтесь методом [create](../../organization/saml/api-ref/Certificate/create.md) для ресурса [Certificate](../../organization/saml/api-ref/Certificate/index.md):

  1. Сформируйте тело запроса. В свойстве `data` укажите содержимое сертификата:

      ```json
      {
        "federationId": "<ID_федерации>",
        "name": "my-certificate",
        "data": "-----BEGIN CERTIFICATE..."
      }
      ```

  1. Отправьте запрос на добавление сертификата:

      ```bash
      export IAM_TOKEN=CggaAT********
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates"
      ```

{% endlist %}

{% note tip %}

Не забывайте своевременно перевыпускать сертификаты и добавлять их в федерацию.

Чтобы не пропустить момент окончания срока действия сертификата, [подпишитесь](../../organization/operations/subscribe-user-for-notifications.md) на уведомления от организации. Уведомления направляются подписанным пользователям за 60, 30 и 5 дней до момента прекращения действия сертификата, а также после того, как сертификат становится недействительным.

{% endnote %}


## Настройка системы единого входа (SSO) {#sso-settings}

### Укажите URL для перенаправления {#add-link}

Когда вы создали федерацию, завершите создание SAML-приложения в Google Workspace:

1. Вернитесь на страницу создания SAML-приложения на шаге **Сведения о поставщике идентификационной информации Google** и нажмите **Продолжить**.

1. На шаге **Сведения о поставщике услуг** укажите сведения о {{ yandex-cloud }}, выступающем в роли поставщика услуг:

    * В полях **URL ACS** и **Идентификатор объекта** введите ACS URL, на который пользователи будут перенаправляться после аутентификации.

      {% cut "Как получить ID федерации" %}
   
      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
      1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **{{ ui-key.yacloud_org.common.columns.column_id }}**.
   
      {% endcut %}

      
      {% cut "Как получить ACS URL федерации" %}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      
      1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
      
      1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **{{ ui-key.yacloud_org.entity.federation.field.acsUrl }}**.

      {% endcut %}

    
    * Включите опцию **Подписанный ответ**.

1. Нажмите **Продолжить**.

    
    {% note tip %}

    Чтобы пользователь мог обратиться в службу технической поддержки {{ yandex-cloud }} из [консоли управления]({{ link-console-support }}), на шаге **Сопоставление атрибутов** нажмите **Добавить сопоставления** и настройте передачу атрибутов:
    * **Primary email**.
    * **First name**.
    * **Last name**.

    Атрибуты пользователей, которые поддерживают сервисы {{ org-full-name }}, перечислены в разделе [Сопоставление атрибутов пользователей](#claims-mapping).

    {% endnote %}


1. Чтобы завершить создание приложения, нажмите **Готово**.

### Добавьте пользователей {#add-users}

1. На странице приложения в разделе **Доступ пользователей** нажмите **Отключено для всех**. 

1. На открывшейся странице выберите, кому будет доступна аутентификация в этой федерации:

    * Чтобы включить доступ для всех пользователей федерации, выберите **Включено для всех**.

    * Чтобы включить доступ для отдельного организационного подразделения, выберите подразделение в списке слева и настройте статус сервиса для этого подразделения. По умолчанию дочерние подразделения наследуют настройки доступа от родительского подразделения.

1. Нажмите **Сохранить**.

### Сопоставление атрибутов пользователей {#claims-mapping}

Данные пользователя | Комментарий | Атрибуты приложений
------------------- | ----------- | -------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать адрес электронной почты. | Поле **Идентификатор названия** в настройках поставщика услуг
Фамилия | Отображается в сервисах {{ yandex-cloud }}.<br> Ограничение значения по длине: {{ saml-limit-last-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`
Имя | Отображается в сервисах {{ yandex-cloud }}.<br> Ограничение значения по длине: {{ saml-limit-first-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`
Полное имя | Отображается в сервисах {{ yandex-cloud }}.<br>Пример: Иван Иванов.<br> Ограничение значения по длине: {{ saml-limit-display-name }}. | Атрибут недоступен
Почта | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}.<br>Пример:&nbsp;`ivanov@example.com`.<br> Ограничение значения по длине: {{ saml-limit-email }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`
Телефон | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}.<br>Пример: +71234567890.<br> Ограничение значения по длине: {{ saml-limit-phone }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone`
Аватар | Отображается в сервисах {{ yandex-cloud }}.<br> Ограничение значения по длине: {{ saml-limit-thumbnail-photo }}. | Атрибут недоступен

{% note warning %}

Значение атрибута `thumbnailPhoto`, превышающее ограничение по длине, игнорируется. Если значение другого атрибута превышает ограничения, то часть значения, выходящая за пределы ограничения, отбрасывается.

{% endnote %}

>Пример сопоставления атрибутов:
>
>![image](../../_assets/organization/google-saml-mapping.png)

### Добавьте пользователей в организацию {#add-users-to-org}

Если при [создании федерации](#yc-settings) вы не включили опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам понадобятся пользовательские Name ID. Их возвращает IdP-сервер вместе с ответом об успешной аутентификации.

При включенной опции **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** в федерацию будут добавлены только пользователи, которые впервые авторизуются в облаке. Если федеративный пользователь был удален, добавить его повторно можно только вручную.

Добавить пользователя может администратор (роль `organization-manager.admin`) или владелец (роль `organization-manager.organizations.owner`) организации. О том, как назначить пользователю роль, читайте в разделе [Роли](../../organization/security/index.md#add-role).

{% note info %}

Для доступа пользователя к [консоли управления]({{ link-console-main }}), назначьте ему роль на [облако](../../organization/security/index.md#access-binding-cloud) или [организацию](../../organization/security/index.md#access-binding-organization). Для безопасности вы можете назначить одну из ролей с минимальными привилегиями, например `resource-manager.clouds.member`, но также можно назначить и другие роли, если вы знаете, какие права вы хотите предоставить приглашенным пользователям.

Чтобы дать эти права сразу всем пользователям в организации, назначьте роль [системной группе](../../iam/concepts/access-control/system-group.md#allOrganizationUsers) `All users in organization X`. При работе с CLI или API назначение дополнительных ролей не требуется.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  
  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
  
  1. В правом верхнем углу нажмите кнопку ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** и в выпадающем списке выберите ![key](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud_org.page.users.action.add-federated-users }}**.
  
  1. В поле **{{ ui-key.yacloud_org.form.users.federated.add.field.federation }}** выберите федерацию удостоверений, из которой необходимо добавить пользователей.
  
  1. В поле **{{ ui-key.yacloud_org.form.users.federated.add.field.users }}** перечислите Name ID пользователей, разделяя их пробелами или переносами строк.
  
  1. Нажмите **{{ ui-key.yacloud_components.organization.action.add }}**. Пользователи будут подключены к организации.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды добавления пользователей:

      ```bash
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Добавьте пользователей, перечислив их Name ID через запятую:

      ```bash
      yc organization-manager federation saml add-user-accounts --id <ID_федерации> \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

      Где:

      * `--id` — идентификатор федерации.
      * `--name-ids` — Name ID пользователей.

- API {#api}

  Чтобы добавить пользователей федерации в облако:

  1. Сформируйте файл с телом запроса, например `body.json`. В теле запроса укажите массив Name ID пользователей, которых необходимо добавить:

      ```json
      {
        "nameIds": [
          "alice@example.com",
          "bob@example.com",
          "charlie@example.com"
        ]
      }
      ```
  1.  Отправьте запрос, указав в параметрах идентификатор федерации:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<ID_федерации>:addUserAccounts
      ```

{% endlist %}

## Проверка аутентификации {#test-auth}

Когда вы закончили настройку сервера, протестируйте, что все работает:

1. Откройте браузер в гостевом режиме или режиме инкогнито.

1. Перейдите по URL для входа в консоль:

   ```text
   {{ link-console-main }}/federations/<ID_федерации>
   ```

   {% cut "Как получить ID федерации" %}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
   1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **{{ ui-key.yacloud_org.common.columns.column_id }}**.

   {% endcut %}

   Браузер должен перенаправить вас на страницу аутентификации в Google.

1. Введите данные для аутентификации и нажмите кнопку **Sign in**.

После успешной аутентификации IdP-сервер перенаправит вас обратно по ACS URL, который вы указали в настройках Google Workspace, а после — на главную страницу [консоли управления]({{ link-console-main }}). В правом верхнем углу вы можете увидеть, что вы вошли в консоль от имени федеративного пользователя.

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../organization/security/index.md#add-role).