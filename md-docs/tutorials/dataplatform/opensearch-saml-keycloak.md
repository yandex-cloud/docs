# Аутентификация в OpenSearch Dashboards кластера Yandex Managed Service for OpenSearch с помощью Keycloak

Вы можете использовать [Keycloak](https://www.keycloak.org/) для [аутентификации пользователей](../../managed-opensearch/operations/saml-authentication.md), которые работают с OpenSearch Dashboards в кластере Yandex Managed Service for OpenSearch.

Чтобы настроить аутентификацию:

1. [Настройте провайдер идентификации](#configure-idp).
1. [Настройте SSO для кластера](#configure-sso).
1. [Настройте роли для SSO](#map-roles).
1. [Проверьте работу SSO](#test-sso).

{% note info %}

Это практическое руководство проверялось для кластера OpenSearch 2.8 и Keycloak 24.0.

{% endnote %}


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for OpenSearch: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы Managed Service for OpenSearch](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

1. Убедитесь, что вы можете [подключиться к OpenSearch Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards) с использованием реквизитов пользователя `admin`.

    В этом практическом руководстве предполагается, что веб-интерфейс OpenSearch Dashboards доступен по URL:

    ```url
    https://c-cat0adul1fj0********.rw.mdb.yandexcloud.net/
    ```

1. Убедитесь, что вы можете работать с Keycloak:

    * Проверьте, что есть доступ к Keycloak.
    * Проверьте, что есть доступ к нужному [realm](https://www.keycloak.org/docs/latest/server_admin/#configuring-realms).
    * Проверьте, что есть достаточные права в этом realm для управления:

        * Ролями.
        * Пользователями и группами.
        * Клиентами (так в терминологии Keycloak называются приложения, с помощью которых происходит аутентификация).

    В этом практическом руководстве предполагается, что:

    * Для управления Keycloak используется [аккаунт суперадминистратора](https://www.keycloak.org/docs/latest/server_admin/index.html#creating-first-admin_server_administration_guide), который позволяет выполнять любые операции в любом realm.
    * Все операции выполняются в realm с именем `master`.
    * Keycloak доступен по URL:

        ```url
        http://keycloak.example.com:8080
        ```

    * Консоль администратора Keycloak доступна по URL:

        ```url
        http://keycloak.example.com:8080/admin/
        ```

## Настройте провайдер идентификации {#configure-idp}

1. Подключитесь к консоли управления Keycloak и выберите realm с именем `master`.

1. Создайте клиент:
    1. На панели слева выберите **Clients**. Нажмите кнопку **Create client**.
    1. В поле **Client type** выберите вариант **SAML**.
    1. В поле **Client ID** укажите идентификатор клиента.

        Этот идентификатор должен совпадать с URL для подключения к OpenSearch Dashboards:

        ```url
        https://c-cat0adul1fj0********.rw.mdb.yandexcloud.net/
        ```

    1. Нажмите кнопку **Next**.

    1. Укажите ACS URL в полях:

        * **Home URL**;
        * **Valid redirect URIs**;
        * **IDP Initiated SSO Relay State**.

        ACS URL имеет вид:

        ```url
        https://c-cat0adul1fj0********.rw.mdb.yandexcloud.net/_opendistro/_security/saml/acs
        ```

    1. Нажмите кнопку **Save**.

1. Убедитесь, что использование клиента разрешено: опция в правом верхнем углу должна быть включена (**Enabled**).

1. На вкладке **Settings** настройте параметры клиента следующим образом:

    * **SAML Capabilities**:
        * **Name ID format** — `email`.
        * **Force name ID format** — убедитесь, что эта опция включена.
        * **Force POST binding** — убедитесь, что эта опция включена.
        * **Include AuthnStatement** — убедитесь, что эта опция включена.

    * **Signature and Encryption**:
        * **Sign documents** — убедитесь, что эта опция включена.
        * **Sign assertions** — убедитесь, что эта опция включена.
        * **Signature algorithm** — `RSA_SHA256`.
        * **SAML signature key name** — `CERT_SUBJECT`.
        * **Canonicalization method** — `EXCLUSIVE`.

1. Нажмите кнопку **Save**.

1. На вкладке **Keys** отключите требование подписи сообщений от клиента.

    Для этого отключите опцию **Client signature required**.


1. На вкладке **Client scopes** настройте сопоставление ролей для клиента:

   {% note info %}
   
   Если на вкладке **Client scopes** в списке **Assigned Default Client Scopes** присутствует сопоставление ролей `role_list`, рекомендуется удалить это сопоставление во избежание проблем с проверкой SAML-ответа.
   
   {% endnote %}
   
    1. Нажмите на URL для подключения к OpenSearch Dashboards с суффиксом `-dedicated`.

    1. На вкладке **Mappers** нажмите **Configure a new mapper**. Выберите из списка маппер **Role list**.

    1. Укажите следующие настройки маппера:

        * **Name** — любое имя маппера, например `OpenSearch Mapper`.
        * **Role attribute name** — `roles`.
        * **SAML Attribute NameFormat** — `Basic`;
        * **Single Role Attribute** — убедитесь, что эта опция включена.

    1. Нажмите кнопку **Save**.

## Настройте SSO для кластера {#configure-sso}

1. Получите метаданные для [созданного ранее клиента](#configure-idp):

    1. Подключитесь к консоли управления Keycloak и выберите realm с именем `master`.
    1. На панели слева выберите **Clients**.
    1. Нажмите на URL для подключения к OpenSearch Dashboards.
    1. В правом верхнем углу раскройте меню **Action** и выберите пункт **Download adapter config**.
    1. Выберите формат `Mod Auth Mellon Files` и нажмите кнопку **Download**.

        Будет загружен архив.

    1. Извлеките файл `idp-metadata.xml` из этого архива. В этом файле содержатся необходимые метаданные.

1. Настройте SSO для кластера.

    {% note tip %}

    Далее приведены инструкции для консоли управления, но можно [использовать и другие доступные интерфейсы Yandex Cloud](../../managed-opensearch/operations/saml-authentication.md#configuration-sso).

    {% endnote %}

    Чтобы настроить источник аутентификации Keycloak:

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. Перейдите в сервис **Managed Service for&nbsp;OpenSearch**.
    1. Нажмите на имя нужного кластера и выберите вкладку **Источники аутентификации**.
    1. Нажмите кнопку **Настроить**.
    1. Укажите нужные значения настроек:

        * **idp_entity_id** — идентификатор провайдера.

            Для Keycloak этот идентификатор совпадает с URL, который указывает на realm с именем `master`:

            ```url
            http://keycloak.example.com:8080/realms/master
            ```

        * **idp_metadata_file** — выберите и загрузите файл с метаданными, извлеченный из архива.

        * **sp_entity_id** — идентификатор поставщика услуг.

            Используйте тот же идентификатор, который [был указан при настройке клиента](#configure-idp) Keycloak в поле **Client ID**:

            ```url
            https://c-cat0adul1fj0********.rw.mdb.yandexcloud.net/
            ```

        * **kibana_url** — URL для подключения к OpenSearch Dashboards.

        * **roles_key** — атрибут, в котором хранится перечень ролей.

            Укажите тот же атрибут, который [был настроен для маппера](#configure-idp) Keycloak — `roles`.

        * **subject_key** — оставьте поле пустым.

        * **Таймаут сессии** — оставьте значение `0`.

        * **Активировать** — убедитесь, что эта опция включена.

    1. Нажмите кнопку **Сохранить**.

1. Дождитесь, когда статус кластера изменится на `Running`. Применение настроек может занять несколько минут.

## Настройте роли для SSO {#map-roles}

1. Настройте Keycloak так, чтобы его пользователям назначались нужные роли:

    1. Подключитесь к консоли управления Keycloak и выберите realm с именем `master`.

    1. Создайте роль:

        1. На панели слева выберите **Realm roles**. Нажмите кнопку **Create role**.
        1. Введите имя роли в поле **Role name**.

            Далее используется имя роли `kc_demo_role`.

        1. Нажмите кнопку **Save**.

    1. Создайте пользователя и настройте его:

        1. На панели слева выберите **Users**. Нажмите кнопку **Add user**.

        1. Укажите реквизиты пользователя:

            * **Username** — имя аккаунта.

                Далее используется имя аккаунта `kc_demo_user`.

            * **Email** — адрес электронной почты.

                Далее используется адрес `kc_demo_user@example.com`.

            * **Email verified** — убедитесь, что эта настройка включена.

                {% note info %}

                Для упрощения изложения в этом практическом руководстве эта настройка включена, чтобы не проходить верификацию по email при первом логине.

                {% endnote %}

        1. Нажмите кнопку **Create**.
        1. На вкладке **Credentials** нажмите кнопку **Set password** и задайте пароль.

            Также отключите настройку **Temporary**.

            {% note info %}

            Для упрощения изложения в этом практическом руководстве эта настройка отключена, чтобы не менять пароль при первом логине.

            {% endnote %}

    1. Создайте группу и настройте ее:

        1. На панели слева выберите **Groups** и нажмите кнопку **Create group**.
        1. Введите имя группы и нажмите кнопку **Create**.

           Далее используется имя группы `kc_demo_group`.

        1. Нажмите на имя группы, чтобы открыть ее свойства.
        1. На вкладке **Members** нажмите кнопку **Add member**, выберите пользователя `kc_demo_user`, затем нажмите кнопку **Add**.
        1. На вкладке **Role mapping** нажмите кнопку **Assign role**, включите фильтр **Filter by realm roles**, выберите роль `kc_demo_role` из списка, затем нажмите кнопку **Assign**.

1. Сопоставьте роли кластера OpenSearch с ролями на стороне Keycloak. Это позволит получить доступ к кластеру через SSO.

    Чтобы сопоставить роли:

    1. [Подключитесь](../../managed-opensearch/operations/connect/clients.md#dashboards) к OpenSearch Dashboards от имени пользователя `admin`.
    1. В меню слева выберите **OpenSearch Plugins** → **Security**.
    1. На панели слева выберите **Roles**.
    1. Настройте сопоставления ролей:

        1. Нажмите на имя нужной роли.

            Далее предполагается, что была выбрана роль `kibana_user`.

        1. Перейдите на вкладку **Mapped users**.
        1. Нажмите кнопку **Manage mapping**.
        1. В блоке **Backend roles** введите имя роли в Keycloak, с которой будет сопоставлена роль в OpenSearch, и нажмите кнопку **Map**.

            Далее предполагается, что была выбрана роль `kc_demo_role`.

Теперь пользователи Keycloak, добавленные в группу `kc_demo_group`, будут получать роль `kc_demo_role`.

Если при подключении к OpenSearch Dashboards аутентификация пройдет успешно, то пользователь с ролью `kc_demo_role` получит роль `kibana_user` в OpenSearch.

## Проверьте работу SSO {#test-sso}

1. Откройте браузер в гостевом режиме или режиме инкогнито.

    Это действие нужно выполнять с компьютера, который имеет доступ к Keycloak.

1. [Подключитесь](../../managed-opensearch/operations/connect/clients.md#dashboards) к OpenSearch Dashboards.

    На странице логина нажмите кнопку **Log in with single sign-on** вместо ввода имени пользователя и пароля.

    Если все настроено правильно, браузер перенаправит вас на страницу аутентификации в Keycloak.

1. Введите реквизиты пользователя `kc_demo_user` и нажмите кнопку **Sign in**.

    После успешной аутентификации Keycloak перенаправит вас на ACS URL, затем вы будете перенаправлены на главную страницу OpenSearch Dashboards.

1. Убедитесь, что пользователю назначена роль `kibana_user` в OpenSearch.

    Для этого нажмите на аватар пользователя в верхнем правом углу и выберите пункт **View roles and identities**. Будут показаны назначенные пользователю роли.

1. Убедитесь, что вы можете выполнять все действия, которые разрешены для роли `kibana_user`.