---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Аутентификация с помощью SAML-совместимой федерации удостоверений

Это общая инструкция о настройке аутентификации в облаке через SAML-совместимую федерацию удостоверений. Используйте эту инструкцию, если для вашей федерации удостоверений нет [специальной инструкции](../index.md#federations).

Чтобы настроить аутентификацию:

1. [Создайте федерацию в облаке](#create-federation).
1. [Добавьте сертификаты в федерацию](#add-certificate).
1. [Получите ссылку для входа в консоль](#get-link).
1. [Настройте аутентификацию на своем сервере](#configure-sso).
1. [Добавьте пользователей в облако](#add-users).
1. [Протестируйте аутентификацию](#test-auth).

## Перед началом {#before-you-begin}

Для того, чтобы воспользоваться инструкциями в этом разделе, вам понадобятся:

1. Роль [admin](../../concepts/access-control/roles.md#admin) или [resource-manager.clouds.owner](../../concepts/access-control/roles.md#owner) в облаке, для которого вы хотите настроить SAML-аутентификацию.
1. Действующий сертификат, который используется для подписи SAML-сообщений на сервере поставщика удостоверений (IdP). Если у вас нет действующего SSL-сертификата, получите новый.

    Имя субъекта в сертификате должно содержать FQDN сервера поставщика удостоверений, например `fs.contoso.com`, чтобы страница аутентификации не могла быть заблокирована браузером.


## Создайте федерацию в облаке {#create-federation}

Чтобы создать федерацию в {{ iam-short-name }}:

{% list tabs %}

- Консоль управления

  1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
  1. В меню слева выберите вкладку **Федерации**.
  1. Нажмите **Создать федерацию**.
  1. Задайте имя федерации. Имя должно быть уникальным в каталоге.
  1. При необходимости добавьте описание.
  1. В поле **Время жизни cookie** укажите время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
  1. В поле **IdP Issuer** укажите идентификатор IdP-сервера, на котором должна происходить аутентификация. Этот же идентификатор сервер IdP указывает в ответе сервису {{ iam-short-name }} после того, как пользователь проходит аутентификацию.
  1. В поле **Ссылка на страницу для входа в IdP** укажите адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.
  1. Включите опцию **Автоматически создавать пользователей**, чтобы аутентифицированный пользователь автоматически добавлялся в облако. Эта опция упрощает процесс заведения пользователей, но созданному таким образом пользователю по умолчанию назначается только роль `resource-manager.clouds.member`: он не сможет выполнять никаких операций с ресурсами в этом облаке. Исключение — те ресурсы, на которые назначены роли системной группе `allUsers` или `allAuthenticatedUsers`.

      Если эту опцию не включать, то пользователь, которого не добавили в облако, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять белым списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды создания федерации:

        ```
        $ yc iam federation create --help
        ```

    1. Создайте федерацию:

        ```
        $ yc iam federation create --name my-federation \
          --auto-create-account-on-login \
          --cookie-max-age 12h \
          --issuer "https://accounts.google.com/o/saml2?idpid=C03xolm0y" \
          --sso-binding POST \
          --sso-url "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y"
        ```

        Где:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `auto-create-account-on-login` — флаг, активирующий автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. Эта опция упрощает процесс заведения пользователей, но созданному таким образом пользователю по умолчанию назначается только роль `resource-manager.clouds.member`: он не сможет выполнять никаких операций с ресурсами в этом облаке. Исключение — те ресурсы, на которые назначены роли системной группе `allUsers` или `allAuthenticatedUsers`.

            Если эту опцию не включать, то пользователь, которого не добавили в облако, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять белым списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.
        * `cookie-max-age` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
        * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация. Этот же идентификатор сервер IdP указывает в ответе сервису {{ iam-short-name }} после того, как пользователь проходит аутентификацию.
        * `sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.
        * `sso-binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

- API

  1. [Получите идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором вы будете создавать федерацию.
  1. Создайте файл с телом запроса, например `body.json`:

      ```json
      {
        "folderId": "<ID каталога>",
        "name": "my-federation",
        "autocreateUsers": true,
        "cookieMaxAge":"43200s",
        "issuer": "https://accounts.google.com/o/saml2?idpid=C03xolm0y",
        "ssoUrl": "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y",
        "ssoBinding": "POST"
      }
      ```

      Где:

      * `folderId` — идентификатор каталога.
      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `autocreateUsers` — флаг, активирующий автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. Эта опция упрощает процесс заведения пользователей, но созданному таким образом пользователю по умолчанию назначается только роль `resource-manager.clouds.member`: он не сможет выполнять никаких операций с ресурсами в этом облаке. Исключение — те ресурсы, на которые назначены роли системной группе `allUsers` или `allAuthenticatedUsers`.

          Если эту опцию не включать, то пользователь, которого не добавили в облако, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять белым списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.
      * `cookieMaxAge` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
      * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация. Этот же идентификатор сервер IdP указывает в ответе сервису {{ iam-short-name }} после того, как пользователь проходит аутентификацию.
      * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.
      * `ssoBinding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.
  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Укажите сертификаты для федерации {#add-certificate}

{% include [federation-sertificates-note](../../../_includes/iam/federation-sertificates-note.md) %}

{% include [federation-sertificates-add](../../../_includes/iam/federation-sertificates-add.md) %}

## Получите ссылку для входа в консоль {#get-link}

{% include [federation-login-link](../../../_includes/iam/federation-login-link.md) %}

## Настройте аутентификацию на своем сервере {#configure-sso}

После того, как вы создали федерацию и получили получили ссылку для входа в консоль управления, настройте сервер поставщика удостоверений. После каждого успешного прохождения аутентификации сервер должен отправлять консоли управления соответствующее SAML-сообщение.

Пример SAML-сообщения:
```xml
<samlp:Response ID="_bcdf7b6b-ea42-4191-8d5e-ebd4274acec6" Version="2.0" IssueInstant="2019-07-30T13:24:25.488Z"
 Destination="https://console.cloud.yandex.ru/federations/bfbrotp6l1b2avhe1spu" Consent="urn:oasis:names:tc:SAML:2.0:consent:unspecified"
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
        <SubjectConfirmationData InResponseTo="19fb953133b313a86a001f2d387160e47f3e7aa0" NotOnOrAfter="2019-07-30T13:29:25.488Z" Recipient="https://console.cloud.yandex.ru/federations/bfbrotp6l1b2avhe1spu" />
      </SubjectConfirmation>
    </Subject>
    <Conditions NotBefore="2019-07-30T13:24:25.482Z" NotOnOrAfter="2019-07-30T14:24:25.482Z">
      <AudienceRestriction>
        <Audience>https://console.cloud.yandex.ru/federations/bfbrotp6l1b2avhe1spu</Audience>
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
  * в `SubjectConfimirationData` в атрибуте `Recipient`;
  * в `Audience`.
* Укажите уникальный идентификатор пользователя в элементе `NameID`. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты.
* Укажите ссылку на страницу IdP в элементе `Issuer`. На эту страницу перенаправлялся пользователь для прохождения аутентификации).
* Укажите подписанное сообщение в элементе `SignatureValue` и сертификат, которым оно было подписано в элементе `KeyInfo`.
* Учтите, что {{ yandex-cloud }} проверяет, что ответ был получен в промежуток времени, указываемый в атрибутах элемента `Conditions` или `SubjectConfimirationsData`.
* Чтобы пользователь мог обратиться в службу технической поддержки {{ yandex-cloud }} из [консоли управления](https://console.cloud.yandex.ru/support), передайте его адрес электронной почты и имя в элементе `AttributeStatement`. Почта, имя и фамилия передаются в отдельных элементах `Attribute`. Вы также можете передать имя и фамилию вместе, например так:
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

## Добавьте пользователей в облако {#add-users}

{% include [add-federated-users](../../../_includes/iam/add-federated-users.md) %}

## Протестируйте аутентификацию {#test-auth}

Теперь, когда вы закончили настройку сервера, проверьте аутентификацию:

1. Откройте браузер в гостевом режиме или режиме инкогнито для чистой симуляции нового пользователя.
1. Перейдите по [ссылке для входа в консоль управления](#get-link), которую вы получили ранее. Браузер должен перенаправить вас на страницу аутентификации.
1. Введите ваши аутентификационные данные. По умолчанию необходимо ввести UPN и пароль. Затем нажмите кнопку **Sign in**.
1. После успешной аутентификации сервер перенаправит вас обратно по ссылке для входа в консоль, а после этого — на главную страницу консоли управления. В правом верхнем углу вы сможете увидеть, что вошли в консоль от имени федеративного пользователя.

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../roles/grant.md#access-to-federated-user).
