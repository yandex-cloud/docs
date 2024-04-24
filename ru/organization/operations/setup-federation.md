# Настроить федерацию удостоверений

Вы можете настроить аутентификацию пользователей в облаке через [федерацию удостоверений](../concepts/add-federation.md). Федерации удостоверений совместимы с любыми поставщиками удостоверений (IdP), которые поддерживают стандарт [SAML 2.0](https://wiki.oasis-open.org/security/FrontPage).

Чтобы настроить аутентификацию через федерацию удостоверений:

1. [Создайте федерацию удостоверений](#create-federation).
1. [Передайте сертификат IdP-сервера в федерацию](#add-certificate-fed).
1. [Передайте сертификат федерации на IdP-сервер](#add-certificate-idp).
1. [Настройте SAML-приложение на стороне IdP-сервера](#configure-sso).
1. [Настройте сопоставление атрибутов пользователей](#claims-mapping).
1. [Проверьте работу аутентификации](#test-auth).

Примеры настройки аутентификации для отдельных поставщиков удостоверений приведены в практических руководствах:

* [Active Directory](../tutorials/federations/integration-adfs.md).
* [Google Workspace](../tutorials/federations/integration-gworkspace.md).
* [Azure Active Directory](../tutorials/federations/integration-azure.md).
* [Keycloak](../tutorials/federations/integration-keycloak.md).

## Создать федерацию удостоверений {#create-federation}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).

  1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}) ![icon-federation](../../_assets/organization/icon-federation.svg).

  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.action.create }}**.

  1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

  1. (Опционально) Добавьте описание федерации.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** укажите идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя. Формат идентификатора зависит от типа IdP-сервера.

      Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** выберите метод перенаправления пользователя на IdP-сервер. Большинство поставщиков удостоверений поддерживает метод **POST**.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** укажите адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

      Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

      {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

  1. В поле **Дополнительно** при необходимости выберите опции:

        * **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** — аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](./add-account.md#add-user-sso).

            {% include [fed-users-note](../../_includes/organization/fed-users-note.md) %}

        * **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** — запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись. Потребуется установить сертификат {{ yandex-cloud }} на стороне поставщика удостоверений.
        * **{{ ui-key.yacloud_org.entity.federation.field.caseInsensitiveNameIds }}** — идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
        * **{{ ui-key.yacloud_org.entity.federation.field.forceAuthn }}** — при истечении сессии в {{ yandex-cloud }} поставщик удостоверений запросит у пользователя повторную аутентификацию.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать федерацию:

    1. Посмотрите описание команды создания федерации:

        ```bash
        yc organization-manager federation saml create --help
        ```

    1. Укажите параметры федерации в команде создания:

        ```bash
        yc organization-manager federation saml create \
            --name <имя_федерации> \
            --organization-id <идентификатор_организации> \
            --cookie-max-age <время_жизни_cookies> \
            --issuer "<идентификатор_IdP-сервера>" \
            --sso-binding <POST_или_REDIRECT> \
            --sso-url "<адрес_страницы_для перенаправления>" \
            --encrypted-assertions \
            --auto-create-account-on-login \
            --case-insensitive-name-ids \
            --force-authn
        ```

        Где:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `organization-id` — идентификатор организации.
        * `cookie-max-age` — время, в течение которого браузер не будет требовать у пользователя повторной аутентификации, например: `12h`.
        * `issuer` — идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя.

            Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

        * `sso-binding` — тип привязки для Single Sign-on. Возможные значения — `POST` или `REDIRECT`. Большинство поставщиков поддерживают тип привязки `POST`.
        * `sso-url` — URL-адрес страницы, на которую браузер перенаправит пользователя для аутентификации.

            Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

            {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

        * (Опционально) `--encrypted-assertions` — запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись. Потребуется установить сертификат {{ yandex-cloud }} на стороне поставщика удостоверений.
        * (Опционально) `auto-create-account-on-login` — аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](./add-account.md#add-user-sso).

            {% include [fed-users-note](../../_includes/organization/fed-users-note.md) %}

        * (Опционально) `--case-insensitive-name-ids` — идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
        * (Опционально) {% include [forceauthn-cli-enable](../../_includes/organization/forceauth-cli-enable.md) %}

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Создайте конфигурационный файл с описанием федерации.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_organizationmanager_saml_federation" federation {
        name            = "my-federation"
        description     = "My new SAML federation"
        organization_id = "<идентификатор_организации>"
        issuer          = "<идентификатор_IdP-сервера>" 
        sso_url         = "<адрес_страницы_для перенаправления>"
        sso_binding     = "<POST_или_REDIRECT>"
        cookie_max_age = <время_жизни_cookies>
        auto_create_account_on_login = "<true_или_false>"
        case_insensitive_name_ids = "<true_или_false>"
        security_settings {
          encrypted_assertions = "<true_или_false>"
          }
      }
      ```

      Где:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.
        * (Опционально) `description` — описание федерации.
        * `organization_id` — идентификатор организации.
        * `issuer` — идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя.

            Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

        * `sso_binding` — тип привязки для Single Sign-on. Возможные значения — `POST` или `REDIRECT`. Большинство поставщиков поддерживают тип привязки `POST`.
        * `sso_url` — URL-адрес страницы, на которую браузер перенаправит пользователя для аутентификации.

            Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

            {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

        * `cookie_max_age` — время в секундах, в течение которого браузер не будет требовать у пользователя повторной аутентификации. По умолчанию — `28800` (8 часов).
        * `auto_create_account_on_login` — если `true`, аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](./add-account.md#add-user-sso).

            {% include [fed-users-note](../../_includes/organization/fed-users-note.md) %}

        * `case_insensitive_name_ids` — если `true`, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
        * `security_settings` — настройки безопасности федерации:

            * `encrypted_assertions` — запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись. Потребуется установить сертификат {{ yandex-cloud }} на стороне поставщика удостоверений.

  1. Проверьте корректность файлов конфигурации {{ TF }}:

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте федерацию:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Проверить появление федерации и ее настройки можно в организации в разделе [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}).

  {% note info %}

  Вы также можете воспользоваться [полным решением по развертыванию федерации на базе Keycloak](https://github.com/yandex-cloud-examples/yc-iam-federation-with-keycloak-vm) с использованием {{ TF }}.

  {% endnote %}

- API {#api}

  1. Создайте файл с телом запроса, например `body.json`:

      ```json
      {
        "name": "my-federation",
        "description": "My new SAML federation",
        "organizationId": "<идентификатор_организации>",
        "cookieMaxAge":"43200s",
        "issuer": "<идентификатор_IdP-сервера>",
        "ssoUrl": "<адрес_страницы_для перенаправления>",
        "ssoBinding": "<POST_или_REDIRECT>",
        "autoCreateAccountOnLogin": true,
        "caseInsensitiveNameIds": true,
        "securitySettings": {
          "encryptedAssertions": true,
          "forceAuthn": true
        }
      }
      ```

      Где:

      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `organizationId` — идентификатор организации.
      * (Опционально) `description` — описание федерации.
      * `cookieMaxAge` — время в секундах, в течение которого браузер не будет требовать у пользователя повторной аутентификации. По умолчанию — `28800` (8 часов).
      * `issuer` — идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя.

            Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

      * `ssoUrl` — URL-адрес страницы, на которую браузер перенаправит пользователя для аутентификации.

          Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

          {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

      * `ssoBinding` — тип привязки для Single Sign-on. Возможные значения — `POST` или `REDIRECT`. Большинство поставщиков поддерживают тип привязки `POST`.
      * `autoCreateAccountOnLogin` — если `true`, аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](./add-account.md#add-user-sso).

          {% include [fed-users-note](../../_includes/organization/fed-users-note.md) %}

      * `caseInsensitiveNameIds` — если `true`, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
      * `encryptedAssertions` — если `true`, запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись. Потребуется установить сертификат {{ yandex-cloud }} на стороне поставщика удостоверений.
      * {% include [forceauthn-api-enable](../../_includes/organization/forceauth-api-enable.md) %}

  1. {% include [include](../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Передать сертификат IdP-сервера в федерацию {#add-certificate-fed}

Когда поставщик удостоверений (IdP) сообщает {{ org-full-name }}, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис {{ org-name }} мог проверить этот сертификат, добавьте его в созданную федерацию:

1. Получите сертификат вашего поставщика удостоверений.

    Чтобы узнать, как это сделать, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

    Имя субъекта в сертификате должно содержать [FQDN](../../glossary/fqdn.md) сервера поставщика удостоверений, например `fs.contoso.com`, чтобы браузер не блокировал страницу аутентификации.

1. Приведите файл сертификата к PEM-формату:

    ```text
      -----BEGIN CERTIFICATE-----
      <значение сертификата>
      -----END CERTIFICATE-----
      ```

1. Добавьте сертификат в федерацию:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).

  1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}) ![icon-federation](../../_assets/organization/icon-federation.svg).

  1. Нажмите на имя федерации, для которой нужно добавить сертификат.

  1. Внизу страницы нажмите кнопку **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.

  1. Введите название и описание сертификата.

  1. Выберите способ добавления сертификата:

      * Чтобы добавить сертификат в виде файла, нажмите **{{ ui-key.yacloud_portal.component.file-input.button_choose }}** и укажите путь к нему.
      * Чтобы вставить скопированное содержимое сертификата, выберите способ **{{ ui-key.yacloud_org.component.form-file-upload.method.manual }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления сертификата:

      ```
      yc organization-manager federation saml certificate create --help
      ```

  1. Добавьте сертификат для федерации, указав путь к файлу сертификата:

      ```
      yc organization-manager federation saml certificate create --federation-name <имя_федерации> \
        --name "<имя_сертификата>" \
        --certificate-file <путь_к_файлу_сертификата>
      ```

- API {#api}

  1. Сформируйте файл с телом запроса `body.json`, указав содержимое сертификата в свойстве `data`:

      ```json
      {
        "federationId": "<идентификатор_федерации>",
        "description": "<описание_сертификата>",
        "name": "<имя_сертификата>",
        "data": "<содержимое_сертификата>"
      }
      ```

  1. Воспользуйтесь методом REST API [create](../api-ref/Certificate/create.md) для ресурса [Certificate](../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Create](../../grpc/certificate_service#Create) и передайте в запросе файл с параметрами запроса.

  Пример cURL-запроса:

  ```bash
  $ export IAM_TOKEN=CggaATEVAgA...
  $ curl -X POST \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d '@body.json' \
      "https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates"
  ```

{% endlist %}

{% note tip %}

Чтобы аутентификация не прерывалась, когда у очередного сертификата закончится срок действия, добавьте в федерацию несколько сертификатов — текущий и те, которые будут использоваться после текущего. Когда один сертификат станет недействительным, {{ yandex-cloud }} проверит подпись другим сертификатом.

{% endnote %}

## Передать сертификат федерации на IdP-сервер {#add-certificate-idp}

Если при создании федерации вы включили опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**, запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись. Чтобы IdP-сервер мог проверить эту подпись, добавьте сертификат {{ yandex-cloud }} на IdP-сервер:

1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}) ![icon-federation](../../_assets/organization/icon-federation.svg).
1. Нажмите на имя федерации, для которой нужно добавить сертификат.
1. Скачайте сертификат по ссылке в поле **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**.
1. Передайте сертификат на IdP-сервер. Чтобы узнать, как это сделать, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

## Настроить SAML-приложение на стороне IdP-сервера {#configure-sso}

Конкретные шаги по настройке SAML-приложения на стороне IdP-сервера зависят от используемого поставщика удостоверений. Здесь приведены общие требования к содержанию SAML-сообщения, которое IdP-сервер отправляет на сторону {{ yandex-cloud }} при успешной аутентификации пользователя:

{% cut "Пример SAML-сообщения" %}

```xml
<samlp:Response ID="_bcdf7b6b-ea42-4191-8d5e-ebd4274acec6" Version="2.0" IssueInstant="2019-07-30T13:24:25.488Z"
 Destination="https://{{ auth-host }}/federations/bfbrotp6l1b2avhe1spu" Consent="urn:oasis:names:tc:SAML:2.0:consent:unspecified"
  InResponseTo="19fb953133b313a86a001f2d387160e47f3e7aa0" xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol">
  <Issuer xmlns="urn:oasis:names:tc:SAML:2.0:assertion">http://example.org/auth</Issuer>
  <samlp:Status>
    <samlp:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success" />
  </samlp:Status>
  <Assertion ID="_90cd8dcc-6105-4300-9ae4-f2c8c5aeb1e5" IssueInstant="2019-07-30T13:24:25.488Z"
   Version="2.0" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
    <Issuer>http://example.org/auth</Issuer>
    <ds:Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
      <ds:SignedInfo>
        <ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#" />
        <ds:SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256" />
        <ds:Reference URI="#_90cd8dcc-6105-4300-9ae4-f2c8c5aeb1e5">
          <ds:Transforms>
            <ds:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />
            <ds:Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#" />
          </ds:Transforms>
          <ds:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256" />
          <ds:DigestValue>phUQR...</ds:DigestValue>
        </ds:Reference>
      </ds:SignedInfo>
      <ds:SignatureValue>VACd7O...</ds:SignatureValue>
      <KeyInfo xmlns="http://www.w3.org/2000/09/xmldsig#">
        <ds:X509Data>
          <ds:X509Certificate>MIIC7j...</ds:X509Certificate>
        </ds:X509Data>
      </KeyInfo>
    </ds:Signature>
    <Subject>
      <NameID>user@example.org</NameID>
      <SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:bearer">
        <SubjectConfirmationData InResponseTo="19fb953133b313a86a001f2d387160e47f3e7aa0" NotOnOrAfter="2019-07-30T13:29:25.488Z" Recipient="https://{{ auth-host }}/federations/bfbrotp6l1b2avhe1spu" />
      </SubjectConfirmation>
    </Subject>
    <Conditions NotBefore="2019-07-30T13:24:25.482Z" NotOnOrAfter="2019-07-30T14:24:25.482Z">
      <AudienceRestriction>
        <Audience>https://{{ auth-host }}/federations/bfbrotp6l1b2avhe1spu</Audience>
      </AudienceRestriction>
    </Conditions>
    <AttributeStatement>
      <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress">
        <AttributeValue>user@example.org</AttributeValue>
      </Attribute>
      <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname">
        <AttributeValue>First Name</AttributeValue>
      </Attribute>
      <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname">
        <AttributeValue>Last Name</AttributeValue>
      </Attribute>
    </AttributeStatement>
  </Assertion>
</samlp:Response>
```

{% endcut %}

Настройте SAML-приложение таким образом, чтобы при формировании сообщения:

* В элементах `Response` и `SubjectConfirmationData` в атрибуте `InResponseTo` был передан идентификатор из SAML-запроса на аутентификацию, отправленного {{ yandex-cloud }}.
* URL вида `https://{{ auth-host }}/federations/<идентификатор_федерации>` был передан в следующих элементах:
  
  * `Response` в атрибуте `Destination`;
  * `SubjectConfirmationData` в атрибуте `Recipient`;
  * `Audience`.

  {% cut "Как получить идентификатор федерации" %}

  {% include [get-federation-id](../../_includes/organization/get-federation-id.md) %}

  {% endcut %}

* В элементе `NameID` был указан уникальный идентификатор пользователя. В качестве идентификатора рекомендуется использовать User Principal Name (UPN) или адрес электронной почты.
* В элементе `Issuer` была указана ссылка на страницу поставщика удостоверений, куда перенаправлялся пользователь для прохождения аутентификации.
* В элементе `SignatureValue` было указано подписанное сообщение, а в элементе `KeyInfo` — сертификат, которым оно было подписано.
* Чтобы пользователь мог обратиться в службу технической поддержки {{ yandex-cloud }} из [консоли управления]({{ link-console-support }}), в элементе `AttributeStatement` должен быть указан его адрес электронной почты и имя.

Чтобы получить более подробную информацию о настройке SAML-приложения, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений. Также примеры настройки для отдельных поставщиков удостоверений приведены в практических руководствах:

* [Active Directory](../tutorials/federations/integration-adfs.md).
* [Google Workspace](../tutorials/federations/integration-gworkspace.md).
* [Azure Active Directory](../tutorials/federations/integration-azure.md).
* [Keycloak](../tutorials/federations/integration-keycloak.md).

## Настроить сопоставление атрибутов пользователей {#claims-mapping}

После аутентификации пользователя IdP-сервер отправляет в {{ yandex-cloud }} SAML-сообщение, которое содержит информацию об успешной аутентификации и атрибуты пользователя, такие как идентификатор, имя, адрес электронной почты и так далее.

Чтобы корректно передавать в сервис {{ org-full-name }} информацию о пользователе, настройте сопоставление между атрибутами SAML-сообщения и персональными данными пользователя, которые хранятся на стороне поставщика удостоверений.

Данные пользователя | Комментарий | Элементы SAML-сообщения
------------------- | ----------- | ----------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты. | `<NameID>`
Фамилия | Отображается в сервисах {{ yandex-cloud }}.<br> Ограничение значения по длине: {{ saml-limit-last-name }}. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"`
Имя | Отображается в сервисах {{ yandex-cloud }}.<br> Ограничение значения по длине: {{ saml-limit-first-name }}. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"`
Полное имя | Отображается в сервисах {{ yandex-cloud }}.<br>Пример: Иван Иванов.<br> Ограничение значения по длине: {{ saml-limit-display-name }}. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"`
Почта | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}.<br>Пример:&nbsp;`ivanov@example.com`.<br> Ограничение по длине: {{ saml-limit-email }}. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"`
Телефон | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}.<br>Пример: +71234567890.<br> Ограничение по длине: {{ saml-limit-phone }}. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone"`
Аватар | Отображается в сервисах {{ yandex-cloud }}.<br>Изображение передается в кодировке [Base64]({{ link-base64 }}).<br> Ограничение по длине: {{ saml-limit-thumbnail-photo }}. | `<Attribute>` с параметром<br>`Name="thumbnailPhoto"`
Членство в группах | Используется для функционала динамического сопоставления членства в группах. | `<Attribute>` с параметром<br>`Name="member"`

{% note info %}

Если значение атрибута `thumbnailPhoto` превышает ограничение по длине, атрибут игнорируется. Если значение другого атрибута превышает ограничение, такое значение обрезается.

{% endnote %}

## Проверить работу аутентификации {#test-auth}

Чтобы проверить работу аутентификации федеративных пользователей:

1. Если в федерации не включена опция **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, [добавьте](add-account.md#add-user-sso) федеративных пользователей вручную.

1. Откройте браузер в гостевом режиме или режиме инкогнито для чистой симуляции нового пользователя.

1. Перейдите по URL для входа в консоль управления:

   ```url
   https://{{ console-host }}/federations/<идентификатор_федерации>
   ```

   {% cut "Как получить идентификатор федерации" %}

   {% include [get-federation-id](../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   Браузер перенаправит вас на страницу аутентификации поставщика удостоверений.

1. Введите ваши аутентификационные данные. По умолчанию необходимо ввести UPN и пароль.
1. Нажмите кнопку **Sign in**.

1. После успешной аутентификации IdP-сервер перенаправит вас по URL `https://{{ auth-host }}/federations/<идентификатор_федерации>`, который вы указали в настройках сервера, а после этого — на главную страницу консоли управления.

Убедитесь, что вошли в консоль от имени федеративного пользователя.
