---
title: Установка WordPress
description: Установка и настройка WordPress с помощью {{ cloud-apps-name }} в {{ yandex-cloud }}
keywords:
  - wordpress
  - cloudapp
  - установка wordpress
  - wordpress cloudapp
---

# Установка WordPress High Availability с помощью {{ cloud-apps-name }}

С помощью этого руководства вы установите и настроите [WordPress](https://wordpress.org/) — систему управления контентом, подходящую как для личных блогов, так и для крупных медиа и коммерческих проектов. Приложение [{{ cloud-apps-name }}](../../cloud-apps/) будет развернуто на виртуальной машине с автоматической настройкой всех необходимых ресурсов, включая базу данных [{{ mmy-full-name }}](../../managed-mysql/), веб-сервер и интеграцию с сервисом [{{ postbox-name }}](../../postbox/).

Чтобы установить WordPress:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сеть и подсети {{ vpc-short-name }}](#create-network).
1. [Настройте DNS-зону](#configure-dns).
1. [Создайте секрет {{ lockbox-name }}](#create-secret).
1. [Установите WordPress, используя {{ cloud-apps-name }}](#install-wordpress).
1. [Настройте WordPress](#configure-wordpress).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* Плата за использование виртуальной машины и хранение данных на диске (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование публичной DNS-зоны и за публичные DNS-запросы (см. [тарифы {{ dns-full-name }}](../../dns/pricing.md)).
* Плата за выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mmy-full-name }}](../../managed-mysql/pricing.md)).
* Плата за использование бакета для хранения медиафайлов (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).
* Плата за хранение секретов и операции с ними (см. тарифы [{{ lockbox-full-name }}](../../lockbox/pricing.md)).
* Плата за исходящие письма (см. тарифы [{{ postbox-full-name }}](../../postbox/pricing.md)).

## Создайте сеть и подсети {{ vpc-short-name }} {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать облачную сеть.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Оставьте включенной опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте [облачную сеть](../../vpc/concepts/network.md) в каталоге по умолчанию:

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

  1. Выберите `NAME` или `ID` требуемой облачной сети. Создайте подсеть в зоне доступности `{{ region-id }}-a`:

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

  1. Аналогичным образом создайте подсеть в зоне доступности `{{ region-id }}-d`.

- API {#api}

  Чтобы создать [облачную сеть](../../vpc/concepts/network.md), воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) и передайте в запросе идентификатор каталога, в котором будет размещена сеть, в параметре `folderId`.

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

  Чтобы создать подсети в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-d`, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором будет размещена подсеть, в параметре `folderId`.
  * Идентификатор сети, в которой будет размещена подсеть, в параметре `networkId`.
  * Идентификатор зоны доступности, в которой будет размещена подсеть, в параметре `zoneId`.
  * Список внутренних IPv4-адресов, определенных для данной подсети, в массиве `v4CidrBlocks[]`. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

  {% include [get-subnet-id](../../_includes/vpc/get-subnet-id.md) %}

{% endlist %}

## Настройте DNS-зону {#configure-dns}

Создайте публичную DNS-зону и делегируйте на нее домен. Подробнее о делегировании домена читайте в [инструкции](../../troubleshooting/dns/how-to/delegate-public-zone.md). В DNS-зоне будут размещаться домены WordPress.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [зону DNS](../../dns/concepts/dns-zone.md).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_zone-create }}**.
  1. Задайте настройки зоны DNS:
     * **{{ ui-key.yacloud.dns.label_zone }}** — укажите ваш зарегистрированный домен, например `example.com.` (с точкой в конце).
     * **{{ ui-key.yacloud.common.type }}** — выберите `{{ ui-key.yacloud.dns.label_public }}`.
     * **{{ ui-key.yacloud.common.name }}** — укажите имя зоны, например `example-zone`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Делегируйте домен на серверы {{ yandex-cloud }}. Для этого в личном кабинете вашего регистратора доменных имен укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

     Делегирование происходит не сразу. Серверы интернет-провайдеров обновляют записи до 24 часов. Проверить делегирование домена можно с помощью [сервиса Whois](https://www.reg.ru/whois/check_site) или утилиты `dig`:

     ```bash
     dig +short NS example.com
     ```

     Результат:

     ```text
     ns2.{{ dns-ns-host-sld }}.
     ns1.{{ dns-ns-host-sld }}.
     ```

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте публичную зону DNS:

     ```bash
     yc dns zone create \
       --name example-zone \
       --zone example.com. \
       --public-visibility
     ```

     Где `--zone` — имя вашего домена, например `example.com.`. Значение параметра `--zone` должно заканчиваться точкой.

     Результат:

     ```text
     id: dns39gihj0ef********
     folder_id: b1g681qpemb4********
     created_at: "2024-09-09T15:23:34.919887Z"
     name: example-zone
     zone: example.com.
     public_visibility: {}
     ```

     Подробнее о команде `yc dns zone create` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/zone/create.md).

  1. Делегируйте домен на серверы {{ yandex-cloud }}. Для этого в личном кабинете вашего регистратора доменных имен укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

     Делегирование происходит не сразу. Серверы интернет-провайдеров обновляют записи до 24 часов.

- API {#api}

  Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md).

  Делегируйте домен на серверы {{ yandex-cloud }}. Для этого в личном кабинете вашего регистратора доменных имен укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

{% endlist %}

## Создайте секрет {{ lockbox-name }} {#create-secret}

В секретах [{{ lockbox-name }}](../../lockbox/) будут храниться пароль базы данных {{ mmy-full-name }} и пароль администратора WordPress.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать секрет, в котором будет храниться пароль базы данных {{ mmy-full-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [секрет](../../lockbox/concepts/secret.md) {{ lockbox-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета: `db-password-secret`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** выберите `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `db_password`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** вставьте пароль базы данных {{ mmy-full-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Аналогичным образом создайте секрет `wp-admin-password-secret`, в котором будет храниться пароль администратора WordPress. В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** укажите `wp_admin_password`.

- {{ yandex-cloud }} CLI {#cli}

  Чтобы создать секрет, в котором будет храниться пароль базы данных {{ mmy-full-name }}, выполните команду:

  ```bash
  yc lockbox secret create \
    --name db-password-secret \
    --payload "[{'key': 'db_password', 'text_value': '<пароль>'}]"
  ```

  Где `text_value` — пароль базы данных {{ mmy-full-name }}.

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

  Аналогичным образом создайте секрет, в котором будет храниться пароль администратора WordPress. В параметре `key` укажите `wp_admin_password`.

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

  В параметре `key` для ключа, в котором будет храниться пароль базы данных {{ mmy-full-name }}, укажите `db_password`. Для ключа, в котором будет храниться пароль администратора WordPress, — `wp_admin_password`.

{% endlist %}

{% note info %}

Вы можете не создавать секрет с паролем администратора WordPress и не указывать его в настройках приложения, тогда он создастся автоматически со случайным паролем во время установки приложения.

{% endnote %}

## Установите WordPress {#install-wordpress}

Установите [WordPress High Availability](/marketplace/products/yc/wordpress-ha-app) с помощью {{ cloud-apps-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите установить приложение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. В открывшемся окне выберите приложение **WordPress High Availability**.
  1. Задайте настройки приложения:


     * Имя приложения — название вашего экземпляра WordPress High Availability.
     * (Опционально) Описание приложения.
     * Сервисный аккаунт с ролью `admin` на каталог или выберите `Автоматически`, чтобы нужный сервисный аккаунт создался при установке приложения.
     * Идентификатор DNS-зоны.
     * (Опционально) Поддомен сайта для WordPress. По умолчанию поддомен пустой. Домен сайта формируется добавлением поддомена к домену DNS-зоны.
     * (Опционально) Отправителя. По умолчанию — `noreply@домен_сайта`. Используется для настройки SMTP через {{ postbox-name }}.
     * (Опционально) Логин администратора WordPress — имя пользователя для учетной записи администратора WordPress. По умолчанию — `admin`.

       {% note warning %}

       Логин администратора WordPress нельзя изменить после установки приложения.

       {% endnote %}

     * Электронную почту администратора WordPress — адрес электронной почты, который будет использоваться для создания учетной записи администратора WordPress, отправки системных уведомлений и восстановления пароля.
     * (Опционально) Идентификатор секрета `wp-admin-password-secret` с паролем администратора WordPress, созданный ранее. Если вы не укажете секрет, он создастся со случайным паролем автоматически во время установки приложения.
     * Подсети VPC в зонах доступности `ru-central1-a` и `ru-central1-d` для развертывания кластера {{ mmy-name }} и виртуальных машин с файловой системой.
     * (Опционально) Размер группы ВМ — количество виртуальных машин в группе. По умолчанию — 2.
     * (Опционально) Количество ядер vCPU. По умолчанию — 2.
     * (Опционально) Объем RAM в ГБ. По умолчанию — 2 ГБ.
     * (Опционально) Гарантированную доля vCPU. Доступные значения — 20%, 50% или 100%. По умолчанию — 100%.
     * (Опционально) Публичный SSH-ключ. Он добавится в `authorized_keys` пользователя WordPress. Как создать SHH-ключ, см. в [документации](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * (Опционально) Размер файловой системы в ГБ. По умолчанию — 100 ГБ.
     * Идентификатор секрета `db-password-secret` с паролем БД для подключения к кластеру {{ mmy-name }}, созданный ранее.
     * (Опционально) Размер диска кластера {{ mmy-name }} в ГБ. По умолчанию — 20 ГБ.

  1. Нажмите кнопку **{{ ui-key.yacloud.cloud-apps.button_install }}**.

     В открывшемся окне отобразятся ресурсы, которые будут созданы во время установки приложения. После создания всех ресурсов на виртуальной машине будет происходить настройка сайта, установка плагинов и выпуск TLS-сертификатов. Дождитесь завершения установки, она займет 5–10 минут.

{% endlist %}

{% note info %}

При установке приложения автоматически создаются [адрес](../../postbox/concepts/glossary.md#adress) {{ postbox-name }} и DNS-запись для его верификации.

{% endnote %}

## Настройте WordPress {#configure-wordpress}

1. Откройте в браузере адрес основного сайта: `https://<домен_сайта>`, где `<домен_сайта>` — поддомен основного сайта, или домен DNS-зоны, если поддомен сайта не был указан.

1. Откройте в браузере адрес административной панели: `https://<домен_сайта>/wp-admin`.

1. Войдите в административную панель, используя:
   * **Логин** — логин администратора, который вы указали при установке.
   * **Пароль** — пароль администратора. Если вы не указывали секрет с паролем администратора в настройках приложения, значение пароля можно найти в секрете, который создался автоматически при установке приложения. Имя секрета — `wp-admin-password-secret`.

      {% note info %}

      Если вы забыли пароль, его можно восстановить через стандартную форму восстановления пароля WordPress, используя адрес электронной почты администратора, указанный при установке.

      {% endnote %}

После входа вы будете перенаправлены в административную панель WordPress, где сможете начать работу с сайтом.

## Проверьте результат {#check-result}

Убедитесь, что WordPress работает корректно:

1. Откройте в браузере поддомен основного сайта, если указали его при установке. Иначе — домен DNS-зоны. Вы должны увидеть главную страницу WordPress.

1. Создайте тестовый пост:

   1. В административной панели нажмите кнопку **Записи** → **Добавить новую**.
   1. Заполните заголовок и содержимое поста.
   1. Загрузите изображение в пост — оно автоматически сохранится в бакет {{ objstorage-name }}.
   1. Опубликуйте пост.

1. Проверьте, что пост доступен на главной странице сайта.

1. Проверьте работу почтовых уведомлений:

   1. В административной панели перейдите в раздел настроек.
   1. Попробуйте восстановить пароль, используя функцию **«Забыли пароль?»**.
   1. Проверьте, что письмо с инструкциями по восстановлению пароля пришло на указанный адрес электронной почты.

   {% note info %}

   Интеграция с {{ postbox-name }} поддерживает регистрацию пользователей и восстановление пароля. Массовые рассылки через {{ postbox-name }} не поддерживаются, так как для них требуется специальный API.

   {% endnote %}

1. Проверьте установленные плагины:

   1. В административной панели перейдите в раздел **Плагины**.
   1. Убедитесь, что установлены следующие плагины:
      * **S3 Uploads** — для интеграции с сервисом **{{objstorage-full-name}}** для хранения медиафайлов.
      * **WP Mail SMTP** — для интеграции с сервисом **{{postbox-full-name}}** для отправки почтовых уведомлений.

1. Откройте в браузере домен административной панели БД:

   1. Войдите в административную панель базы данных.
   1. Для входа используйте:
      * **Сервер** — `db`.
      * **Движок** — `MySQL`.
      * **Имя пользователя** — `wordpress`.
      * **Пароль** — пароль базы данных, который вы указали в секрете `db-passwords-secret`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу и перестать платить за созданные ресурсы:

1. Удалите адрес {{ postbox-name }} и связанную с ним [DNS-запись](../../dns/operations/resource-record-delete.md) — они не удалятся автоматически при удалении приложения.
1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты из бакетов {{ objstorage-name }}, созданных при установке приложения, так как удалять можно только пустые бакеты.
1. Удалите установленное приложение WordPress High Availability:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором установлено приложение.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Найдите установленное приложение WordPress High Availability в списке.
   1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) рядом с приложением и выберите **{{ ui-key.yacloud.common.delete }}**.
   1. Подтвердите удаление приложения.
1. [Удалите](../../dns/operations/zone-delete.md) публичную DNS-зону.
1. [Удалите](../../lockbox/operations/secret-delete.md) секреты {{ lockbox-name }}.
1. Удалите [подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md) {{ vpc-short-name }}.
