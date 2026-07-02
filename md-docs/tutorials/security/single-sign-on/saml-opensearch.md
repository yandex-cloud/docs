[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > [Безопасность](../index.md) > Настройка единого входа в приложения (SSO) > Managed Service for OpenSearch

# Создать SAML-приложение в Yandex Identity Hub для интеграции с Managed Service for OpenSearch

[OpenSearch](https://opensearch.org/) — это легко масштабируемая система поисковых и аналитических инструментов с открытым исходным кодом. OpenSearch включает в себя пользовательский интерфейс визуализации данных [OpenSearch Dashboards](https://docs.opensearch.org/latest/dashboards/). [Yandex Managed Service for OpenSearch](../../../managed-opensearch/index.md) — сервис для управления кластерами OpenSearch в инфраструктуре Yandex Cloud. Managed Service for OpenSearch поддерживает SAML-аутентификацию для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Managed Service for OpenSearch с помощью технологии единого входа по стандарту [SAML](https://ru.wikipedia.org/wiki/SAML), создайте [SAML-приложение](../../../organization/concepts/applications/saml.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне кластера OpenSearch.

Управлять SAML-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-admin) `organization-manager.samlApplications.admin` или выше.

## Перед началом работы {#before-you-begin}

Убедитесь, что вы можете [подключиться к OpenSearch Dashboards](../../../managed-opensearch/operations/connect/clients.md#dashboards) с использованием реквизитов пользователя `admin`. О том, как создать и настроить кластер OpenSearch, смотрите в разделе [Создание кластера OpenSearch](../../../managed-opensearch/operations/cluster-create.md).

В этом практическом руководстве предполагается, что веб-интерфейс OpenSearch Dashboards доступен по URL:

```url
https://c-cat0adul1fj0********.rw.mdb.yandexcloud.net/
```

Чтобы дать доступ пользователям вашей организации в Managed Service for OpenSearch:

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

Чтобы настроить интеграцию Managed Service for OpenSearch с созданным SAML-приложением в Yandex Identity Hub, выполните настройки на стороне кластера OpenSearch и на стороне Yandex Identity Hub.

1. Получите метаданные для [созданного ранее приложения](#create-app):

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите созданное ранее SAML-приложение.
    1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значение параметра `Issuer / IdP EntityID`, которое необходимо задать на стороне кластера OpenSearch.
    1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** нажмите кнопку **Скачать файл с метаданными**.

      Скачанный [XML](https://ru.wikipedia.org/wiki/XML)-файл содержит необходимые метаданные и сертификат, который используется для проверки подписи SAML-ответов.

1. Настройте SSO для кластера OpenSearch.

    {% note tip %}

    Далее приведены инструкции для консоли управления, но можно [использовать и другие доступные интерфейсы Yandex Cloud](../../../managed-opensearch/operations/saml-authentication.md#configuration-sso).

    {% endnote %}

    Чтобы настроить источник аутентификации Yandex Identity Hub:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;OpenSearch**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Источники аутентификации**.
    1. Нажмите кнопку **Настроить**.
    1. Укажите нужные значения настроек:

        * **idp_entity_id** — идентификатор провайдера. Введите сохраненное ранее значение параметра `Issuer / IdP EntityID`.

        * **idp_metadata_file** — выберите и загрузите ранее скачанный файл с метаданными.

        * **sp_entity_id** — идентификатор поставщика услуг.
        
            Этот идентификатор должен совпадать с URL для подключения к OpenSearch Dashboards:

            ```url
            https://c-cat0adul1fj0********.rw.mdb.yandexcloud.net/
            ```

        * **kibana_url** — URL для подключения к OpenSearch Dashboards.

        * **roles_key** — атрибут, в котором хранится перечень ролей. Укажите значение `groups`.

        * **subject_key** — оставьте поле пустым.

        * **Таймаут сессии** — оставьте значение `0`.

        * **Активировать** — убедитесь, что эта опция включена.

    1. Нажмите кнопку **Сохранить**. Дождитесь, когда статус кластера изменится на `Running`. Применение настроек может занять несколько минут.

1. Настройте сопоставление ролей в OpenSearch.

    Чтобы группы пользователей Yandex Identity Hub сопоставлялись с ролями OpenSearch при аутентификации:

    1. Подключитесь к OpenSearch Dashboards от имени пользователя `admin`.
    1. В меню слева выберите **OpenSearch Plugins** → **Security**.
    1. На панели слева выберите **Roles**.
    1. Настройте сопоставления ролей:
        1. Нажмите на имя нужной роли. В данном руководстве это роль `kibana_user`.
        1. Перейдите на вкладку **Mapped users**.
        1. Нажмите кнопку **Manage mapping**.
        1. В блоке **Backend roles** введите имя [группы пользователей](../../../organization/concepts/groups.md) Yandex Identity Hub, которой будет сопоставлена роль в OpenSearch, например, `opensearch-users`.
        1. Нажмите кнопку **Map**.
    
    Теперь пользователи вашей организации, добавленные в группу `opensearch-users`, будут получать роль `kibana_user` при успешной аутентификации в OpenSearch Dashboards.

### Настройте SAML-приложение на стороне Yandex Identity Hub {#setup-idp}

#### Настройте эндпоинты поставщика услуг {#sp-endpoints}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:  
      1. В поле **SP EntityID** укажите URL для подключения к OpenSearch Dashboards.
      1. В поле **ACS URL** укажите ACS URL.

        ACS URL имеет вид:

        ```url
        https://c-cat0adul1fj0********.rw.mdb.yandexcloud.net/_opendistro/_security/saml/acs
        ```
      1. Нажмите **Сохранить**.

{% endlist %}

#### Добавьте атрибут групп пользователей {#group-attribute}

Необходимо, чтобы пользователи в OpenSearch при входе получали одну из базовых ролей. Чтобы это выполнялось, источник аутентификации Yandex Identity Hub должен передавать в SAML-ответе список групп пользователей, которым в OpenSearch будут сопоставлены роли. Для этого:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. В правом верхнем углу страницы нажмите ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **Добавить атрибут группы** и в открывшемся окне:
    1. В поле **Имя атрибута** оставьте значение `groups`.
    1. В поле **Передаваемые группы** выберите `Только назначенные группы`.
    1. Нажмите **Добавить**.

{% endlist %}

Подробнее о настройке атрибутов смотрите в разделе [Настройте атрибуты пользователей и групп](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Добавьте пользователей {#add-users}

Чтобы пользователи вашей организации могли аутентифицироваться в OpenSearch Dashboards с помощью SAML-приложения Yandex Identity Hub, необходимо явно добавить в SAML-приложение нужных пользователей и группы пользователей.

{% note info %}

Управлять пользователями и группами, добавленными в SAML-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) `organization-manager.samlApplications.userAdmin` или выше.

{% endnote %}

1. Если вы настроили сопоставление ролей на стороне Managed Service for OpenSearch, [создайте](../../../organization/operations/create-group.md) нужные группы:

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![groups](../../../_assets/console-icons/persons.svg) **Группы**.
        1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать группу**.
        1. Задайте название, например, `opensearch-users`. Название группы должно точно соответствовать имени группы пользователей, указанному при сопоставлении с ролью OpenSearch.
        1. Нажмите **Создать группу**.
        1. Добавьте пользователей в группу:
            1. Перейдите на вкладку **Участники**.  
            1. Нажмите **Добавить участника**.
            1. В открывшемся окне выберите нужных пользователей.
            1. Нажмите **Сохранить**.

    {% endlist %}

1. Добавьте пользователей в приложение:

    {% list tabs group=instructions %}

    - Интерфейс Cloud Center {#cloud-center}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное приложение.
        1. Перейдите на вкладку **Пользователи и группы**.
        1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **Добавить пользователей**.
        1. В открывшемся окне выберите нужного пользователя или группу пользователей.
        1. Нажмите **Добавить**.

    {% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../organization/concepts/authentication-policy.md).

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе SAML-приложения и интеграции с Managed Service for OpenSearch, выполните аутентификацию в OpenSearch Dashboards от имени одного из добавленных в приложение пользователей. Для этого:

1. В браузере перейдите по адресу вашего экземпляра OpenSearch Dashboards.
1. Если вы были авторизованы в OpenSearch Dashboards, выйдите из профиля.
1. На странице аутентификации OpenSearch Dashboards нажмите **Log in with single sign-on**.
1. На странице аутентификации Yandex Cloud укажите адрес электронной почты и пароль пользователя. Пользователь должен состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в OpenSearch Dashboards.
1. Если вы настроили сопоставление ролей, то:
     1. Нажмите на иконку пользователя в OpenSearch Dashboards.
     1. Перейдите в **View roles and identities**.
     1. Убедитесь, что в блоке **Roles** отображается роль `kibana_user`, а в блоке **Backend roles** — роль `opensearch-users`.