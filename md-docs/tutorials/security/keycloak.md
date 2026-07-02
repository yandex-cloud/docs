[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Безопасность](index.md) > Управление федерациями удостоверений > Сопоставление групп пользователей > Сопоставление групп пользователей в Keycloak

# Сопоставление групп пользователей в Keycloak

Чтобы настроить сопоставление групп пользователей в [Keycloak](https://www.keycloak.org/) и групп пользователей в [федерации удостоверений](../../organization/concepts/add-federation.md):

1. [Создайте федерацию в Yandex Identity Hub](#create-federation).
1. [Добавьте сертификат Keycloak в федерацию](#add-certificate)
1. [Создайте и настройте SAML-приложение в Keycloak](#keycloak-settings).
1. [Настройте сопоставление групп на стороне Keycloak](#kc-mapping)
1. [Настройте сопоставление групп на стороне федерации](#org-mapping).
1. [Проверьте работу аутентификации](#test-auth).

{% note info %}

Все примеры проверялись на версии Keycloak `21.1.2`.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% note tip %}

Если у вас уже есть работающий сервер Keycloak, сравните настройки Keycloak с рекомендуемыми в этом руководстве и используйте ваш собственный сервер вместо создания нового. В этом случае вы можете перейти сразу к разделу [Настройте сопоставление групп на стороне Keycloak](#kc-mapping).

{% endnote %}

1. Настройте локальный сервер Keycloak для тестирования:

    1. Если у вас не установлен [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers), [установите его](https://docs.docker.com/get-docker/). Убедитесь, что Docker Engine запущен.

    1. Установите и запустите Docker-контейнер с Keycloak версии 21.1.2:

        ```bash
        docker run -p 8080:8080 \
        -e KEYCLOAK_ADMIN=admin \
        -e KEYCLOAK_ADMIN_PASSWORD=Pa55w0rd \
        quay.io/keycloak/keycloak:21.1.2 start-dev
        ```

    Пока контейнер запущен, аккаунт администратора Keycloak будет доступен по адресу [http://localhost:8080/admin](http://localhost:8080/admin) или [http://0.0.0.0:8080/admin](http://0.0.0.0:8080/admin). Параметры входа по умолчанию:

    * **User name or email**: `admin`.
    * **Password**: `Pa55w0rd`.

    {% note info %}

    Чтобы сотрудники в корпоративной сети или интернете могли использовать Keycloak для аутентификации в вашем приложении, разверните IdP-сервер Keycloak в сети и настройте публичный адрес. Подробнее читайте в [документации Keycloak](https://www.keycloak.org/server/hostname).

    {% endnote %}

1. Получите сертификат, который используется для подписи в службе Keycloak:

    1. Войдите в аккаунт администратора Keycloak по адресу: `http://<IP_или_URL_Keycloak>:8080/admin`.

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

## Создайте федерацию Yandex Identity Hub {#create-federation}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Перейдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![icon-federation](../../_assets/console-icons/vector-square.svg) **Федерации**.

  1. В правом верхнем углу страницы нажмите кнопку ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **Создать федерацию**. В открывшемся окне:

      1. Задайте имя федерации, например `demo-federation`. Имя должно быть уникальным в каталоге.

      1. При необходимости добавьте описание.

      1. В поле **Время жизни cookie** укажите время, в течение которого браузер не будет требовать у пользователя повторной аутентификации.

      1. В поле **IdP Issuer** вставьте ссылку вида:

          ```text
          http://<IP_или_URL_Keycloak>:8080/realms/master
          ```

      1. В поле **Ссылка на страницу для входа в IdP** вставьте ссылку вида:

          ```text
          http://<IP_или_URL_Keycloak>:8080/realms/master/protocol/saml
          ```

          В ссылке допустимо использовать только протоколы HTTP и HTTPS.

      1. Включите опцию **Автоматически создавать пользователей**, чтобы автоматически добавлять пользователя в организацию после аутентификации. Если опция отключена, федеративных пользователей потребуется [добавить вручную](../../organization/operations/add-account.md#add-user-sso).

          Автоматически федеративный пользователь создается только при первом входе пользователя в облако. Если вы исключили пользователя из федерации, вернуть его туда можно будет только вручную.

      1. (Опционально) Чтобы все запросы аутентификации от Yandex Cloud содержали цифровую подпись, включите опцию **Подписывать запросы аутентификации**. Потребуется установить SAML-сертификат Yandex Cloud на стороне поставщика удостоверений.

          В появившемся блоке **Сертификаты SAML** появится информация о действующем SAML-сертификате Yandex Cloud.
          
          Нажмите ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **Скачать** и сохраните скачанный файл сертификата. Он потребуется для установки на ваш IdP-сервер.
          
          {% note tip %}
          
          Следите за сроком действия сертификатов и устанавливайте новые сертификаты до истечения срока действия используемых. Перевыпущенный SAML-сертификат Yandex Cloud необходимо заранее [скачать и установить](../../organization/operations/renew-yc-certificate.md) на стороне IdP-провайдера и в вашей федерации.
          
          {% endnote %}

          [Скачать и установить сертификат](../../organization/operations/setup-federation.md#add-certificate-idp) Yandex Cloud вы можете и после создания федерации.

          Сертификат потребуется в дальнейшем при настройке клиента в Keycloak.

      1. Включите опцию **Принудительная повторная аутентификация (ForceAuthn) в IdP**, чтобы задать значение `true` для параметра [ForceAuthn](../../organization/saml/api-ref/Federation/index.md) в запросе аутентификации SAML. При включении этой опции поставщик удостоверений (Identity Provider, IdP) запрашивает у пользователя аутентификацию по истечении сессии в Yandex Cloud. Необязательный параметр.

      1. Нажмите кнопку **Создать федерацию**.

{% endlist %}

## Добавьте сертификат Keycloak в федерацию {#add-certificate}

Чтобы при аутентификации сервис Yandex Identity Hub мог проверить сертификат сервера Keycloak, добавьте сертификат в федерацию:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.

  1. Нажмите на строку с федерацией, для которой нужно добавить сертификат — `demo-federation`.

  1. Внизу страницы в блоке **Сертификаты** нажмите кнопку **Добавить сертификат**.

  1. Введите название сертификата и укажите путь к файлу `keycloak-cert.cer`.

  1. Нажмите кнопку **Добавить**.

{% endlist %}

{% note tip %}

Не забывайте своевременно перевыпускать сертификаты и добавлять их в федерацию.

Чтобы не пропустить момент окончания срока действия сертификата, [подпишитесь](../../organization/operations/subscribe-user-for-notifications.md) на уведомления от организации. Уведомления направляются подписанным пользователям за 60, 30 и 5 дней до момента прекращения действия сертификата, а также после того, как сертификат становится недействительным.

{% endnote %}

## Создайте и настройте SAML-приложение в Keycloak {#keycloak-settings}

В роли поставщика удостоверений (IdP) выступает SAML-приложение в Keycloak. Чтобы создать и настроить SAML-приложение:

1. Войдите в аккаунт администратора Keycloak по адресу: `http://<IP_или_URL_Keycloak>:8080/admin`.

    Если вы используете локальный сервер из Docker-образа, то параметры входа по умолчанию:

    * URL: [http://0.0.0.0:8080/admin](http://0.0.0.0:8080/admin).
    * **User name or email** : `admin`.
    * **Password** : `Pa55w0rd`.

1. Создайте SAML-приложение:

    1. На панели слева выберите **Clients**. Нажмите кнопку **Create client**.

    1. В поле **Client type** выберите вариант **SAML**.

    1. В поле **Client ID** укажите ACS URL, на который пользователи будут перенаправляться после аутентификации.

        {% cut "Как получить идентификатор федерации" %}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
        1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **Идентификатор**.

        {% endcut %}

        
        {% cut "Как получить ACS URL федерации" %}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        
        1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
        
        1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **ACS URL**.

        {% endcut %}


    1. Нажмите **Next**.
    1. Укажите ACS URL для перенаправления в полях:

        * **Home URL**;
        * **Valid Redirect URIs**;
        * **IDP Initiated SSO Relay State**.
    
        
        {% cut "Как получить ACS URL федерации" %}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        
        1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
        
        1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **ACS URL**.

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

1. (Опционально) Если при [создании федерации](#create-federation) в Yandex Identity Hub вы включили опцию **Подписывать запросы аутентификации**, настройте в SAML-приложении проверку цифровой подписи:

    1. На вкладке **Keys** SAML-приложения убедитесь, что опция **Client Signature Required** включена.
    1. Нажмите кнопку **Import key** под автоматически сгенерированным сертификатом и в поле **Archive Format** выберите **Certificate PEM**.
    1. Нажмите кнопку **Browse** и выберите скачанный ранее SAML-сертификат Yandex Cloud для подписи запросов аутентификации.

        Если вы не скачивали SAML-сертификат при создании федерации, вы можете скачать его на странице сведений о федерации в Yandex Identity Hub, нажав кнопку ![ArrowDownToLine](../../_assets/console-icons/arrow-down-to-line.svg) **Скачать сертификат** в поле **Подписывать запросы аутентификации**.

    1. Нажмите **Import**.
    1. Включите опцию **Encrypt Assertions**.
    1. В появившемся окне выберите метод **Generate** и нажмите **Confirm**.
    1. Нажмите кнопку **Import key** под сгенерированным сертификатом и в поле **Archive Format** выберите **Certificate PEM**.
    1. Нажмите кнопку **Browse** и выберите сертификат для подписи запросов аутентификации. Сертификат доступен для скачивания на странице сведений о федерации в Yandex Identity Hub в поле **Подписывать запросы аутентификации**.
    1. Нажмите **Import**.

## Настройте сопоставление групп на стороне Keycloak {#kc-mapping}

1. Создайте пользователя:

    1. На панели слева выберите **Users**.
    1. Нажмите **Add user** и введите имя пользователя, например `demo_user1`.
    1. Нажмите кнопку **Create**.
    1. На вкладке **Credentials** нажмите **Set Password** и задайте пароль. Для удобства тестирования отключите опцию **Temporary**.

1. Создайте группу и добавьте в нее пользователя:

    1. На панели слева выберите **Groups**.
    1. Нажмите **Create group** и введите имя группы, например `kc_demo_group`.
    1. Нажмите на имя группы, на вкладке **Members** нажмите **Add member** и добавьте в группу пользователя `demo_user1` из списка.

1. Добавьте маппер в приложение Keycloak:

    1. На панели слева выберите **Clients** и выберите ранее созданное приложение из списка.
    1. Перейдите на вкладку **Client scopes** и выберите из списка ACS URL с постфиксом `-dedicated`: `<ACS_URL>-dedicated`.

        
        {% cut "Как получить ACS URL федерации" %}

        1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
        
        1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
        
        1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **ACS URL**.

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

{% note info %}

Чтобы настроить сопоставление [групп пользователей](../../organization/concepts/user-pools.md) на стороне Yandex Cloud, [назначьте](../../iam/operations/roles/grant.md#resource) пользователю одну из следующих [ролей](../../iam/concepts/access-control/roles.md):

* [`organization-manager.federations.editor`](../../organization/security/index.md#organization-manager-federations-editor);
* [`organization-manager.federations.admin`](../../organization/security/index.md#organization-manager-federations-admin);
* [`organization-manager.editor`](../../organization/security/index.md#organization-manager-editor);
* [`organization-manager.admin`](../../organization/security/index.md#organization-manager-admin);

Роль должна быть назначена на те группы, для которых настраивается сопоставление.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).

  1. [Создайте группу пользователей](../../organization/operations/create-group.md) `yc_demo_group` в Yandex Identity Hub и [выдайте ей права](../../organization/operations/access-group.md) на просмотр ресурсов в облаке или отдельном каталоге (роль `viewer`).

  1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.

  1. Выберите созданную ранее федерацию `demo-federation` и перейдите на вкладку **IdP-группы**.

  1. Включите опцию **Маппинг групп в IdP**.

  1. Нажмите кнопку **Добавить группу**.

  1. В поле **Имя группы** введите имя группы в Keycloak — `kc_demo_group`.

  1. В поле **IAM-группа** выберите из списка имя группы в Yandex Identity Hub — `yc_demo_group`.

  1. Нажмите **Сохранить**.

- Terraform {#tf}

  1. Опишите в конфигурационном файле Terraform параметры создаваемых ресурсов:

      ```hcl
      # Создание группы пользователей
      resource "yandex_organizationmanager_group" "my-group" {
        name            = "yc_demo_group"
        organization_id = "demo-federation"
      }

      # Назначение роли viewer на каталог
      resource "yandex_resourcemanager_folder_iam_member" "viewers" {
        folder_id = "<идентификатор_каталога>"
        role      = "viewer"
        member    = "group:${yandex_organizationmanager_group.my-group.id}"
      }

      # Включение сопоставления групп федеративных пользователей
      resource "yandex_organizationmanager_group_mapping" "my_group_map" {
        federation_id = "demo-federation"
        enabled       = true
      }

      # Настройка сопоставления групп федеративных пользователей
      resource "yandex_organizationmanager_group_mapping_item" "group_mapping_item" {
        federation_id     = "demo-federation"
        internal_group_id = yandex_organizationmanager_group.my-group.id
        external_group_id = "kc_demo_group"

        depends_on = [yandex_organizationmanager_group_mapping.group_mapping]
      }
      ```

      Где:
      * `folder_id` — каталог, на который назначается роль.

      Подробнее в описаниях ресурсов [yandex_organizationmanager_group_mapping](../../terraform/resources/organizationmanager_group_mapping.md) и [yandex_organizationmanager_group_mapping_item](../../terraform/resources/organizationmanager_group_mapping_item.md) в документации провайдера Terraform.

  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

{% endlist %}

## Проверьте работу аутентификации {#test-auth}

1. Откройте браузер в гостевом режиме или режиме инкогнито.

1. Перейдите по URL для входа в консоль:

    ```text
    https://console.yandex.cloud/federations/<идентификатор_федерации>
    ```

    {% cut "Как получить идентификатор федерации" %}

    1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![VectorSquare](../../_assets/console-icons/vector-square.svg) **Федерации**.
    1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **Идентификатор**.

    {% endcut %}

    Если все настроено правильно, браузер перенаправит вас на страницу аутентификации в Keycloak.

1. Введите имя пользователя и пароль тестового федеративного пользователя `demo_user1` и нажмите кнопку **Sign in**.

    После успешной аутентификации IdP-сервер перенаправит вас по ACS URL, который вы указали в настройках Keycloak, а после — на главную страницу [консоли управления](https://console.yandex.cloud).

1. Убедитесь, что созданный пользователь `demo_user1` входит в группу `yc_demo_group` и у него есть права на просмотр ресурсов в соответствии с ролью, назначенной для группы.