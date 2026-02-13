# Создать SAML-приложение в {{ org-full-name }} для интеграции с {{ OS }}

[{{ OS }}](https://opensearch.org/) — это легко масштабируемая система поисковых и аналитических инструментов с открытым исходным кодом. {{ OS }} включает в себя пользовательский интерфейс визуализации данных [{{ OS }} Dashboards](https://docs.opensearch.org/latest/dashboards/). 

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в {{ OS }} с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications.md#saml) в {{ org-name }}, настройте его на стороне {{ org-name }} и на стороне {{ OS }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

Чтобы дать доступ пользователям вашей организации в {{ OS }}:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}**.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `opensearch-app`.

        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию {{ OS }} с созданным SAML-приложением в {{ org-name }}, выполните настройки на стороне кластера {{ OS }} и на стороне {{ org-name }}.

1. Получите метаданные для [созданного ранее приложения](#create-app):

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите созданное ранее SAML-приложение.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значение параметра `Issuer / IdP EntityID`, которое необходимо задать на стороне кластера {{ OS }}.
    1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит необходимые метаданные и сертификат, который используется для проверки подписи SAML-ответов.

1. Настройте SAML-аутентификацию для кластера {{ OS }}.

    Настройка производится путём изменения конфигурационных файлов `config.yml` и `roles_mapping.yml` плагина **{{ OS }} Security Plugin**, по умолчанию находящихся в каталоге `/etc/opensearch/opensearch-security/`, а также файла **{{ OS }} Dashboards** `opensearch_dashboards.yml`, по умолчанию расположенного в каталоге `/etc/opensearch-dashboards/`.

    1. Поместите ранее загруженный файл метаданных `idp-metadata.xml` в каталог плагина **{{ OS }} Security Plugin** (например, `/etc/opensearch/opensearch-security/saml/`). 
   
    1. Убедитесь, что пользователь {{ OS }} (обычно `opensearch`) имеет права на чтение этого файла.
   
        ```bash
        sudo chown opensearch:opensearch /etc/opensearch/opensearch-security/saml/idp-metadata.xml
   
        sudo chmod 644 /etc/opensearch/opensearch-security/saml/idp-metadata.xml
        ```

    1. Сгенерируйте ключ `exchange_key` для подписи токенов **JSON Web Tokens (JWT)**. 

        {% note tip %}

        Ключ **JSON Web Tokens (JWT)** должен представлять собой строку, сгенерированную с использованием алгоритма HMAC256. Вы можете использовать онлайн‑генераторы или утилиты командной строки, создающие криптографически надёжные строки с поддержкой данного алгоритма.

        {% endnote %}

    1. Добавьте новый домен аутентификации SAML `yandex_saml_auth_domain` в секции `authc` файла `config.yml` и укажите параметры как показано ниже.

        ```yaml
        authc:
         # ... (оставьте существующий basic_internal_auth для служебного пользователя) ...

         # Домен аутентификации SAML для {{ org-full-name }}
         yandex_saml_auth_domain:
           order: 1 # Рекомендуется: 1 или 2
           http_enabled: true
           transport_enabled: false
           http_authenticator:
             type: saml
             challenge: true
             config:
               # --- Настройки IdP ({{ org-full-name }}) ---
               idp:
                 # Путь к загруженному XML-файлу метаданных 
                 metadata_file: "/etc/opensearch/opensearch-security/saml/idp-metadata.xml"

               # --- Настройки SP ({{ OS }}) ---
               sp:
                 # Параметр должен совпадать с SP EntityID, который указан в {{ org-full-name }}
                 entity_id: "opensearch-saml-sso" 
        
               # URL-адрес вашего Dashboards
               kibana_url: "https://<your-dashboards-url>/"
          
               # Ключ для подписи токенов JWT
               exchange_key: "5efe29a39306bed6bd4f67af06d54d813ff8b05692ef480204c917602ffdd9a9"

               # --- Настройка групп доступа ---
               # Имя атрибута в SAML-ответе, содержащего группы
               roles_key: "groups" 
         
        # ... 
        ```
        {% note tip %}

        В современных версиях плагина **{{ OS }} Security Plugin** добавлен параметр `metadata_url`, позволяющий напрямую загружать файл метаданных из {{ org-full-name }}. Если ваша версия поддерживает этот параметр, вам не потребуется загружать и размещать файл метаданных на сервер. Для настройки достаточно заменить параметр `metadata_file` в конфигурационном файле `config.yml` на параметр `metadata_url`.
    
        ```yaml
        # ... 

        # --- Настройки IdP ({{ org-full-name }}) ---
        idp:
          # URL XML-файла метаданных 
          metadata_url: "https://auth.yandex.cloud/saml/metadata/ek0vbjom..." 

        # ... 
        ```
      
        {% endnote %}

    1. Чтобы сопоставить группы пользователей {{ org-full-name }} с внутренними ролями {{ OS }} при SAML-аутентификации, отредактируйте файл `roles_mapping.yml` плагина **{{ OS }} Security Plugin**. Добавьте требуемые [группы](../../../organization/concepts/groups.md) из {{ org-name }} в секцию `backend_roles` соответствующих ролей в {{ OS }}, как показано ниже.

        ```yaml
        # ...
 
        # Группа "opensearch-users" из {{ org-full-name }} 
        # сопоставляется с ролью "all_access" в {{ OS }}
        all_access:
          reserved: false
          backend_roles:
            - "admin"
            - "opensearch-users" # группа созданная в {{ org-name }} 
          description: "Allow full access for opensearch-users group from {{ org-name }}"
  
        # ... 
        ```

        {% note tip %}

        В качестве альтернативного варианта сопоставления ролей можно использовать веб‑интерфейс {{ OS }} Dashboards.

        {% endnote %}
        
        {% cut "Сопоставление ролей через веб‑интерфейс {{ OS }} Dashboards" %}
        
        1. Войдите в {{ OS }} Dashboards под учётной записью `admin`.
        1. В левом боковом меню перейдите в раздел: **Management** → **Security**.
        1. В левой панели выберите пункт **Roles**.
        1. Настройте сопоставления ролей:
            1. Кликните на название необходимой роли (например, `all_access`).
            1. Перейдите на вкладку **Mapped users**.
            1. Нажмите кнопку **Manage mapping**.
            1. В поле **Backend roles** укажите [группу пользователей](../../../organization/concepts/groups.md) {{ org-name }}, которую требуется сопоставить с ролью {{ OS }}, например `opensearch-users`.
            1. Нажмите кнопку **Map**.

        {% endcut %}

    1. После изменений в файлах `config.yml` и `roles_mapping.yml` необходимо загрузить новую конфигурацию в кластер вашего {{ OS }}. Для этого используйте скрипт `securityadmin.sh`.
   
        ```bash
        # Убедитесь, что вы используете правильные пути к сертификатам и ключам
        # и что securityadmin.sh запущен с правами администратора.

        sudo "/usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh" \
            -cd "/etc/opensearch/opensearch-security" \
            -icl \
            -key "<путь_к_вашему_ключу>" \
            -cert "<путь_к_вашему_сертификату>" \
            -cacert "<путь_к_корневому_сертификату_CA>" \
            -nhnv
        ```

    1. Внесите изменения в конфигурационный файл {{ OS }} Dashboards `opensearch_dashboards.yml` следующим образом:

        ```yaml
        # ...

        # Включите множественную аутентификацию
        opensearch_security.auth.multiple_auth_enabled: true

        # Укажите доступные типы аутентификации
        # (оставьте basic для служебного пользователя)
        opensearch_security.auth.type: [basicauth, saml]

        # ... 
        ```

    1. Перезапустите сервисы {{ OS }}.
   
        ```bash
        sudo systemctl restart opensearch
        sudo systemctl restart opensearch-dashboards
        ```

### Настройте SAML-приложение на стороне {{ org-full-name }} {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите необходимое SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:  
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** укажите `opensearch-saml-sso`.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** укажите адрес `https://<your-dashboards-url>/_opendistro/_security/saml/acs`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Добавьте атрибут групп пользователей {#group-attribute}

Чтобы настроить механизм автоматической привязки пользователей к соответствующим ролям при входе в систему {{ OS }}, добавьте атрибут группы пользователей. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** и в открывшемся окне:
    1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** оставьте значение `groups`.
    1. В поле **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** выберите `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

Подробнее о настройке атрибутов см. [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в {{ OS }} Dashboards с помощью SAML‑приложения {{ org-name }}, необходимо явно добавить в это приложение пользователей и группы.

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. После настройки сопоставления ролей на стороне {{ OS }} [создайте](../../../organization/operations/create-group.md) требуемые [группы](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Задайте название группы (например, `opensearch-users`). Оно должно полностью совпадать с именем группы, указанным при сопоставлении с ролью в {{ OS }}.
        1. Нажмите **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Добавьте пользователей в группу:
            1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.  
            1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. В открывшемся окне выберите необходимых пользователей.
            1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}

1. Добавьте пользователей в приложение:

    {% list tabs group=instructions %}

    - Интерфейс {{ cloud-center }} {#cloud-center}

        1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите необходимое приложение.
        1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
        1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
        1. В открывшемся окне выберите требуемого пользователя или группу пользователей.
        1. Нажмите **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы SAML‑приложения и его интеграцию с {{ OS }}, выполните аутентификацию в {{ OS }} Dashboards под учётной записью одного из пользователей, добавленных в приложение. Для этого:

1. В браузере перейдите по адресу вашего экземпляра {{ OS }} Dashboards.
1. Если вы были авторизованы в {{ OS }} Dashboards, выйдите из профиля.
1. На странице аутентификации {{ OS }} Dashboards нажмите **Log in with single sign-on**.
1. На странице аутентификации {{ yandex-cloud }} укажите адрес электронной почты и пароль пользователя. Пользователь должен состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в {{ OS }} Dashboards.
1. Если вы настроили сопоставление ролей, то:
     1. Нажмите на иконку пользователя в {{ OS }} Dashboards.
     1. Перейдите в **View roles and identities**.
     1. Убедитесь, что в блоке **Roles** отображается роль `all_access`, а в блоке **Backend roles** — `opensearch-users`.