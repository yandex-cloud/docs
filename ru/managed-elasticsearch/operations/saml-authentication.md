---
title: "Как настроить SAML-аутентификацию"
description: "Следуя данной инструкции, вы сможете настроить SAML-аутентификацию."
---

# Настройка SAML-аутентификации

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

SAML (Security Assertion Markup Language) — это язык разметки для обмена данными аутентификации и авторизации между сторонами. SAML позволяет реализовать систему единого входа (Single Sign-On, SSO), с помощью которой можно переключаться между приложениями без повторной аутентификации.

При работе с SAML и SSO кластер {{ mes-name }} получает сведения от провайдера идентификации (Identity Provider, IdP).

Подробнее о SAML и SSO см. в [документации OASIS](https://wiki.oasis-open.org/security/saml/).

{{ mes-name }} поддерживает всех SAML 2.0-совместимых провайдеров идентификации.

{% note warning %}

Использование SSO поддерживается для кластеров {{ mes-name }} редакции **Platinum** с включенным публичным доступом для всех хостов с ролью _Data node_. При [понижении редакции {{ ES }}](./cluster-version-update.md#start-edition-update) функция SSO будет отключена.

{% endnote %}

Чтобы настроить SAML-аутентификацию:
1. [Настройте провайдер идентификации](#configuration-idp).
1. [Настройте кластер {{ mes-name }}](#configuration-sso) на использование этого провайдера для SSO.
1. [Настройте роли кластера](#roles-sso) для пользователей SSO на стороне провайдера.

## Настройте провайдер идентификации {#configuration-idp}

1. Создайте приложение на стороне провайдера.
1. Укажите **Assertion Consumer Service (ACS) URL**.

    Используйте URL со [специальным FQDN кластера](cluster-connect.md#automatic-host-selection):

    ```
    https://c-<идентификатор_кластера_{{ ES }}>.rw.{{ dns-zone }}/api/security/saml/callback
    ```

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    **Пример:** `https://c-e4ut2....rw.{{ dns-zone }}/api/security/saml/callback`

1. Укажите **SP Entity ID (Audience URI)**.

    Используйте URL со [специальным FQDN кластера](cluster-connect.md#automatic-host-selection):

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

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.elasticsearch.auth.auth-providers }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Создайте провайдер аутентификации:
        * **{{ ui-key.yacloud.elasticsearch.auth.provider-type }}** — `Saml`.

        * **{{ ui-key.yacloud.common.name }}** — имя провайдера.

        * **{{ ui-key.yacloud.common.description }}** — описание провайдера.

        * **{{ ui-key.yacloud.elasticsearch.auth.provider-hint }}** — подсказка для входа.

        * **{{ ui-key.yacloud.elasticsearch.auth.provider-icon }}** — иконка провайдера.

        * Выберите опцию **{{ ui-key.yacloud.elasticsearch.auth.provider-enabled }}**.

        * **{{ ui-key.yacloud.elasticsearch.auth.saml_settings }}**:
        
            * **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_entity_id }}** — информация об эмитенте провайдера идентификации (Identity Provider Issuer), которая получена при [настройке провайдера идентификации](#configuration-idp).

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_metadata_file }}** — файл с метаданными провайдера в формате XML, который получен при [настройке провайдера идентификации](#configuration-idp).

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-sp_entity_id }}** — URI-идентификатор приложения SP Entity ID (Audience URI). Должен соответствовать указанному при [настройке провайдера идентификации](#configuration-idp).

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-kibana_url }}** — URL со [специальным FQDN кластера](cluster-connect.md#automatic-host-selection). Значение совпадает с **{{ ui-key.yacloud.elasticsearch.auth.saml-sp_entity_id }}**.

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_principal }}** — формат параметра `nameid`, например, `nameid:persistent`. Значение совпадает с **Name ID Format** провайдера идентификации.

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_groups }}** — группы привилегий пользователя (рекомендуется).

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_name }}** — имя пользователя (опционально).

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_email }}** — адрес электронной почты пользователя (опционально).

            * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_dn }}** — идентификатор пользователя `X.500 Distinguished Name` (опционально).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- API {#api}

    1. Сконвертируйте файл с метаданными, полученный от эмитента провайдера идентификации, в формат Base64.
    1. Чтобы задать настройки провайдера идентификации на стороне кластера, воспользуйтесь методом REST API [addProviders](../api-ref/Auth/addProviders.md) для ресурса [Auth](../api-ref/Auth/index.md) или вызовом gRPC API [AuthService/AddProviders](../api-ref/grpc/auth_service.md#AddProviders) и передайте в запросе:

        * Идентификатор кластера в параметре `clusterId`.

          {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

        * Значение `SAML` в параметре `type`.
        * Имя провайдера в параметре `name`.
        * Значение `true` в параметре `enabled`.
        * Описание провайдера в параметре `description`.
        * Идентификатор эмитента провайдера аутентификации (Identity Provider Issuer), который был получен при [настройке провайдера идентификации](#configuration-idp), в параметре `idpEntityId`.
        * Путь к файлу с метаданными в формате Base64 в параметре `idpMetadataFile`.
        * URI приложения SP Entity ID (Audience URI) в параметре `spEntityId`. URI должен соответствовать указанному при [настройке провайдера идентификации](#configuration-idp).
        * URL со [специальным FQDN кластера](cluster-connect.md#automatic-host-selection) в параметре `kibanaUrl`. Значение совпадает с `spEntityId`.
        * Формат параметра `nameid`, например, `nameid:persistent` в параметре `attributePrincipal`. Значение совпадает с **Name ID Format** провайдера идентификации.

{% endlist %}

{% note info %}

Подробнее о SAML-атрибутах см. в [документации Elasticsearch]({{ links.es.docs }}/elasticsearch/reference/6.8/saml-guide-authentication.html#saml-user-properties).

{% endnote %}

## Настройте роли для SSO {#roles-sso}

Чтобы получить доступ к кластеру через SSO, свяжите роли кластера с пользователями SSO на стороне провайдера. Для этого:

1. [Сопоставьте роли](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-roles.html) пользователей {{ ES }} на стороне провайдера идентификации с ролями в кластере. Выполните эту операцию от имени [пользователя `admin`](../concepts/index.md) одним из способов:
    * С помощью [Kibana](https://www.elastic.co/guide/en/kibana/current/role-mappings.html).
    * С помощью [Security API {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api-put-role-mapping.html).
1. На стороне провайдера идентификации создайте пользователя, который удовлетворяет указанным сопоставлениям ролей в {{ ES }}.
1. Разрешите этому пользователю доступ к [созданному ранее приложению](#configuration-idp).

Чтобы авторизоваться в кластере {{ ES }} под новым пользователем, перейдите на страницу **Kibana**.

## Примеры {#examples}

### Подключение SAML SSO с Okta {#example-okta}

Чтобы настроить SSO Okta для кластера с идентификатором `c9qmc1lmo2k0********`:
1. [Настройте провайдера идентификации Okta](#example-configuration-okta).
1. [Настройте SSO для кластера {{ mes-name }}](#example-configuration-sso).
1. [Настройте роли для SSO с Okta](#example-roles-sso).

#### Настройте провайдера идентификации Okta {#example-configuration-okta}

1. Создайте новое приложение:
    * Выберите вкладку **Applications**.
    * Нажмите кнопку **Create App Integration**.
    * Выберите опцию **SAML 2.0**.
    * Нажмите кнопку **Next**.
1. В разделе **General Settings** укажите имя приложения в параметре **App name** и нажмите кнопку **Next**.
1. В разделе **SAML Settings**:
    * Укажите **Single sign on URL**:

        ```
        https://c-c9qmc1lmo2k0********.rw.{{ dns-zone }}/api/security/saml/callback
        ```

    * Включите опцию **Use this for Recipient URL and Destination URL**.
    * Укажите **Audience URI (SP Entity ID)**:

        ```
        https://c-c9qmc1lmo2k0********.rw.{{ dns-zone }}
        ```

    * Укажите **Name ID Format** — `Persistent`.
    * Нажмите кнопку **Next**.
1. В разделе **Feedback**:
    * Выберите **I'm an Okta customer adding an internal app** и **This is an internal app that we have created**.
    * Нажмите кнопку **Finish**.
1. На вкладке **Sign On** нажмите **View Setup Instructions**:
    * Скопируйте **Identity Provider Issuer**:

        ```
        http://www.okta.com/exkv2pzpvigX********
        ```

    * Содержимое поля **Provide the following IDP metadata to your SP provider** скопируйте и сохраните, например, под именем `okta.xml`.

Подробнее об остальных параметрах, см. в [документации Okta](https://help.okta.com/en/prod/Content/Topics/Apps/Apps_App_Integration_Wizard.htm).

#### Настройте SSO для кластера {#example-configuration-sso}

Пусть после настройки провайдера был предоставлен **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_entity_id }}**: `http://www.okta.com/exkv2pzpvigX********`. 

[Настройте SSO для кластера](#configuration-sso). При настройке укажите:
* **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_entity_id }}**: `http://www.okta.com/exkv2pzpvigX********`.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_metadata_file }}**: файл метаданных, предоставленный Okta.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-sp_entity_id }}**: `https://c-c9qmc1lmo2k0********.rw.{{ dns-zone }}`.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-kibana_url }}**: `https://c-c9qmc1lmo2k0********.rw.{{ dns-zone }}`.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_principal }}**: `nameid:persistent`.

#### Настройте роли для SSO с Okta {#example-roles-sso}

Чтобы получить доступ к кластеру через SSO, свяжите роли кластера с пользователями SSO на стороне провайдера. Для этого:

1. Настройте роли для кластера {{ mes-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.elasticsearch.label_kibana }}**.
    1. В окне авторизации укажите пользователя `admin` и пароль, заданный при настройке кластера.
    1. Перейдите в раздел **Management → Stack Management → Security → Role Mappings**.
        
        {% note info %}

        Функция **Role Mappings** доступна в редакции {{ ES }} `Platinum`.

        [Подробнее об изменении редакции {{ ES }}](./cluster-version-update.md#start-edition-update).

        {% endnote %}
        
    1. Нажмите кнопку **Create role mapping**.
    1. Чтобы создать [сопоставление ролей](#roles-sso), заполните поля:
        * **Mapping name** — уникальное имя для сопоставления роли.
        * **Roles** — выбранная роль.
        * **Mapping rules** — правила, по которым будет осуществляться сопоставление.

        Например, чтобы задать правило, которое сопоставит пользователей с доменом `example.com` с ролью `editor`:

        1. Выберите роль `editor`.
        1. Добавьте правило **All are true**.
        1. Добавьте в правило поле `username` типа `text` со значением `*@example.com`.

{% endlist %}

1. Создайте пользователя на стороне Okta:
    1. Перейдите в раздел **Directory → People**
    1. Нажмите кнопку **Add person**.
    1. Укажите параметры пользователя: `First name`, `Last name`, `username`, `password`.

        Они должны удовлетворять указанным правилам сопоставления ролей в {{ mes-name }}.

    1. Нажмите кнопку **Save**.
1. Перейдите в раздел **Applications**.
1. Нажмите кнопку **Assign User to App**.
1. [Назначьте приложение](https://help.okta.com/en/prod/Content/Topics/users-groups-profiles/usgp-assign-apps.htm) нужному пользователю.
1. Нажмите кнопку **Next**.
1. При необходимости скорректируйте указанный `username`. Так будет отображаться имя пользователя в **Kibana**.
1. Нажмите кнопку **Confirm Assignments**.

Чтобы авторизоваться в кластере {{ mes-name }} под новым пользователем:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.elasticsearch.label_kibana }}**.
    1. В окне авторизации выберите вариант, который был указан при [настройке SSO](#configuration-sso) в пункте **Описание провайдера**.
    1. Укажите **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** и **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**.

{% endlist %}
