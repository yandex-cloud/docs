[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > [Безопасность](../index.md) > Настройка единого входа в приложения (SSO) > Использование OAuth2 Proxy для приложений, не поддерживающих SSO

# Использовать OIDC-приложение и OAuth2 Proxy для настройки единого входа в приложения, не поддерживающие SSO

Не в каждом приложении реализована встроенная поддержка технологии [единого входа](../../../glossary/sso.md) (SSO). При этом иногда возникает потребность в настройке аутентификации пользователей в них с помощью Yandex Identity Hub.

В данном руководстве вы воспользуетесь утилитой [OAuth2 Proxy](https://oauth2-proxy.github.io/oauth2-proxy/) в связке с прокси-сервером, чтобы настроить интеграцию простейшего приложения с Yandex Identity Hub и организовать доступ к этому приложению только для заданных пользователей Yandex Identity Hub с помощью технологии единого входа по стандарту [OpenID Connect](https://ru.wikipedia.org/wiki/OpenID#OpenID_Connect) (OIDC).

В качестве прокси-сервера в данном руководстве используется [nginx](https://nginx.org/ru/), а в качестве тестового приложения — статическая HTML-страница. Чтобы ваши пользователи Yandex Identity Hub могли получить доступ к тестовому приложению, вы создадите и настроите [OIDC-приложение](../../../organization/concepts/applications/oidc.md). Дополнительно вам потребуется [виртуальная машина](../../../compute/concepts/vm.md) Yandex Compute Cloud, на которой будут запущены `nginx` и `OAuth2 Proxy`, а также размещено тестовое приложение. Кроме этого, для реализации защищенного доступа к тестовому приложению вам понадобятся доменное имя и выпущенный для него [SSL-сертификат](../../../glossary/ssl-certificate.md).

Управлять OIDC-приложениями может пользователь, которому назначена [роль](../../../organization/security/index.md#organization-manager-oauthApplications-admin) `organization-manager.oauthApplications.admin` или выше.

Чтобы настроить доступ в приложение для ваших пользователей Yandex Identity Hub:

1. [Создайте и настройте OIDC-приложение в Yandex Identity Hub](#setup-oidc-app).
1. [Подготовьте виртуальную машину с тестовым приложением](#setup-server).
1. [Настройте интеграцию](#setup-integration).
1. [Убедитесь в корректной работе интеграции](#validate).

## Создайте и настройте OIDC-приложение в Yandex Identity Hub {#setup-oidc-app}

### Создайте OIDC-приложение {#create-app}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.
  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **Создать приложение** и в открывшемся окне:

      1. Выберите метод единого входа **OIDC (OpenID Connect)**.
      1. В поле **Тип приложения** выберите тип [Web Application](*web_app_type).
         
         [*web_app_type]: OIDC-приложения типа `Web Application` оптимально подходят для аутентификации пользователей во внешних веб-приложениях, имеющих серверную часть (бэкенд), в которой может безопасно храниться секрет приложения. Подробнее о типах OIDC-приложений читайте в разделе [Типы OIDC-приложений в Yandex Identity Hub](../../../organization/concepts/applications/oidc.md#oidc-application-types).
      1. В поле **Имя** задайте имя создаваемого приложения: `website-oidc-app`.
      1. В поле **Каталог** выберите каталог, в котором будет создан OAuth-клиент для приложения.
      1. (Опционально) В поле **Описание** задайте описание приложения.
      1. (Опционально) Добавьте [метки](../../../resource-manager/concepts/labels.md):

          1. Нажмите **Добавить метку**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.
      1. Нажмите **Создать приложение**.
  1. В открывшемся окне на вкладке **Обзор** в блоке **Конфигурация поставщика удостоверений (IdP)** скопируйте и сохраните значение параметра `ClientID` с уникальным идентификатором OAuth-клиента. Это значение понадобится позднее при настройке утилиты `OAuth2 Proxy`.
  1. Создайте [секрет приложения](../../../organization/concepts/applications/oidc.md#oidc-secret):
  
      Создайте секрет приложения (действие доступно только для приложений [типа](../../../organization/concepts/applications/oidc.md#oidc-application-types) `Web Application`):
      
      1. В блоке **Секреты приложения** нажмите кнопку **Добавить секрет** и в открывшемся окне:
      
          1. (Опционально) Добавьте произвольное описание создаваемого секрета.
          1. Нажмите **Создать**.
      
      В окне отобразится сгенерированный [секрет приложения](../../../organization/concepts/applications/oidc.md#oidc-secret). Сохраните полученное значение.
      
      {% note warning %}
      
      После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.
      
      {% endnote %}
      
      Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **Добавить секрет**, чтобы создать новый.
      
      Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте OAuth-клиент:

      ```bash
      yc iam oauth-client create \
        --name website-oauth-client \
        --scopes openid,email,profile
      ```

      Где:

      * `--name` — имя OAuth-клиента.
      * `--scopes` — набор атрибутов пользователей, которые будут передаваться в `OAuth2 Proxy`. Указаны атрибуты:
          * `openid` — идентификатор пользователя. Обязательный атрибут.
          * `email` — адрес электронной почты пользователя.
          * `profile` — дополнительная информация о пользователе, такая как имя, фамилия, аватар.

      Результат:

      ```text
      id: ajeiu3otac08********
      name: website-oauth-client
      scopes:
        - email
        - openid
        - profile
      folder_id: b1gkd6dks6i1********
      status: ACTIVE
      ```

      Сохраните ClientID приложения (значение поля `id`) — оно понадобится для создания секрета и настройки `OAuth2 Proxy`.

  1. Создайте секрет для OAuth-клиента, указав полученный на предыдущем шаге идентификатор:

      ```bash
      yc iam oauth-client-secret create \
        --oauth-client-id <идентификатор_OAuth-клиента>
      ```

      Результат:

      ```text
      oauth_client_secret:
        id: ajeohit7l3t6********
        oauth_client_id: ajeiu3otac08********
        masked_secret: yccs__460c4ca204****
        created_at: "2026-01-22T08:51:27.263668671Z"
      secret_value: yccs__4d2243a25b501220ee2a6f********************************e76e64e797_07911bfb
      ```

      Сохраните значение поля `secret_value`, оно понадобится для настройки `OAuth2 Proxy`.

  1. Создайте OIDC-приложение:

      ```bash
      yc organization-manager idp application oauth application create \
        --organization-id <идентификатор_организации> \
        --name website-oidc-app \
        --description "OIDC-приложение для настройки доступа пользователей Yandex Identity Hub к сайту" \
        --client-id <идентификатор_OAuth-клиента> \
        --authorized-scopes openid,email,profile \
        --group-distribution-type none
      ```

      Где:

      * `--organization-id` — [идентификатор организации](../../../organization/operations/organization-get-id.md), в которой нужно создать OIDC-приложение. Обязательный параметр.
      * `--name` — имя OIDC-приложения. Обязательный параметр.
      * `--description` — описание OIDC-приложения. Необязательный параметр.
      * `--client-id` — идентификатор OAuth-клиента, полученный на втором шаге. Обязательный параметр.
      * `--authorized-scopes` — укажите те же атрибуты, которые были указаны при создании OAuth-клиента.
      * `--group-distribution-type` — укажите `none`, так как группы пользователей не передаются в `OAuth2 Proxy`.

      Результат:

      ```text
      done (2s)
      id: ek0odpetc1o4********
      name: website-oidc-app
      organization_id: bpf2c65rqcl8********
      description: OIDC-приложение для настройки доступа пользователей Yandex Identity Hub к сайту
      group_claims_settings:
        group_distribution_type: NONE
      client_grant:
        client_id: ajeiu3otac08********
        authorized_scopes:
          - openid
          - email
          - profile
      status: ACTIVE
      created_at: "2026-01-22T08:53:26.873089Z"
      updated_at: "2026-01-22T08:53:27.439690Z"
      ```

{% endlist %}

### Настройте Redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения** и выберите нужное OIDC-приложение.
  1. Справа сверху нажмите ![pencil](../../../_assets/console-icons/pencil.svg) **Редактировать** и в открывшемся окне:
      1. В поле **Redirect URI** укажите эндпоинт аутентификации для тестового приложения:

         ```text
         https://<ваш_домен>/oauth2/callback
         ```

         Где `<ваш_домен>` — домен вашего тестового приложения, например: `example.com`.
      1. Нажмите **Сохранить**.

- CLI {#cli}

  Обновите OAuth-клиент, указав Redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <идентификатор_OAuth-клиента> \
    --redirect-uris "https://<ваш_домен>/oauth2/callback"
  ```

  Где:
  
  * `<идентификатор_OAuth-клиента>` — идентификатор OAuth-клиента, полученный при его создании.
  * `--redirect-uris` — эндпоинт аутентификации для вашего тестового приложения. Например: `https://example.com/oauth2/callback`.

  Результат:

  ```text
    id: ajeiu3otac08********
    name: website-oauth-client
    redirect_uris:
      - https://example.com/oauth2/callback
    scopes:
      - email
      - openid
      - profile
    folder_id: b1gkd6dks6i1********
    status: ACTIVE
  ```

{% endlist %}

### Добавьте пользователя {#add-user}

Чтобы ваши пользователи Yandex Identity Hub могли проходить аутентификацию в тестовом приложении с помощью протокола OIDC, необходимо явно добавить в OIDC-приложение нужных пользователей и/или [группы пользователей](../../../organization/concepts/groups.md).

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

- CLI {#cli}

  1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md) или [группы пользователей](../../../organization/operations/group-get-id.md).
  1. Чтобы добавить в приложение пользователя или группу пользователей, выполните команду:
   
      ```bash
      yc organization-manager idp application oauth application add-assignments \
        --id <идентификатор_приложения> \
        --subject-id <идентификатор_пользователя_или_группы>
      ```
  
      Где:
  
      * `--id` — идентификатор OIDC-приложения.
      * `--subject-id` — идентификатор нужного пользователя или группы пользователей.
  
      Результат:
  
      ```text
      done (2s)
      assignment_deltas:
        - action: ADD
          assignment:
            subject_id: aje0j5mts02t********
      ```

{% endlist %}

{% note tip %}

Если вы хотите более тонко настроить аутентификацию пользователей в приложениях, в том числе разрешить аутентификацию только с определенных IP-адресов, используйте [политики аутентификации](*authentication_policies).

{% endnote %}

[*authentication_policies]: Политики аутентификации — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ к приложениям, запрещая или разрешая аутентификацию определенным пользователям в определенных приложениях и/или с определенных IP-адресов. Подробнее читайте в разделе [Политики аутентификации в Yandex Identity Hub](../../../organization/concepts/authentication-policy.md).

## Подготовьте виртуальную машину с тестовым приложением {#setup-server}

В данном руководстве вы развернете тестовое приложение, а также настроите утилиты `nginx` и `OAuth2 Proxy` на виртуальной машине под управлением ОС [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin).

{% note warning %}

Если вы хотите настроить доступ к вашему существующему приложению, выполните аналогичные настройки на том сервере, который принимает запросы от пользователей вашего приложения. В этом случае создавать отдельную виртуальную машину не требуется, и вы можете переходить к [настройке](#setup-nginx) `nginx` и `OAuth2 Proxy`.

{% endnote %}

### Подготовьте окружение Yandex Cloud {#prepare-env}

Прежде чем создавать виртуальную машину, убедитесь, что в вашем каталоге есть [облачная сеть](../../../vpc/concepts/network.md) и [подсеть](../../../vpc/concepts/network.md#subnet). При необходимости воспользуйтесь следующими инструкциями, чтобы создать их:

* [Создать облачную сеть](../../../vpc/operations/network-create.md)
* [Создать подсеть](../../../vpc/operations/subnet-create.md)

Кроме того, в вашей облачной сети [создайте](../../../vpc/operations/security-group-create.md) группу безопасности, разрешающую входящий TCP-трафик для портов `22`, `80` и `443`, а также любой исходящий трафик.

### Создайте виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `Ubuntu 24.04 LTS` и выберите публичный образ [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-24-04-lts).
  1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md), соответствующую зоне доступности вашей подсети.
  1. В блоке **Вычислительные ресурсы** выберите конфигурацию `2 vCPU 4 ГБ RAM`.
  1. В блоке **Сетевые настройки**:

      * В поле **Подсеть** выберите ваши сеть и подсеть в зоне доступности создаваемой виртуальной машины.
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный публичный IP-адрес из пула Yandex Cloud.
      * В поле **Группы безопасности** выберите созданную [ранее](#prepare-env) группу безопасности.
  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа к ВМ:

      * В поле **Логин** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
  1. В блоке **Общая информация** задайте имя ВМ: `my-nginx-vm`.
  1. Нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  Чтобы создать виртуальную машину, выполните команду:

  ```bash
    yc compute instance create \
      --name my-nginx-vm \
      --zone <зона_доступности_ВМ> \
      --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2404-lts,auto-delete=true \
      --ssh-key <путь_к_открытому_SSH-ключу> \
      --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4,security-group-ids=<идентификатор_группы_безопасности>
  ```

  Где:
  * `--name` — имя ВМ. Требования к имени:

    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.

  * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой вы создаете виртуальную машину.
  * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), например: `~/.ssh/id_ed25519.pub`. Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.
  * `subnet-name` — имя подсети в том же каталоге и той же зоне доступности, в которых создается виртуальная машина.
  * `<идентификатор_группы_безопасности>` — идентификатор группы безопасности, созданной [ранее](#prepare-env).

  {% cut "Результат" %}

  ```text
  done (29s)
  id: epdvqa1rtvjj********
  folder_id: b1gt6g8ht345********
  created_at: "2026-01-22T12:03:52Z"
  name: my-nginx-vm
  zone_id: ru-central1-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epdbi403v2or********
    auto_delete: true
    disk_id: epdbi403v2or********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:1f:d2:83:be
      subnet_id: e2lqsms4cdl3********
      primary_v4_address:
        address: 192.168.2.31
        one_to_one_nat:
          address: 89.169.***.***
          ip_version: IPV4
      security_group_ids:
        - enp378h7n0cm********
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  gpu_settings: {}
  fqdn: epdvqa1rtvjj********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V2
  application: {}
  ```

  {% endcut %}

{% endlist %}

## Настройте интеграцию {#setup-integration}

### Создайте тестовое приложение и настройте nginx {#setup-nginx}

1. Убедитесь, что для вашего домена создана ресурсная [A-запись](../../../dns/concepts/resource-record.md#a), указывающая на [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) созданной виртуальной машины. Если такой ресурсной записи нет, создайте ее.

    {% note info %}

    Если управление вашим доменом делегировано сервису [Yandex Cloud DNS](../../../dns/index.md), для создания ресурсной записи воспользуйтесь инструкцией [Создать ресурсную запись](../../../dns/operations/resource-record-create.md). Если доменом управляет сторонний провайдер, воспользуйтесь документацией этого провайдера или обратитесь в его службу поддержки.

    {% endnote %}
1. [Подключитесь по SSH](../../../compute/operations/vm-connect/ssh.md) к созданной виртуальной машине.
1. Установите `nginx`:

    ```bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install nginx -y
    ```
1. Создайте файлы тестового приложения:

    1. Сохраните имя вашего домена в переменную окружения:

        ```bash
        export MY_DOMAIN="<имя_домена>"
        ```

        Где `<имя_домена>` — имя вашего домена, для которого создана ресурсная запись, указывающая на публичный IP-адрес текущей виртуальной машины. Например: `example.com`.
    1. Создайте директорию и основную HTML-страницу тестового приложения:

        ```bash
        sudo mkdir /var/www/$MY_DOMAIN
        sudo touch /var/www/$MY_DOMAIN/index.html \
          && echo "<h1>Your Web application that is available to your Yandex Identity Hub users only</h1>" | sudo tee -a /var/www/$MY_DOMAIN/index.html
        ```
1. Создайте самоподписанный SSL-сертификат для вашего домена. Для этого выполните команду и введите значения, следуя инструкциям на экране:

    ```bash
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/my-private.key -out /etc/ssl/certs/my-certificate.crt
    ```

    В результате будет создан [самоподписанный SSL-сертификат](../../../glossary/ssl-certificate.md#self-signed), которого достаточно для тестирования предлагаемого решения.

    {% note tip %}

    Чтобы при использовании приложения браузер не выдавал предупреждение о проблемах с безопасностью, используйте SSL-сертификат, выданный удостоверяющим центром.
    
    Например, чтобы создать сертификат от Let's Encrypt и сохранить его и закрытый ключ на свой компьютер, воспользуйтесь инструкциями [Добавить сертификат от Let's Encrypt®](../../../certificate-manager/operations/managed/cert-create.md) и [Получить содержимое сертификата от Let's Encrypt](../../../certificate-manager/operations/managed/cert-get-content.md).

    {% endnote %}

1. Задайте настройки `nginx`:

    1. С помощью текстового редактора `nano` откройте файл конфигурации `nginx`:

        ```bash
        sudo nano /etc/nginx/conf.d/default.conf
        ```

    1. Замените содержимое открытого файла следующим:

        ```text
        server {
            listen 80;
            listen [::]:80;
            server_name <имя_домена>;

            return 301 https://$server_name$request_uri;
        }

        server {
            listen 443 ssl;
            listen [::]:443 ssl;
            server_name <имя_домена>;

            location /oauth2/ {
                proxy_pass       http://127.0.0.1:4180;
                proxy_set_header Host                    $host;
                proxy_set_header X-Real-IP               $remote_addr;
                proxy_set_header X-Auth-Request-Redirect $request_uri;
                # or, if you are handling multiple domains:
                # proxy_set_header X-Auth-Request-Redirect $scheme://$host$request_uri;
            }
          
            location = /oauth2/auth {
                proxy_pass       http://127.0.0.1:4180;
                proxy_set_header Host             $host;
                proxy_set_header X-Real-IP        $remote_addr;
                proxy_set_header X-Forwarded-Uri  $request_uri;
                # nginx auth_request includes headers but not body
                proxy_set_header Content-Length   "";
                proxy_pass_request_body           off;
            }

            # Пути к вашим сертификату и ключу
            ssl_certificate /etc/ssl/certs/my-certificate.crt;
            ssl_certificate_key /etc/ssl/private/my-private.key;

            # Рекомендуемые настройки безопасности
            ssl_protocols TLSv1.2 TLSv1.3;
            ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
            ssl_prefer_server_ciphers on;

            access_log /var/log/nginx/$server_name.access.log;
            error_log /var/log/nginx/$server_name.error.log;

            location / {

                auth_request /oauth2/auth;
                error_page 401 =403 /oauth2/sign_in;

                # pass information via X-User and X-Email headers to backend,
                # requires running with --set-xauthrequest flag
                auth_request_set $user   $upstream_http_x_auth_request_user;
                auth_request_set $email  $upstream_http_x_auth_request_email;
                proxy_set_header X-User  $user;
                proxy_set_header X-Email $email;

                root /var/www/$server_name/;
                index index.html;

                try_files $uri $uri/ =404;
            }

        }
        ```

        Где `<имя_домена>` — имя вашего домена, для которого создана ресурсная запись, указывающая на публичный IP-адрес текущей виртуальной машины. Например: `example.com`.

        {% note warning %}

        Если вы используете SSL-сертификат, выданный удостоверяющим центром, скопируйте файлы сертификата и закрытого ключа на виртуальную машину и укажите локальные пути к этим файлам соответственно в полях `ssl_certificate` и `ssl_certificate_key` файла конфигурации.

        {% endnote %}
1. Примените обновленные настройки `nginx`:

    ```bash
    sudo nginx -s reload
    ```

### Настройте OAuth2 Proxy {#setup-oauth2-proxy}

1. [Подключитесь по SSH](../../../compute/operations/vm-connect/ssh.md) к созданной виртуальной машине.
1. [Установите](https://oauth2-proxy.github.io/oauth2-proxy/installation) актуальную версию утилиты `OAuth2 Proxy` удобным вам способом.

    В приведенном примере используется установка путем скачивания архива с исполняемым файлом. На момент написания настоящего руководства актуальной являлась версия `v7.14.2`:

    ```bash
    sudo wget https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v7.14.2/oauth2-proxy-v7.14.2.linux-amd64.tar.gz
    sudo tar -xvf oauth2-proxy-v7.14.2.linux-amd64.tar.gz -C /usr/bin/
    sudo chmod +x /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy
    sudo rm oauth2-proxy-v7.14.2.linux-amd64.tar.gz
    ```
1. Задайте настройки `OAuth2 Proxy`:

    1. Сгенерируйте секрет cookie, который потребуется при настройке утилиты:

        ```bash
        dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 | tr -d -- '\n' | tr -- '+/' '-_' ; echo
        ```

        Сохраните полученное значение — оно понадобится позднее.
    1. С помощью текстового редактора `nano` откройте файл конфигурации `oauth2-proxy.cfg`:

        ```bash
        sudo nano /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy.cfg
        ```
    1. Вставьте в файл `oauth2-proxy.cfg` следующую конфигурацию, подставив в нее необходимые значения:

        ```text
        provider = "oidc"  # Тип провайдера
        provider_display_name = "Yandex Identity Hub" # Имя провайдера на кнопке
        reverse_proxy = true # Включение режима работы за nginx
        client_id = "<идентификатор_ClientID>" # ClientID OIDC приложения 
        client_secret = "<секрет_OIDC_приложения>" # Секрет OIDC приложения
        oidc_issuer_url = "https://auth.yandex.cloud"
        cookie_name = "_oauth2_proxy" # Имя cookie
        cookie_secret = "<секрет_cookie>"  # Сгенерированный ранее ключ cookie
        email_domains = [ "<домен_1>","<домен_2>",...,"<домен_n>" ]  # Домены, для которых разрешена аутентификация
        upstreams = [ "<адрес_вашего_приложения>" ]  # Адрес бэкенд-приложения
        http_address = "127.0.0.1:4180"  # Адрес и порт, на которых слушает oauth2-proxy
        redirect_url = "<redirect_URI>"  # URL для обратного вызова
        ```

        Где:

        * `client_id` — значение `ClientID` OAuth-клиента, полученное [ранее](#create-app) при создании OIDC-приложения.
        * `client_secret` — значение секрета, сгенерированного в OIDC-приложении.
        * `cookie_secret` — секрет cookie, сгенерированный и сохраненный ранее.
        * `email_domains` — список доменов в адресе электронной почты, для которых будет разрешена аутентификация пользователя Yandex Identity Hub в тестовом приложении.

            Утилита `OAuth2 Proxy` проверяет домен электронной почты, указанной в поле `Электронная почта` настроек пользователя в Yandex Identity Hub ([атрибут](../../../organization/concepts/applications/oidc.md#oidc-attributes) `email`).

            В поле `email_domains` укажите домен электронной почты того пользователя, которого вы добавили ранее в ваше OIDC-приложение. Если в OIDC-приложение вы добавляли группу пользователей, укажите домен электронной почты того пользователя группы, от имени которого вы будете тестировать аутентификацию. Вы можете указать несколько доменов через запятую.

            {% note tip %}

            Чтобы в тестовом приложении могли аутентифицироваться пользователи [с аккаунтом на Яндексе](../../../iam/concepts/users/accounts.md#passport), добавьте в список `email_domains` значение `yandex.ru`.

            {% endnote %}

        * `upstreams` — адрес вашего приложения. Например: `https://example.com/`.
        * `redirect_url` — значение `Redirect URI`, которое вы задали при настройке OIDC-приложения.

1. Запустите `OAuth2 Proxy`:

    ```bash
    sudo /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy \
      --config /usr/bin/oauth2-proxy-v7.14.2.linux-amd64/oauth2-proxy.cfg
    ```

    {% note tip %}

    Вы также можете запустить `OAuth2 Proxy` в фоновом режиме, например, с помощью утилиты [nohup](https://ru.wikipedia.org/wiki/Nohup).

    {% endnote %}

## Убедитесь в корректной работе аутентификации {#validate}

Чтобы убедиться в корректной работе аутентификации в тестовом приложении с помощью OIDC-приложения:

1. В браузере введите адрес вашего тестового приложения (например, `https://example.com`).

    Если все было настроено правильно, в браузере откроется окно аутентификации `OAuth2 Proxy`.
1. Нажмите кнопку **Sign in with Yandex Identity Hub**.
1. Пройдите аутентификацию от имени того пользователя, которого вы ранее добавили в OIDC-приложение. Если в OIDC-приложение вы добавляли группу пользователей, пройдите аутентификацию от имени пользователя, который входит в эту группу.

    Если все было настроено правильно, в браузере откроется страница с вашим тестовым приложением.
1. При попытке аутентифицироваться от имени пользователя, не добавленного в OIDC-приложение, или имеющего адрес электронной почты с доменом, отличным от разрешенных в настройках `OAuth2 Proxy`, ваше приложение выдаст сообщение об ошибке доступа.