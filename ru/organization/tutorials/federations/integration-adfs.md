# Аутентификация с помощью Active Directory

С помощью [федерации удостоверений](../../concepts/add-federation.md) вы можете использовать [Active Directory Federation Services]({{ link-adfs }}) (AD FS) для аутентификации в облаке.

Чтобы настроить аутентификацию:

1. [Создайте федерацию в организации](#create-federation).

1. [Добавьте сертификаты в федерацию](#add-certificate).

1. [Настройте аутентификацию на сервере AD FS](#configure-sso).

1. [Добавьте пользователей в организацию](#add-users).

1. [Протестируйте аутентификацию](#test-auth).

## Перед началом работы {#before-you-begin}

Чтобы воспользоваться инструкциями в этом разделе, вам понадобятся:

1. Работающая ферма AD FS. Если на вашем сервере еще не настроен AD FS, [установите и настройте его](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/deploying-a-federation-server-farm). Для развертывания AD FS вам также необходимо установить и настроить Active Directory Domain Services (AD DS).


    {% note tip %}

    В ферму рекомендуется включать более одного сервера, чтобы обеспечить большую надежность аутентификации.

    {% endnote %}

1. Действующий сертификат, который используется для подписи в службе AD FS. Если у вас нет действующего SSL-сертификата, получите новый.

    Имя субъекта в сертификате должно содержать [FQDN](../../../glossary/fqdn.md) сервера поставщика удостоверений, например `fs.contoso.com`, чтобы страница аутентификации не могла быть заблокирована браузером.

## Создайте федерацию в организации {#create-federation}

Чтобы создать федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-federation](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**. В открывшемся окне:

      1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

      1. При необходимости добавьте описание.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** укажите ссылку в формате `http://<ADFS>/adfs/services/trust`, где `<ADFS>` — это FQDN вашего AD FS сервера.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** выберите **POST**.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** укажите ссылку в формате `https://<ADFS>/adfs/ls/`, где `<ADFS>` — это FQDN вашего AD FS сервера.

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию. Если вы не включите эту опцию, федеративных пользователей потребуется [добавить вручную](../../operations/add-account.md#add-user-sso).

          {% include [fed-users-note](../../../_includes/organization/fed-users-note.md) %}

      1. {% include [forceauthn-option-enable](../../../_includes/organization/forceauthn-option-enable.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды создания федерации:

        ```
        yc organization-manager federation saml create --help
        ```

    1. Создайте федерацию:

        ```bash
        yc organization-manager federation saml create --name my-federation \
            --organization-id <идентификатор_организации> \
            --auto-create-account-on-login \
            --cookie-max-age 12h \
            --issuer "http://example.com/adfs/services/trust" \
            --sso-url "https://example.com/adfs/ls/" \            
            --sso-binding POST \
            --force-authn
        ```

        Где:

        * `--name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `--organization-id` — [идентификатор](../../operations/organization-get-id.md) организации. 
        * `--auto-create-account-on-login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `--cookie-max-age` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
        * `--issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

            Укажите ссылку в формате `http://<ADFS>/adfs/services/trust`, где `<ADFS>` — это FQDN вашего AD FS сервера.

        * `--sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Укажите ссылку в формате `https://<ADFS>/adfs/ls/`, где `<ADFS>` — это FQDN вашего AD FS сервера.

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `--sso-binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

        * {% include [forceauthn-cli-enable](../../../_includes/organization/forceauth-cli-enable.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. В конфигурационном файле опишите параметры федерации:

        * `name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `description` — описание федерации.
        * `organization_id` — [идентификатор](../../operations/organization-get-id.md) организации. 
        * `labels` — набор пар меток ключ/значение, которые присвоены федерации.
        * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

            Укажите ссылку в формате `http://<ADFS>/adfs/services/trust`, где `<ADFS>` — это FQDN вашего AD FS сервера. 
        
        * `sso_binding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.
        * `sso_url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Укажите ссылку в формате `https://<ADFS>/adfs/ls/`, где `<ADFS>` — это FQDN вашего AD FS сервера.

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `cookie_max_age` — время в секундах, в течение которого браузер не должен требовать у пользователя повторной аутентификации. Значение по умолчанию `8 часов`. 
        * `auto_create_account_on_login` — флаг, который активирует автоматическое создание новых пользователей в облаке после аутентификации на IdP-сервере. 
        Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.
        * `case_insensitive_name_ids` — зависимость имен пользователей от регистра.
           Если опция включена, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
        * `security_settings` — настройки безопасности федерации: 
          * `encrypted_assertions` — подписывать запросы аутентификации. 
            Если включить опцию, то все запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись. Вам потребуется скачать и установить сертификат {{ yandex-cloud }}.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_organizationmanager_saml_federation" federation {
      name            = "my-federation"
      organization_id = "<идентификатор_организации>"
      auto_create_account_on_login = "true"
      issuer          = "http://example.com/adfs/services/trust"
      sso_url         = "https://example.com/adfs/ls/"
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
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразятся параметры федерации. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Создайте федерацию.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
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
        "issuer": "http://example.com/adfs/services/trust",
        "ssoUrl": "https://example.com/adfs/ls/",
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

          Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию на вашем сервере. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `cookieMaxAge` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
      * `issuer` — идентификатор IdP-сервера, на котором должна происходить аутентификация.

          Укажите ссылку в формате `http://<ADFS>/adfs/services/trust`, где `<ADFS>` — это FQDN вашего AD FS сервера.

      * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Укажите ссылку в формате `https://<ADFS>/adfs/ls/`, где `<ADFS>` — это FQDN вашего AD FS сервера.

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `ssoBinding` — укажите тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

      * {% include [forceauthn-api-enable](../../../_includes/organization/forceauth-api-enable.md) %}

  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

{% note info %}

Чтобы принудительная повторная аутентификация (ForceAuthn) в IdP работала корректно, внесите изменения в настройки IdP-провайдера. Для этого на вашем сервере ADFS откройте консоль `PowerShell` и выполните команду:

```powershell
Get-AdfsRelyingPartyTrust -Name YC | Set-AdfsRelyingPartyTrust -AlwaysRequireAuthentication $true
```

{% endnote %}

## Добавьте сертификаты в федерацию {#add-certificate}

Когда поставщик удостоверений (IdP) сообщает {{ org-full-name }}, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис {{ org-name }} мог проверить этот сертификат, добавьте его в созданную федерацию.

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

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-cert-to-fed](../../../_includes/organization/add-cert-to-fed.md) %}

- CLI {#cli}

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

- API {#api}

  Чтобы добавить сертификат, воспользуйтесь методом [create](../../saml/api-ref/Certificate/create.md) для ресурса [Certificate](../../saml/api-ref/Certificate/index.md):

  1. Сформируйте тело запроса, указав содержимое сертификата в свойстве `data`:

      ```json
      {
        "federationId": "<ID_федерации>",
        "name": "my-certificate",
        "data": "MII...=="
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

Чтобы аутентификация не прерывалась в тот момент, когда у очередного сертификата закончился срок действия, рекомендуется добавлять в федерацию несколько сертификатов — текущий и те, которые будут использоваться после текущего. Если один сертификат окажется недействительным, {{ yandex-cloud }} попробует проверить подпись другим сертификатом.

{% endnote %}


## Настройте аутентификацию на сервере AD FS {#configure-sso}

После того как вы настроили федерацию в {{ org-full-name }}, вы можете настроить сервер AD FS так, чтобы он сообщал консоли управления о каждой успешной аутентификации и возвращал пользователя в консоль.

Инструкции в этом разделе написаны для ОС Windows Server 2016, для других версий шаги могут отличаться.

Чтобы настроить аутентификацию на сервере AD FS:

1. [Создайте отношение доверия с проверяющей стороной](#configure-relying-party-trust).

1. [Настройте Claims Mapping](#configure-claims-mapping).

### Создайте отношение доверия с проверяющей стороной {#configure-relying-party-trust}

AD FS требует создавать _отношение доверия с проверяющей стороной (relying party trust)_ для каждого поставщика услуг (Service Provider, SP), который будет использовать AD FS для аутентификации.

Создайте отношение доверия с проверяющей стороной для федерации, созданной в облаке:

1. Войдите на ваш сервер AD FS и откройте **Server Manager**.

1. Откройте консоль управления AD FS: **Tools** → **AD FS Management**.

1. В списке действий выберите **Add Relying Party Trust**.

1. Откроется окно помощника. На первой странице выберите **Claims aware** и нажмите **Start**.

1. Выберите **Enter data about the relying party manually** и нажмите **Next**.

1. Задайте имя, например <q>{{ yandex-cloud }}</q>, и нажмите **Next**.

1. На следующем шаге вас попросят указать сертификат для подписи токенов. Этот шаг необязательный, поэтому нажмите **Next**.

1. На шаге Configure URL выберите **Enable support for the SAML 2.0 WebSSO protocol** и укажите ACS URL, на который пользователи будут перенаправляться после аутентификации.

   {% cut "Как получить ID федерации" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}


   {% cut "Как получить ACS URL федерации" %}

   {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

   {% endcut %}



   ![image](../../../_assets/iam/federations/specify-console-sso-link.png)

   
   После этого нажмите **Next**.

1. На следующей странице введите в качестве идентификатора этот же URL для перенаправления и нажмите **Add**. После этого нажмите **Next**.

1. На следующей странице можно выбрать, кому будет доступна аутентификация с помощью этой федерации. По умолчанию выбрана политика **Permit for everyone**, которая разрешает доступ для всех пользователей.

    Вы можете выбрать другую политику. Например, чтобы разрешить доступ только для отдельной группы пользователей, выберите **Permit specific group** и нажмите на слово `<parameter>`, чтобы выбрать, для каких групп разрешить доступ. [Подробнее о политиках управления доступом](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

    ![image](../../../_assets/iam/federations/specify-access-policy-ad.png)

1. Нажмите **Next**.

1. На странице **Ready to Add Trust** проверьте введенные данные и нажмите **Close**.

### Настройте Claims Mapping {#configure-claims-mapping}

Когда служба AD FS аутентифицирует пользователя, она отправляет в {{ yandex-cloud }} SAML-сообщение с подтверждением успешной аутентификации. Сообщение обязательно должно содержать элемент Name ID, однозначно идентифицирующий пользователя, а также может содержать другие данные пользователя (имя, электронная почта и так далее). Для этого необходимо настроить соответствие атрибутов пользователя типам исходящих утверждений (Outgoing Claim Type). Типы персональных данных, которые поддерживает {{ org-full-name }}, приведены ниже.

Данные пользователя | Комментарий | Outgoing Claim Type
------------------- | ----------- | -------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуем использовать один из уникальных и неизменных атрибутов пользователя Active Directory: **User-Principal-Name**, **Object-Sid**, **Object-Guid** или адрес электронной почты. | Name ID 
Фамилия | Отображается в сервисах {{ yandex-cloud }}. Рекомендуется использовать атрибут **Surname**.<br> Ограничение значения по длине: {{ saml-limit-last-name }}. | Surname
Имя | Отображается в сервисах {{ yandex-cloud }}. Рекомендуется использовать атрибут **Given-Name**.<br> Ограничение значения по длине: {{ saml-limit-first-name }}. | Given Name
Полное имя | Отображается в сервисах {{ yandex-cloud }}. Пример: Иван Иванов.<br>Рекомендуется использовать атрибут **Display-Name**.<br> Ограничение значения по длине: {{ saml-limit-display-name }}. | Name
Почта | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}. Пример:&nbsp;`ivanov@example.com`<br>Рекомендуется использовать атрибут **E-Mail-Address**.<br> Ограничение значения по длине: {{ saml-limit-email }}. | E-Mail Address
Телефон | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}. Пример: +71234567890<br>Рекомендуется использовать атрибут `Telephone-Number`.<br> Ограничение значения по длине: {{ saml-limit-phone }}. | В поле **Outgoing Claim Type** введите `phone`
Аватар | Отображается в сервисах {{ yandex-cloud }}.<br>Рекомендуется использовать атрибут `thumbnailPhoto`. [Как добавить аватар](#add-avatar).<br> Ограничение значения по длине: {{ saml-limit-thumbnail-photo }}. | В поле **Outgoing Claim Type** введите `thumbnailPhoto`

{% note warning %}

В качестве идентификатора `Name ID` используйте только такие атрибуты пользователя Active Directory, значения которых уникальны и не будут изменены. Если значение `Name ID` пользователя федерации изменится, для такого пользователя потребуется создать новую учетную запись в федерации, а доступ к прежним настройкам и данным в {{ yandex-cloud }} будет потерян.

Значение атрибута `thumbnailPhoto`, превышающее ограничение по длине, игнорируется. Если значение другого атрибута превышает ограничения, то часть значения, выходящая за пределы ограничения, отбрасывается.

{% endnote %}

Чтобы настроить соответствие данных пользователя типам исходящих утверждений (Outgoing Claim Type):

1. В консоли управления AD FS в блоке **Relying Party Trusts** нажмите правой кнопкой мыши на созданном ранее отношении доверия с проверяющей стороной и выберите **Edit Claim Issuance Policy**.

1. В открывшемся окне нажмите **Add Rule**.

1. Выберите **Send LDAP Attributes as Claims** и нажмите **Next**.

1. На следующей странице настройте, какие данные будут передаваться в сообщении:

    1. В поле **Claim rule name** задайте имя правила, например `Claims mapping`

    1. В поле **Attribute Store** выберите **Active Directory**.

    1. Укажите, что будет передаваться в качестве Name ID — уникального идентификатора пользователя. Для этого добавьте строчку в списке **Mapping of LDAP attributes**:

        В столбце **LDAP Attribute** выберите атрибут, который обеспечит уникальность и неизменность идентификатора пользователя федерации: **User-Principal-Name**, **Object-Sid**, **Object-Guid** или **E-Mail-Addresses**.

        В столбце **Outgoing Claim Type** выберите **Name ID**.


    1. Чтобы пользователь мог обратиться в службу технической поддержки {{ yandex-cloud }} из [консоли управления]({{ link-console-support }}), добавьте адрес электронной почты (тип утверждения **E-Mail Address**) и имя пользователя (тип утверждения **Name**).


    1. Чтобы передавать отдельно имя и фамилию пользователя, добавьте типы утверждения **Given Name** и **Surname**.
	
	1. Чтобы добавить номер телефона или [аватар пользователя](#add-avatar), в поле **Outgoing Claim Type** вручную введите название типа: `phone` или `thumbnailPhoto`.

       ![image](../../../_assets/iam/federations/specify-claims-mapping-ad.png)

1. Нажмите **Finish**, затем нажмите **OK**, чтобы закрыть окно **Edit Claim Issuance Policy**.


#### Как добавить аватар в Active Directory {#add-avatar}

Чтобы добавить в Active Directory аватар пользователя, запишите изображение в атрибут `thumbnailPhoto` с помощью командной оболочки PowerShell. 

{% note info %}

Атрибут `thumbnailPhoto` поддерживает максимальный размер изображения 100 Кбайт. Рекомендуемый размер файла до 10 Кбайт, размер изображения до 96×96 пикселей.

{% endnote %}

1. Запустите командную оболочку PowerShell.

1. Подключите модуль Active Directory Module for Windows PowerShell с помощью команды: 
   
   ```
   Import-Module ActiveDirectory
   ```

1. Чтобы добавить аватар для одного пользователя, выполните команду:

   ```
   Set-ADUser <имя_пользователя> -Replace @{thumbnailPhoto=([byte[]](Get-Content "<путь_к_изображению>" -Encoding byte))}
   ```

1. Чтобы массово добавить аватары для пользователей:

   1. Подготовьте CSV-файл, в котором указаны имена пользователей и пути к изображениям.
   
      Пример CSV-файла:
	  
      ```csv
      AD_username, Photo
      smith, C:\Photo\smith.jpg
      jones, C:\Photo\jones.jpg
      ```
	  
   1. Выполните команду:
   
      ```
      Import-Csv <путь_к_CSV-файлу> |%{Set-ADUser -Identity $_.AD_username -Replace @{thumbnailPhoto=([byte[]](Get-Content $_.Photo -Encoding byte))}}
      ```
   
## Добавьте пользователей в организацию {#add-users}

Если при создании федерации вы не включили опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам необходимо знать Name ID пользователей, которые возвращает сервер поставщика удостоверений (IdP) вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает сервер в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

{% include [auto-create-users](../../../_includes/organization/auto-create-users.md) %}

Добавить пользователя может администратор (роль `organization-manager.admin`) или владелец (роль `organization-manager.organizations.owner`) организации. О том, как назначить пользователю роль, читайте в разделе [Роли](../../security/index.md#admin).

{% include [console-user-access](../../../_includes/organization/console-user-access.md) %}

Чтобы добавить пользователей федерации в организацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-users-to-fed](../../../_includes/organization/add-users-to-fed.md) %}

- CLI {#cli}

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
  1. Отправьте запрос, указав в параметрах идентификатор федерации:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<ID_федерации>:addUserAccounts
      ```

{% endlist %}

## Протестируйте аутентификацию {#test-auth}

Теперь, когда вы закончили настройку аутентификации с помощью Active Directory, проверьте ее работу:

1. Откройте браузер в гостевом режиме или режиме инкогнито для чистой симуляции нового пользователя.

1. Перейдите по URL для входа в консоль управления:

   ```
   {{ link-console-main }}/federations/<ID_федерации>
   ```

   {% cut "Как получить ID федерации" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   Браузер должен перенаправить вас на страницу аутентификации в AD FS, которая по умолчанию выглядит так:

   ![image](../../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Введите ваши данные для аутентификации. По умолчанию, необходимо ввести UPN и пароль. Затем нажмите кнопку **Sign in**.

1. После успешной аутентификации AD FS перенаправит вас по ACS URL, который вы указали в настройках сервера AD FS, а после этого — на главную страницу консоли управления. В правом верхнем углу вы можете увидеть, что вы вошли в консоль от имени аккаунта в Active Directory.

#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../../iam/operations/roles/grant.md).
