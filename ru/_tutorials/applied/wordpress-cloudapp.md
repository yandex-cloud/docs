

С помощью этого руководства вы установите и настроите [WordPress](https://wordpress.org/) — систему управления контентом, подходящую как для личных блогов, так и для крупных медиа и коммерческих проектов. Приложение [{{ cloud-apps-name }}](../../cloud-apps/) будет развернуто на виртуальной машине с автоматической настройкой всех необходимых ресурсов, включая веб-сервер и интеграцию с сервисом [{{ postbox-name }}](../../postbox/).

Чтобы установить WordPress:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сеть и подсети {{ vpc-short-name }}](#create-network).
1. [Настройте DNS-зону](#configure-dns).
1. [Создайте секреты {{ lockbox-name }}](#create-secret).
1. [Установите WordPress, используя {{ cloud-apps-name }}](#install-wordpress).
1. [Настройте WordPress](#configure-wordpress).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* Плата за использование виртуальной машины и хранение данных на диске ([тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование публичной DNS-зоны и за публичные DNS-запросы ([тарифы {{ dns-full-name }}](../../dns/pricing.md)).
* Плата за хранение секретов и операции с ними (тарифы [{{ lockbox-full-name }}](../../lockbox/pricing.md)).
* Плата за исходящие письма (тарифы [{{ postbox-full-name }}](../../postbox/pricing.md)).


## Создайте сеть и подсети {{ vpc-short-name }} {#create-network}

Создайте [облачную сеть](../../vpc/concepts/network.md) и [подсеть](../../vpc/concepts/network.md#subnet), в которой будет развернута ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будете разворачивать инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Оставьте включенной опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте облачную сеть в каталоге по умолчанию:

      ```
      yc vpc network create --name wordpress-network
      ```

  1. Получите список облачных сетей в каталоге:

      ```
      yc vpc network list --folder-id b1g6ci08ma55********
      ```

      Результат:

      ```
      +----------------------+-------------------+
      |          ID          |      NAME         |
      +----------------------+-------------------+
      | enpavfmgapum******** | wordpress-network |
      | enplom7a98s1******** | default           |
      +----------------------+-------------------+
      ```

  1. Выберите `NAME` или `ID` требуемой облачной сети. Создайте подсеть в любой зоне доступности:

      ```
      yc vpc subnet create \
        --network-id enpavfmgapum******** \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      Где:

      * `--network-id` — идентификатор облачной сети. При создании подсети указывается облачная сеть, в которой создаются подсеть и CIDR.
      * `--zone` — зона доступности, в которой создается подсеть.
      * `--range` — список внутренних IPv4-адресов, определенных для данной подсети. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — /28, а максимальный размер подсети — /16. Поддерживается только IPv4.

      Требования к названию подсети:

      {% include [name-format](../../_includes/name-format.md) %}

- API {#api}

  Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) и передайте в запросе идентификатор каталога, в котором будет размещена сеть, в параметре `folderId`.

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором будет размещена подсеть, в параметре `folderId`.
  * Идентификатор сети, в которой будет размещена подсеть, в параметре `networkId`.
  * Идентификатор зоны доступности, в которой будет размещена подсеть, в параметре `zoneId`.
  * Список внутренних IPv4-адресов, определенных для данной подсети, в массиве `v4CidrBlocks[]`. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

  {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

{% endlist %}


## Настройте DNS-зону {#configure-dns}

{% include [wordpress-configure-dns](../_tutorials_includes/wordpress/configure-dns.md) %}

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}


## Создайте секреты {{ lockbox-name }} {#create-secret}

В [секретах](../../lockbox/concepts/secret.md) {{ lockbox-name }} будут храниться пароль базы данных {{ mmy-name }}, root-пароль базы данных и пароль администратора WordPress.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать секрет, в котором будет храниться пароль базы данных {{ mmy-name }}:

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета: `db-password-secret`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}** выберите `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** введите `db_password`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** вставьте пароль базы данных {{ mmy-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Аналогичным образом создайте еще два секрета:

  {{ ui-key.yacloud.common.name }} | {{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }} | Описание
  --- | --- | ---
  `db-root-password-secret`  | `db_root_password`  | Root-пароль базы данных {{ mmy-name }}.
  `wp-admin-password-secret` | `wp_admin_password` | Пароль администратора WordPress.


- {{ yandex-cloud }} CLI {#cli}

  Чтобы создать секрет, в котором будет храниться пароль базы данных {{ mmy-name }}, выполните команду:

  ```bash
  yc lockbox secret create \
    --name db-password-secret \
    --payload "[{'key': 'db_password', 'text_value': '<пароль>'}]"
  ```

  Где `text_value` — пароль базы данных {{ mmy-name }}.

  Результат:

  ```text
  id: e6q0rdjdggjp********
  folder_id: b1g681qpemb4********
  created_at: "2025-07-12T18:23:49.844Z"
  name: db-password-secret
  status: ACTIVE
  current_version:
    id: e6qbp772i014********
    secret_id: e6q0rdjdggjp********
    created_at: "2025-07-12T18:23:49.844Z"
    status: ACTIVE
    payload_entry_keys:
      - db_password
  ```

  Аналогичным образом создайте еще два секрета:

  {{ ui-key.yacloud.common.name }} | {{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }} | Описание
  --- | --- | ---
  `db-root-password-secret`  | `db_root_password`  | Root-пароль базы данных {{ mmy-name }}.
  `wp-admin-password-secret` | `wp_admin_password` | Пароль администратора WordPress.

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

  Используйте следующие имена и ключи:

  {{ ui-key.yacloud.common.name }} | {{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }} | Описание
  --- | --- | ---
  `db-password-secret`       | `db_password`       | Пароль базы данных {{ mmy-name }}.
  `db-root-password-secret`  | `db_root_password`  | Root-пароль базы данных {{ mmy-name }}.
  `wp-admin-password-secret` | `wp_admin_password` | Пароль администратора WordPress.

{% endlist %}

{% note info %}

Вы можете не создавать секреты с root-паролем БД и паролем администратора WordPress и не указывать их в настройках приложения, тогда они создадутся автоматически со случайными паролями во время установки приложения.

{% endnote %}


## Установите WordPress {#install-wordpress}

Установите [WordPress](/marketplace/products/yc/wordpress-app) с помощью {{ cloud-apps-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Нажмите **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. Выберите приложение **WordPress** и нажмите **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Задайте настройки приложения:

      {% note warning %}

      Логин администратора WordPress нельзя изменить после установки приложения.

      {% endnote %}

      #|
      || **Параметр** | **Обязательный** | **Значение по умолчанию** | **Описание** ||
      || **{{ ui-key.yacloud.common.name }}** | Да | — | Название вашего экземпляра WordPress. ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Описание экземпляра приложения. ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Да | — | Сервисный аккаунт с ролью `admin` на каталог. Чтобы сервисный аккаунт с необходимыми правами создался во время установки приложения, выберите `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **Идентификатор DNS-зоны** | Да | — | Идентификатор DNS-зоны, в которой будет находиться домен приложения. ||
      || **Поддомен сайта** | — | Пустой | Домен, на котором будет доступен основной сайт. Формируется добавлением поддомена к домену DNS-зоны: `site.example.com` или `example.com`, если поддомен не указан. ||
      || **Поддомен админ панели базы данных** | — | `db` | Домен, на котором будет доступна административная панель сайта. Формируется добавлением поддомена к домену DNS-зоны: `db.example.com`. ||
      || **Отправитель почты** | — | `noreply@<домен_сайта>` | Отправитель почты. Используется для настройки SMTP через {{ postbox-name }}. ||
      || **Логин администратора WordPress** | — | `admin` | Имя пользователя для учетной записи администратора WordPress. ||
      || **Email администратора WordPress** | Да | — | Адрес электронной почты, который будет использоваться для создания учетной записи администратора WordPress, отправки системных уведомлений и восстановления пароля. ||
      || **ID секрета с паролем администратора WordPress** | — | — | Идентификатор секрета `wp-admin-password-secret` с паролем администратора WordPress, созданный ранее. Если вы не укажете секрет, он будет создан со случайным паролем автоматически во время установки приложения. ||
      || **Подсеть VPC** | Да | — | Подсеть, в которой будет развернута виртуальная машина. ||
      || **Количество vCPU** | — | `2` | Количество ядер vCPU. ||
      || **Объем RAM в GB** | — | `2` | Объем RAM в ГБ. ||
      || **Гарантированная доля vCPU** | — | `100` | Гарантированная доля vCPU в процентах. Доступные значения: 20%, 50% или 100%. ||
      || **Публичный SSH-ключ** | — | — | Ключ добавится в `authorized_keys` пользователя WordPress.
      Рекомендуется указать публичный SSH-ключ, чтобы иметь доступ к ВМ по SSH. Пару ключей для подключения по SSH необходимо [создать самостоятельно](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). ||
      || **Тип диска** | — | `network-ssd` | Тип диска, который будет подключен к ВМ. ||
      || **Размер диска в GB** | — | `20` | Размер диска, который будет подключен к ВМ, в ГБ. ||
      || **ID секрета с паролем БД** | Да | — | Идентификатор секрета `db-password-secret` с паролем для подключения к кластеру {{ mmy-name }}, созданного ранее. ||
      || **ID секрета с root паролем БД** | Да | — | Идентификатор секрета `db-root-password-secret` с паролем для подключения к кластеру {{ mmy-name }}, созданный ранее. ||
      |#

  1. Нажмите **{{ ui-key.yacloud.cloud-apps.button_install }}**.

     В открывшемся окне отобразятся ресурсы, которые будут созданы во время установки приложения. После создания всех ресурсов на виртуальной машине будет происходить настройка сайта, установка плагинов и выпуск TLS-сертификатов. Дождитесь завершения установки, она займет 5–10 минут.

{% endlist %}

{% include [note-auto-address](../_tutorials_includes/wordpress/note-auto-address.md) %}


## Настройте WordPress {#configure-wordpress}

{% include [configure-wordpress](../_tutorials_includes/wordpress/configure-wordpress.md) %}


## Проверьте результат {#check-result}

{% include [check-result](../_tutorials_includes/wordpress/check-result.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу и перестать платить за созданные ресурсы:

1. Удалите адрес {{ postbox-name }} и связанную с ним [DNS-запись](../../dns/operations/resource-record-delete.md) — они не удалятся автоматически при удалении приложения.
1. Удалите установленное приложение WordPress:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором установлено приложение.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Найдите установленное приложение WordPress в списке.
   1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) рядом с приложением и выберите **{{ ui-key.yacloud.common.delete }}**.
   1. Подтвердите удаление приложения.

1. [Удалите](../../dns/operations/zone-delete.md) публичную DNS-зону.
1. [Удалите](../../lockbox/operations/secret-delete.md) секреты {{ lockbox-name }}.
1. Удалите [подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md) {{ vpc-short-name }}.
