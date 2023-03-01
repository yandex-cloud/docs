# Аутентификация с помощью SAML-совместимой федерации удостоверений

Это общая инструкция о настройке аутентификации в облаке через SAML-совместимую федерацию удостоверений. Используйте эту инструкцию, если для вашей федерации удостоверений нет специальной инструкции.

Чтобы настроить аутентификацию:

1. [Создайте федерацию в организации](#create-federation).

1. [Добавьте сертификаты в федерацию](#add-certificate).

1. [Получите ссылку для входа в консоль](#get-link).

1. [Настройте аутентификацию на своем сервере](#configure-sso).

1. [Настройте сопоставление атрибутов пользователей](#claims-mapping).

1. [Добавьте пользователей в организацию](#add-users).

1. [Протестируйте аутентификацию](#test-auth).

## Перед началом {#before-you-begin}

Чтобы воспользоваться инструкциями в этом разделе, вам понадобится действующий сертификат, который используется для подписи SAML-сообщений на сервере поставщика удостоверений (IdP). Если у вас нет действующего SSL-сертификата, получите новый.

Имя субъекта в сертификате должно содержать FQDN сервера поставщика удостоверений, например `fs.contoso.com`, чтобы страница аутентификации не могла быть заблокирована браузером.

## Создайте федерацию в организации {#create-federation}

Чтобы создать федерацию:

{% list tabs %}

- Консоль управления

  1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).

  1. На левой панели выберите раздел [Федерации]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

  1. Нажмите кнопку **Создать федерацию**.

  1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

  1. При необходимости добавьте описание.

  1. В поле **Время жизни cookie** укажите время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.

  1. В поле **IdP Issuer** укажите идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя. Этот же идентификатор IdP-сервер должен указывать в ответе сервису {{org-name}} во время аутентификации пользователя.

      {% note info %}

      Формат идентификатора зависит от типа IdP-сервера, который вы используете (например, Active Directory или Google Workspace).

      {% endnote %}

  1. В поле **SSO метод** выберите **POST**.

  1. В поле **Ссылка на страницу для входа в IdP** укажите адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

  1. Добавьте для созданной федерации [сертификат поставщика удостоверений](#add-certificate).

  1. Включите опцию **Автоматически создавать пользователей**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию. Если вы не включите эту опцию, федеративных пользователей потребуется [добавить вручную](../../add-account.md#add-user-sso).

  1. Настройте сервер поставщика удостоверений, чтобы он передавал в {{ yandex-cloud }} информацию об успешной аутентификации и атрибуты пользователя.

   Атрибуты пользователей, которые поддерживают сервисы {{ org-full-name }}, перечислены в разделе [{#T}](#claims-mapping).

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды создания федерации:

        ```
        yc organization-manager federation saml create --help
        ```

    1. Создайте федерацию:

        ```bash
        yc organization-manager federation saml create --name my-federation \
            --organization-id <ID организации> \
            --auto-create-account-on-login \
            --cookie-max-age 12h \
            --issuer "https://accounts.google.com/o/saml2?idpid=C03xolm0y" \
            --sso-binding POST \
            --sso-url "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y"
        ```

        Где:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `organization-id` — идентификатор организации. 
        * `auto-create-account-on-login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [системной группе](../../../iam/concepts/access-control/system-group.md) `allUsers` или `allAuthenticatedUsers`.

          Если  опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.
        * `cookie-max-age` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
        * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация. Этот же идентификатор IdP-сервер указывает в ответе сервису {{org-name}} после того, как пользователь проходит аутентификацию.
        * `sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.
        * `sso-binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

- API

  1. [Получите идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором вы будете создавать федерацию.
  1. Создайте файл с телом запроса, например `body.json`:

      ```json
      {
        "folderId": "<ID каталога>",
        "name": "my-federation",
        "organizationId": "<ID организации>",
        "autoCreateAccountOnLogin": true,
        "cookieMaxAge":"43200s",
        "issuer": "https://accounts.google.com/o/saml2?idpid=C03xolm0y",
        "ssoUrl": "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y",
        "ssoBinding": "POST"
      }
      ```

      Где:

      * `folderId` — идентификатор каталога.
      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `organizationId` — идентификатор организации. 
      * `autoCreateAccountOnLogin` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [системной группе](../../../iam/concepts/access-control/system-group.md) `allUsers` или `allAuthenticatedUsers`.

          Если  опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.
      * `cookieMaxAge` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
      * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация. Этот же идентификатор IdP-сервер указывает в ответе сервису {{org-name}} после того, как пользователь проходит аутентификацию.
      * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.
      * `ssoBinding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. В конфигурационном файле опишите параметры федерации:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `description` — описание федерации.
        * `organization_id` — идентификатор организации. 
        * `labels` — набор пар меток ключ/значение, которые присвоены федерации.
        * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация. Этот же идентификатор IdP-сервер указывает в ответе сервису {{org-name}} после того, как пользователь проходит аутентификацию.        
        * `sso_binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.
        * `sso_url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.
        * `cookie_max_age` — время в секундах, в течение которого браузер не должен требовать у пользователя повторной аутентификации. Значение по умолчанию `8 часов`. 
        * `auto_create_account_on_login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [системной группе](../../../iam/concepts/access-control/system-group.md) `allUsers` или `allAuthenticatedUsers`.

            Если  опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.
        * `case_insensitive_name_ids` — зависимость имен пользователей от регистра.
           Если опция включена, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
        * `security_settings` — настройки безопасности федерации: 
          * `encrypted_assertions` — подписывать запросы аутентификации. 
            Если включить опцию, то все запросы аутентификации от {{yandex-cloud}} будут содержать цифровую подпись. Вам потребуется скачать и установить сертификат {{yandex-cloud}}.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_organizationmanager_saml_federation" federation {
      name            = "my-federation"
      organization_id = "<ID организации>"
      auto_create_account_on_login = "true"
      issuer          = "https://accounts.google.com/o/saml2?idpid=C03xolm0y" 
      sso_url         = "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y"
      sso_binding     = "POST"
      security_settings {
         encrypted_assertions = "true"
         }
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        $ terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразятся параметры федерации. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Создайте федерацию.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        $ terraform apply
        ```

     1. Подтвердите создание федерации.

     После этого в указанной организации будет создана федерация. Проверить появление федерации и ее настроек можно в организации в разделе [Федерации]({{link-org-federations}}).

{% endlist %}

## Укажите сертификаты для федерации {#add-certificate}

Когда поставщик удостоверений (IdP) сообщает {{org-full-name}}, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис {{org-name}} мог проверить этот сертификат, добавьте его в созданную федерацию.

Чтобы добавить сертификат в федерацию:

{% list tabs %}

- Консоль управления

  1. Получите сертификат вашего поставщика удостоверений.

    {% note info %}

    Чтобы узнать, как получить сертификат, обратитесь к документации или в службу поддержки сервиса, который вы используете в качестве поставщика удостоверений.

    {% endnote %}

  1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).

  1. На левой панели выберите раздел [Федерации]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

  1. Нажмите имя федерации, для которой нужно добавить сертификат.

  1. Внизу страницы нажмите кнопку **Добавить сертификат**.

  1. Введите название и описание сертификата.

  1. Выберите способ добавления сертификата:
      * Чтобы добавить сертификат в виде файла, нажмите **Выбрать файл** и укажите путь к нему.
      * Чтобы вставить скопированное содержимое сертификата, выберите способ **Текст** и вставьте содержимое.
  1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления сертификата:

      ```
      yc organization-manager federation saml certificate create --help
      ```

  1. Добавьте сертификат для федерации, указав путь к файлу сертификата:

      ```
      yc organization-manager federation saml certificate create --federation-name my-federation \
        --name "my-certificate" \
        --certificate-file test.pem
      ```

- API

  Чтобы добавить сертификат, воспользуйтесь методом [create](../../api-ref/Certificate/create.md) для ресурса [Certificate](../../api-ref/Certificate/index.md):

  1. Сформируйте тело запроса, указав содержимое сертификата в свойстве `data`:

      ```json
      {
        "federationId": "<ID федерации>",
        "name": "my-certificate",
        "data": "MII...=="
      }
      ```

  1. Отправьте запрос на добавление сертификата:

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

Чтобы аутентификация не прерывалась в тот момент, когда у очередного сертификата закончился срок действия, рекомендуется добавлять в федерацию несколько сертификатов — текущий и те, которые будут использоваться после текущего. Если один сертификат окажется недействительным, {{ yandex-cloud }} попробует проверить подпись другим сертификатом.

{% endnote %}

## Получите ссылку для входа в консоль {#get-link}

Когда вы настроите аутентификацию с помощью федерации, пользователи смогут войти в консоль управления по ссылке, в которой содержится идентификатор федерации. Эту же ссылку необходимо будет указать при настройке сервера аутентификации.

Получите и сохраните эту ссылку:

1. Получите идентификатор федерации:

    1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).

    1. На левой панели выберите раздел [Федерации]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

    1. Скопируйте идентификатор федерации, для которой вы настраиваете доступ.

1. Сформируйте ссылку с помощью полученного идентификатора:

    `https://{{ auth-host }}/federations/<ID федерации>`

## Настройте аутентификацию на своем сервере {#configure-sso}

После того, как вы создали федерацию и получили получили ссылку для входа в консоль управления, настройте сервер поставщика удостоверений. После каждого успешного прохождения аутентификации сервер должен отправлять консоли управления соответствующее SAML-сообщение.

Пример SAML-сообщения:
```xml
<samlp:Response ID="_bcdf7b6b-ea42-4191-8d5e-ebd4274acec6" Version="2.0" IssueInstant="2019-07-30T13:24:25.488Z"
 Destination="{{ link-console-main }}/federations/bfbrotp6l1b2avhe1spu" Consent="urn:oasis:names:tc:SAML:2.0:consent:unspecified"
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
        <SubjectConfirmationData InResponseTo="19fb953133b313a86a001f2d387160e47f3e7aa0" NotOnOrAfter="2019-07-30T13:29:25.488Z" Recipient="{{ link-console-main }}/federations/bfbrotp6l1b2avhe1spu" />
      </SubjectConfirmation>
    </Subject>
    <Conditions NotBefore="2019-07-30T13:24:25.482Z" NotOnOrAfter="2019-07-30T14:24:25.482Z">
      <AudienceRestriction>
        <Audience>{{ link-console-main }}/federations/bfbrotp6l1b2avhe1spu</Audience>
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

При формировании сообщения:

* В элементах `Response` и `SubjectConfirmationData` в атрибуте `InResponseTo` укажите идентификатор из SAML-запроса на аутентификацию, который отправило {{ yandex-cloud }}.
* Укажите полученную [ссылку для входа в консоль](#get-link) в следующих элементах:
  * в `Response` в атрибуте `Destination`;
  * в `SubjectConfirmationData` в атрибуте `Recipient`;
  * в `Audience`.
* Укажите уникальный идентификатор пользователя в элементе `NameID`. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты.
* Укажите ссылку на страницу IdP в элементе `Issuer`. На эту страницу перенаправлялся пользователь для прохождения аутентификации).
* Укажите подписанное сообщение в элементе `SignatureValue` и сертификат, которым оно было подписано в элементе `KeyInfo`.
* Учтите, что {{ yandex-cloud }} проверяет, что ответ был получен в промежуток времени, указываемый в атрибутах элемента `Conditions` или `SubjectConfirmationData`.
* Чтобы пользователь мог обратиться в службу технической поддержки {{ yandex-cloud }} из [консоли управления]({{link-console-support}}), передайте его адрес электронной почты и имя в элементе `AttributeStatement`. Почта, имя и фамилия передаются в отдельных элементах `Attribute`. Вы также можете передать имя и фамилию вместе, например так:
    ```
    <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name">
      <AttributeValue>John Doe</AttributeValue>
    </Attribute>
    ```

    В атрибуте `Name` можно указать короткое название атрибута, например:
    ```
    <Attribute Name="name">
      <AttributeValue>John Doe</AttributeValue>
    </Attribute>
    ```

## Настройте сопоставление атрибутов пользователей {#claims-mapping}

После аутентификации пользователя сервер поставщика удостоверений отправляет в {{ yandex-cloud }} SAML-сообщение, которое содержит информацию об успешной аутентификации и атрибуты пользователя, такие как идентификатор, имя, адрес электронной почты и так далее.

Чтобы корректно передавать в сервис {{ org-full-name }} информацию о пользователе, настройте сопоставление между атрибутами SAML-сообщения и персональными данными пользователя, которые хранятся на сервере поставщика удостоверений. 

Данные пользователя | Комментарий | Элементы SAML-сообщения
------------------- | ----------- | ----------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты. | `<NameID>`
Фамилия | Отображается в сервисах {{yandex-cloud}}. | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"`
Имя | Отображается в сервисах {{yandex-cloud}}. | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"`
Полное имя | Отображается в сервисах {{yandex-cloud}}.<br>Пример: Иван Иванов | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"`
Почта | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример:&nbsp;`ivanov@example.com` | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"`
Телефон | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример: {% if product == "yandex-cloud" %}+71234567890{% endif %}{% if product == "cloud-il" %}+972571234567{% endif %} | `<Attribute>`  с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone"`
Аватар | Отображается в сервисах {{yandex-cloud}}.<br>Изображение передается в кодировке Base64. [Пример](#avatar-example) | `<Attribute>`  с параметром<br>`Name="thumbnailPhoto"`

### Пример изображения в кодировке Base64 {#avatar-example}

Изображение для аватара передается в текстовом виде в кодировке [Base64]({{link-base64}}).

{% cut "Пример закодированного изображения" %}

```
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
UYGmIgo9HwAAAABJRU5ErkJggg==
```

{% endcut %}

## Добавьте пользователей в организацию {#add-users}

Если при создании федерации вы не включили опцию **Автоматически создавать пользователей**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам необходимо знать Name ID пользователей, которые возвращает сервер поставщика удостоверений (IdP) вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает сервер в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

Добавить пользователя может администратор (роль `organization-manager.admin`) или владелец (роль `organization-manager.organizations.owner`) организации. Как назначить роль пользователю, читайте в разделе [Роли](../../roles.md#admin).

Чтобы добавить пользователей федерации в организацию:

{% list tabs %}

- Консоль управления

  1. [Войдите в аккаунт]({{link-passport}}) администратора или владельца организации.

  1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).

  1. На левой панели выберите раздел [Пользователи]({{link-org-users}}) ![icon-users](../../../_assets/organization/icon-users.svg).

  1. В правом верхнем углу нажмите на стрелку возле кнопки **Добавить пользователя**. Выберите пункт **Добавить федеративных пользователей**.

  1. Выберите федерацию, из которой необходимо добавить пользователей.

  1. Перечислите Name ID пользователей, разделяя их переносами строк.

  1. Нажмите кнопку **Добавить**. Пользователи будут подключены к организации.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления пользователей:

      ```
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Добавьте пользователей, перечислив их Name ID через запятую:

      ```
      yc organization-manager federation saml add-user-accounts --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

- API

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
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM-токен>" \
        -d '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<ID федерации>:addUserAccounts
      ```

{% endlist %}

## Протестируйте аутентификацию {#test-auth}

Теперь, когда вы закончили настройку сервера, проверьте аутентификацию:

1. Откройте браузер в гостевом режиме или режиме инкогнито для чистой симуляции нового пользователя.

1. Перейдите по [ссылке для входа в консоль управления](#get-link), которую вы получили ранее. Браузер должен перенаправить вас на страницу аутентификации.

1. Введите ваши аутентификационные данные. По умолчанию необходимо ввести UPN и пароль. Затем нажмите кнопку **Sign in**.

1. После успешной аутентификации сервер перенаправит вас обратно по ссылке для входа в консоль, а после этого — на главную страницу консоли управления. В правом верхнем углу вы сможете увидеть, что вошли в консоль от имени федеративного пользователя.

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../../iam/operations/roles/grant.md#access-to-federated-user).
