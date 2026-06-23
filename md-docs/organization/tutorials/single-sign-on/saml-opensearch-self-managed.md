# Создать SAML-приложение в Yandex Identity Hub для интеграции с OpenSearch

[OpenSearch](https://opensearch.org/) — это легко масштабируемая система поисковых и аналитических инструментов с открытым исходным кодом. OpenSearch включает в себя пользовательский интерфейс визуализации данных [OpenSearch Dashboards](https://docs.opensearch.org/latest/dashboards/). 

Чтобы пользователи вашей [организации](../../concepts/organization.md) могли аутентифицироваться в OpenSearch с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../concepts/applications/saml.md) в Yandex Identity Hub, настройте его на стороне Yandex Identity Hub и на стороне OpenSearch.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

Чтобы дать доступ пользователям вашей организации в OpenSearch:

1. [Создайте приложение](#create-app).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе приложения](#validate).

## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
        1. Выберите метод единого входа **SAML (Security Assertion Markup Language)**.
        1. В поле **Имя** задайте имя создаваемого приложения: `opensearch-app`.

        1. (Опционально) В поле **Описание** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **Добавить метку**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **Создать приложение**.

{% endlist %}

## Настройте интеграцию {#setup-integration}

Чтобы настроить интеграцию OpenSearch с созданным SAML-приложением в Yandex Identity Hub, выполните настройки на стороне кластера OpenSearch и на стороне Yandex Identity Hub.

1. Получите метаданные для [созданного ранее приложения](#create-app):

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите созданное ранее SAML-приложение.
    1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значение параметра `Issuer / IdP EntityID`, которое необходимо задать на стороне кластера OpenSearch.
    1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** нажмите кнопку **Скачать файл с метаданными**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит необходимые метаданные и сертификат, который используется для проверки подписи SAML-ответов.

1. Настройте SAML-аутентификацию для кластера OpenSearch.

    Настройка производится путём изменения конфигурационных файлов `config.yml` и `roles_mapping.yml` плагина **OpenSearch Security Plugin**, по умолчанию находящихся в каталоге `/etc/opensearch/opensearch-security/`, а также файла **OpenSearch Dashboards** `opensearch_dashboards.yml`, по умолчанию расположенного в каталоге `/etc/opensearch-dashboards/`.

    1. Поместите ранее загруженный файл метаданных `idp-metadata.xml` в каталог плагина **OpenSearch Security Plugin** (например, `/etc/opensearch/opensearch-security/saml/`). 
   
    1. Убедитесь, что пользователь OpenSearch (обычно `opensearch`) имеет права на чтение этого файла.
   
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

         # Домен аутентификации SAML для Yandex Identity Hub
         yandex_saml_auth_domain:
           order: 1 # Рекомендуется: 1 или 2
           http_enabled: true
           transport_enabled: false
           http_authenticator:
             type: saml
             challenge: true
             config:
               # --- Настройки IdP (Yandex Identity Hub) ---
               idp:
                 # Путь к загруженному XML-файлу метаданных 
                 metadata_file: "/etc/opensearch/opensearch-security/saml/idp-metadata.xml"

               # --- Настройки SP (OpenSearch) ---
               sp:
                 # Параметр должен совпадать с SP EntityID, который указан в Yandex Identity Hub
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

        В современных версиях плагина **OpenSearch Security Plugin** добавлен параметр `metadata_url`, позволяющий напрямую загружать файл метаданных из Yandex Identity Hub. Если ваша версия поддерживает этот параметр, вам не потребуется загружать и размещать файл метаданных на сервер. Для настройки достаточно заменить параметр `metadata_file` в конфигурационном файле `config.yml` на параметр `metadata_url`.
    
        ```yaml
        # ... 

        # --- Настройки IdP (Yandex Identity Hub) ---
        idp:
          # URL XML-файла метаданных 
          metadata_url: "https://auth.yandex.cloud/saml/metadata/ek0vbjom..." 

        # ... 
        ```
      
        {% endnote %}

    1. Чтобы сопоставить группы пользователей Yandex Identity Hub с внутренними ролями OpenSearch при SAML-аутентификации, отредактируйте файл `roles_mapping.yml` плагина **OpenSearch Security Plugin**. Добавьте требуемые [группы](../../concepts/groups.md) из Yandex Identity Hub в секцию `backend_roles` соответствующих ролей в OpenSearch, как показано ниже.

        ```yaml
        # ...
 
        # Группа "opensearch-users" из Yandex Identity Hub 
        # сопоставляется с ролью "all_access" в OpenSearch
        all_access:
          reserved: false
          backend_roles:
            - "admin"
            - "opensearch-users" # группа созданная в Yandex Identity Hub 
          description: "Allow full access for opensearch-users group from Yandex Identity Hub"
  
        # ... 
        ```

        {% note tip %}

        В качестве альтернативного варианта сопоставления ролей можно использовать веб‑интерфейс OpenSearch Dashboards.

        {% endnote %}
        
        {% cut "Сопоставление ролей через веб‑интерфейс OpenSearch Dashboards" %}
        
        1. Войдите в OpenSearch Dashboards под учётной записью `admin`.
        1. В левом боковом меню перейдите в раздел: **Management** → **Security**.
        1. В левой панели выберите пункт **Roles**.
        1. Настройте сопоставления ролей:
            1. Кликните на название необходимой роли (например, `all_access`).
            1. Перейдите на вкладку **Mapped users**.
            1. Нажмите кнопку **Manage mapping**.
            1. В поле **Backend roles** укажите [группу пользователей](../../concepts/groups.md) Yandex Identity Hub, которую требуется сопоставить с ролью OpenSearch, например `opensearch-users`.
            1. Нажмите кнопку **Map**.

        {% endcut %}

    1. После изменений в файлах `config.yml` и `roles_mapping.yml` необходимо загрузить новую конфигурацию в кластер вашего OpenSearch. Для этого используйте скрипт `securityadmin.sh`.
   
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

    1. Внесите изменения в конфигурационный файл OpenSearch Dashboards `opensearch_dashboards.yml` следующим образом:

        ```yaml
        # ...

        # Включите множественную аутентификацию
        opensearch_security.auth.multiple_auth_enabled: true

        # Укажите доступные типы аутентификации
        # (оставьте basic для служебного пользователя)
        opensearch_security.auth.type: [basicauth, saml]

        # ... 
        ```

    1. Перезапустите сервисы OpenSearch.
   
        ```bash
        sudo systemctl restart opensearch
        sudo systemctl restart opensearch-dashboards
        ```

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите необходимое SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** укажите `opensearch-saml-sso`.
      1. В поле **ACS URL** укажите адрес `https://<your-dashboards-url>/_opendistro/_security/saml/acs`.
      1. Нажмите **Сохранить**.

{% endlist %}

#### Добавьте атрибут групп пользователей {#group-attribute}

Чтобы настроить механизм автоматической привязки пользователей к соответствующим ролям при входе в систему OpenSearch, добавьте атрибут группы пользователей. Для этого:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **Добавить атрибут группы** и в открывшемся окне:
    1. В поле **Имя атрибута** оставьте значение `groups`.
    1. В поле **Передаваемые группы** выберите `Только назначенные группы`.
    1. Нажмите **Добавить**.

{% endlist %}

Подробнее о настройке атрибутов смотрите в разделе [Настройте атрибуты пользователей и групп](../../operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в OpenSearch Dashboards с помощью SAML‑приложения Yandex Identity Hub, необходимо явно добавить в это приложение пользователей и группы.

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. После настройки сопоставления ролей на стороне OpenSearch [создайте](../../operations/create-group.md) требуемые [группы](../../concepts/groups.md):

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **Группы**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать группу**.
        1. Задайте название группы (например, `opensearch-users`). Оно должно полностью совпадать с именем группы, указанным при сопоставлении с ролью в OpenSearch.
        1. Нажмите **Создать группу**.
        1. Добавьте пользователей в группу:
            1. Перейдите на вкладку **Участники**.  
            1. Нажмите **Добавить участника**.
            1. В открывшемся окне выберите необходимых пользователей.
            1. Нажмите **Сохранить**.

    {% endlist %}

1. Добавьте пользователей в приложение:

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите необходимое приложение.
        1. Перейдите на вкладку **Пользователи и группы**.
        1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
        1. В открывшемся окне выберите требуемого пользователя или группу пользователей.
        1. Нажмите **Добавить**.

    {% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы проверить корректность работы SAML‑приложения и его интеграцию с OpenSearch, выполните аутентификацию в OpenSearch Dashboards под учётной записью одного из пользователей, добавленных в приложение. Для этого:

1. В браузере перейдите по адресу вашего экземпляра OpenSearch Dashboards.
1. Если вы были авторизованы в OpenSearch Dashboards, выйдите из профиля.
1. На странице аутентификации OpenSearch Dashboards нажмите **Log in with single sign-on**.
1. На странице аутентификации Yandex Cloud укажите адрес электронной почты и пароль пользователя. Пользователь должен состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в OpenSearch Dashboards.
1. Если вы настроили сопоставление ролей, то:
     1. Нажмите на иконку пользователя в OpenSearch Dashboards.
     1. Перейдите в **View roles and identities**.
     1. Убедитесь, что в блоке **Roles** отображается роль `all_access`, а в блоке **Backend roles** — `opensearch-users`.