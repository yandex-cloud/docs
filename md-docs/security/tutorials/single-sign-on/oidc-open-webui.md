[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Настройка SSO > Настройка единого входа в Open WebUI по стандарту OIDC

# Создать OIDC-приложение в Yandex Identity Hub для интеграции с Open WebUI


[Open WebUI](https://openwebui.com/) — это бесплатная платформа с открытым исходным кодом для удобной работы с большими языковыми моделями, которую можно развернуть в собственной инфраструктуре. Open WebUI поддерживает аутентификацию [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC) для обеспечения безопасного единого входа пользователей организации.

Чтобы пользователи вашей [организации](../../../organization/concepts/organization.md) могли аутентифицироваться в Open WebUI с помощью технологии единого входа по стандарту OpenID Connect, создайте [OIDC-приложение](../../../organization/concepts/applications/oidc.md) в Yandex Identity Hub и настройте его на стороне Yandex Identity Hub и на стороне Open WebUI.

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

{% note info %}

Для демонстрации интеграции в этом руководстве вы развернете экземпляр Open WebUI на [виртуальной машине](../../../compute/concepts/vm.md) Yandex Compute Cloud.

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

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Подготовьте окружение {#prepare}

1. [Создайте](../../../vpc/operations/network-create.md) облачную сеть с [подсетью](../../../vpc/operations/subnet-create.md) в [зоне доступности](*availability_zone), в которой вы будете развертывать экземпляр Open WebUI.
1. [Зарезервируйте](../../../vpc/operations/get-static-ip.md) статический публичный IP-адрес в зоне доступности, в которой вы будете развертывать экземпляр Open WebUI.
1. В вашей облачной сети создайте группу безопасности, разрешающую следующий трафик:

    | Направление<br/>трафика | Диапазон портов | Протокол | Источник /<br/>Назначение | IPv4 CIDR | Описание |
    | --- | --- | --- | --- | --- | --- |
    | Входящий | `80` | `TCP` | `Диапазон адресов` | `0.0.0.0/0` | `http`           |
    | Входящий | `8080` | `TCP` | `Диапазон адресов` | `0.0.0.0/0` | `8080`           |
    | Входящий | `443`   | `TCP`  | `Диапазон адресов` | `0.0.0.0/0` | `https`            |
    | Входящий | `22`   | `TCP`  | `Диапазон адресов` | `0.0.0.0/0` | `ssh`            |
    | Исходящий | `Весь` | `Любой` | `Диапазон адресов` | `0.0.0.0/0` | `any`           |
1. [Создайте](../../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину из публичного образа [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin).

    {% note info %}

    При создании виртуальной машины выберите зону доступности, в которой создана ваша подсеть, используйте зарезервированный ранее публичный IP-адрес и созданную группу безопасности.
    
    Рекомендуется использовать конфигурацию ВМ с 8 ГБ RAM и более.

    {% endnote %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой в руководстве инфраструктуры входят:
* плата за постоянно запущенную виртуальную машину ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование статического публичного IP-адреса ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).


## Создайте приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

    1. Перейдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
    1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:
        1. Выберите метод единого входа **OIDC (OpenID Connect)**.
        1. В поле **Тип приложения** выберите тип [Web Application](*web_app_type).
           
           [*web_app_type]: OIDC-приложения типа `Web Application` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться секрет приложения. Подробнее о типах OIDC-приложений читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../../organization/concepts/applications/oidc.md#oidc-application-types).
        1. В поле **Имя** задайте имя создаваемого приложения: `open-webui-oidc-app`.
        1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
        1. (Опционально) В поле **Описание** задайте описание приложения.
        1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

            1. Нажмите **Добавить метку**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.
        1. Нажмите **Создать приложение**.

{% endlist %}

### Получите учетные данные приложения {#get-credentials}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. На вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте значения параметров, которые потребуется задать на стороне Open WebUI:

        * `ClientID` — уникальный идентификатор приложения.
        * `OpenID Configuration` — URL с конфигурацией всех необходимых для настройки интеграции параметров.

  1. Создайте секрет приложения (действие доступно только для приложений [типа](../../../organization/concepts/applications/oidc.md#oidc-application-types) `Web Application`):
     
     1. В блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
     
         1. (Опционально) Добавьте произвольное описание создаваемого секрета.
         1. Нажмите **Создать**.
     
     В окне отобразится сгенерированный [секрет приложения](../../../organization/concepts/applications/oidc.md#oidc-secret). Сохраните полученное значение.
     
     {% note warning %}
     
     После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
     
     {% endnote %}
     
     Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
     
     Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.

{% endlist %}


### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите OIDC-приложение `open-webui-oidc-app`.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
      1. В поле **Redirect URI** укажите эндпоинт аутентификации для вашего экземпляра Open WebUI в формате:

          ```text
          https://<адрес_сервера>/oauth/oidc/callback
          ```

          Где `<адрес_сервера>` — статический публичный IP-адрес ВМ, зарезервированный ранее.
          
          
          {% note info %}

          Если за экземпляром Open WebUI зарезервировано доменное имя, в качестве адреса сервера используйте это доменное имя.

          {% endnote %}

      1. В блоке **Безопасность OAuth/OIDC** отключите опцию **Требовать PKCE**, чтобы приложение Yandex Identity Hub при обмене данными не требовало от внешнего приложения использовать расширение безопасности [PKCE](*pkce_info).
         
         [*pkce_info]: PKCE — это расширение безопасности, применяемое в стандарте OAuth 2.0 с целью минимизировать риски перехвата аутентификационных данных. Подробнее читайте в разделе [PKCE](../../../organization/concepts/applications/oidc.md#pkce).
      1. Нажмите **Сохранить**.

{% endlist %}


## Разверните экземпляр Open WebUI {#deploy-open-webui}

В этом руководстве вы развернете экземпляр Open WebUI на виртуальной машине Compute Cloud в [Docker](https://www.docker.com/)-контейнере.

Чтобы развернуть Open WebUI:

1. Подключитесь к созданной [ранее](#prepare) виртуальной машине. В зависимости от заданных настроек ВМ вы можете подключиться к ней [по SSH](../../../compute/operations/vm-connect/ssh.md) или [по OS Login](../../../compute/operations/vm-connect/os-login.md).
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

    TLS-сертификат необходим для организации доступа к Open WebUI по протоколу `https`. В настройках OIDC-приложения на стороне Yandex Identity Hub значение `Redirect URI` можно добавить только со схемой `https://`.

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
    1. Замените содержимое файла `docker-compose.yml` на следующую конфигурацию, указав в ней параметры OIDC-приложения Yandex Identity Hub:

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
              - OAUTH_PROVIDER_NAME=Yandex Identity Hub
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
        * `OAUTH_CLIENT_ID` — значение `ClientID` OIDC-приложения Yandex Identity Hub.
        * `OAUTH_CLIENT_SECRET` — секрет OIDC-приложения Yandex Identity Hub.
        * `OPENID_PROVIDER_URL` — значение `OpenID Configuration` OIDC-приложения Yandex Identity Hub.
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

    * **Provider Name** — `Yandex Identity Hub`.
    * **Provider URL** — значение `OpenID Configuration` OIDC-приложения Yandex Identity Hub.
    * **Client ID** — значение `ClientID` OIDC-приложения Yandex Identity Hub.
    * **Client Secret** — секрет OIDC-приложения Yandex Identity Hub.
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

Чтобы пользователи вашей организации могли аутентифицироваться в Open WebUI с помощью OIDC-приложения Yandex Identity Hub, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

{% note info %}

Управлять пользователями и группами, добавленными в OIDC-приложение, может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) `organization-manager.oidcApplications.userAdmin` или выше.

{% endnote %}

Добавьте пользователя в приложение:

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

Чтобы убедиться в корректной работе OIDC-приложения и интеграции с Open WebUI, выполните аутентификацию в Open WebUI от имени одного из добавленных в приложение пользователей.

Для этого:

1. В браузере перейдите по адресу вашего экземпляра Open WebUI:

    ```text
    https://<адрес_сервера>
    ```
1. Если вы были авторизованы в Open WebUI, выйдите из профиля.
1. На странице входа в Open WebUI нажмите **Продолжить с Yandex Identity Hub**.
1. На странице аутентификации Yandex Cloud укажите email и пароль пользователя Yandex Identity Hub. Пользователь должен быть добавлен в приложение или состоять в группе, добавленной в приложение.
1. Убедитесь, что вы аутентифицировались в Open WebUI.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес.
1. При необходимости удалите другие ресурсы Virtual Private Cloud:

    1. [группу безопасности](../../../vpc/operations/security-group-delete.md);
    1. [подсеть](../../../vpc/operations/subnet-delete.md);
    1. [облачную сеть](../../../vpc/operations/network-delete.md).

[*availability_zone]: Зона доступности — это инфраструктура внутри дата-центра, в котором размещается платформа Yandex Cloud. Подробнее читайте в разделе [Зоны доступности](../../../overview/concepts/geo-scope.md).