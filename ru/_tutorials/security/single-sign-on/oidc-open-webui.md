# Создать OIDC-приложение в {{ org-full-name }} для интеграции с Open WebUI


[Open WebUI](https://openwebui.com/) — это бесплатная платформа с открытым исходным кодом для удобной работы с большими языковыми моделями, которую можно развернуть в собственной инфраструктуре. Open WebUI поддерживает аутентификацию [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Open WebUI с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в {{ org-full-name }} и настройте его на стороне {{ org-full-name }} и на стороне Open WebUI.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

{% note info %}

Для демонстрации интеграции в этом руководстве вы развернете экземпляр Open WebUI на [виртуальной машине](../../../compute/concepts/vm.md) {{ compute-full-name }}.

{% endnote %}

Чтобы предоставить пользователям вашей организации доступ в Open WebUI:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте и настройте OIDC-приложение](#create-app).
1. [Разверните экземпляр Open WebUI](#deploy-open-webui).
1. [Настройте интеграцию на стороне Open WebUI](#setup-integration).
1. [Добавьте пользователя](#add-user).
1. [Убедитесь в корректной работе приложения](#validate).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Подготовьте окружение {#prepare}

1. [Создайте](../../../vpc/operations/network-create.md) облачную сеть с [подсетью](../../../vpc/operations/subnet-create.md) в [зоне доступности](*availability_zone), в которой вы будете развертывать экземпляр Open WebUI.
1. [Зарезервируйте](../../../vpc/operations/get-static-ip.md) статический публичный IP-адрес в зоне доступности, в которой вы будете развертывать экземпляр Open WebUI.
1. В вашей облачной сети создайте группу безопасности, разрешающую следующий трафик:

    | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} |
    | --- | --- | --- | --- | --- | --- |
    | Входящий | `80` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `http`           |
    | Входящий | `8080` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `8080`           |
    | Входящий | `443`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `https`            |
    | Входящий | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `ssh`            |
    | Исходящий | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | `any`           |
1. [Создайте](../../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину из публичного образа [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin).

    {% note info %}

    При создании виртуальной машины выберите зону доступности, в которой создана ваша подсеть, используйте зарезервированный ранее публичный IP-адрес и созданную группу безопасности.
    
    Рекомендуется использовать конфигурацию ВМ с 8 ГБ RAM и более.

    {% endnote %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой в руководстве инфраструктуры входят:
* плата за постоянно запущенную виртуальную машину ([тарифы {{ compute-full-name }}](../../../compute/pricing.md));
* плата за использование статического публичного IP-адреса ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).


## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** и в открывшемся окне:
        1. Выберите метод единого входа **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}**.
        1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** задайте имя создаваемого приложения: `open-webui-oidc-app`.
        1. В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) В поле **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное OIDC-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** скопируйте значения параметров, которые потребуется задать на стороне Open WebUI:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` — уникальный идентификатор приложения.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` — URL с конфигурацией всех необходимых для настройки интеграции параметров.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}


### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите OIDC-приложение `open-webui-oidc-app`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:
      1. В поле **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** укажите эндпоинт аутентификации для вашего экземпляра Open WebUI в формате:

          ```text
          https://<адрес_сервера>/oauth/oidc/callback
          ```

          Где `<адрес_сервера>` — статический публичный IP-адрес ВМ, зарезервированный ранее.
          
          
          {% note info %}

          Если за экземпляром Open WebUI зарезервировано доменное имя, в качестве адреса сервера используйте это доменное имя.

          {% endnote %}

      1. {% include [org-oidc-app-disable-pkce](../../../_tutorials/_tutorials_includes/org-oidc-app-disable-pkce.md) %}
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Разверните экземпляр Open WebUI {#deploy-open-webui}

В этом руководстве вы развернете экземпляр Open WebUI на виртуальной машине {{ compute-name }} в [Docker](https://www.docker.com/)-контейнере.

Чтобы развернуть Open WebUI:

1. Подключитесь к созданной [ранее](#prepare) виртуальной машине. В зависимости от заданных настроек ВМ вы можете подключиться к ней [по SSH](../../../compute/operations/vm-connect/ssh.md) или [по {{ oslogin }}](../../../compute/operations/vm-connect/os-login.md).
1. Установите и настройте Docker:

    ```bash
    sudo apt update && sudo apt install docker.io docker-compose
    ```
1. Добавьте текущего локального пользователя в группу `docker` и запустите новый shell-процесс с обновленным составом групп пользователя:

    ```bash
    sudo usermod -aG docker $USER
    newgrp docker
    ```
1. Создайте директорию для проекта Open WebUI:

    ```bash
    mkdir -p ~/projects/open-webui/certs
    cd ~/projects/open-webui/certs
    ```
1. Создайте самоподписанный TLS-сертификат, который будет использоваться вашим экземпляром Open WebUI:

    {% note info %}

    TLS-сертификат необходим для организации доступа к Open WebUI по протоколу `https`. В настройках OIDC-приложения на стороне {{ org-full-name }} значение `Redirect URI` можно добавить только со схемой `https://`.

    {% endnote %}

    1. Сгенерируйте закрытый ключ:

        ```bash
        openssl genrsa -out server.key 2048
        ```
    1. Создайте самоподписанный сертификат со сроком действия 1 год:

        ```bash
        openssl req \
          -new \
          -x509 \
          -key server.key \
          -out server.crt \
          -days 365
        ```

        В появившейся форме заполните поля. В поле `Common Name (e.g. server FQDN or YOUR name)` укажите зарезервированный [ранее](#prepare) статический публичный IP-адрес, который был присвоен виртуальной машине.
1. Для удобства дальнейшей настройки переименуйте полученные файлы:

    ```bash
    mv server.crt nginx-cert.crt
    mv server.key nginx-cert.key
    ```
1. Перейдите в директорию проекта Open WebUI и создайте файлы его конфигурации:

    ```bash
    cd ~/projects/open-webui
    touch nginx.conf
    touch docker-compose.yml
    ```
1. Настройте среду Docker-контейнера для первого запуска Open WebUI:

    {% note info %}

    Первый запуск выполняется с выключенной опцией аутентификации через SSO и необходим для создания учетной записи администратора проекта.

    {% endnote %}

    1. В текстовом редакторе откройте файл `docker-compose.yml`:

        ```bash
        nano docker-compose.yml
        ```
    1. Добавьте в файл `docker-compose.yml` следующую конфигурацию:

        ```yml
        version: '3.8'

        services:
          open-webui:
            image: ghcr.io/open-webui/open-webui:main
            container_name: open-webui
            environment:
              - WEBUI_BASE_URL=http://<IP-адрес_ВМ>
            ports:
              - "8080:8080"
            volumes:
              - open-webui-data:/app/backend/data
            restart: unless-stopped

        volumes:
          open-webui-data:
        ```

        Где `WEBUI_BASE_URL` — статический публичный IP-адрес вашей виртуальной машины со схемой `http://`.
1. В директории `~/projects/open-webui` выполните команду:

    ```bash
    docker-compose up -d
    ```

    Дождитесь скачивания и распаковки всех компонентов и зависимостей, а также запуска контейнера:

    ```text
    Creating network "open-webui_default" with the default driver
    Creating volume "open-webui_open-webui-data" with default driver
    Pulling open-webui (ghcr.io/open-webui/open-webui:main)...
    main: Pulling from open-webui/open-webui
    4f4f********: Pull complete
    a8ac********: Pull complete
    ...
    Digest: sha256:5c0d8f6d58ea276204b927205e43850689799f25420a67079cb988df********
    Status: Downloaded newer image for ghcr.io/open-webui/open-webui:main
    Creating open-webui ... done
    ```
1. Убедитесь, что контейнер запущен:

    ```bash
    docker ps
    ```

    Если все настроено правильно, команда должна вывести контейнер `open-webui` со статусом `Up (healthy)`.

    {% note info %}

    В зависимости от конфигурации виртуальной машины запуск контейнера может занять несколько минут.

    {% endnote %}

1. Создайте учетную запись администратора Open WebUI:

    1. В браузере откройте адрес вашего экземпляра Open WebUI:

        ```text
        http://<IP-адрес_ВМ>:8080
        ```
    1. На открывшейся странице Open WebUI нажмите кнопку **Давайте начнем →**.
    1. В появившейся форме укажите полное имя, адрес электронной почты (логин) и пароль администратора.
    1. Нажмите кнопку **Создать аккаунт Администратора**.
    1. Закройте окно браузера.
1. В терминале виртуальной машины остановите контейнер Open WebUI:

    ```bash
    docker-compose down
    ```
1. Настройте конфигурацию [nginx](https://nginx.org), которая будет запускаться в контейнере:

    1. В текстовом редакторе откройте файл конфигурации `nginx.conf`:

        ```bash
        nano nginx.conf
        ```
    1. Добавьте в файл `nginx.conf` следующую конфигурацию:

        ```json
        server {
            listen 80;
            server_name <адрес_сервера>;
            return 301 https://$host$request_uri;
        }

        server {
            listen 443 ssl;
            server_name <адрес_сервера>;

            ssl_certificate     /etc/nginx/ssl/cert.crt;
            ssl_certificate_key /etc/nginx/ssl/key.key;

            location / {
                proxy_pass http://open-webui:8080;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Port $server_port;

                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_buffering off;
            }
        }
        ```

        Где `server_name` (в обеих секциях) — статический публичный IP-адрес вашей виртуальной машины. Если за экземпляром Open WebUI зарезервировано доменное имя, в качестве адреса сервера используйте это доменное имя.
1. Обновите конфигурацию Docker-контейнера:

    1. В текстовом редакторе откройте файл `docker-compose.yml`:

        ```bash
        nano docker-compose.yml
        ```
    1. Замените содержимое файла `docker-compose.yml` на следующую конфигурацию, указав в ней параметры OIDC-приложения {{ org-full-name }}:

        ```yml
        version: '3.8'

        services:
          open-webui:
            image: ghcr.io/open-webui/open-webui:main
            container_name: open-webui
            environment:
              - WEBUI_BASE_URL=https://<адрес_сервера>
              - ENABLE_OAUTH_SIGNUP=true
              - ENABLE_LOGIN_FORM=true
              - ENABLE_PERSISTENT_CONFIG=true
              - ENABLE_OAUTH_PERSISTENT_CONFIG=true
              - OPENID_REDIRECT_URI=https://<адрес_сервера>/oauth/oidc/callback
              - OAUTH_CLIENT_ID=<значение_client_ID>
              - OAUTH_CLIENT_SECRET=<значение_client_secret>
              - OPENID_PROVIDER_URL=<значение_OpenID_Configuration>
              - OAUTH_PROVIDER_NAME={{ org-full-name }}
              - OAUTH_SCOPES=openid email profile

            ports:
              - "8080:8080"
            volumes:
              - open-webui-data:/app/backend/data
            networks:
              - webui-net
            restart: unless-stopped

          nginx:
            image: nginx:alpine
            container_name: nginx-webui
            volumes:
              - ./certs/nginx-cert.crt:/etc/nginx/ssl/cert.crt:ro
              - ./certs/nginx-cert.key:/etc/nginx/ssl/key.key:ro
              - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
            ports:
              - "443:443"
              - "80:80"
            depends_on:
              - open-webui
            networks:
              - webui-net
            restart: unless-stopped

        volumes:
          open-webui-data:

        networks:
          webui-net:
            driver: bridge
        ```

        Где:
        
        * `WEBUI_BASE_URL` — статический публичный IP-адрес вашей виртуальной машины со схемой `https://`.

            Если за экземпляром Open WebUI зарезервировано доменное имя, в качестве адреса сервера используйте это доменное имя.
        * `OPENID_REDIRECT_URI` — значение `Redirect URI` вашего экземпляра Open WebUI. Также содержит статический публичный IP-адрес вашей ВМ или доменное имя, если оно зарезервировано за экземпляром Open WebUI.
        * `OAUTH_CLIENT_ID` — значение `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` OIDC-приложения {{ org-full-name }}.
        * `OAUTH_CLIENT_SECRET` — секрет OIDC-приложения {{ org-full-name }}.
        * `OPENID_PROVIDER_URL` — значение `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` OIDC-приложения {{ org-full-name }}.
1. В директории `~/projects/open-webui` вновь запустите конфигурацию:

    ```bash
    docker-compose up -d
    ```

    Дождитесь скачивания и распаковки всех компонентов и зависимостей, а также запуска контейнеров. 
1. Убедитесь, что контейнеры запущены:

    ```bash
    docker ps
    ```

    Если все настроено правильно, команда должна вывести контейнеры `nginx` и `open-webui` со статусом `Up`/`Healthy`.

    {% note info %}

    В зависимости от конфигурации виртуальной машины запуск контейнеров может занять несколько минут.

    {% endnote %}

## Настройте интеграцию на стороне Open WebUI {#setup-integration}

Донастройте Open WebUI в пользовательском интерфейсе:

1. В окне браузера откройте адрес вашего экземпляра Open WebUI:

    ```text
    https://<адрес_сервера>
    ```
1. На странице входа введите логин (адрес электронной почты) и пароль администратора, затем нажмите **Войти**.
1. В левом нижнем углу нажмите на значок профиля, выберите **Настройки** и перейдите в раздел **Аутентификация**.
1. В поле **Роль пользователя по умолчанию** выберите `пользователь`.
1. Убедитесь, что опция **OAuth / OIDC** включена, а также что в следующих полях указаны корректные данные:

    * **Provider Name** — `{{ org-full-name }}`.
    * **Provider URL** — значение `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}` OIDC-приложения {{ org-full-name }}.
    * **Client ID** — значение `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}` OIDC-приложения {{ org-full-name }}.
    * **Client Secret** — секрет OIDC-приложения {{ org-full-name }}.
    * **Redirect URI** — значение `Redirect URI` вашего экземпляра Open WebUI.

    При необходимости задайте в этих полях значения, которые ранее были указаны для переменных окружения в файле `docker-compose.yml`.
1. Задайте значения дополнительных полей:

    * **Scopes** — `openid email profile`.
    * **Email Claim** — `email`.
    * **Username Claim** — `preferred_username`.
    * **Sub Claim** — `sub`.
1. Включите опции **OAuth Signup** и **Merge Accounts by Email**.
1. Значения остальных параметров оставьте без изменений и нажмите кнопку **Сохранить**.


## Добавьте пользователя {#add-user}

Чтобы пользователи вашей организации могли аутентифицироваться в Open WebUI с помощью OIDC-приложения {{ org-full-name }}, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

Добавьте пользователя в приложение:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

    1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
    1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}**.
    1. Нажмите ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. В открывшемся окне выберите нужного пользователя или группу пользователей.
    1. Нажмите **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Убедитесь в корректной работе приложения {#validate}

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с Open WebUI, выполните аутентификацию в Open WebUI от имени одного из добавленных в приложение пользователей.

Для этого:

1. В браузере перейдите по адресу вашего экземпляра Open WebUI:

    ```text
    https://<адрес_сервера>
    ```
1. Если вы были авторизованы в Open WebUI, выйдите из профиля.
1. На странице входа в Open WebUI нажмите **Продолжить с {{ org-full-name }}**.
1. На странице аутентификации {{ yandex-cloud }} укажите email и пароль пользователя {{ org-full-name }}. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в Open WebUI.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес.
1. При необходимости удалите другие ресурсы {{ vpc-name }}:

    1. [группу безопасности](../../../vpc/operations/security-group-delete.md);
    1. [подсеть](../../../vpc/operations/subnet-delete.md);
    1. [облачную сеть](../../../vpc/operations/network-delete.md).

[*availability_zone]: {% include [before-you-begin](../../../_popups/availability-zone.md) %}
