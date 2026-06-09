# Аутентификация с помощью {{ microsoft-idp.ad-short }}

С помощью [федерации удостоверений](../../../organization/concepts/add-federation.md) вы можете настроить систему единого входа (Single Sign-On, SSO) и использовать {{ microsoft-idp.ad-full }} совместно с [{{ microsoft-idp.adfs-full }}]({{ link-adfs }}) ({{ microsoft-idp.adfs-abbreviated }}) для аутентификации в облаке.

Чтобы настроить SSO:

1. [Создайте федерацию в организации](#create-federation).

1. [Укажите сертификаты для федерации](#add-certificate).

1. [Добавьте пользователей в организацию](#add-users).

1. [Протестируйте работу аутентификации](#test-auth).

## Перед началом работы {#before-you-begin}

Чтобы воспользоваться инструкциями в этом разделе, вам понадобятся:

1. Работающая ферма {{ microsoft-idp.adfs-abbreviated }}.

    Если у вас еще нет настроенной фермы {{ microsoft-idp.adfs-abbreviated }}, то выполните следующие действия для настройки:

    1. [Разверните и настройте {{ microsoft-idp.ad-short }} Domain Services (AD DS)](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-), если это еще не сделано. Наличие AD DS — необходимое условие для развертывания {{ microsoft-idp.adfs-abbreviated }}.
    1. [Разверните и настройте ферму {{ microsoft-idp.adfs-abbreviated }}](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/deploying-a-federation-server-farm) из одного или нескольких серверов.

        {% note tip %}

        Добавьте в ферму {{ microsoft-idp.adfs-abbreviated }} несколько серверов, чтобы обеспечить отказоустойчивость.

        Тогда SSO будет доступен, даже если отдельные серверы выйдут из строя.

        {% endnote %}

1. Действующий SSL-сертификат для использования в {{ microsoft-idp.adfs-abbreviated }}. Если у вас нет действующего сертификата, получите новый.

    Чтобы браузеры не блокировали страницу аутентификации при использовании SSO, сертификат должен удовлетворять следующим требованиям:

    * Устройства и пользователи в рамках леса {{ microsoft-idp.ad-short }} должны доверять сертификату.
    * [FQDN](../../../glossary/fqdn.md) фермы {{ microsoft-idp.adfs-abbreviated }} должен содержаться в свойстве `Subject Name` и расширении `Alternative Name` сертификата.

        {% cut "Как получить FQDN фермы" %}
        
        1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }}, откройте консоль PowerShell.
        
        1. Получите эндпоинт сервиса федераций:
           
            ```powershell
            Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
            ```
           
           Эндпоинт содержит в себе FQDN фермы {{ microsoft-idp.adfs-abbreviated }} и имеет следующий вид:
           
           ```text
           https://<FQDN_фермы_AD_FS>/adfs/ls/
           ```
        
        {% endcut %}

## Создайте федерацию в организации {#create-federation}

Чтобы создать федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-federation](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**.

  1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

  1. При необходимости добавьте описание.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

     {% cut "Как получить FQDN фермы" %}
     
     1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }}, откройте консоль PowerShell.
     
     1. Получите эндпоинт сервиса федераций:
        
         ```powershell
         Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
         ```
        
        Эндпоинт содержит в себе FQDN фермы {{ microsoft-idp.adfs-abbreviated }} и имеет следующий вид:
        
        ```text
        https://<FQDN_фермы_AD_FS>/adfs/ls/
        ```
     
     {% endcut %}

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** выберите **POST**.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

     В ссылке допустимо использовать только протоколы HTTP и HTTPS.

  1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию. Если эта опция выключена, то пользователь не сможет использовать {{ yandex-cloud }} до тех пор, пока его не [добавят в организацию вручную](../../../organization/operations/add-account.md#add-user-sso).

      Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

  1. Чтобы все запросы аутентификации от {{ yandex-cloud }} содержали цифровую подпись, включите опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**. Потребуется установить сертификат {{ yandex-cloud }} на стороне поставщика удостоверений.

      В появившемся блоке **Сертификаты SAML** появится информация о действующем SAML-сертификате {{ yandex-cloud }}.
      
      Нажмите ![ArrowDownToLine](../../../_assets/console-icons/arrow-down-to-line.svg) **Скачать** и сохраните скачанный файл сертификата. Он потребуется для установки на ваш IdP-сервер.
      
      {% note tip %}
      
      Следите за сроком действия сертификатов и устанавливайте новые сертификаты до истечения срока действия используемых. Перевыпущенный SAML-сертификат {{ yandex-cloud }} необходимо заранее [скачать и установить](../../../organization/operations/renew-yc-certificate.md) на стороне IdP-провайдера и в вашей федерации.
      
      {% endnote %}

      [Скачать и установить сертификат](../../../organization/operations/setup-federation.md#add-certificate-idp) {{ yandex-cloud }} вы можете и после создания федерации.

  1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.forceAuthn }}**, чтобы задать значение `true` для параметра [ForceAuthn](../../../organization/saml/api-ref/Federation/index.md) в запросе аутентификации SAML. При включении этой опции поставщик удостоверений (Identity Provider, IdP) запрашивает у пользователя аутентификацию по истечении сессии в {{ yandex-cloud }}. Необязательный параметр.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
          --issuer "http://example.com/adfs/services/trust" \
          --sso-url "https://example.com/adfs/ls/" \
          --sso-binding POST \
          --encrypted-assertions \
          --force-authn
        ```

        Где:

        * `--name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `--organization-id` — [идентификатор](../../../organization/operations/organization-get-id.md) организации.
        * `--auto-create-account-on-login` — опция, которая активирует автоматическое создание новых пользователей в облаке после аутентификации с помощью поставщика удостоверений (Identity Provider, IdP).

            Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию с помощью поставщика удостоверений. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `--cookie-max-age` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
        * `--issuer` — идентификатор поставщика удостоверений, с помощью которого будет происходить аутентификация.

            Укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

            {% cut "Как получить FQDN фермы" %}
            
            1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }}, откройте консоль PowerShell.
            
            1. Получите эндпоинт сервиса федераций:
               
                ```powershell
                Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
                ```
               
               Эндпоинт содержит в себе FQDN фермы {{ microsoft-idp.adfs-abbreviated }} и имеет следующий вид:
               
               ```text
               https://<FQDN_фермы_AD_FS>/adfs/ls/
               ```
            
            {% endcut %}

        * `--sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

            В ссылке допустимо использовать только протоколы HTTP и HTTPS.

        * `--sso-binding` — тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

        * (Опционально) `--encrypted-assertions` — флаг, который включает цифровую подпись запросов аутентификации.
          
          Если указано значение `true`, то все запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись.

            [Скачать и установить сертификат](../../../organization/operations/setup-federation.md#add-certificate-idp) {{ yandex-cloud }} вы можете и после создания федерации.

        * `--force-authn` — по истечении сессии в {{ yandex-cloud }} поставщик удостоверений запросит у пользователя повторную аутентификацию. Необязательный параметр.

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. В конфигурационном файле опишите параметры федерации.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_organizationmanager_saml_federation" federation {
        name            = "my-federation"
        organization_id = "<идентификатор_организации>"
        auto_create_account_on_login = "true"
        issuer          = "http://example.com/adfs/services/trust"
        sso_url         = "https://example.com/adfs/ls/"
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
      * `organization_id` — [идентификатор](../../../organization/operations/organization-get-id.md) организации.
      * `labels` — набор пар меток ключ/значение, которые присвоены федерации. Необязательный параметр.
      * `issuer` — идентификатор поставщика удостоверений (Identity Provider, IdP), с помощью которого будет происходить аутентификация.

          Укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

          {% cut "Как получить FQDN фермы" %}
          
          1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }}, откройте консоль PowerShell.
          
          1. Получите эндпоинт сервиса федераций:
             
              ```powershell
              Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
              ```
             
             Эндпоинт содержит в себе FQDN фермы {{ microsoft-idp.adfs-abbreviated }} и имеет следующий вид:
             
             ```text
             https://<FQDN_фермы_AD_FS>/adfs/ls/
             ```
          
          {% endcut %}

      * `sso_binding` — тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.
      * `sso_url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

          В ссылке допустимо использовать только протоколы HTTP и HTTPS.

      * `cookie_max_age` — время в секундах, в течение которого браузер не должен требовать у пользователя повторной аутентификации. Значение по умолчанию `8 часов`.
      * `auto_create_account_on_login` — опция, которая активирует автоматическое создание новых пользователей в облаке после аутентификации с помощью поставщика удостоверений.

          Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

          Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию с помощью поставщика удостоверений. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `case_insensitive_name_ids` — зависимость имен пользователей от регистра.
          Если опция включена, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
      * `security_settings` — настройки безопасности федерации:

          * `encrypted_assertions` — подписывать запросы аутентификации.
            
            Если включить эту опцию, то все запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись.

              [Скачать и установить сертификат](../../../organization/operations/setup-federation.md#add-certificate-idp) {{ yandex-cloud }} вы можете и после создания федерации.

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
        "issuer": "http://example.com/adfs/services/trust",
        "ssoUrl": "https://example.com/adfs/ls/",
        "ssoBinding": "POST",
        "securitySettings": {
          "encryptedAssertions": true,
          "forceAuthn": true
        }
      }
      ```

      Где:

      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `organizationId` — [идентификатор](../../../organization/operations/organization-get-id.md) организации.
      * `autoCreateAccountOnLogin` — опция, которая активирует автоматическое создание новых пользователей в облаке после аутентификации с помощью поставщика удостоверений (Identity Provider, IdP).

         Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

         Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию с помощью поставщика удостоверений. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `cookieMaxAge` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
      * `issuer` — идентификатор поставщика удостоверений, с помощью которого будет происходить аутентификация.

          Укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

          {% cut "Как получить FQDN фермы" %}
          
          1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }}, откройте консоль PowerShell.
          
          1. Получите эндпоинт сервиса федераций:
             
              ```powershell
              Get-AdfsEndpoint -AddressPath /adfs/ls/ | Select FullUrl
              ```
             
             Эндпоинт содержит в себе FQDN фермы {{ microsoft-idp.adfs-abbreviated }} и имеет следующий вид:
             
             ```text
             https://<FQDN_фермы_AD_FS>/adfs/ls/
             ```
          
          {% endcut %}

      * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

          В ссылке допустимо использовать только протоколы HTTP и HTTPS.

      * `ssoBinding` — тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

      * `encryptedAssertions` — флаг, который включает цифровую подпись запросов аутентификации.
        
        Если указано значение `true`, то все запросы аутентификации от {{ yandex-cloud }} будут содержать цифровую подпись.

        [Скачать и установить сертификат](../../../organization/operations/setup-federation.md#add-certificate-idp) {{ yandex-cloud }} вы можете и после создания федерации.

      * `forceAuthn` — параметр, который включает принудительную повторную аутентификацию пользователя по истечении сессии в {{ yandex-cloud }}. Необязательный параметр.

  1. Чтобы создать федерацию, воспользуйтесь методом REST API [create](../../../organization/saml/api-ref/Federation/create.md) для ресурса [Federation](../../../organization/saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Create](../../../organization/saml/api-ref/grpc/Federation/create.md) и передайте в запросе файл с параметрами запроса.
     
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

## Укажите сертификаты для федерации {#add-certificate}

Когда поставщик удостоверений сообщает {{ org-full-name }}, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис {{ org-full-name }} мог проверить этот сертификат, добавьте его в созданную федерацию:

1. Получите сертификат фермы {{ microsoft-idp.adfs-abbreviated }}:

    {% list tabs group=instructions %}

    - MMC-оснастка

        1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }} и откройте **Server Manager**.

        1. Откройте консоль управления {{ microsoft-idp.adfs-abbreviated }}: **Tools** → **AD FS Management**.

        1. В открывшемся окне в дереве слева нажмите **Services** → **Certificates**.

        1. Нажмите правой кнопкой мыши на сертификате в блоке **Token-signing** и выберите **View certificate**.

        1. В открывшемся окне перейдите на вкладку **Details**.

        1. Нажмите кнопку **Copy to file**.

        1. Нажмите кнопку **Next**.

        1. Выберите формат **Base-64 encoded X.509 (.CER)** и нажмите **Next**.

        1. Укажите, куда сохранить сертификат и с каким именем, и нажмите **Next**.

        1. Проверьте настройки экспорта сертификата и нажмите **Finish**.

    - PowerShell

        1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }}, откройте консоль PowerShell.

        1. Получите сертификат типа `Token-Signing` в формате Base64. Для этого выполните команды, указав путь, по которому нужно сохранить сертификат:

            ```powershell
            $ADFS_CERT_PATH = "<путь_к_сертификату>/adfs_certificate.cer"
            
            $TEMP_CERT = (Get-AdfsCertificate -CertificateType Token-Signing |
                            where {$_.IsPrimary -eq $true} | Select-Object -First 1
                         ).Certificate.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
            
            @(
                '-----BEGIN CERTIFICATE-----'
                [System.Convert]::ToBase64String($TEMP_CERT, 'InsertLineBreaks')
                '-----END CERTIFICATE-----'
            ) | Out-File -FilePath $ADFS_CERT_PATH -Encoding ascii
            
            ```
            
            Сертификат будет сохранен под именем `adfs_certificate.cer`.

    {% endlist %}

1. Добавьте сертификат фермы в федерацию:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
      
      1. На панели слева выберите ![VectorSquare](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
      
      1. Нажмите на строку с федерацией, для которой нужно добавить сертификат.
      
      1. Внизу страницы в блоке **{{ ui-key.yacloud_org.page.federation.section.certificates }}** нажмите кнопку **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.
      
      1. Введите название и описание сертификата.
      
      1. Выберите способ добавления сертификата:
      
          * Чтобы добавить сертификат в виде файла, нажмите **{{ ui-key.yacloud_portal.component.file-input.button_choose }}** и укажите путь к нему.
          * Чтобы вставить скопированное содержимое сертификата, выберите способ **{{ ui-key.yacloud_org.component.form-file-upload.method.manual }}** и вставьте содержимое.
      
      1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.add }}**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Посмотрите описание команды добавления сертификата:

          ```bash
          yc organization-manager federation saml certificate create --help
          ```

      1. Добавьте сертификат для федерации, указав путь к файлу сертификата:

          ```bash
          yc organization-manager federation saml certificate create --federation-name my-federation \
            --name "my-certificate" \
            --certificate-file test.pem
          ```

    - API {#api}

      Чтобы добавить сертификат, воспользуйтесь методом [create](../../../organization/saml/api-ref/Certificate/create.md) для ресурса [Certificate](../../../organization/saml/api-ref/Certificate/index.md):

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
          curl -X POST \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer ${IAM_TOKEN}" \
            -d '@body.json' \
            "https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates"
          ```

    {% endlist %}

{% note tip %}

Не забывайте своевременно перевыпускать сертификаты и добавлять их в федерацию.

Чтобы не пропустить момент окончания срока действия сертификата, [подпишитесь](../../../organization/operations/subscribe-user-for-notifications.md) на уведомления от организации. Уведомления направляются подписанным пользователям за 60, 30 и 5 дней до момента прекращения действия сертификата, а также после того, как сертификат становится недействительным.

{% endnote %}

Настройте ферму {{ microsoft-idp.adfs-abbreviated }} так, чтобы она сообщала {{ yandex-cloud }} о каждой успешной аутентификации и затем перенаправляла пользователя в консоль. Для настройки фермы потребуются сведения о федерации, которая [была создана ранее](#create-federation).

{% note info %}

Инструкции по настройке приведены для ОС Windows Server 2016, для других версий шаги могут отличаться.

{% endnote %}

Чтобы настроить ферму:

1. [Создайте отношение доверия с проверяющей стороной](#configure-relying-party-trust).

1. [Настройте Claims Mapping](#configure-claims-mapping).

### Создайте отношение доверия с проверяющей стороной {#configure-relying-party-trust}

Создайте _отношение доверия с проверяющей стороной (relying party trust)_, чтобы {{ yandex-cloud }} мог использовать {{ microsoft-idp.adfs-abbreviated }} для аутентификации:

1. Подключитесь к любому серверу в ферме {{ microsoft-idp.adfs-abbreviated }} и откройте **Server Manager**.

1. Откройте консоль управления {{ microsoft-idp.adfs-abbreviated }}: **Tools** → **AD FS Management**.

1. В списке действий выберите **Add Relying Party Trust**.

    Откроется окно помощника.

1. На шаге Welcome выберите **Claims aware** и нажмите **Start**.

1. На шаге Select Data Source выберите **Enter data about the relying party manually** и нажмите **Next**.

1. На шаге Specify Display Name задайте имя, например `{{ yandex-cloud }}`, и нажмите **Next**.

1. Пропустите шаг Configure Certificate, нажав кнопку **Next**. Сертификаты будут настроены позднее.

1. На шаге Configure URL выберите **Enable support for the SAML 2.0 WebSSO protocol** и укажите ACS URL, на который пользователи будут перенаправляться после аутентификации.

   {% cut "Как получить ID федерации" %}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![VectorSquare](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
   1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **{{ ui-key.yacloud_org.common.columns.column_id }}**.

   {% endcut %}

   
   {% cut "Как получить ACS URL федерации" %}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   
   1. На панели слева выберите ![VectorSquare](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
   
   1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **{{ ui-key.yacloud_org.entity.federation.field.acsUrl }}**.

   {% endcut %}


   ![image](../../../_assets/iam/federations/specify-console-sso-link.png)

   После этого нажмите **Next**.

1. На шаге Configure Identifiers введите в качестве идентификатора этот же URL для перенаправления и нажмите **Add**. После этого нажмите **Next**.

1. На шаге Choose Access Control Policy выберите, кому будет доступна аутентификация с помощью этой федерации. По умолчанию выбрана политика **Permit for everyone**, которая разрешает доступ для всех пользователей.

    Вы можете выбрать другую политику. Например, чтобы разрешить доступ только для отдельной группы пользователей, выберите **Permit specific group** и нажмите на слово `<parameter>`, чтобы выбрать, для каких групп разрешить доступ. [Подробнее о политиках управления доступом](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

    ![image](../../../_assets/iam/federations/specify-access-policy-ad.png)

    После выбора политики нажмите **Next**.

1. На шаге Ready to Add Trust проверьте введенные данные и нажмите **Close**.

1. (Опционально) Если при [создании федерации](#create-federation) в {{ org-full-name }} вы включили опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**, настройте связанные с этим параметры для отношения доверия:
   
   1. Откройте контекстное меню созданного отношения доверия и выберите пункт **Properties**.
   
       Откроется окно со свойствами отношения доверия.
   
   1. Перейдите на вкладку **Encryption** и добавьте скачанный [ранее](#create-federation) SAML-сертификат {{ yandex-cloud }} для подписи запросов аутентификации:
   
       1. Нажмите кнопку **Browse**.
       1. Выберите файл с сертификатом (например, `YandexCloud.cer`).
   
            Если вы не скачивали SAML-сертификат при создании федерации, вы можете скачать его на странице сведений о федерации в {{ org-full-name }}, нажав кнопку ![ArrowDownToLine](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.page.federation.action.download-cert }}** в поле **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**.
   
   1. Перейдите на вкладку **Signature** и добавьте этот же сертификат:
   
       1. Нажмите кнопку **Add**.
       1. Выберите файл с сертификатом.
   
   1. Нажмите кнопку **OK**.
   
   1. Включите обязательные шифрование утверждений и подпись запросов для созданного отношения доверия:
   
       ```powershell
       Set-AdfsRelyingPartyTrust `
           -TargetName "{{ yandex-cloud }}" `
           -EncryptClaims $true `
           -SignedSamlRequestsRequired $true `
           -SamlResponseSignature MessageAndAssertion
       ```

1. (Опционально) Если при [создании федерации](#create-federation) в {{ org-full-name }} вы включили опцию **{{ ui-key.yacloud_org.entity.federation.field.forceAuthn }}**, то включите принудительное требование аутентификации на стороне отношения доверия:

    ```powershell
    Set-AdfsRelyingPartyTrust `
        -TargetName "{{ yandex-cloud }}" `
        -AlwaysRequireAuthentication $true
    ```

### Настройте Claims Mapping {#configure-claims-mapping}

Когда служба {{ microsoft-idp.adfs-abbreviated }} аутентифицирует пользователя, она отправляет в {{ yandex-cloud }} SAML-сообщение с подтверждением успешной аутентификации. Сообщение обязательно должно содержать элемент `Name ID`, однозначно идентифицирующий пользователя, а также может содержать другие данные пользователя (имя, электронная почта и так далее). Для этого необходимо настроить соответствие атрибутов пользователя типам исходящих утверждений (Outgoing Claim Type).

#### Изучите перечень данных, атрибутов и типов исходящих утверждений {#explore-claims-list}

Данные пользователя | Комментарий | Outgoing Claim Type
------------------- | ----------- | -------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуем использовать один из уникальных и неизменных атрибутов пользователя {{ microsoft-idp.ad-short }}: **User-Principal-Name**, **Object-Sid**, **Object-Guid** или адрес электронной почты. | `Name ID`
Перечень групп, к которым принадлежит пользователь | Этот перечень используется для сопоставления групп при аутентификации пользователя в {{ yandex-cloud }}.<br><br>Используйте атрибут из семейства `Token-Groups`.<br><br>В зависимости от выбранного атрибута формат, в котором передается перечень групп, будет разным.<br>Например, при использовании `Token-Groups - Unqualified Names` будут передаваться короткие имена групп (например `adfs_group`, `Domain Users`) без указания их принадлежности к домену.<br><br>Пример настройки сопоставления групп см. в разделе [{#T}](../../../organization/tutorials/federations/group-mapping/adfs.md). | `Group`
Фамилия | Отображается в сервисах {{ yandex-cloud }}. Рекомендуется использовать атрибут **Surname**.<br> Ограничение значения по длине: {{ saml-limit-last-name }}. | `Surname`
Имя | Отображается в сервисах {{ yandex-cloud }}. Рекомендуется использовать атрибут **Given-Name**.<br> Ограничение значения по длине: {{ saml-limit-first-name }}. | `Given Name`
Полное имя | Отображается в сервисах {{ yandex-cloud }}. Пример: Иван Иванов.<br>Рекомендуется использовать атрибут **Display-Name**.<br> Ограничение значения по длине: {{ saml-limit-display-name }}. | `Name`
Почта | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}. Пример:&nbsp;`ivanov@example.com`<br>Рекомендуется использовать атрибут **E-Mail-Address**.<br> Ограничение значения по длине: {{ saml-limit-email }}. | `E-Mail Address`
Телефон | Используется для отправки уведомлений из сервисов {{ yandex-cloud }}. Пример: +71234567890<br>Рекомендуется использовать атрибут `Telephone-Number`.<br> Ограничение значения по длине: {{ saml-limit-phone }}. | `phone`
Аватар | Отображается в сервисах {{ yandex-cloud }}.<br>Рекомендуется использовать атрибут `thumbnailPhoto`. [Как добавить аватар](#add-avatar).<br> Ограничение значения по длине: {{ saml-limit-thumbnail-photo }}. | `thumbnailPhoto`

#### Настройте сопоставления для атрибутов и утверждений {#do-claims-mapping}

{% note info %}

В {{ yandex-cloud }} действуют [ограничения на длину значений некоторых атрибутов](#explore-claims-list), в которых содержатся данные пользователя.

Если длина значения превышает ограничение, то часть значения, выходящая за ограничение, будет отброшена.

Исключение — атрибут `thumbnailPhoto`, в котором хранится [аватар пользователя](#add-avatar). Если значение этого атрибута превышает ограничение, то оно будет отброшено полностью и аватар не будет загружен.

{% endnote %}

Настройте сопоставления:

1. В консоли управления {{ microsoft-idp.adfs-abbreviated }} в блоке **Relying Party Trusts** нажмите правой кнопкой мыши на созданном ранее отношении доверия с проверяющей стороной и выберите **Edit Claim Issuance Policy**.

1. В открывшемся окне нажмите **Add Rule**.

1. Выберите **Send LDAP Attributes as Claims** и нажмите **Next**.

1. На следующей странице настройте, какие данные будут передаваться в сообщении:

    1. В поле **Claim rule name** задайте имя правила, например `Claims mapping`.

    1. В поле **Attribute Store** выберите **Active Directory**.

    1. Настройте сопоставление для обязательного утверждения `Name ID`, добавив запись в списке **Mapping of LDAP attributes**:

        1. Выберите тип утверждения `Name ID` в столбце **Outgoing Claim Type**.
        1. Выберите нужный атрибут в столбце **LDAP Attribute**.

            Вы можете выбрать либо [один из рекомендуемых атрибутов](#explore-claims-list), либо другой атрибут. Выбранный атрибут должен быть неизменным и уникальным, чтобы можно было однозначно идентифицировать пользователя по этому атрибуту.

            {% note warning %}

            Если значение идентификатора пользователя изменится, то для такого пользователя придется создать новую учетную запись в федерации, а доступ к прежним настройкам и данным в {{ yandex-cloud }} будет потерян.

            {% endnote %}

    1. Аналогичным образом настройте сопоставление для утверждения `Group`, если вы используете [сопоставление групп пользователей](../../../organization/concepts/add-federation.md#group-mapping).

    
    1. Аналогичным образом настройте сопоставления для утверждений `Name` и `E-Mail Address`, если нужно, чтобы пользователь мог обратиться в службу технической поддержки {{ yandex-cloud }} из [консоли управления]({{ link-console-support }}).


    1. (Опционально) Аналогичным образом настройте сопоставления для других утверждений. Конкретный перечень сопоставлений зависит от того, какие [данные пользователя](#explore-claims-list) нужно передать на сторону {{ yandex-cloud }} после прохождения аутентификации.

        {% cut "Как сохранить изображение с аватаром пользователя в атрибут `thumbnailPhoto`" %} {#add-avatar}

        1. Подготовьте изображения для использования в качестве аватара.

            Убедитесь, что изображение удовлетворяет требованиям:

            * Максимальный размер файла с изображением — 100 Кбайт.
            * Рекомендуемый размер файла с изображением — до 10 Кбайт, размер изображения — до 96×96 пикселей.

        1. Запустите консоль PowerShell.

        1. Подключите модуль Active Directory Module for Windows PowerShell с помощью команды:

            ```powershell
            Import-Module ActiveDirectory
            ```

        1. Чтобы добавить аватар для одного пользователя, выполните команду:

            ```powershell
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

                ```powershell
                Import-Csv <путь_к_CSV-файлу> |%{Set-ADUser -Identity $_.AD_username -Replace @{thumbnailPhoto=([byte[]](Get-Content $_.Photo -Encoding byte))}}
                ```

        {% endcut %}

        Если нужно настроить сопоставления для `phone` и `thumbnailPhoto`, то введите названия этих типов исходящих утверждений вручную в поле **Outgoing Claim Type**. Эти типы нельзя выбрать из выпадающего списка:

        ![image](../../../_assets/iam/federations/specify-claims-mapping-ad.png)

1. Нажмите **Finish**, затем нажмите **OK**, чтобы закрыть окно **Edit Claim Issuance Policy**.

## Добавьте пользователей в организацию {#add-users}

Если при создании федерации вы не включили опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам необходимо знать Name ID пользователей, которые возвращает поставщик удостоверений вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает поставщик в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

При включенной опции **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** в федерацию будут добавлены только пользователи, которые впервые авторизуются в облаке. Если федеративный пользователь был удален, добавить его повторно можно только вручную.

Добавить пользователя может администратор (роль `organization-manager.admin`) или владелец (роль `organization-manager.organizations.owner`) организации. О том, как назначить пользователю роль, читайте в разделе [Роли](../../../organization/security/index.md#add-role).

{% note info %}

Для доступа пользователя к [консоли управления]({{ link-console-main }}), назначьте ему роль на [облако](../../../organization/security/index.md#access-binding-cloud) или [организацию](../../../organization/security/index.md#access-binding-organization). Для безопасности вы можете назначить одну из ролей с минимальными привилегиями, например `resource-manager.clouds.member`, но также можно назначить и другие роли, если вы знаете, какие права вы хотите предоставить приглашенным пользователям.

Чтобы дать эти права сразу всем пользователям в организации, назначьте роль [системной группе](../../../iam/concepts/access-control/system-group.md#allOrganizationUsers) `All users in organization X`. При работе с CLI или API назначение дополнительных ролей не требуется.

{% endnote %}

Чтобы добавить пользователей федерации в организацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  
  1. На панели слева выберите ![icon-users](../../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.
  
  1. В правом верхнем углу нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.users.dropdown.button-text }}** и в выпадающем списке выберите ![key](../../../_assets/console-icons/key.svg) **{{ ui-key.yacloud_org.page.users.action.add-federated-users }}**.
  
  1. В поле **{{ ui-key.yacloud_org.form.users.federated.add.field.federation }}** выберите федерацию удостоверений, из которой необходимо добавить пользователей.
  
  1. В поле **{{ ui-key.yacloud_org.form.users.federated.add.field.users }}** перечислите Name ID пользователей, разделяя их пробелами или переносами строк.
  
  1. Нажмите **{{ ui-key.yacloud_components.organization.action.add }}**. Пользователи будут подключены к организации.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды добавления пользователей:

      ```bash
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Добавьте пользователей, перечислив их Name ID через запятую:

      ```bash
      yc organization-manager federation saml add-user-accounts --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

- API {#api}

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

## Протестируйте работу аутентификации {#test-auth}

Теперь, когда вы закончили настройку SSO, проверьте работу аутентификации:

1. Откройте браузер в гостевом режиме или режиме инкогнито для чистой симуляции нового пользователя.

1. Перейдите по URL для входа в консоль управления:

   ```url
   {{ link-console-main }}/federations/<ID_федерации>
   ```

   {% cut "Как получить ID федерации" %}

   1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
   1. На панели слева выберите ![VectorSquare](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.
   1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **{{ ui-key.yacloud_org.common.columns.column_id }}**.

   {% endcut %}

   Браузер должен перенаправить вас на страницу аутентификации в {{ microsoft-idp.adfs-abbreviated }}, которая по умолчанию выглядит так:

   ![image](../../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Введите ваши данные для аутентификации. По умолчанию необходимо ввести UPN и пароль. Затем нажмите кнопку **Sign in**.

1. После успешной аутентификации {{ microsoft-idp.adfs-abbreviated }} перенаправит вас по ACS URL, который вы указали в настройках отношения доверия {{ microsoft-idp.adfs-abbreviated }}, а после этого — на главную страницу консоли управления. В правом верхнем углу вы можете увидеть, что вы вошли в консоль от имени аккаунта в {{ microsoft-idp.ad-short }}.

## Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../../iam/operations/roles/grant.md).