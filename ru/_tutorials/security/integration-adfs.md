# Аутентификация с помощью {{ microsoft-idp.ad-short }}

С помощью [федерации удостоверений](../../organization/concepts/add-federation.md) вы можете настроить систему единого входа (Single Sign-On, SSO) и использовать {{ microsoft-idp.ad-full }} совместно с [{{ microsoft-idp.adfs-full }}]({{ link-adfs }}) ({{ microsoft-idp.adfs-abbreviated }}) для аутентификации в облаке.

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
    * [FQDN](../../glossary/fqdn.md) фермы {{ microsoft-idp.adfs-abbreviated }} должен содержаться в свойстве `Subject Name` и расширении `Alternative Name` сертификата.

        {% include [get-adfs-farm-fqdn](../../_includes/organization/get-adfs-farm-fqdn.md) %}

## Создайте федерацию в организации {#create-federation}

Чтобы создать федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-federation](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**.

  1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

  1. При необходимости добавьте описание.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

     {% include [get-adfs-farm-fqdn](../../_includes/organization/get-adfs-farm-fqdn.md) %}

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** выберите **POST**.

  1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

     {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

  1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы аутентифицированный пользователь автоматически добавлялся в организацию. Если эта опция выключена, то пользователь не сможет использовать {{ yandex-cloud }} до тех пор, пока его не [добавят в организацию вручную](../../organization/operations/add-account.md#add-user-sso).

      {% include [fed-users-note](../../_includes/organization/fed-users-note.md) %}

  1. {% include [encrypted-assertions-console](../../_includes/organization/encrypted-assertions-console.md) %}

      {% include [download-saml-cert-when-creating-fed](../../_includes/organization/download-saml-cert-when-creating-fed.md) %}

      {% include [setup-cert-for-idp](../../_includes/organization/setup-cert-for-idp.md) %}

  1. {% include [forceauthn-option-enable](../../_includes/organization/forceauthn-option-enable.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
        * `--organization-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации.
        * `--auto-create-account-on-login` — опция, которая активирует автоматическое создание новых пользователей в облаке после аутентификации с помощью поставщика удостоверений (Identity Provider, IdP).

            Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

            Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию с помощью поставщика удостоверений. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

        * `--cookie-max-age` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
        * `--issuer` — идентификатор поставщика удостоверений, с помощью которого будет происходить аутентификация.

            Укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

            {% include [get-adfs-farm-fqdn](../../_includes/organization/get-adfs-farm-fqdn.md) %}

        * `--sso-url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

            Укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

            {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

        * `--sso-binding` — тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

        * {% include [encrypted-assertions-cli](../../_includes/organization/encrypted-assertions-cli.md) %}

            {% include [setup-cert-for-idp](../../_includes/organization/setup-cert-for-idp.md) %}

        * {% include [forceauthn-cli-enable](../../_includes/organization/forceauth-cli-enable.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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
      * `organization_id` — [идентификатор](../../organization/operations/organization-get-id.md) организации.
      * `labels` — набор пар меток ключ/значение, которые присвоены федерации.
      * `issuer` — идентификатор поставщика удостоверений (Identity Provider, IdP), с помощью которого будет происходить аутентификация.

          Укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

          {% include [get-adfs-farm-fqdn](../../_includes/organization/get-adfs-farm-fqdn.md) %}

      * `sso_binding` — тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.
      * `sso_url` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

          {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

      * `cookie_max_age` — время в секундах, в течение которого браузер не должен требовать у пользователя повторной аутентификации. Значение по умолчанию `8 часов`.
      * `auto_create_account_on_login` — опция, которая активирует автоматическое создание новых пользователей в облаке после аутентификации с помощью поставщика удостоверений.

          Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

          Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию с помощью поставщика удостоверений. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `case_insensitive_name_ids` — зависимость имен пользователей от регистра.
          Если опция включена, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
      * `security_settings` — настройки безопасности федерации:

          * {% include [encrypted-assertions-tf](../../_includes/organization/encrypted-assertions-tf.md) %}

              {% include [setup-cert-for-idp](../../_includes/organization/setup-cert-for-idp.md) %}

          * {% include [force-authn-tf](../../_includes/organization/force-authn-tf.md) %}

      {% include [organizationmanager_saml_federation-tf](../../_includes/organization/organizationmanager_saml_federation-tf.md) %}

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
      * `organizationId` — [идентификатор](../../organization/operations/organization-get-id.md) организации.
      * `autoCreateAccountOnLogin` — опция, которая активирует автоматическое создание новых пользователей в облаке после аутентификации с помощью поставщика удостоверений (Identity Provider, IdP).

         Опция упрощает процесс заведения пользователей, но созданный таким образом пользователь не сможет выполнять никаких операций с ресурсами в облаке. Исключение — те ресурсы, на которые назначены роли [публичной группе](../../iam/concepts/access-control/public-group.md) `All users` или `All authenticated users`.

         Если опцию не включать, то пользователь, которого не добавили в организацию, не сможет войти в консоль управления, даже если пройдет аутентификацию с помощью поставщика удостоверений. В этом случае вы можете управлять списком пользователей, которым разрешено пользоваться ресурсами {{ yandex-cloud }}.

      * `cookieMaxAge` — время, в течение которого браузер не должен требовать у пользователя повторной аутентификации.
      * `issuer` — идентификатор поставщика удостоверений, с помощью которого будет происходить аутентификация.

          Укажите ссылку в формате `http://<FQDN_фермы_AD_FS>/adfs/services/trust`.

          {% include [get-adfs-farm-fqdn](../../_includes/organization/get-adfs-farm-fqdn.md) %}

      * `ssoUrl` — URL-адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

          Укажите ссылку в формате `https://<FQDN_фермы_AD_FS>/adfs/ls/`.

          {% include [ssourl_protocol](../../_includes/organization/ssourl_protocol.md) %}

      * `ssoBinding` — тип привязки для Single Sign-on. Большинство поставщиков поддерживают тип привязки `POST`.

      * {% include [encrypted-assertions-api](../../_includes/organization/encrypted-assertions-api.md) %}

        {% include [setup-cert-for-idp](../../_includes/organization/setup-cert-for-idp.md) %}

      * {% include [forceauthn-api-enable](../../_includes/organization/forceauth-api-enable.md) %}

  1. {% include [include](../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Укажите сертификаты для федерации {#add-certificate}

Когда поставщик удостоверений сообщает {{ org-full-name }}, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис {{ org-name }} мог проверить этот сертификат, добавьте его в созданную федерацию:

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

            {% include [adfs-cert-guide-powershell](../../_includes/organization/adfs-cert-guide-powershell.md) %}

    {% endlist %}

1. Добавьте сертификат фермы в федерацию:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

      {% include [add-cert-to-fed](../../_includes/organization/add-cert-to-fed.md) %}

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

      Чтобы добавить сертификат, воспользуйтесь методом [create](../../organization/saml/api-ref/Certificate/create.md) для ресурса [Certificate](../../organization/saml/api-ref/Certificate/index.md):

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

{% include [federation-certificates-note](../../_includes/organization/federation-certificates-note.md) %}

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

   {% include [get-federation-id](../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   
   {% cut "Как получить ACS URL федерации" %}

   {% include [get-acs-url](../../_includes/organization/get-acs-url.md) %}

   {% endcut %}


   ![image](../../_assets/iam/federations/specify-console-sso-link.png)

   После этого нажмите **Next**.

1. На шаге Configure Identifiers введите в качестве идентификатора этот же URL для перенаправления и нажмите **Add**. После этого нажмите **Next**.

1. На шаге Choose Access Control Policy выберите, кому будет доступна аутентификация с помощью этой федерации. По умолчанию выбрана политика **Permit for everyone**, которая разрешает доступ для всех пользователей.

    Вы можете выбрать другую политику. Например, чтобы разрешить доступ только для отдельной группы пользователей, выберите **Permit specific group** и нажмите на слово `<parameter>`, чтобы выбрать, для каких групп разрешить доступ. [Подробнее о политиках управления доступом](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

    ![image](../../_assets/iam/federations/specify-access-policy-ad.png)

    После выбора политики нажмите **Next**.

1. На шаге Ready to Add Trust проверьте введенные данные и нажмите **Close**.

1. {% include [adfs-postinstall-setup-additional-encryption-settings](../../_includes/organization/adfs-postinstall-setup-additional-encryption-settings.md) %}

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
Перечень групп, к которым принадлежит пользователь | Этот перечень используется для сопоставления групп при аутентификации пользователя в {{ yandex-cloud }}.<br><br>Используйте атрибут из семейства `Token-Groups`.<br><br>В зависимости от выбранного атрибута формат, в котором передается перечень групп, будет разным.<br>Например, при использовании `Token-Groups - Unqualified Names` будут передаваться короткие имена групп (например `adfs_group`, `Domain Users`) без указания их принадлежности к домену.<br><br>Пример настройки сопоставления групп см. в разделе [{#T}](../../organization/tutorials/federations/group-mapping/adfs.md). | `Group`
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

    1. Аналогичным образом настройте сопоставление для утверждения `Group`, если вы используете [сопоставление групп пользователей](../../organization/concepts/add-federation.md#group-mapping).

    
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

        ![image](../../_assets/iam/federations/specify-claims-mapping-ad.png)

1. Нажмите **Finish**, затем нажмите **OK**, чтобы закрыть окно **Edit Claim Issuance Policy**.

## Добавьте пользователей в организацию {#add-users}

Если при создании федерации вы не включили опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам необходимо знать Name ID пользователей, которые возвращает поставщик удостоверений вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает поставщик в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

{% include [auto-create-users](../../_includes/organization/auto-create-users.md) %}

Добавить пользователя может администратор (роль `organization-manager.admin`) или владелец (роль `organization-manager.organizations.owner`) организации. О том, как назначить пользователю роль, читайте в разделе [Роли](../../organization/security/index.md#admin).

{% include [console-user-access](../../_includes/organization/console-user-access.md) %}

Чтобы добавить пользователей федерации в организацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-users-to-fed](../../_includes/organization/add-users-to-fed.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

   {% include [get-federation-id](../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   Браузер должен перенаправить вас на страницу аутентификации в {{ microsoft-idp.adfs-abbreviated }}, которая по умолчанию выглядит так:

   ![image](../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Введите ваши данные для аутентификации. По умолчанию необходимо ввести UPN и пароль. Затем нажмите кнопку **Sign in**.

1. После успешной аутентификации {{ microsoft-idp.adfs-abbreviated }} перенаправит вас по ACS URL, который вы указали в настройках отношения доверия {{ microsoft-idp.adfs-abbreviated }}, а после этого — на главную страницу консоли управления. В правом верхнем углу вы можете увидеть, что вы вошли в консоль от имени аккаунта в {{ microsoft-idp.ad-short }}.

## Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../../iam/operations/roles/grant.md).
