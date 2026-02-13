# Создать OIDC-приложение в {{ org-full-name }} для интеграции с 1С:Предприятие


[1С:Предприятие](https://scloud.ru/1s-predpriyatie/) — это технологическая платформа, на которой разрабатываются программы 1С для автоматизации учета и бизнеса. Платформа поддерживает [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) — аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в 1С:Предприятие с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications.md#oidc) в {{ org-full-name }}, настройте его на стороне {{ org-name }} и на стороне 1С:Предприятие.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в 1С:Предприятие:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate)


## Перед началом работы {#before-you-begin}

Для прохождения руководства может потребоваться действующий [договор «1С:ИТС»](https://its.1c.ru/db/aboutitsnew) для доступа к расширенной версии документации.


## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** укажите `enterprise-1c-oidc-app`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания OIDC-приложения:

     ```bash
     yc organization-manager idp application oauth application create --help
     ```

  1. Создайте OAuth-клиент:

     ```bash
     yc iam oauth-client create \
       --name enterprise-1c-oauth-client \
       --scopes openid,email,profile
     ```

     Где:

     * `--name` — имя OAuth-клиента.
     * `--scopes` — набор атрибутов пользователей, которые будут доступны 1С:Предприятие. Указаны атрибуты:
       * `openid` — идентификатор пользователя. Обязательный атрибут.
       * `email` — адрес электронной почты пользователя.
       * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.

     Результат:

     ```text
     id: ajeqqip130i1********
     name: enterprise-1c-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Сохраните значение поля `id`, оно понадобится для создания и настройки приложения.

  1. Создайте секрет для OAuth-клиента:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Результат:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Сохраните значение поля `secret_value`, оно понадобится для настройки 1С:Предприятие.
  
  1. Создайте OIDC-приложение:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <идентификатор_организации> \
       --name enterprise-1c-oidc-app \
       --description "OIDC-приложение для интеграции с 1С:Предприятие" \
       --client-id <идентификатор_OAuth-клиента> \
       --authorized-scopes openid,email,profile \
       --group-distribution-type none
     ```

     Где:

     * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
     * `--name` — имя OIDC-приложения. Обязательный параметр.
     * `--description` — описание OIDC-приложения. Необязательный параметр.
     * `--client-id` — идентификатор OAuth-клиента, полученный на втором шаге. Обязательный параметр.
     * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
     * `--group-distribution-type` — укажите `none`, так как группы пользователей не передаются в 1С:Предприятие.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: enterprise-1c-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

{% endlist %}


## Настройте интеграцию {#setup-integration}

Настройте интеграцию 1С:Предприятие с созданным OIDC-приложением в {{ org-name }}.


### Настройте OIDC-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** разверните секцию **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** и скопируйте значения параметров, которые необходимо задать на стороне 1С:Предприятие:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` — уникальный идентификатор приложения.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` — URL с конфигурацией всех необходимых для настройки интеграции параметров.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  1. Получите информацию о созданном OIDC-приложении:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения>
     ```

     Где `<идентификатор_приложения>` — это идентификатор OIDC-приложения, полученный при создании.

     В результате вы получите информацию о приложении, включая:

     ```text
     id: ek0o663g4rs2********
     name: enterprise-1c-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     ```

     Сохраните значение `client_id` — это идентификатор OIDC-приложения для настройки 1С:Предприятие.

  1. Получите URL с конфигурацией OpenID Connect Discovery:

     ```bash
     yc organization-manager idp application oauth application get <идентификатор_приложения> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     Результат будет выглядеть так:

     ```text
     https://{{ auth-main-host }}/oauth/<идентификатор_OAuth-клиента>
     ```

     Сохраните этот URL — это OpenID Connect Discovery URL для настройки 1С:Предприятие.

  1. Используйте секрет OAuth-клиента, который был сохранен при создании приложения на предыдущем шаге. Если вы не сохранили секрет, создайте новый:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <идентификатор_OAuth-клиента>
     ```

     Сохраните значение `secret_value` из результата команды — это секрет приложения для настройки 1С:Предприятие.

{% endlist %}


#### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите  ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите URL информационной базы 1С, по которому будет обрабатываться ответ от OIDC-приложения, в форме:

        ```text
        <домен_публикации_ИБ_1С>/<имя_приложения>/authform.html
        ```

        Например: `https://your.company.ru/your-app/authform.html`.

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Обновите OAuth-клиент, указав Redirect URI:

     ```bash
     yc iam oauth-client update \
       --id <идентификатор_OAuth-клиента> \
       --redirect-uris "<домен_публикации_ИБ_1С>/<имя_приложения>/authform.html"
     ```

     Где:
     
     * `<идентификатор_OAuth-клиента>` — идентификатор OAuth-клиента, полученный при его создании.
     * `--redirect-uris` — URL информационной базы 1С, по которому будет обрабатываться ответ от OIDC-приложения. Например: `https://your.company.ru/your-app/authform.html`.

     Результат:

     ```text
     id: ajeiu3otac08********
     name: enterprise-1c-oauth-client
     redirect_uris:
       - https://your.company.ru/your-app/authform.html
     scopes:
       - openid
       - email
       - profile
     folder_id: b1gkd6dks6i1********
     status: ACTIVE
     ```

{% endlist %}


### Настройте OIDC-приложение на стороне 1С:Предприятие {#setup-sp}

Чтобы настроить аутентификацию по стандарту OpenID Connect на стороне 1С:Предприятие, настройте конфигурацию публикации информационной базы, перезапустите [Apache HTTP Server](https://httpd.apache.org/) и разрешите OIDC-аутентификацию.

Расположение файла конфигурации зависит от особенностей работы с 1С:Предприятие и может находиться, например, по пути `/var/www/<имя_приложения>/default.vrd`.

1. Откройте файл конфигурации и внутри раздела `point` добавьте раздел `openidconnect`:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <point xmlns="http://v8.1c.ru/8.2/virtual-resource-system"
    ...
            <openidconnect>
                    <providers>
                  <![CDATA[[
                    {
                    "name": "identity-hub",
                    "title": "Identity Hub",
                    "discovery": "https://{{ auth-main-host }}/.well-known/openid-configuration",
                    "authenticationClaimName": "preferred_username",
                    "authenticationUserPropertyName": "email",
                    "clientconfig": {
                          "authority": "https://{{ auth-main-host }}",
                          "client_id": "<идентификатор_приложения>",
                          "client_secret" : "<секрет_приложения>",
                          "redirect_uri": "https://<домен_публикации_ИБ_1С>/<имя_приложения>/authform.html",
                          "response_type": "code",
                          "scope": "openid email profile",
                          "filterProtocolClaims": true,
                          "loadUserInfo": false
                          }
                    }
                    ]]]>
                    </providers>
                    <allowStandardAuthentication>true</allowStandardAuthentication>
            </openidconnect>
    ...
    </point>
    ```

    Где:

    * `authenticationUserPropertyName` — атрибут пользователя, по которому будет проходить аутентификация. В данном примере — `email`, адрес электронной почты.
    * `client_id` — уникальный идентификатор OIDC-приложения, полученный [ранее](#get-credentials).
    * `client_secret` — сгенерированный секрет OIDC-приложения, полученный [ранее](#get-credentials).
    * `redirect_uri` — URL информационной базы 1С, по которому будет обрабатываться ответ от OIDC-приложения.

1. Перезапустите Apache HTTP Server:

    ```bash
    systemctl restart apache2
    ```

1. Перейдите в «Конфигуратор 1С» и включите опцию **OpenID Connect authentication** для каждого нужного пользователя. При этом у пользователя должен быть заполнен атрибут, соответствующий параметру `authenticationUserPropertyName` в конфигурации.


## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с 1С:Предприятие, выполните аутентификацию в 1С:Предприятие от имени одного из пользователей, для которого разрешена OIDC-аутентификация.

Для этого:

1. В браузере перейдите по адресу вашего экземпляра 1С:Предприятие (например, `https://your.company.ru`).
1. Если вы были авторизованы в 1С:Предприятие, выйдите из профиля.
1. На странице авторизации 1С:Предприятие нажмите **Войти**.
1. На странице авторизации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя.
1. Убедитесь, что вы аутентифицировались в «1С:Предприятие».