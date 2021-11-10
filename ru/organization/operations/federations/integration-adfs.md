# Аутентификация с помощью Active Directory

С помощью [федерации удостоверений](../../add-federation.md) вы можете использовать [Active Directory Federation Services]({{link-adfs}}) (AD FS) для аутентификации в облаке.

Чтобы настроить аутентификацию:

1. [Создайте федерацию в организации](#create-federation).
1. [Добавьте сертификаты в федерацию](#add-certificate).
1. [Получите ссылку для входа в консоль](#get-link).
1. [Настройте аутентификацию на сервере AD FS](#configure-sso).
1. [Добавьте пользователей в организацию](#add-users).
1. [Протестируйте аутентификацию](#test-auth).

## Перед началом {#before-you-begin}

Чтобы воспользоваться инструкциями в этом разделе, вам понадобятся:

1. Работающая ферма AD FS. Если на вашем сервере еще не настроен AD FS, [установите и настройте его](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/deploying-a-federation-server-farm). Для развертывания AD FS вам также необходимо установить и настроить Active Directory Domain Services (AD DS).

    Если у вас нет машины с ОС Windows, чтобы развернуть сервер AD FS, вы можете [создать виртуальную машину](../../../compute/quickstart/quick-create-windows.md) в {{ yandex-cloud }}.

    {% note tip %}

    В ферму рекомендуется включать более одного сервера, чтобы обеспечить большую надежность аутентификации.

    {% endnote %}

1. Действующий сертификат, который используется для подписи в службе AD FS. Если у вас нет действующего SSL-сертификата, получите новый.

    Имя субъекта в сертификате должно содержать FQDN сервера поставщика удостоверений, например `fs.contoso.com`, чтобы страница аутентификации не могла быть заблокирована браузером.

## Создайте федерацию в организации {#create-federation}

{% list tabs %}

- Консоль управления

  Чтобы создать федерацию:

  1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).
  1. На левой панели выберите раздел [Федерации]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png).
  1. Нажмите кнопку **Создать федерацию**.
  1. Задайте имя федерации. Имя должно быть уникальным в каталоге.
  1. При необходимости добавьте описание.
  1. В поле **Время жизни cookie** укажите время, в течении которого браузер не должен требовать у пользователя повторной аутентификации.
  1. В поле **IdP Issuer** укажите ссылку в формате `http://<ADFS>/adfs/services/trust`, где `<ADFS>` — это FQDN вашего AD FS сервера.
  1. В поле **SSO метод** выберите **POST**.
  1. В поле **Ссылка на страницу для входа в IdP** укажите ссылку в формате `https://<ADFS>/adfs/ls/`, где `<ADFS>` — это FQDN вашего AD FS сервера.
  1. Включите опцию **Автоматически создавать пользователей**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию. Если вы не включите эту опцию, федеративных пользователей потребуется [добавить вручную](../../add-account.md#add-user-sso).

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды создания федерации:

        ```
        yc organization-manager federation saml create --help
        ```

    1. Создайте федерацию:

        ```
        yc organization-manager federation saml create --name my-federation \
          --auto-create-account-on-login \
          --cookie-max-age 12h \
          --issuer "http://example.com/adfs/services/trust" \
          --sso-binding POST \
          --sso-url "https://example.com/adfs/ls/"
        ```

        Где:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `auto-create-account-on-login` — флаг, активирующий автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. Эта опция упрощает процесс заведения пользователей, но созданному таким образом пользователю по умолчанию назначается только роль `resource-manager.clouds.member`: он не сможет выполнять никаких операций с ресурсами в этом облаке. Исключение — те ресурсы, на которые назначены роли системной группе `allUsers` или `allAuthenticatedUsers`.

            Если эту опцию не включать, то пользователь, которого не добавили в облако, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять белым списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `cookie-max-age` — время, в течении которого браузер не должен требовать у пользователя повторной аутентификации.
        * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

            Укажите ссылку в формате `http://<ADFS>/adfs/services/trust`, где `<ADFS>` — это FQDN вашего AD FS сервера.

        * `sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Укажите ссылку в формате `https://<ADFS>/adfs/ls/`, где `<ADFS>` — это FQDN вашего AD FS сервера.

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
        "issuer": "http://example.com/adfs/services/trust",
        "ssoUrl": "https://example.com/adfs/ls/",
        "ssoBinding": "POST"
      }
      ```

      Где:

      * `folderId` — идентификатор каталога.
      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `autocreateUsers` — флаг, активирующий автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. Эта опция упрощает процесс заведения пользователей, но созданному таким образом пользователю по умолчанию назначается только роль `resource-manager.clouds.member`: он не сможет выполнять никаких операций с ресурсами в этом облаке. Исключение — те ресурсы, на которые назначены роли системной группе `allUsers` или `allAuthenticatedUsers`.

          Если эту опцию не включать, то пользователь, которого не добавили в облако, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять белым списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `cookieMaxAge` — время, в течении которого браузер не должен требовать у пользователя повторной аутентификации.
      * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

          Укажите ссылку в формате `http://<ADFS>/adfs/services/trust`, где `<ADFS>` — это FQDN вашего AD FS сервера.

      * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Укажите ссылку в формате `https://<ADFS>/adfs/ls/`, где `<ADFS>` — это FQDN вашего AD FS сервера.

      * `ssoBinding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Укажите сертификаты для федерации {#add-certificate}

Когда поставщик удостоверений (IdP) сообщает {{org-full-name}}, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис {{org-name}} мог проверить этот сертификат, добавьте его в созданную федерацию.

{% include [federation-sertificates-note](../../../_includes/iam/federation-sertificates-note.md) %}

Чтобы получить сертификат службы AD FS:

1. Войдите на ваш сервер AD FS и откройте **Server Manager**.
1. Откройте консоль управления AD FS: **Tools** → **AD FS Management**.
1. В открывшемся окне в дереве слева нажмите **Services** → **Certificates**.
1. Нажмите правой кнопкой мыши на сертификате в блоке **Token-signing** и выберите **View certificate**.
1. В открывшемся окне перейдите на вкладку **Details**.
1. Нажмите кнопку **Copy to file**.
1. Нажмите кнопку **Next**.
1. Выберите формат **Base-64 encoded X.509 (.CER)** и нажмите **Next**.
1. Укажите, куда сохранить сертификат и с каким именем, и нажмите **Next**.
1. Проверьте настройки экспорта сертификата и нажмите **Finish**.

Чтобы добавить сертификат в федерацию:

{% list tabs %}

- Консоль управления

  1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).
  1. На левой панели выберите раздел [Федерации]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png).
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

  Чтобы добавить сертификат, воспользуйтесь методом [create](../../../organization/api-ref/grpc/certificate_service.md#Create) для ресурса [Certificate](../../../organization/api-ref/grpc/certificate_service.md):

  1. Сформируйте тело запроса, указав содержимое сертификата в свойстве `data`:

      ```json
      {
        "federationId": "<ID федерации>",
        "name": "my-certificate",
        "data": "MII...=="
      }
      ```

  2. Отправьте запрос на добавление сертификата:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/certificates"
      ```

{% endlist %}

## Получите ссылку для входа в консоль {#get-link}

Когда вы настроите аутентификацию с помощью федерации, пользователи смогут войти в консоль управления по ссылке, в которой содержится идентификатор федерации. Эту же ссылку необходимо будет указать при настройке сервера аутентификации.

Получите и сохраните эту ссылку:

1. Получите идентификатор федерации:

    1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).
    1. На левой панели выберите раздел [Федерации]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png).
    1. Скопируйте идентификатор федерации, для которой вы настраиваете доступ.

2. Сформируйте ссылку с помощью полученного идентификатора:

    `{{ link-console-main }}/federations/<ID федерации>`

## Настройте аутентификацию на сервере AD FS {#configure-sso}

После того, как вы получили ссылку для входа в консоль управления вы можете настроить сервер AD FS так, чтобы он сообщал консоли управления о каждой успешной аутентификации и возвращал пользователя на указанный адрес для входа в консоль управления.

Инструкции в этом разделе написаны для ОС Windows Server 2016, для других версий шаги могут отличаться.

Чтобы настроить аутентификацию на сервере AD FS:

1. [Создайте отношение доверия с проверяющей стороной](#configure-relying-party-trust)
1. [Настройте Claims Mapping](#configure-claims-mapping)

### Создайте отношение доверия с проверяющей стороной {#configure-relying-party-trust}

AD FS требует создавать _отношение доверия с проверяющей стороной (relying party trust)_ для каждого поставщика услуг (Service Provider, SP), который будет использовать AD FS для аутентификации.

Создайте отношение доверия с проверяющей стороной для федерации, созданной в облаке:

1. Войдите на ваш сервер AD FS и откройте **Server Manager**.
1. Откройте консоль управления AD FS: **Tools** → **AD FS Management**.
1. В списке действий выберите **Add Relying Party Trust**.
1. Откроется окно помощника. На первой странице выберите **Claims aware** и нажмите **Start**.
1. Выберите **Enter data about the relying party manually** и нажмите **Next**.
1. Задайте имя, например <q>Yandex.Cloud</q>, и нажмите **Next**.
1. На следующем шаге вас попросят указать сертификат для подписи токенов. Этот шаг необязательный, поэтому нажмите **Next**.
1. На шаге Configure URL выберите **Enable support for the SAML 2.0 WebSSO protocol** и укажите [ссылку для входа в консоль](#get-link), полученную ранее. После этого нажмите **Next**.

    ![image](../../../_assets/iam/federations/specify-console-sso-link.png)

1. На следующей странице введите в качестве идентификатора эту же [ссылку для входа в консоль](#get-link) и нажмите **Add**. После этого нажмите **Next**.
1. На следующей странице можно выбрать, кому будет доступна аутентификация с помощью этой федерации. По умолчанию выбрана политика **Permit for everyone**, которая разрешает доступ для всех пользователей.

    Вы можете выбрать другую политику. Например, чтобы разрешить доступ только для отдельной группы пользователей, выберите **Permit specific group** и нажмите на слово `<parameter>`, чтобы выбрать, для каких групп разрешить доступ. [Подробнее о политиках управления доступом](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

    ![image](../../../_assets/iam/federations/specify-access-policy-ad.png)

1. Нажмите **Next**.
1. На странице **Ready to Add Trust** проверьте введенные данные и нажмите **Close**.

### Настройте Claims Mapping {#configure-claims-mapping}

Когда AD FS аутентифицирует пользователя, она отправляет в {{ yandex-cloud }} SAML-сообщение с подтверждением об успешной аутентификации. В элементе `NameID` в этом сообщении должно указываться, кто именно был аутентифицирован. Для этого необходимо настроить соответствие данных пользователя элементам SAML-сообщения. Типы персональных данных, которые поддерживает {{ org-full-name }}, приведены ниже.

Данные пользователя | Комментарий | Outgoing Claim Type
------------------- | ----------- | -------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты. | Name Identifier 
Фамилия | Отображается в сервисах {{yandex-cloud}}. | Surname
Имя | Отображается в сервисах {{yandex-cloud}}. | Given Name
Полное имя | Отображается в сервисах {{yandex-cloud}}.<br>Пример: Иван Иванов | Name
Почта | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример:&nbsp;`ivanov@example.com` | E-Mail Address
Телефон | Используется для отправки уведомлений из сервисов {{yandex-cloud}}.<br>Пример: +71234567890 | Добавьте новый атрибут с идентификатором<br>`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone`.<br>См. [документацию AD FS]({{ link-adfs-add-claim }})
Аватар | Отображается в сервисах {{yandex-cloud}}.<br>Изображение передается в кодировке Base64. [Пример](#avatar-example) | Добавьте новый атрибут с идентификатором `thumbnailPhoto`.<br>См. [документацию AD FS]({{ link-adfs-add-claim }})

{% note warning %}

Идентификатор `NameID` должен быть уникальным для всех пользователей федерации. В качестве идентификатора рекомендуется указывать User Principal Name (UPN) или адрес электронной почты.

{% endnote %}

Чтобы настроить соответствие данных пользователя элементам SAML-сообщения:

1. В консоли управления AD FS в блоке **Relying Party Trusts** нажмите правой кнопкой мыши на созданном ранее отношении доверия с проверяющей стороной и выберите **Edit Claim Issuance Policy**.
1. В открывшемся окне нажмите **Add Rule**.
1. Выберите **Send LDAP Attributes as Claims** и нажмите **Next**.
1. На следующей странице настройте, что будет передаваться в полях сообщения:
    1. В поле **Claim rule name** задайте имя правила, например `Claims mapping`
    1. В поле **Attribute Store** выберите `Active Directory`.
    1. Укажите, что будет передаваться в качестве Name ID — уникального идентификатора пользователя. Для этого добавьте строчку в списке **Mapping of LDAP attributes**:

        В **LDAP Attribute** выберите `User-Principal-Name` или `E-Mail-Addresses`.

        В **Outgoing Claim Type** выберите `Name ID`.

    1. Чтобы пользователь мог обратиться в службу технической поддержки {{ yandex-cloud }} из [консоли управления]({{link-console-support}}), настройте, чтобы сервер передавал адрес электронной почты (`E-Mail Address` и имя пользователя (`Name`):

        ![image](../../../_assets/iam/federations/specify-claims-mapping-ad.png)

        Вы также можете передавать отдельно имя и фамилию пользователя. Для этого вместо `Name` используйте типы `Given Name` и `Surname`.

1. Нажмите **Finish**, затем нажмите **OK**, чтобы закрыть окно **Edit Claim Issuance Policy**.

#### Пример изображения в кодировке Base64 {#avatar-example}

Изображение для аватара передается в текстовом виде в кодировке [Base64]({{link-base64}}).

{% cut "Пример закодированного изображения" %}

```
iVBORw0KGgoAAAANSUhEUgAAACoAAAAqCAYAAADFw8lbAAAABmJLR0QA/wD/AP+gvaeTAAAACXBI
WXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH5QMRDiIqU8/IRwAACMFJREFUWMO1mWuMXVUVx39rn3un
dF609DEpFj6ofQw0GEbtDNGCIBRKKk6w2kSJsU2EgNKKUQK1JhpJMfgByyOoRPQDmFTSZpAmCBgr
ktgpSGugZQpEElpLYVqmzExnGJi79/LD3vuefc6dQdB6kjP7nDPn8d//tdZ/rbWv8H/aNm5Ttq6V
+vn1D2qzc5wPdDnlPBQH7AK23/8NmfxP75NTBWzzNuW2BNhND2ubs8yzjpVO+ZYqy1ShvkP4w9Ds
Vs65Y428+cQ/lZUfk1MP9Cd/Un54af6KH+zUTmu5zlqucY7ZNYs4hzgFdeDKQAPYmTPQNZ9l1YVn
yeOPvaKsWiSnFuiWXbraWb5uHV3OssA6mq0Fa8E6Pzrnj1X9MRoAJ+9xDi5YCgvncv8Vi+TanS8r
qxfLhwN61x5lQ7dw525tU+UKVT6vjs84ZZlzJVDhuBYB2hys0wRkGCMABea2w4pzwSlPO7jyqiVy
MsVhPgBx527t10cFRgR+L3AdwjIRqO/4kfJ5OpKbPTJLOEdhsla/tALl8CMHdSlA34C+P6Nb+1WA
e0S4AXIWNGWnzF7ConVQq+XHLtkj4PrXFRbOg08tzv1XPb6rejvl0b4BbWR0a3/de/4K3KBa8hPJ
3x8ZTZmrTyrxSy2BrIMNo1XomJX7bvLNP/QN6KbeTpma0a39eiuwBYog6h/S/EPWQs2BrSVjLbCo
MDHhn69fC8BJXMIprOqG06rTul9HJT27e4+icDawJWVyOqnQ4JdGgMy7wYlhGDwOx9+CY0PYsTGk
WsWs6Pb3qvOsiebvMAaaZ/iJTBPlZxeA3tgt3L1Hb9WSKcvMRrE2wMg4vDEIr74Gr7+Rfyz4YZZl
TDjHaSMnobUluEEaxQIzmxqSQBnpYGUKwlaXMWoJqFEYnYAn/wLj7wSdtJBl/p6om8GHJVonBl1k
Mvp8tZIHaOrnyXakMgVrCxugaz5kBva+CPsH8pmLhA+XJCtYpqqKZgap1YI0lSZ+2oxcV6fYXv/S
OWILQO99RrumwiiSg33uBXjhRe9X0UICiPF+JwlT4Rkj8J5CU83mukkymdmtDQymzvoUQB3ofc8q
CpdQSm9p4AyPwIGDOciUmQiSBHTdlzPU2aL0xHuthdntxW9q6sPK44XMdP2nBYEeCVGcmjEC/uOf
p5cAMf45Y/LMZML/m2fSZG2SAGwx5c5q86aPO8mxg70NKdQISyI4I4lZBUZHvfwYk+9puhTC9QA2
M4wj/FotXQvP5Fc1W8xacWyqQFO1CDTZ1SmDBdMHoGdAoxkQOPKmB6Elk6fBEZjdIMqO/fdwRII5
Pn6bXo3B65Lk7xG82WNyKLo2IDhRxupAH9irrO8SRJilQX40kZAsg6ODwfeSmTj17AXN3Occl+y7
U94GkLv8PZf+SFutY5643FXie1WgvSXUC1oMTvWIawbG60DXdwm/2aftqjQrxYiMwn58qJTPQzgn
0brSGN5O2e25WZm0zBc3RTUVxvZWn3qjUtRrFf/el776CT/F1PQXiBQKmjrYyUmYeM/7U5o44j0O
7t/9UzlejrP+O4QVm3UxWiz9IhFOoaW5WPFLMTk9Gd9VB5oJlzf4ZkAyPOazR5blDKYpT2D7dGpt
LV8x0dxaBDpZg7YWXz1FrS5lxScagIpwaZnNeHwyABUpAk1y+ss9Nyv9d+SfWf59xRhmqbLOhSJE
SxYDaE4YLbGJCP2FCv93z2smQZpMuBhNlRk4+Y4HWsmgEpitZPl5tcqxCLLru/5Tz/xMcI4+TVuP
tLlTz6YxXgxc2qZ4dxpfd76MPLBXc0ZFmGkgK6c2gjaOnPSAY9Xj0mk7Bh/fnPc31tJ8/k36yczQ
p8oZLgSSMclzwcQd83wgqeaRHktAxQfm+i4pAG0RxSCNpq8YGB2DrJLLlknTYMZ2LtJsSSeXVzK+
5xwX1+Wl1GmWVeOsBaEs1MbKTmAofb4ShL4jvU+LSYCxCc9oqU3ACLx6iHWLlnAtShZrUREQ11gT
pM86hblzihNQLfjwwYYu1ECXiZV6GOM+PhGEPfO+GfdKxV97Z4KqKlmchCNvj6cr3VThvKUwY0Yh
IIttDuy+71ktMopwRaSx3O0NDftAqqdPTWpQBWuxxmBUAxnOtyWpKpQbv9Pboeu8IpvSKI27blgu
RaACn5uucT4x6tlLM1UMspqv1psASwhGTRlyoFkiPQqzTofeK30TKMlEyuR/e7nsK/jojhc1Azqm
E+zRcc8opVY2y+Ddd+ssWZHc/JosLMTROs/iuUugNlkC1+gi/ypfqJRbD02kxwhMTIagiIVI1FmT
20sVW2dG6y6BAgvmQudiWDA/tBxJkBWaxWLE72wECvOmLIR9WmWyVgSath6tLaFPhxnOYSsVsjln
wEc6oGM+dMzxASMmr7LS7JZGe1o6Kmy5e49yY3fRRw9Nt2rmwppQqouieeFcrcBlF8LQMKa9DebM
gkrVS5nJPPXWQZaUd4X2RhvbclU2beyRw2VGTW+nDAKbGnog8f6paZshSYUf7qlWYUGHL9cgrIKU
wBR8Uadyyfr29MYeuT1ZVsqB9g0ovZ1yO3A1aVshcHzYsyMSimZJWpDYjqS9kikxVCxcClWZNi5s
3AtcBLCxZ5qF3ACWRw7qMoG/idBmBPoPwtGhxiW/tDcS8QpgTEgCUkwMmcmP4/1p82gMO4FbNnTL
gfdb+zQAvZ0eyheXyn6EswT2xMK23onGrGXya1pSiriuFKnTsq560+9X+KXCWoXWDd3yBeDAh/6x
IS5LP/aKPnj4GF/b81IxZ0e3SEFnwQ3KDGaG8SzjqDH83WQ8tOliefS/XYZvWNIJIFm1SK556pD2
HXiNh8ffLU6p0Nfk2qkoqsoJVR5S5Rc/XiUD6Q8T/8s27Yrzk68ql31UuGWHnvnWCM8Dc0j7+Hzf
b4R7s4wnjOHYnV+W0fiO72xTfr721PxC9IHe8s3fagasAS4BjDE8DzxnDP+47xoZn+5HsFO5/Rtd
UYGmIgo9HwAAAABJRU5ErkJggg==
```

{% endcut %}

## Добавьте пользователей в организацию {#add-users}

Если при создании федерации вы не включили опцию **Автоматически создавать пользователей**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам необходимо знать Name ID пользователей, которые возвращает сервер поставщика удостоверений (IdP) вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает сервер в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

Чтобы добавить пользователей федерации в организацию:

{% list tabs %}

- Консоль управления

  1. [Войдите в аккаунт]({{link-passport}}) администратора организации.
  1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).
  1. На левой панели выберите раздел [Пользователи]({{link-org-users}}) ![icon-users](../../../_assets/organization/icon-users.png).
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
        https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/<ID федерации>:addUserAccounts
      ```

{% endlist %}

## Протестируйте аутентификацию {#test-auth}

Теперь, когда вы закончили настройку аутентификации с помощью Active Directory, проверьте ее работу:

1. Откройте браузер в гостевом режиме или режиме инкогнито для чистой симуляции нового пользователя.
1. Перейдите по [ссылке для входа в консоль управления](#get-link), которую вы получили ранее. Браузер должен перенаправить вас на страницу аутентификации в AD FS, которая по умолчанию выглядит так:

    ![image](../../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Введите ваши данные для аутентификации. По умолчанию, необходимо ввести UPN и пароль. Затем нажмите кнопку **Sign in**.
1. После успешной аутентификации AD FS перенаправит вас обратно по ссылке для входа в консоль управления, а после этого — на главную страницу консоли управления. В правом верхнем углу вы можете увидеть, что вы вошли в консоль от имени аккаунта в Active Directory.

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../../iam/operations/roles/grant.md#access-to-federated-user).
