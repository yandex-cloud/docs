# Настройка SAML-аутентификации

SAML (Security Assertion Markup Language) — это язык разметки для обмена данными аутентификации и авторизации между сторонами. SAML позволяет реализовать систему единого входа (Single Sign-On, SSO), с помощью которой можно переключаться между приложениями без повторной аутентификации.

При работе с SAML и SSO кластер {{ mos-name }} получает сведения от провайдера идентификации (Identity Provider, IdP). Подробнее о SAML и SSO см. в [документации OASIS](https://wiki.oasis-open.org/security/saml/).

{{ mos-name }} поддерживает все SAML 2.0-совместимые провайдеры идентификации.

Чтобы настроить SAML-аутентификацию:
1. [Настройте провайдер идентификации](#configuration-idp).
1. [Настройте кластер {{ mos-name }}](#configuration-sso) на использование этого провайдера для SSO.
1. [Настройте роли кластера](#roles-sso) для пользователей SSO на стороне провайдера.

## Настройте провайдер идентификации {#configuration-idp}

1. Создайте приложение на стороне провайдера.
1. Укажите **Assertion Consumer Service (ACS) URL**.

    Используйте URL со [специальным FQDN кластера](connect.md#special-fqdns):

    ```text
    https://c-<идентификатор_кластера_{{ OS }}>.rw.{{ dns-zone }}/_opendistro/_security/saml/acs
    ```

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Пример URL: `https://c-e4ut2....rw.{{ dns-zone }}/_opendistro/_security/saml/acs`

1. Укажите **SP Entity ID (Audience URI)**.

    Используйте URL со [специальным FQDN кластера](connect.md#special-fqdns):

    ```text
    https://c-<идентификатор_кластера>rw.{{ dns-zone }}/
    ```

    Пример URL: `https://c-e4ut2....rw.{{ dns-zone }}/`

1. Укажите **Name ID Format**:

    * `email`, если вы используете [федерацию удостоверений с провайдером Keycloak](../../organization/tutorials/federations/integration-keycloak.md).
    * `persistent` — для остальных провайдеров.

1. Получите данные, необходимые для настройки SAML SSO на стороне {{ OS }}:
    * Скопируйте информацию об эмитенте провайдера идентификации (Identity Provider Issuer).
    * Сохраните файл с метаданными провайдера в формате XML.

    Эти данные потребуются при настройке SSO для кластера.

## Настройте SSO для кластера {#configuration-sso}

{% note warning %}

Некорректные настройки могут привести к неработоспособности кластера.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.opensearch.auth.section_auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
    1. Укажите параметры внешнего источника аутентификации:

        * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}** — информация об эмитенте провайдера идентификации (Identity Provider Issuer), которая получена при [настройке провайдера идентификации](#configuration-idp).

        * **idp_metadata_file** — файл с метаданными провайдера в формате XML, который получен при [настройке провайдера идентификации](#configuration-idp).

        * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}** — URI-идентификатор приложения SP Entity ID (Audience URI). Должен соответствовать указанному при [настройке провайдера идентификации](#configuration-idp).

        * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}** — URL со [специальным FQDN кластера](./connect.md#special-fqdns). Значение совпадает с **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**.

        * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}** — имя параметра в ответе SAML, в котором хранятся роли. Ответ SAML приходит от провайдера идентификации. Если параметр не настроен, роли не используются.

        * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}** — имя параметра в ответе SAML, в котором хранится тема. Ответ SAML приходит от провайдера идентификации. Если параметр не настроен, используется параметр `NameID`.

        * **{{ ui-key.yacloud.opensearch.auth.field_jwt-default-expiration-timeout }}** — срок жизни сессии в минутах. Укажите его, если провайдер идентификации не установил свой таймаут.

            Если значение отсутствует или указан `0`, срок жизни сессии не ограничен (значение по умолчанию).

        * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}** — активировать ли источник аутентификации после создания.

    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_save }}**.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.UpdateAuthSettings](../api-ref/Cluster/updateAuthSettings.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PUT \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<идентификатор_кластера>/auth' \
            --data '{
                        "settings": {
                            "saml": {
                                "enabled": "<включить_SSO>",
                                "idpEntityId": "<идентификатор_эмитента_IdP>",
                                "idpMetadataFile": "<файл_с_метаданными>",
                                "spEntityId": "<URI_приложения_SP_Entity_ID>",
                                "dashboardsUrl": "<URL_хоста_Dashboards>",
                                "rolesKey": "<параметр_с_ролями_в_ответе_SAML>",
                                "subjectKey": "<параметр_с_темой_в_ответе_SAML>",
                                "jwtDefaultExpirationTimeout": "<срок_жизни_сессии>"
                            }
                        }
                    }'
        ```

        Где `settings` — набор настроек SSO. Содержат блок `saml` со следующими параметрами:

        * `enabled` — включение SSO: `true` или `false`.
        * `idpEntityId` — идентификатор эмитента провайдера аутентификации (Identity Provider Issuer), который был получен при [настройке провайдера идентификации](#configuration-idp).
        * `idpMetadataFile` — путь к файлу с метаданными в формате Base64.
        * `spEntityId` — URI приложения SP Entity ID (Audience URI). URI должен соответствовать указанному при [настройке провайдера идентификации](#configuration-idp).
        * `dashboardsUrl` — URL хоста с ролью `DASHBOARDS`.
        * `rolesKey` — имя параметра в ответе SAML, в котором хранятся роли. Ответ SAML приходит от провайдера идентификации. Если параметр не настроен, роли не используются.
        * `subjectKey` — имя параметра в ответе SAML, в котором хранится тема. Ответ SAML приходит от провайдера идентификации. Если параметр не настроен, используется параметр `NameID`.
        * `jwtDefaultExpirationTimeout` — срок жизни сессии в минутах. Укажите его, если провайдер идентификации не установил свой таймаут.

            Если значение отсутствует или указан `0`, срок жизни сессии не ограничен (значение по умолчанию).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateAuthSettings.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.UpdateAuthSettings](../api-ref/grpc/Cluster/updateAuthSettings.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "settings": {
                    "saml": {
                        "enabled": "<включить_SSO>",
                        "idp_entity_id": "<идентификатор_эмитента_IdP>",
                        "idp_metadata_file": "<файл_с_метаданными>",
                        "sp_entity_id": "<URI_приложения_SP_Entity_ID>",
                        "dashboards_url": "<URL_хоста_Dashboards>",
                        "roles_key": "<параметр_с_ролями_в_ответе_SAML>",
                        "subject_key": "<параметр_с_темой_в_ответе_SAML>",
                        "jwt_default_expiration_timeout": "<срок_жизни_сессии>"
                    }
                }
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.UpdateAuthSettings
        ```

        Где `settings` — набор настроек SSO. Содержат блок `saml` со следующими параметрами:

        * `enabled` — включение SSO: `true` или `false`.
        * `idp_entity_id` — идентификатор эмитента провайдера аутентификации (Identity Provider Issuer), который был получен при [настройке провайдера идентификации](#configuration-idp).
        * `idp_metadata_file` — путь к файлу с метаданными в формате Base64.
        * `sp_entity_id` — URI приложения SP Entity ID (Audience URI). URI должен соответствовать указанному при [настройке провайдера идентификации](#configuration-idp).
        * `dashboards_url` — URL хоста с ролью `DASHBOARDS`.
        * `roles_key` — имя параметра в ответе SAML, в котором хранятся роли. Ответ SAML приходит от провайдера идентификации. Если параметр не настроен, роли не используются.
        * `subject_key` — имя параметра в ответе SAML, в котором хранится тема. Ответ SAML приходит от провайдера идентификации. Если параметр не настроен, используется параметр `NameID`.
        * `jwt_default_expiration_timeout` — срок жизни сессии в минутах. Укажите его, если провайдер идентификации не установил свой таймаут.

            Если значение отсутствует или указан `0`, срок жизни сессии не ограничен (значение по умолчанию).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateAuthSettings.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note info %}

Подробнее о SAML-атрибутах см. в [документации {{ OS }}]({{ os.docs }}/security/authentication-backends/saml/).

{% endnote %}

## Настройте роли для SSO {#roles-sso}

Чтобы получить доступ к кластеру через SSO, свяжите роли кластера с пользователями SSO на стороне провайдера:

1. [Сопоставьте роли](https://opensearch.org/docs/latest/security/access-control/users-roles/) пользователей {{ OS }} на стороне провайдера идентификации с ролями в кластере. Выполните эту операцию от имени [пользователя `admin`](../concepts/index.md) одним из способов:
    * С помощью [OpenSearch Dashboards](https://opensearch.org/docs/latest/security/access-control/users-roles/#opensearch-dashboards-2).
    * С помощью [API {{ OS }}](https://opensearch.org/docs/latest/security/access-control/api/#create-role-mapping).
1. На стороне провайдера идентификации создайте пользователя, который удовлетворяет указанным сопоставлениям ролей в {{ OS }}.
1. Разрешите этому пользователю доступ к [созданному ранее приложению](#configuration-idp).

Чтобы авторизоваться в {{ OS }} под новым пользователем, перейдите на страницу **OpenSearch Dashboards**.

## Примеры интеграции с провайдерами {#examples}

[{#T}](../tutorials/saml-keycloak.md).
