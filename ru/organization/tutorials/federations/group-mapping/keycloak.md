# Сопоставление групп пользователей в {{ keycloak }}

Чтобы настроить сопоставление групп пользователей в [{{ keycloak }}](https://www.keycloak.org/) и групп пользователей в [федерации удостоверений](../../../concepts/add-federation.md):

1. [Создайте федерацию в {{ org-full-name }}](#create-federation).
1. [Добавьте сертификат {{ keycloak }} в федерацию](#add-certificate)
1. [Создайте и настройте SAML-приложение в {{ keycloak }}](#keycloak-settings).
1. [Настройте сопоставление групп на стороне {{ keycloak }}](#kc-mapping)
1. [Настройте сопоставление групп на стороне федерации](#org-mapping).
1. [Проверьте работу аутентификации](#test-auth).

{% note info %}

Все примеры проверялись на версии {{ keycloak }} `21.1.2`.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% note tip %}

Если у вас уже есть работающий сервер {{ keycloak }}, сравните настройки {{ keycloak }} с рекомендуемыми в этом руководстве и используйте ваш собственный сервер вместо создания нового. В этом случае вы можете перейти сразу к разделу [Настройте сопоставление групп на стороне {{ keycloak }}](#kc-mapping).

{% endnote %}

1. Настройте локальный сервер {{ keycloak }} для тестирования:

    1. Если у вас не установлен [Docker](/blog/posts/2022/03/docker-containers), [установите его](https://docs.docker.com/get-docker/). Убедитесь, что Docker Engine запущен.

    1. Установите и запустите Docker-контейнер с {{ keycloak }} версии 21.1.2:

        ```bash
        docker run -p 8080:8080 \
        -e KEYCLOAK_ADMIN=admin \
        -e KEYCLOAK_ADMIN_PASSWORD=Pa55w0rd \
        quay.io/keycloak/keycloak:21.1.2 start-dev
        ```

    Пока контейнер запущен, аккаунт администратора {{ keycloak }} будет доступен по адресу [http://localhost:8080/admin](http://localhost:8080/admin) или [http://0.0.0.0:8080/admin](http://0.0.0.0:8080/admin). Параметры входа по умолчанию:

    * **User name or email**: `admin`.
    * **Password**: `Pa55w0rd`.

    {% note info %}

    Чтобы сотрудники в корпоративной сети или интернете могли использовать {{ keycloak }} для аутентификации в вашем приложении, разверните IdP-сервер {{ keycloak }} в сети и настройте публичный адрес. Подробнее читайте в [документации {{ keycloak }}](https://www.keycloak.org/server/hostname).

    {% endnote %}

1. Получите сертификат, который используется для подписи в службе {{ keycloak }}:

    1. Войдите в аккаунт администратора {{ keycloak }} по адресу: `http://<IP_или_URL_{{ keycloak }}>:8080/admin`.

        Если вы используете локальный сервер из Docker-образа, то параметры входа по умолчанию:

        * URL: [http://0.0.0.0:8080/admin](http://0.0.0.0:8080/admin).
        * **User name or email**: `admin`.
        * **Password**: `Pa55w0rd`.

    1. В разделе **Realm Settings** выберите вкладку **Keys**.

    1. В строке **RS256** нажмите **Certificate** и скопируйте значение сертификата.

    1. Сохраните сертификат в файле `keycloak-cert.cer` в следующем формате:

      ```text
      -----BEGIN CERTIFICATE-----
      <значение_сертификата>
      -----END CERTIFICATE-----
      ```

      Сертификат потребуется в дальнейшем при настройке федерации удостоверений.

## Создайте федерацию {{ org-full-name }} {#create-federation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-federation](../../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}**. В открывшемся окне:

      1. Задайте имя федерации, например `demo-federation`. Имя должно быть уникальным в каталоге.

      1. При необходимости добавьте описание.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** вставьте ссылку вида:

          ```text
          http://<IP_или_URL_{{ keycloak }}>:8080/realms/master
          ```

      1. В поле **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** вставьте ссылку вида:

          ```text
          http://<IP_или_URL_{{ keycloak }}>:8080/realms/master/protocol/saml
          ```

          {% include [ssourl_protocol](../../../../_includes/organization/ssourl_protocol.md) %}

      1. Включите опцию **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}**, чтобы автоматически добавлять пользователя в организацию после аутентификации. Если опция отключена, федеративных пользователей потребуется [добавить вручную](../../../operations/add-account.md#add-user-sso).

          {% include [fed-users-note](../../../../_includes/organization/fed-users-note.md) %}

      1. (Опционально) Чтобы все запросы аутентификации от {{ yandex-cloud }} содержали цифровую подпись, включите опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**. Потребуется установить SAML-сертификат {{ yandex-cloud }} на стороне поставщика удостоверений.

          {% include [download-saml-cert-when-creating-fed](../../../../_includes/organization/download-saml-cert-when-creating-fed.md) %}

          {% include [setup-cert-for-idp](../../../../_includes/organization/setup-cert-for-idp.md) %}

          Сертификат потребуется в дальнейшем при настройке клиента в {{ keycloak }}.

      1. {% include [forceauthn-option-enable](../../../../_includes/organization/forceauthn-option-enable.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

{% endlist %}

## Добавьте сертификат {{ keycloak }} в федерацию {#add-certificate}

Чтобы при аутентификации сервис {{ org-name }} мог проверить сертификат сервера {{ keycloak }}, добавьте сертификат в федерацию:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Нажмите на строку с федерацией, для которой нужно добавить сертификат — `demo-federation`.

  1. Внизу страницы в блоке **{{ ui-key.yacloud_org.page.federation.section.certificates }}** нажмите кнопку **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.

  1. Введите название сертификата и укажите путь к файлу `keycloak-cert.cer`.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.actions.add }}**.

{% endlist %}

{% include [federation-certificates-note](../../../../_includes/organization/federation-certificates-note.md) %}

## Создайте и настройте SAML-приложение в {{ keycloak }} {#keycloak-settings}

В роли поставщика удостоверений (IdP) выступает SAML-приложение в {{ keycloak }}. Чтобы создать и настроить SAML-приложение:

1. Войдите в аккаунт администратора {{ keycloak }} по адресу: `http://<IP_или_URL_{{ keycloak }}>:8080/admin`.

    Если вы используете локальный сервер из Docker-образа, то параметры входа по умолчанию:

    * URL: [http://0.0.0.0:8080/admin](http://0.0.0.0:8080/admin).
    * **User name or email** : `admin`.
    * **Password** : `Pa55w0rd`.

1. Создайте SAML-приложение:

    1. На панели слева выберите **Clients**. Нажмите кнопку **Create client**.

    1. В поле **Client type** выберите вариант **SAML**.

    1. В поле **Client ID** укажите ACS URL, на который пользователи будут перенаправляться после аутентификации.

        {% cut "Как получить идентификатор федерации" %}

        {% include [get-federation-id](../../../../_includes/organization/get-federation-id.md) %}

        {% endcut %}


        {% cut "Как получить ACS URL федерации" %}

        {% include [get-acs-url](../../../../_includes/organization/get-acs-url.md) %}

        {% endcut %}


    1. Нажмите **Next**.
    1. Укажите ACS URL для перенаправления, в полях:

        * **Home URL**;
        * **Valid Redirect URIs**;
        * **IDP Initiated SSO Relay State**.
    

        {% cut "Как получить ACS URL федерации" %}

        {% include [get-acs-url](../../../../_includes/organization/get-acs-url.md) %}

        {% endcut %}


    1. Нажмите **Save**.

1. Настройте параметры SAML-приложения на вкладке **Settings**:

    1. Включите опции:

       * **Include AuthnStatement**;
       * **Sign Assertions**;
       * **Force name ID format**;
       * **Force POST Binding**;
       * **Front Channel Logout**.

    1. В поле **Signature Algorithm** выберите **RSA_SHA256**.

    1. В поле **SAML Signature Key Name** выберите **CERT_SUBJECT**.

    1. В качестве **Name ID Format** выберите `username`.

    1. Нажмите кнопку **Save**.

1. (Опционально) Если при [создании федерации](#create-federation) в {{ org-full-name }} вы включили опцию **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**, настройте в SAML-приложении проверку цифровой подписи:

    1. На вкладке **Keys** SAML-приложения убедитесь, что опция **Client Signature Required** включена.
    1. Нажмите кнопку **Import key** под автоматически сгенерированным сертификатом и в поле **Archive Format** выберите **Certificate PEM**.
    1. Нажмите кнопку **Browse** и выберите скачанный ранее SAML-сертификат {{ yandex-cloud }} для подписи запросов аутентификации.

        Если вы не скачивали SAML-сертификат при создании федерации, вы можете скачать его на странице сведений о федерации в {{ org-full-name }}, нажав кнопку ![ArrowDownToLine](../../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.page.federation.link.download-cert }}** в поле **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**.

    1. Нажмите **Import**.
    1. Включите опцию **Encrypt Assertions**.
    1. В появившемся окне выберите метод **Generate** и нажмите **Confirm**.
    1. Нажмите кнопку **Import key** под сгенерированным сертификатом и в поле **Archive Format** выберите **Certificate PEM**.
    1. Нажмите кнопку **Browse** и выберите сертификат для подписи запросов аутентификации. Сертификат доступен для скачивания на странице сведений о федерации в {{ org-full-name }} в поле **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**.
    1. Нажмите **Import**.

## Настройте сопоставление групп на стороне {{ keycloak }} {#kc-mapping}

1. Создайте пользователя:

    1. На панели слева выберите **Users**.
    1. Нажмите **Add user** и введите имя пользователя, например `demo_user1`.
    1. Нажмите кнопку **Create**.
    1. На вкладке **Credentials** нажмите **Set Password** и задайте пароль. Для удобства тестирования отключите опцию **Temporary**.

1. Создайте группу и добавьте в нее пользователя:

    1. На панели слева выберите **Groups**.
    1. Нажмите **Create group** и введите имя группы, например `kc_demo_group`.
    1. Нажмите на имя группы, на вкладке **Members** нажмите **Add member** и добавьте в группу пользователя `demo_user1` из списка.

1. Добавьте маппер в приложение {{ keycloak }}:

    1. На панели слева выберите **Clients** и выберите ранее созданное приложение из списка.
    1. Перейдите на вкладку **Client scopes** и выберите из списка ACS URL с постфиксом `-dedicated`: `<ACS_URL>-dedicated`.


        {% cut "Как получить ACS URL федерации" %}

        {% include [get-acs-url](../../../../_includes/organization/get-acs-url.md) %}

        {% endcut %}


    1. На вкладке **Mappers** нажмите **Configure a new mapper**. Выберите из списка **Group list**.
    1. Укажите следующие настройки маппера:

        * **Name** — `group_mapper`;
        * **Group attribute name** — `member`;
        * **SAML Attribute NameFormat** — `Basic`;
        * **Single Group Attribute** — `On`.
        * **Full group path** — `Off`.

    1. Нажмите **Save**.

## Настройте сопоставление групп на стороне федерации {#org-mapping}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. [Создайте группу пользователей](../../../operations/create-group.md) `yc_demo_group` в {{ org-name }} и [выдайте ей права](../../../operations/access-group.md) на просмотр ресурсов в облаке или отдельном каталоге (роль `viewer`).

  1. На панели слева выберите ![VectorSquare](../../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Выберите созданную ранее федерацию `demo-federation` и перейдите на вкладку **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}**.

  1. Включите опцию **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.form.group-mapping.create.add }}**.

  1. В поле **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}** введите имя группы в {{ keycloak }} — `kc_demo_group`.

  1. В поле **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}** выберите из списка имя группы в {{ org-full-name }} — `yc_demo_group`.

  1. Нажмите **{{ ui-key.yacloud_org.actions.save-changes }}**.

{% endlist %}

## Проверьте работу аутентификации {#test-auth}

1. Откройте браузер в гостевом режиме или режиме инкогнито.

1. Перейдите по URL для входа в консоль:

    ```text
    {{ link-console-main }}/federations/<идентификатор_федерации>
    ```

    {% cut "Как получить идентификатор федерации" %}

    {% include [get-federation-id](../../../../_includes/organization/get-federation-id.md) %}

    {% endcut %}

    Если все настроено правильно, браузер перенаправит вас на страницу аутентификации в {{ keycloak }}.

1. Введите имя пользователя и пароль тестового федеративного пользователя `demo_user1` и нажмите кнопку **Sign in**.

    После успешной аутентификации IdP-сервер перенаправит вас по ACS URL, который вы указали в настройках {{ keycloak }}, а после — на главную страницу [консоли управления]({{ link-console-main }}).

1. Убедитесь, что созданный пользователь `demo_user1` входит в группу `yc_demo_group` и у него есть права на просмотр ресурсов в соответствии с ролью, назначенной для группы.
