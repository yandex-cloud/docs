# Настройка SAML-аутентификации

SAML (Security Assertion Markup Language) — это язык разметки для обмена данными аутентификации и авторизации между сторонами. SAML позволяет реализовать систему единого входа (Single Sign-On, SSO), с помощью которой можно переключаться между приложениями без повторной аутентификации.

При работе с SAML и SSO кластер {{ mos-name }} получает сведения от провайдера идентификации (Identity Provider, IdP).

Подробнее о SAML и SSO см. в [документации OASIS](https://wiki.oasis-open.org/security/saml/).

{{ mos-name }} поддерживает все SAML 2.0-совместимые провайдеры идентификации.

Чтобы настроить SAML-аутентификацию:
1. [Настройте провайдер идентификации](#configuration-idp).
1. [Настройте кластер {{ mos-name }}](#configuration-sso) на использование этого провайдера для SSO.
1. [Настройте роли кластера](#roles-sso) для пользователей SSO на стороне провайдера.

## Настройте провайдер идентификации {#configuration-idp}

1. Создайте приложение на стороне провайдера.
1. Укажите **Assertion Consumer Service (ACS) URL**.

    Используйте URL со [специальным FQDN кластера](connect.md#special-fqdns):

    ```
    https://c-<идентификатор_кластера_{{ OS }}>.rw.{{ dns-zone }}/api/security/saml/callback
    ```

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    **Пример:** `https://c-e4ut2....rw.{{ dns-zone }}/api/security/saml/callback`

1. Укажите **SP Entity ID (Audience URI)**.

    Используйте URL со [специальным FQDN кластера](connect.md#special-fqdns):

    ```
    https://c-<идентификатор_кластера>rw.{{ dns-zone }}
    ```

    **Пример:** `https://c-e4ut2....rw.{{ dns-zone }}`

1. Укажите **Name ID Format** — `persistent`.
1. Из предоставленных провайдером данных:
    * Скопируйте информацию об эмитенте провайдера идентификации (Identity Provider Issuer).
    * Сохраните файл с метаданными провайдера в формате XML.

    Эти данные потребуются при настройке SSO для кластера.

## Настройте SSO для кластера {#configuration-sso}

{% note warning %}

Некорректные настройки могут привести к неработоспособности кластера.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.opensearch.auth.section_auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
    1. Укажите параметры внешнего источника аутентификации:

        * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}** — информация об эмитенте провайдера идентификации (Identity Provider Issuer), которая получена при [настройке провайдера идентификации](#configuration-idp).

        * **idp_metadata_file** — файл с метаданными провайдера в формате XML, который получен при [настройке провайдера идентификации](#configuration-idp).

        * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}** — URI-идентификатор приложения SP Entity ID (Audience URI). Должен соответствовать указанному при [настройке провайдера идентификации](#configuration-idp).

        * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}** — URL со [специальным FQDN кластера](./connect.md#special-fqdns). Значение совпадает с **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**.

        * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}** — параметр в ответе SAML, в котором хранятся роли. Если не настроен, роли не используются.

        * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}** — параметр в ответе SAML, в котором хранится тема. Если параметр не настроен, используется параметр `NameID`.

        * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}** — активировать ли источник аутентификации после создания.

    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_save }}**.

- API

    1. Сконвертируйте файл с метаданными, полученный от эмитента провайдера идентификации, в формат Base64.
    1. Чтобы задать настройки провайдера идентификации на стороне кластера, воспользуйтесь методом REST API [updateAuthSettings](../api-ref/Cluster/updateAuthSettings.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/UpdateAuthSettings](../api-ref/grpc/cluster_service.md#UpdateAuthSettings) и передайте в запросе:

        * Идентификатор кластера в параметре `clusterId`.

          {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

        * Значение `true` в параметре `enabled`.
        * Идентификатор эмитента провайдера аутентификации (Identity Provider Issuer), который был получен при [настройке провайдера идентификации](#configuration-idp), в параметре `idpEntityId`.
        * Путь к файлу с метаданными в формате Base64 в параметре `idpMetadataFile`.
        * URI приложения SP Entity ID (Audience URI) в параметре `spEntityId`. URI должен соответствовать указанному при [настройке провайдера идентификации](#configuration-idp).
        * URL хоста {{ OS }} с ролью `DASHBOARDS` в параметре `dashboardsUrl`.
        * (Опционально) Параметр в ответе SAML, в котором хранятся роли, в параметре `rolesKey`.
        * (Опционально) Параметр в ответе SAML, в котором хранится тема, в параметре `subjectKey`.

{% endlist %}

{% note info %}

Подробнее о SAML-атрибутах см. в [документации {{ OS }}]({{ os.docs }}/security/authentication-backends/saml/).

{% endnote %}

## Настройте роли для SSO {#roles-sso}

Чтобы получить доступ к кластеру через SSO, свяжите роли кластера с пользователями SSO на стороне провайдера. Для этого:

1. [Сопоставьте роли](https://opensearch.org/docs/latest/security/access-control/users-roles/) пользователей {{ OS }} на стороне провайдера идентификации с ролями в кластере. Выполните эту операцию от имени [пользователя `admin`](../concepts/index.md) одним из способов:
    * С помощью [OpenSearch Dashboards](https://opensearch.org/docs/latest/security/access-control/users-roles/#opensearch-dashboards-2).
    * С помощью [API {{ OS }}](https://opensearch.org/docs/latest/security/access-control/api/#create-role-mapping).
1. На стороне провайдера идентификации создайте пользователя, который удовлетворяет указанным сопоставлениям ролей в {{ OS }}.
1. Разрешите этому пользователю доступ к [созданному ранее приложению](#configuration-idp).

Чтобы авторизоваться в {{ OS }} под новым пользователем, перейдите на страницу **{{ ui-key.yacloud.opensearch.title_opensearch-dashboards-section }}**.
