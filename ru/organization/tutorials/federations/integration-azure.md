# Аутентификация с помощью {{ microsoft-idp.entra-id-full }}

С помощью [федерации удостоверений](../../concepts/add-federation.md) вы можете использовать [{{ microsoft-idp.entra-id-full }}]({{ link-azure-ad }}) (далее — {{ microsoft-idp.entra-id-short }}) для аутентификации пользователей в организации.

Настройка аутентификации состоит из следующих этапов:

1. [Создание и настройка SAML-приложения в Azure](#azure-settings).

1. [Создание и настройка федерации в {{ org-full-name }}](#yc-settings).

1. [Настройка системы единого входа (SSO)](#sso-settings).

1. [Проверка аутентификации](#test-auth).

## Перед началом работы {#before-you-begin}

Чтобы воспользоваться инструкциями в этом разделе, вам понадобится учетная запись Azure с активной подпиской.

## Создание и настройка SAML-приложения в Azure {#azure-settings}

### Создайте SAML-приложение и скачайте сертификат {#create-app}

В роли поставщика удостоверений (IdP) выступает SAML-приложение в Microsoft Azure. Начните создавать приложение и скачайте сертификат:

1. Перейдите на [портал Azure](https://portal.azure.com/).

1. В разделе **Службы Azure** выберите **{{ microsoft-idp.entra-id-full }}**.

1. На панели слева выберите **Корпоративные приложения**.

1. Нажмите **Новое приложение**.

1. На странице **Обзор коллекции {{ microsoft-idp.entra-full }}** нажмите **Создайте собственное приложение**.

1. В открывшемся окне:

   1. Введите название приложения.

   1. Выберите вариант **Integrate any other application you don't find in the gallery (Non-gallery)**.

   1. Нажмите кнопку **Создать**.

1. На открывшейся странице **Обзор** на панели слева выберите **Единый вход**.

1. Выберите метод единого входа **SAML**.

1. На странице **Вход на основе SAML** в разделе **3. Сертификат подписи SAML** скачайте сертификат (Base64). С помощью него поставщик удостоверений подписывает сообщение о том, что пользователь прошел аутентификацию.

Не закрывайте страницу: данные IdP-сервера понадобятся при [создании и настройке федерации](#yc-settings).

### Добавьте пользователей {#add-users}

Добавьте пользователей на IdP-сервер:

1. Перейдите на страницу [Корпоративные приложения](https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps).

1. Выберите созданное SAML-приложение.

1. На панели слева выберите **Пользователи и группы**.

1. Нажмите **Добавить пользователя или группу**.

1. В поле **Пользователи** нажмите **Не выбрано**.

1. В открывшемся окне отметьте пользователей и нажмите кнопку **Выбрать**.

1. Нажмите кнопку **Назначить**.

## Создание и настройка федерации в {{ org-full-name }} {#yc-settings}

### Создайте федерацию {#create-federation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-federation](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**. В открывшемся окне:

      1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

      1. При необходимости добавьте описание.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** вставьте ссылку, которая указана в поле **Идентификатор {{ microsoft-idp.entra-full }}** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:

          ```text
          https://sts.windows.net/<идентификатор_SAML-приложения>/
          ```

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** вставьте ссылку, которая указана в поле **URL-адрес входа** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:

          ```text
          https://login.microsoftonline.com/<идентификатор_SAML-приложения>/saml2
          ```

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы пользователь после аутентификации автоматически добавлялся в организацию. Если опция отключена, федеративных пользователей потребуется [добавить вручную](../../operations/add-account.md#add-user-sso).

          {% include [fed-users-note](../../../_includes/organization/fed-users-note.md) %}

      1. {% include [forceauthn-option-enable](../../../_includes/organization/forceauthn-option-enable.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
          --issuer "https://sts.windows.net/<идентификатор_SAML-приложения>/" \
          --sso-url "https://login.microsoftonline.com/<идентификатор_SAML-приложения>/saml2" \
          --sso-binding POST \
          --force-authn
        ```

        Где:

        * `--name` — имя федерации. Имя должно быть уникальным в каталоге.

        * `--organization-id` — [идентификатор](../../operations/organization-get-id.md) организации.

        * `--auto-create-account-on-login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем IdP-сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `--cookie-max-age` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.

        * `--issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

            Используйте ссылку, которая указана в поле **Идентификатор {{ microsoft-idp.entra-full }}** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:
            ```text
            https://sts.windows.net/<идентификатор_SAML-приложения>/
            ```

        * `--sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Используйте ссылку, которая указана в поле **URL-адрес входа** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:

            ```text
            https://login.microsoftonline.com/<идентификатор_SAML-приложения>/saml2
            ```

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `--sso-binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

        * {% include [forceauthn-cli-enable](../../../_includes/organization/forceauth-cli-enable.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле опишите параметры федерации.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_organizationmanager_saml_federation" federation {
        name            = "my-federation"
        organization_id = "<идентификатор_организации>"
        auto_create_account_on_login = "true"
        issuer          = "https://sts.windows.net/<идентификатор_SAML-приложения>/"
        sso_url         = "https://login.microsoftonline.com/<идентификатор_SAML-приложения>/saml2"
        sso_binding     = "POST"
        security_settings {
          encrypted_assertions = "true"
          force_authn          = "true"
        }
      }
      ```

      Где:

      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `description` — описание федерации.
      * `organization_id` — [идентификатор](../../operations/organization-get-id.md) организации.
      * `labels` — набор пар меток ключ/значение, которые присвоены федерации.
      * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

          Используйте ссылку, которая указана в поле **Идентификатор {{ microsoft-idp.entra-full }}** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:

          ```text
          https://sts.windows.net/<идентификатор_SAML-приложения>/
          ```

      * `sso_binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.
      * `sso_url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Используйте ссылку, которая указана в поле **URL-адрес входа** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:

          ```text
          https://login.microsoftonline.com/<идентификатор_SAML-приложения>/saml2
          ```

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `cookie_max_age` — время в секундах, в течение которого браузер не должен требовать у пользователя повторной аутентификации. Значение по умолчанию `8 часов`.
      * `auto_create_account_on_login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере.
      Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

          Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `case_insensitive_name_ids` — зависимость имен пользователей от регистра.
          Если опция включена, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.

      * `security_settings` — настройки безопасности федерации: 

          * {% include [encrypted-assertions-tf](../../../_includes/organization/encrypted-assertions-tf.md) %}

          * {% include [force-authn-tf](../../../_includes/organization/force-authn-tf.md) %}

      {% include [organizationmanager_saml_federation-tf](../../../_includes/organization/organizationmanager_saml_federation-tf.md) %}

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
          "issuer": "https://sts.windows.net/<идентификатор_SAML-приложения>/",
          "ssoUrl": "https://login.microsoftonline.com/<идентификатор_SAML-приложения>/saml2",
          "ssoBinding": "POST",
          "securitySettings": {
            "forceAuthn": true
          }
        }
        ```

        Где:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.

        * `organizationId` — [идентификатор](../../operations/organization-get-id.md) организации.

        * `autoCreateAccountOnLogin` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем IdP-сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `cookieMaxAge` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.

        * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

            Используйте ссылку, которая указана в поле **Идентификатор {{ microsoft-idp.entra-full }}** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:

            ```text
            https://sts.windows.net/<идентификатор_SAML-приложения>/
            ```

        * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Используйте ссылку, которая указана в поле **URL-адрес входа** на странице **Вход на основе SAML** в {{ microsoft-idp.entra-id-short }}. Формат ссылки:

            ```text
            https://login.microsoftonline.com/<идентификатор_SAML-приложения>/saml2
            ```

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `ssoBinding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

        * {% include [forceauthn-api-enable](../../../_includes/organization/forceauth-api-enable.md) %}

    1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

### Добавьте сертификаты {#add-certificate}

При аутентификации у сервиса {{ org-name }} должна быть возможность проверить сертификат IdP-сервера. Для этого добавьте [скачанный ранее](#azure-settings) сертификат в федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-cert-to-fed](../../../_includes/organization/add-cert-to-fed.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления сертификата:

      ```bash
      yc organization-manager federation saml certificate create --help
      ```

  1. Добавьте сертификат для федерации, указав путь к файлу сертификата:

      ```bash
      yc organization-manager federation saml certificate create \
        --federation-id <ID_федерации> \
        --name "my-certificate" \
        --certificate-file certificate.cer
      ```

- API {#api}

  Воспользуйтесь методом [create](../../saml/api-ref/Certificate/create.md) для ресурса [Certificate](../../saml/api-ref/Certificate/index.md):

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

{% include [federation-certificates-note](../../../_includes/organization/federation-certificates-note.md) %}

## Настройка системы единого входа (SSO) {#sso-settings}

### Укажите URL для перенаправления {#add-link}

Когда вы создали федерацию, завершите создание SAML-приложения в Azure:

1. Откройте страницу настроек SAML-приложения **Вход на основе SAML**.

1. В разделе **1. Базовая конфигурация SAML** укажите сведения о {{ yandex-cloud }}, выступающем в роли поставщика услуг. Для этого в полях **Идентификатор (сущности)** и **URL-адрес ответа (URL-адрес службы обработчика утверждений)** укажите ACS URL, на который пользователи будут перенаправляться после аутентификации.


   {% cut "Как получить ACS URL федерации" %}

   {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

   {% endcut %}


1. Нажмите **Сохранить**.

### Настройте сопоставление атрибутов пользователей {#claims-mapping}

{% note warning %}

Настройка сопоставления атрибутов обязательна.

{% endnote %}

После аутентификации пользователя IdP-сервер отправит в {{ yandex-cloud }} SAML-сообщение, которое будет содержать:

* информацию об успешной аутентификации;

* атрибуты пользователя, такие как идентификатор Name ID, имя и адрес электронной почты.

Чтобы настроить сопоставление между атрибутами SAML-сообщения и персональными данными, на странице **Вход на основе SAML** в разделе **2. Утверждения и атрибуты пользователя** нажмите **Изменить**.

Типы персональных данных, которые поддерживает {{ org-full-name }} для {{ microsoft-idp.entra-id-short }}, приведены ниже.

Данные пользователя | Комментарий | Атрибуты приложений
------------------- | ----------- | -------------------
Уникальный идентификатор пользователя (Name ID) | Обязательный атрибут.<br> По умолчанию в {{ microsoft-idp.entra-id-short }} в качестве источника атрибута используется User Principal Name (UPN) в формате `<логин>_<домен>#EXT#@<поставщик>.onmicrosoft.com`. При добавлении пользователей в федерацию вручную такой формат Name ID не поддерживается. Рекомендуется в {{ microsoft-idp.entra-id-short }} изменить источник атрибута: вместо UPN `user.userprincipalname` выбрать адрес электронной почты `user.mail`. | Утверждение **Уникальный идентификатор пользователя (ID)**
Фамилия | Отображается в сервисах {{ yandex-cloud }}.<br> Ограничение значения по длине: {{ saml-limit-last-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`
Имя | Отображается в сервисах {{ yandex-cloud }}.<br> Ограничение значения по длине: {{ saml-limit-first-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`
Полное имя | Отображается в сервисах {{ yandex-cloud }}.<br>Пример: `Иван Иванов`.<br> Ограничение значения по длине: {{ saml-limit-display-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name`
Почта | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}.<br>Пример:&nbsp;`ivanov@example.com`.<br> Ограничение значения по длине: {{ saml-limit-email }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`

{% note warning %}

Если значение атрибута превышает ограничение по длине, то часть значения, выходящая за пределы ограничения, отбрасывается.

{% endnote %}

### Добавьте пользователей в организацию {#add-users-to-org}

Если при [создании федерации](#yc-settings) вы не включили опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам понадобятся пользовательские Name ID. Их возвращает IdP-сервер вместе с ответом об успешной аутентификации.

{% include [auto-create-users](../../../_includes/organization/auto-create-users.md) %}

Добавить пользователя может администратор (роль `organization-manager.admin`) или владелец (роль `organization-manager.organizations.owner`) организации. О том, как назначить пользователю роль, читайте в разделе [Роли](../../security/index.md#admin).

{% include [console-user-access](../../../_includes/organization/console-user-access.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-users-to-fed](../../../_includes/organization/add-users-to-fed.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

  1.  Сформируйте файл с телом запроса, например `body.json`. В теле запроса укажите массив Name ID пользователей, которых необходимо добавить:

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

Когда вы закончили настройку SSO, протестируйте, что все работает:

1. Откройте браузер в гостевом режиме или режиме инкогнито.

1. Перейдите по URL для входа в консоль:

   ```text
   {{ link-console-main }}/federations/<ID_федерации>
   ```

   {% cut "Как получить ID федерации" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   Браузер должен перенаправить вас на страницу аутентификации в Microsoft.

1. Введите данные для аутентификации и нажмите кнопку **Далее**.

После успешной аутентификации IdP-сервер перенаправит вас по ACS URL, который вы указали в настройках {{ microsoft-idp.entra-id-short }}, а после — на главную страницу [консоли управления]({{ link-console-main }}). В правом верхнем углу вы сможете увидеть, что вошли в консоль от имени федеративного пользователя.

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../security/index.md#add-role).
