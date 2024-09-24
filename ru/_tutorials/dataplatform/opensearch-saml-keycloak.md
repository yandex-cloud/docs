Вы можете использовать [{{ keycloak }}](https://www.keycloak.org/) для [аутентификации пользователей](../../managed-opensearch/operations/saml-authentication.md), которые работают с {{ OS }} Dashboards в кластере {{ mos-name }}.

Чтобы настроить аутентификацию:

1. [Настройте провайдер идентификации](#configure-idp).
1. [Настройте SSO для кластера](#configure-sso).
1. [Настройте роли для SSO](#map-roles).
1. [Проверьте работу SSO](#test-sso).

{% note info %}

Это практическое руководство проверялось для кластера {{ OS }} 2.8 и {{ keycloak }} 24.0.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Убедитесь, что вы можете [подключиться к {{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards) с использованием реквизитов пользователя `admin`.

    В этом практическом руководстве предполагается, что веб-интерфейс {{ OS }} Dashboards доступен по URL:

    ```url
    https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
    ```

1. Убедитесь, что вы можете работать с {{ keycloak }}:

    * Проверьте, что есть доступ к {{ keycloak }}.
    * Проверьте, что есть доступ к нужному [realm](https://www.keycloak.org/docs/latest/server_admin/#configuring-realms).
    * Проверьте, что есть достаточные права в этом realm для управления:

        * Ролями.
        * Пользователями и группами.
        * Клиентами (так в терминологии {{ keycloak }} называются приложения, с помощью которых происходит аутентификация).

    В этом практическом руководстве предполагается, что:

    * Для управления {{ keycloak }} используется [аккаунт суперадминистратора](https://www.keycloak.org/docs/latest/server_admin/index.html#creating-first-admin_server_administration_guide), который позволяет выполнять любые операции в любом realm.
    * Все операции выполняются в realm с именем `master`.
    * {{ keycloak }} доступен по URL:

        ```url
        http://keycloak.example.com:8080
        ```

    * Консоль администратора {{ keycloak }} доступна по URL:

        ```url
        http://keycloak.example.com:8080/admin/
        ```

## Настройте провайдер идентификации {#configure-idp}

1. Подключитесь к консоли управления {{ keycloak }} и выберите realm с именем `master`.

1. Создайте клиент:
    1. На панели слева выберите **Clients**. Нажмите кнопку **Create client**.
    1. В поле **Client type** выберите вариант **SAML**.
    1. В поле **Client ID** укажите идентификатор клиента.

        Этот идентификатор должен совпадать с URL для подключения к {{ OS }} Dashboards:

        ```url
        https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
        ```

    1. Нажмите кнопку **Next**.

    1. Укажите ACS URL в полях:

        * **Home URL**;
        * **Valid redirect URIs**;
        * **IDP Initiated SSO Relay State**.

        ACS URL имеет вид:

        ```url
        https://c-{{ cluster-id }}.rw.{{ dns-zone }}/_opendistro/_security/saml/acs
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

    1. Нажмите на URL для подключения к {{ OS }} Dashboards с суффиксом `-dedicated`.

    1. На вкладке **Mappers** нажмите **Configure a new mapper**. Выберите из списка маппер **Role list**.

    1. Укажите следующие настройки маппера:

        * **Name** — любое имя маппера, например `{{ OS }} Mapper`.
        * **Role attribute name** — `roles`.
        * **SAML Attribute NameFormat** — `Basic`;
        * **Single Role Attribute** — убедитесь, что эта опция включена.

    1. Нажмите кнопку **Save**.

## Настройте SSO для кластера {#configure-sso}

1. Получите метаданные для [созданного ранее клиента](#configure-idp):

    1. Подключитесь к консоли управления {{ keycloak }} и выберите realm с именем `master`.
    1. На панели слева выберите **Clients**.
    1. Нажмите на URL для подключения к {{ OS }} Dashboards.
    1. В правом верхнем углу раскройте меню **Action** и выберите пункт **Download adapter config**.
    1. Выберите формат `Mod Auth Mellon Files` и нажмите кнопку **Download**.

        Будет загружен архив.

    1. Извлеките файл `idp-metadata.xml` из этого архива. В этом файле содержатся необходимые метаданные.

1. Настройте SSO для кластера.

    {% note tip %}

    Далее приведены инструкции для консоли управления, но можно [использовать и другие доступные интерфейсы {{ yandex-cloud }}](../../managed-opensearch/operations/saml-authentication.md#configuration-sso).

    {% endnote %}

    Чтобы настроить источник аутентификации {{ keycloak }}:

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.opensearch.auth.section_auth }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
    1. Укажите нужные значения настроек:

        * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}** — идентификатор провайдера.

            Для {{ keycloak }} этот идентификатор совпадает с URL, который указывает на realm с именем `master`:

            ```url
            http://keycloak.example.com:8080/realms/master
            ```

        * **idp_metadata_file** — выберите и загрузите файл с метаданными, извлеченный из архива.

        * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}** — идентификатор поставщика услуг.

            Используйте тот же идентификатор, который [был указан при настройке клиента](#configure-idp) {{ keycloak }} в поле **Client ID**:

            ```url
            https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
            ```

        * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}** — URL для подключения к {{ OS }} Dashboards.

        * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}** — атрибут, в котором хранится перечень ролей.

            Укажите тот же атрибут, который [был настроен для маппера](#configure-idp) {{ keycloak }} — `roles`.

        * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}** — оставьте поле пустым.

        * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}** — убедитесь, что эта опция включена.

    1. Нажмите кнопку **{{ ui-key.yacloud.opensearch.auth.button_save }}**.

1. Дождитесь, когда статус кластера изменится на `Running`. Применение настроек может занять несколько минут.

## Настройте роли для SSO {#map-roles}

1. Настройте {{ keycloak }} так, чтобы его пользователям назначались нужные роли:

    1. Подключитесь к консоли управления {{ keycloak }} и выберите realm с именем `master`.

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

1. Сопоставьте роли кластера {{ OS }} с ролями на стороне {{ keycloak }}. Это позволит получить доступ к кластеру через SSO.

    Чтобы сопоставить роли:

    1. [Подключитесь](../../managed-opensearch/operations/connect.md#dashboards) к {{ OS }} Dashboards от имени пользователя `admin`.
    1. В меню слева выберите **{{ OS }} Plugins** → **Security**.
    1. На панели слева выберите **Roles**.
    1. Настройте сопоставления ролей:

        1. Нажмите на имя нужной роли.

            Далее предполагается, что была выбрана роль `kibana_user`.

        1. Перейдите на вкладку **Mapped users**.
        1. Нажмите кнопку **Manage mapping**.
        1. В блоке **Backend roles** введите имя роли в {{ keycloak }}, с которой будет сопоставлена роль в {{ OS }}, и нажмите кнопку **Map**.

            Далее предполагается, что была выбрана роль `kc_demo_role`.

Теперь пользователи {{ keycloak }}, добавленные в группу `kc_demo_group`, будут получать роль `kc_demo_role`.

Если при подключении к {{ OS }} Dashboards аутентификация пройдет успешно, то пользователь с ролью `kc_demo_role` получит роль `kibana_user` в {{ OS }}.

## Проверьте работу SSO {#test-sso}

1. Откройте браузер в гостевом режиме или режиме инкогнито.

    Это действие нужно выполнять с компьютера, который имеет доступ к {{ keycloak }}.

1. [Подключитесь](../../managed-opensearch/operations/connect.md#dashboards) к {{ OS }} Dashboards.

    На странице логина нажмите кнопку **Log in with single sign-on** вместо ввода имени пользователя и пароля.

    Если все настроено правильно, браузер перенаправит вас на страницу аутентификации в {{ keycloak }}.

1. Введите реквизиты пользователя `kc_demo_user` и нажмите кнопку **Sign in**.

    После успешной аутентификации {{ keycloak }} перенаправит вас на ACS URL, затем вы будете перенаправлены на главную страницу {{ OS }} Dashboards.

1. Убедитесь, что пользователю назначена роль `kibana_user` в {{ OS }}.

    Для этого нажмите на аватар пользователя в верхнем правом углу и выберите пункт **View roles and identities**. Будут показаны назначенные пользователю роли.

1. Убедитесь, что вы можете выполнять все действия, которые разрешены для роли `kibana_user`.
