# Настроить федерацию удостоверений

Вы можете настроить аутентификацию пользователей в облаке через [федерацию удостоверений](../concepts/add-federation.md). Федерации удостоверений совместимы с любыми поставщиками удостоверений (IdP), которые поддерживают стандарт [SAML 2.0](https://wiki.oasis-open.org/security/FrontPage).

Для настройки аутентификации через федерацию удостоверений, у вас должна быть _минимальная_ [роль](../security/index.md#organization-manager-federations-editor) `organization-manager.federations.editor` на [организацию](../concepts/organization.md).

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
* [Microsoft Entra ID](../tutorials/federations/integration-azure.md).
* [Keycloak](../tutorials/federations/integration-keycloak.md).

## Создать федерацию удостоверений {#create-federation}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.

  1. Нажмите кнопку ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **Создать федерацию**.

  1. Задайте имя федерации. Имя должно быть уникальным в каталоге.

  1. (Опционально) Добавьте описание федерации.

  1. В поле **Время жизни cookie** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.

  1. В поле **IdP Issuer** укажите идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя. Формат идентификатора зависит от типа IdP-сервера.

      Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

  1. В поле **Single Sign-On метод** выберите метод перенаправления пользователя на IdP-сервер. Большинство поставщиков удостоверений поддерживает метод **POST**.

  1. В поле **Ссылка на страницу для входа в IdP** укажите адрес страницы, на которую браузер должен перенаправить пользователя для аутентификации.

      Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

      В ссылке допустимо использовать только протоколы HTTP и HTTPS.

  1. В поле **Дополнительно** при необходимости выберите опции:

        * **Автоматически создавать пользователей** — аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](add-account.md#add-user-sso).

            Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

        * **Подписывать запросы аутентификации** — запросы аутентификации от Yandex Cloud будут содержать цифровую подпись. Потребуется установить SAML-сертификат Yandex Cloud на стороне поставщика удостоверений.

            В появившемся блоке **Сертификаты SAML** появится информация о действующем SAML-сертификате Yandex Cloud.
            
            Нажмите ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **Скачать** и сохраните скачанный файл сертификата. Он потребуется для установки на ваш IdP-сервер.
            
            {% note tip %}
            
            Следите за сроком действия сертификатов и устанавливайте новые сертификаты до истечения срока действия используемых. Перевыпущенный SAML-сертификат Yandex Cloud необходимо заранее [скачать и установить](renew-yc-certificate.md) на стороне IdP-провайдера и в вашей федерации.
            
            {% endnote %}

        * **Регистронезависимые имена пользователей** — идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
        * **Принудительная повторная аутентификация (ForceAuthn) в IdP** — по истечении сессии в Yandex Cloud поставщик удостоверений запросит у пользователя повторную аутентификацию.

  1. Нажмите кнопку **Создать федерацию**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

        * `--name` — имя федерации. Имя должно быть уникальным в каталоге.
        * `--organization-id` — идентификатор организации.
        * `--cookie-max-age` — время, в течение которого браузер не будет требовать у пользователя повторной аутентификации, например: `12h`.
        * `--issuer` — идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя.

            Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

        * `--sso-binding` — тип привязки для Single Sign-on. Возможные значения — `POST` или `REDIRECT`. Большинство поставщиков поддерживают тип привязки `POST`.
        * `--sso-url` — URL-адрес страницы, на которую браузер перенаправит пользователя для аутентификации.

            Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

            В ссылке допустимо использовать только протоколы HTTP и HTTPS.

        * `--encrypted-assertions` — запросы аутентификации от Yandex Cloud будут содержать цифровую подпись. Потребуется установить сертификат Yandex Cloud на стороне поставщика удостоверений. Необязательный параметр.
        * `--auto-create-account-on-login` — аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](add-account.md#add-user-sso). Необязательный параметр.

            Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

        * `--case-insensitive-name-ids` — идентификаторы имен федеративных пользователей будут нечувствительны к регистру. Необязательный параметр.
        * `--force-authn` — по истечении сессии в Yandex Cloud поставщик удостоверений запросит у пользователя повторную аутентификацию. Необязательный параметр.

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  1. Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

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
          force_authn          = "<true_или_false>"
        }
      }
      ```

      Где:

      * `name` — имя федерации. Имя должно быть уникальным в каталоге.
      * `description` — описание федерации. Необязательный параметр.
      * `organization_id` — идентификатор организации.
      * `issuer` — идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя.

          Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

      * `sso_binding` — тип привязки для Single Sign-on. Возможные значения — `POST` или `REDIRECT`. Большинство поставщиков поддерживают тип привязки `POST`.
      * `sso_url` — URL-адрес страницы, на которую браузер перенаправит пользователя для аутентификации.

          Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

          В ссылке допустимо использовать только протоколы HTTP и HTTPS.

      * `cookie_max_age` — время в секундах, в течение которого браузер не будет требовать у пользователя повторной аутентификации. По умолчанию — `28800` (8 часов).
      * `auto_create_account_on_login` — если `true`, аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](add-account.md#add-user-sso).

          Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

      * `case_insensitive_name_ids` — если `true`, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
      * `security_settings` — настройки безопасности федерации:

          * `encrypted_assertions` — запросы аутентификации от Yandex Cloud будут содержать цифровую подпись. Потребуется установить сертификат Yandex Cloud на стороне поставщика удостоверений.

          * `force-authn` — по истечении сессии в Yandex Cloud поставщик удостоверений запросит у пользователя повторную аутентификацию. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_organizationmanager_saml_federation` смотрите в [документации провайдера](../../terraform/resources/organizationmanager_saml_federation.md).

  1. Проверьте корректность файлов конфигурации Terraform:

       1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
       1. Выполните команду:
       
          ```bash
          terraform validate
          ```
       
          Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Создайте федерацию:

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.

  Проверить появление федерации и ее настройки можно в организации в разделе [Федерации](https://org.yandex.cloud/federations).

  {% note info %}

  Вы также можете воспользоваться [полным решением по развертыванию федерации на базе Keycloak](https://github.com/yandex-cloud-examples/yc-iam-federation-with-keycloak-vm) с использованием Terraform.

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
      * `description` — описание федерации. Необязательный параметр.
      * `cookieMaxAge` — время в секундах, в течение которого браузер не будет требовать у пользователя повторной аутентификации. По умолчанию — `28800` (8 часов).
      * `issuer` — идентификатор IdP-сервера, на котором будет происходить аутентификация пользователя.

            Чтобы узнать, как получить идентификатор IdP-сервера, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

      * `ssoUrl` — URL-адрес страницы, на которую браузер перенаправит пользователя для аутентификации.

          Чтобы узнать, как получить адрес страницы для перенаправления, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

          В ссылке допустимо использовать только протоколы HTTP и HTTPS.

      * `ssoBinding` — тип привязки для Single Sign-on. Возможные значения — `POST` или `REDIRECT`. Большинство поставщиков поддерживают тип привязки `POST`.
      * `autoCreateAccountOnLogin` — если `true`, аутентифицированные через федерацию пользователи будут автоматически добавлены в организацию. Если опция не выбрана, федеративных пользователей потребуется [добавить вручную](add-account.md#add-user-sso).

          Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

      * `caseInsensitiveNameIds` — если `true`, идентификаторы имен федеративных пользователей будут нечувствительны к регистру.
      * `encryptedAssertions` — если `true`, запросы аутентификации от Yandex Cloud будут содержать цифровую подпись. Потребуется установить сертификат Yandex Cloud на стороне поставщика удостоверений.
      * `forceAuthn` — параметр, который включает принудительную повторную аутентификацию пользователя по истечении сессии в Yandex Cloud. Необязательный параметр.

  1. Чтобы создать федерацию, воспользуйтесь методом REST API [create](../saml/api-ref/Federation/create.md) для ресурса [Federation](../saml/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Create](../saml/api-ref/grpc/Federation/create.md) и передайте в запросе файл с параметрами запроса.
     
     Пример запроса:
     
     ```bash
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer <IAM-токен>" \
       --data '@body.json' \
       https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations
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

## Передать сертификат IdP-сервера в федерацию {#add-certificate-fed}

Когда поставщик удостоверений (IdP) сообщает Yandex Identity Hub, что пользователь прошел аутентификацию, он подписывает сообщение своим сертификатом. Чтобы сервис Yandex Identity Hub мог проверить этот сертификат, добавьте его в созданную федерацию:

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

    - Интерфейс Cloud Center {#cloud-center}

      1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

      1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.

      1. Нажмите на строку с федерацией, для которой нужно добавить сертификат.

      1. Внизу страницы в блоке **Сертификаты** нажмите кнопку **Добавить сертификат**.

      1. Введите название и описание сертификата.

      1. Выберите способ добавления сертификата:

          * Чтобы добавить сертификат в виде файла, нажмите **Выбрать файл** и укажите путь к нему.
          * Чтобы вставить скопированное содержимое сертификата, выберите способ **Текст**.

      1. Нажмите кнопку **Добавить**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Посмотрите описание команды добавления сертификата:

          ```bash
          yc organization-manager federation saml certificate create --help
          ```

      1. Добавьте сертификат для федерации, указав путь к файлу сертификата:

          ```bash
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

      1. Воспользуйтесь методом REST API [create](../saml/api-ref/Certificate/create.md) для ресурса [Certificate](../saml/api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Create](../saml/api-ref/grpc/Certificate/create.md) и передайте в запросе файл с параметрами запроса.

      Пример cURL-запроса:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/certificates"
      ```
    {% endlist %}

{% note tip %}

Не забывайте своевременно перевыпускать сертификаты и добавлять их в федерацию.

Чтобы не пропустить момент окончания срока действия сертификата, [подпишитесь](subscribe-user-for-notifications.md) на уведомления от организации. Уведомления направляются подписанным пользователям за 60, 30 и 5 дней до момента прекращения действия сертификата, а также после того, как сертификат становится недействительным.

{% endnote %}

## Передать сертификат федерации на IdP-сервер {#add-certificate-idp}

Если при создании федерации вы включили опцию **Подписывать запросы аутентификации**, запросы аутентификации от Yandex Cloud будут содержать цифровую подпись. Чтобы IdP-сервер мог проверить эту подпись, добавьте сертификат Yandex Cloud на IdP-сервер:

1. Если вы не скачивали SAML-сертификат Yandex Cloud при создании федерации удостоверений, скачайте его сейчас:

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

      1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
      1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
      1. В открывшемся списке выберите нужную федерацию удостоверений и в поле **Подписывать запросы аутентификации** нажмите ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **Скачать сертификат**.

          Если слева от кнопки ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **Скачать сертификат** отображается значок ![TriangleExclamation](../../_assets/console-icons/triangle-exclamation.svg), значит срок действия текущего SAML-сертификата Yandex Cloud закончился или вот-вот закончится.

          [Скачайте и установите](renew-yc-certificate.md) перевыпущенный SAML-сертификат Yandex Cloud в вашей федерации удостоверений.

          {% note tip %}

          Чтобы узнать дату истечения срока действия текущего SAML-сертификата, в правом верхнем углу нажмите ![pencil](../../_assets/console-icons/pencil.svg) **Изменить**. Нужная дата будет указана в блоке **Дополнительно** в секции **Сертификат SAML**.

          Сохраните дату истечения срока действия SAML-сертификата в свой календарь. За несколько месяцев до указанной даты вам будет необходимо [скачать и установить](renew-yc-certificate.md) в вашей федерации и на IdP-сервере перевыпущенный SAML-сертификат Yandex Cloud.

          {% endnote %}

    {% endlist %}

1. Передайте скачанный SAML-сертификат Yandex Cloud на IdP-сервер. Чтобы узнать, как это сделать, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

## Настроить SAML-приложение на стороне IdP-сервера {#configure-sso}

Конкретные шаги по настройке SAML-приложения на стороне IdP-сервера зависят от используемого поставщика удостоверений. Здесь приведены общие требования к содержанию SAML-сообщения, которое IdP-сервер отправляет на сторону Yandex Cloud при успешной аутентификации пользователя:

{% cut "Пример SAML-сообщения" %}

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

{% endcut %}

Настройте SAML-приложение таким образом, чтобы при формировании сообщения:

* В элементах `Response` и `SubjectConfirmationData` в атрибуте `InResponseTo` был передан идентификатор из SAML-запроса на аутентификацию, отправленного Yandex Cloud.
* ACS URL был передан в следующих элементах:
  
  * `Response` в атрибуте `Destination`;
  * `SubjectConfirmationData` в атрибуте `Recipient`;
  * `Audience`.

  {% cut "Как получить идентификатор федерации" %}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
  1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **Идентификатор**.

  {% endcut %}

  
  {% cut "Как получить ACS URL федерации" %}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  
  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
  
  1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **ACS URL**.

  {% endcut %}


* В элементе `NameID` был указан уникальный идентификатор пользователя. В качестве идентификатора рекомендуется использовать User Principal Name (UPN) или адрес электронной почты.
* В элементе `Issuer` была указана ссылка на страницу поставщика удостоверений, куда перенаправлялся пользователь для прохождения аутентификации.
* В элементе `SignatureValue` было указано подписанное сообщение, а в элементе `KeyInfo` — сертификат, которым оно было подписано.
* Чтобы пользователь мог обратиться в службу технической поддержки Yandex Cloud из [консоли управления](https://center.yandex.cloud/support), в элементе `AttributeStatement` должен быть указан его адрес электронной почты и имя.

Чтобы получить более подробную информацию о настройке SAML-приложения, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений. Также примеры настройки для отдельных поставщиков удостоверений приведены в практических руководствах:

* [Active Directory](../tutorials/federations/integration-adfs.md).
* [Google Workspace](../tutorials/federations/integration-gworkspace.md).
* [Microsoft Entra ID](../tutorials/federations/integration-azure.md).
* [Keycloak](../tutorials/federations/integration-keycloak.md).

## Настроить сопоставление атрибутов пользователей {#claims-mapping}

{% note info %}

[Атрибуты](setup-federation.md#claims-mapping) федеративного пользователя загружаются в его профиль в [организации](../concepts/organization.md) Yandex Identity Hub после первой аутентификации этого пользователя в Yandex Cloud.

{% endnote %}

После аутентификации пользователя IdP-сервер отправляет в Yandex Cloud SAML-сообщение, которое содержит информацию об успешной аутентификации и атрибуты пользователя, такие как идентификатор, имя, адрес электронной почты и так далее.

Чтобы корректно передавать в сервис Yandex Identity Hub информацию о пользователе, настройте сопоставление между атрибутами SAML-сообщения и персональными данными пользователя, которые хранятся на стороне поставщика удостоверений.

Данные пользователя | Комментарий | Элементы SAML-сообщения
------------------- | ----------- | ----------------------
Уникальный идентификатор пользователя | Обязательный атрибут. Рекомендуется использовать User Principal Name (UPN) или адрес электронной почты. | `<NameID>`
Фамилия | Отображается в сервисах Yandex Cloud.<br> Ограничение значения по длине: 64 символа. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"`
Имя | Отображается в сервисах Yandex Cloud.<br> Ограничение значения по длине: 64 символа. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"`
Полное имя | Отображается в сервисах Yandex Cloud.<br>Пример: Иван Иванов.<br> Ограничение значения по длине: 64 символа. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"`
Почта | Используется для отправки уведомлений из сервисов Yandex Cloud.<br>Пример:&nbsp;`ivanov@example.com`.<br> Ограничение по длине: 256 символов. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"`
Телефон | Используется для отправки уведомлений из сервисов Yandex Cloud.<br>Пример: +71234567890.<br> Ограничение по длине: 64 символа. | `<Attribute>` с параметром<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone"`
Аватар | Отображается в сервисах Yandex Cloud.<br>Изображение передается в кодировке [Base64](https://ru.wikipedia.org/wiki/Base64).<br> Ограничение по длине: 204800 символов. | `<Attribute>` с параметром<br>`Name="thumbnailPhoto"`
Членство в группах | Используется для функционала динамического сопоставления членства в группах. | `<Attribute>` с параметром<br>`Name="member"`
Название компании | Отображается в сервисах Yandex Cloud.<br>Пример: ООО «Праздник». | `<Attribute>` с параметром<br>`Name="company_name"`
Подразделение | Отображается в сервисах Yandex Cloud.<br>Пример: Отдел АСУ. | `<Attribute>` с параметром<br>`Name="department"`
Должность | Отображается в сервисах Yandex Cloud.<br>Пример: Разработчик. | `<Attribute>` с параметром<br>`Name="job_title"`
Табельный номер | Отображается в сервисах Yandex Cloud.<br>Пример: 08012. | `<Attribute>` с параметром<br>`Name="employee_id"`


{% note info %}

Если значение атрибута `thumbnailPhoto` превышает ограничение по длине, атрибут игнорируется. Если значение другого атрибута превышает ограничение, такое значение обрезается.

{% endnote %}

## Проверить работу аутентификации {#test-auth}

Чтобы проверить работу аутентификации федеративных пользователей:

1. Если в федерации не включена опция **Автоматически создавать пользователей**, [добавьте](add-account.md#add-user-sso) федеративных пользователей вручную.

1. Откройте браузер в гостевом режиме или режиме инкогнито для чистой симуляции нового пользователя.

1. Перейдите по URL для входа в консоль управления:

   ```url
   https://console.yandex.cloud/federations/<идентификатор_федерации>
   ```

   {% cut "Как получить идентификатор федерации" %}

   1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
   1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
   1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **Идентификатор**.

   {% endcut %}

   Браузер перенаправит вас на страницу аутентификации поставщика удостоверений.

1. Введите ваши аутентификационные данные. По умолчанию необходимо ввести UPN и пароль.
1. Нажмите кнопку **Sign in**.

1. После успешной аутентификации IdP-сервер перенаправит вас по ACS URL, который вы указали в настройках сервера, а после этого — на главную страницу консоли управления.

Убедитесь, что вошли в консоль от имени федеративного пользователя.