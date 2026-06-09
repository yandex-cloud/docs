# Установка Ghost CMS High Availability с помощью {{ cloud-apps-name }}


В этом руководстве вы установите и настроите [Ghost CMS High Availability](https://ghost.org/) — платформу для публикации контента и ведения блогов. Приложение будет развернуто с помощью [{{ cloud-apps-full-name }}](../index.md) на виртуальной машине с автоматической настройкой всех необходимых ресурсов, включая базу данных, веб-сервер и интеграцию с почтовым сервисом.

Чтобы установить Ghost CMS High Availability:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сеть и подсети {{ vpc-short-name }}](#create-network).
1. [Настройте DNS-зону](#configure-dns).
1. [Создайте секрет {{ lockbox-name }}](#create-secret).
1. [Установите Ghost CMS High Availability](#install-ghost).
1. [Настройте Ghost CMS High Availability](#configure-ghost).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* Плата за использование [виртуальной машины](../../compute/concepts/vm.md) и хранение данных на [диске](../../compute/concepts/disk.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) и исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за использование публичной [DNS-зоны](../../dns/concepts/dns-zone.md) и за публичные DNS-запросы (см. [тарифы {{ dns-full-name }}](../../dns/pricing.md)).
* Плата за выделенные [хостам](../../managed-mysql/concepts/index.md) {{ MY }} вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mmy-full-name }}](../../managed-mysql/pricing.md)).
* Плата за использование [бакета](../../storage/concepts/bucket.md) для хранения медиафайлов (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).
* Плата за хранение [секретов](../../lockbox/concepts/secret.md) и операции с ними (см. тарифы [{{ lockbox-full-name }}](../../lockbox/pricing.md)).
* Плата за исходящие письма (см. тарифы [{{ postbox-full-name }}](../../postbox/pricing.md)).


## Создайте сеть и подсети {{ vpc-short-name }} {#create-network}

Создайте [облачную сеть](../../vpc/concepts/network.md) и [подсети](../../vpc/concepts/network.md#subnet), в которых будут развернуты ресурсы.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будете разворачивать инфраструктуру.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети. Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
  1. Оставьте включенной опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Аналогичным образом создайте подсеть в зоне доступности `{{ region-id }}-d`.

- API {#api}

  Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) и передайте в запросе идентификатор каталога, в котором будет размещена сеть, в параметре `folderId`.

  О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

  Чтобы создать подсети в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-d`, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором будет размещена подсеть, в параметре `folderId`.
  * Идентификатор сети, в которой будет размещена подсеть, в параметре `networkId`.
  * Идентификатор зоны доступности, в которой будет размещена подсеть, в параметре `zoneId`.
  * Список внутренних IPv4-адресов, определенных для данной подсети, в массиве `v4CidrBlocks[]`. Например, `10.0.0.0/22` или `192.168.0.0/16`. Адреса должны быть уникальными внутри сети. Минимальный размер подсети — `/28`, а максимальный размер подсети — `/16`. Поддерживается только IPv4.

  Чтобы узнать идентификатор подсети, воспользуйтесь методом REST API [list](../../vpc/api-ref/Subnet/list.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/List](../../vpc/api-ref/grpc/Subnet/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

{% endlist %}


## Настройте DNS-зону {#configure-dns}

Создайте [публичную DNS-зону](../../dns/concepts/dns-zone.md#public-zones) и делегируйте на нее домен. Подробнее о делегировании домена читайте в [инструкции](../../troubleshooting/dns/how-to/delegate-public-zone.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
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

     Делегирование происходит не сразу. Серверы интернет-провайдеров обновляют записи в течение 24 часов.

- API {#api}

  Чтобы создать публичную зону DNS, воспользуйтесь методом REST API [create](../../dns/api-ref/DnsZone/create.md) для ресурса [DnsZone](../../dns/api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md).

  Делегируйте домен на серверы {{ yandex-cloud }}. Для этого в личном кабинете вашего регистратора доменных имен укажите адреса DNS-серверов `ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`.

{% endlist %}


## Создайте секрет {{ lockbox-name }} {#create-secret}

Создайте секрет [{{ lockbox-name }}](../../lockbox/index.md) для хранения пароля базы данных [{{ mmy-name }}](../../managed-mysql/index.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета: `db-password-secret`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}** выберите `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** введите `db_password`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** укажите пароль, который будет использоваться для базы данных {{ mmy-name }}. Требования к паролю:

      * Длина от 8 до 128 символов.
      * Может содержать цифры, латинские буквы в верхнем и нижнем регистре, специальные символы.
      * Не должен состоять только из цифр.

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc lockbox secret create \
    --name db-password-secret \
    --payload "[{'key': 'db_password', 'text_value': '<пароль>'}]"
  ```

  Где `text_value` — пароль базы данных {{ mmy-name }}. Требования к паролю:

  * Длина от 8 до 128 символов.
  * Может содержать цифры, латинские буквы в верхнем и нижнем регистре, специальные символы.
  * Не должен состоять только из цифр.

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

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

  В параметре `key` для ключа, в котором будет храниться пароль базы данных {{ mmy-name }}, укажите `db_password`. Требования к паролю:

  * Длина от 8 до 128 символов.
  * Может содержать цифры, латинские буквы в верхнем и нижнем регистре, специальные символы.
  * Не должен состоять только из цифр.

{% endlist %}


## Установите Ghost CMS High Availability {#install-ghost}

Установите [Ghost CMS High Availability](https://yandex.cloud/ru/marketplace/products/yc/ghost-cms-ha) с помощью {{ cloud-apps-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Нажмите **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. Выберите приложение **Ghost CMS High Availability** и нажмите **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Задайте параметры приложения:

      #|
      || **Параметр** | **Обязательный** | **Значение по умолчанию** | **Описание** ||
      || **{{ ui-key.yacloud.common.name }}** | Да | — | Название экземпляра приложения. ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Описание экземпляра приложения. ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Да | — | Сервисный аккаунт, от имени которого будет происходить установка приложения. Сервисный аккаунт должен иметь роль `admin` на каталог.
      Чтобы сервисный аккаунт с необходимыми правами создался во время установки приложения, выберите `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **Идентификатор DNS-зоны** | Да | — | Идентификатор DNS-зоны, в которой будет находиться домен приложения. ||
      || **Поддомен сайта** | — | Пустой | Домен, на котором будет доступен основной сайт. Формируется добавлением поддомена к домену DNS-зоны: `site.example.com` или `example.com`, если поддомен не указан. ||
      || **Поддомен панели администратора** | — | `admin` | Домен, на котором будет доступна панель администратора. Формируется добавлением поддомена к домену DNS-зоны: `admin.example.com/ghost`. ||
      || **Отправитель** | — | `noreply@<домен_сайта>` | Отправитель почты. Используется для настройки [SMTP](https://{{ lang }}.wikipedia.org/wiki/SMTP) через {{ postbox-name }}. ||
      || **Подсеть в {{ region-id }}-a** | Да | — | Подсеть в зоне доступности {{ region-id }}-a для кластера {{ mmy-name }}, созданная ранее.
||
      || **Подсеть в {{ region-id }}-d** | Да | — | Подсеть в зоне доступности {{ region-id }}-d для кластера {{ mmy-name }}, созданная ранее. ||
      || **Подсеть VPC для ВМ** | — | Подсеть в зоне доступности `{{ region-id }}-d` | Подсеть, в которой будет развернута ВМ. ||
      || **Количество vCPU** | — | `2` | Количество ядер vCPU. ||
      || **Объём RAM** | — | `2` | Объем RAM в ГБ. ||
      || **Гарантированная доля vCPU** | — | `100` | Гарантированная доля vCPU в процентах. Доступные значения — 20%, 50% или 100%. ||
      || **Публичный SSH-ключ** | — | — | Ключ добавится в `authorized_keys` пользователя ВМ `ghost`.
      Рекомендуется указать публичный SSH-ключ, чтобы иметь доступ к ВМ по SSH. Пару ключей для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать самостоятельно, см. [раздел о подключении к ВМ по SSH](../../compute/operations/vm-connect/ssh.md). ||
      || **Тип диска** | — | `network-ssd` | Тип диска ВМ. ||
      || **Размер диска** | — | `20` | Размер диска ВМ в ГБ. ||
      || **Идентификатор секрета с паролем БД** | Да | — | Секрет с паролем для подключения к кластеру {{ mmy-name }}. Пароль должен быть указан в ключе `db_password`. ||
      || **Размер диска кластера {{ mmy-name }}** | — | `20` | Размер диска кластера {{ mmy-name }} в ГБ. ||
      |#

  1. Нажмите **{{ ui-key.yacloud.cloud-apps.button_install }}**.

      Установка приложения и создание необходимых ресурсов займут 5–10 минут.

      После создания всех ресурсов на ВМ будет происходить настройка сайта и выпуск TLS-сертификатов. Дождитесь завершения установки.

{% endlist %}


## Настройте Ghost CMS High Availability {#configure-ghost}

После успешной установки приложения настройте Ghost CMS High Availability:

1. Откройте в браузере адрес панели администратора:

    ```text
    https://<поддомен_панели_администратора>.<домен>/ghost
    ```

    Где:

    * `<поддомен_панели_администратора>` — поддомен панели администратора, который вы указали при создании приложения. По умолчанию — `admin`.
    * `<домен>` — домен, который вы указали при создании DNS-зоны.

    Например: `https://admin.example.com/ghost`.

1. Заполните форму регистрации администратора:

    * **Site title** — укажите название сайта.
    * **Full name** — укажите имя, от которого будут публиковаться посты.
    * **Email address** — укажите адрес электронной почты для входа в панель администратора. На указанный адрес придет уведомление.
    * **Password** — создайте надежный пароль для входа в панель администратора.

1. Нажмите **Create account & start publishing**.

    После регистрации вы будете перенаправлены в панель администратора Ghost CMS High Availability, где сможете начать работу с сайтом.


## Проверьте результат {#check-result}

Убедитесь, что Ghost CMS High Availability работает корректно:

1. Создайте тестовый пост:

    1. В интерфейсе панели администратора возле вкладки **Posts** нажмите ![image](../../_assets/console-icons/plus.svg).
    1. Заполните заголовок и содержимое поста.
    1. Загрузите изображение в пост — оно автоматически сохранится в S3-бакете.
    1. Справа вверху нажмите **Publish** → **Continue, final review** → **Publish post, right now**.
    1. В открывшемся окне скопируйте ссылку на пост — нажмите **Copy link**.


1. Откройте скопированную ссылку в браузере.

    В результате откроется пост с URL вида `https://example.com/new-post/`.


## Как удалить созданные ресурсы {#clear-out}

{% note warning %}

Не удаляйте вручную ресурсы, созданные автоматически. Это может привести к ошибке удаления приложения.

{% endnote %}

Чтобы остановить работу и перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты из бакета {{ objstorage-name }}, созданного при установке приложения.
1. Удалите установленное приложение Ghost CMS High Availability:

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
    1. Найдите установленное приложение Ghost CMS High Availability в списке.
    1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) рядом с приложением и выберите **{{ ui-key.yacloud.common.delete }}**.
    1. Подтвердите удаление приложения.

        Дождитесь завершения удаления.

1. [Удалите](../../dns/operations/zone-delete.md) публичную DNS-зону.
1. [Удалите](../../lockbox/operations/secret-delete.md) секрет {{ lockbox-name }}.
1. Удалите [подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md) {{ vpc-short-name }}.
1. Удалите адрес {{ postbox-name }} и связанную с ним [DNS-запись](../../dns/operations/resource-record-delete.md) — они не удалятся автоматически при удалении приложения.