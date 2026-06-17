

С помощью этого руководства вы установите и настроите [WordPress](https://wordpress.org/) — систему управления контентом, подходящую как для личных блогов, так и для крупных медиа и коммерческих проектов. Приложение [{{ cloud-apps-name }}](../../cloud-apps/) будет развернуто на виртуальной машине с автоматической настройкой всех необходимых ресурсов, включая базу данных [{{ mmy-full-name }}](../../managed-mysql/), веб-сервер и интеграцию с сервисом [{{ postbox-name }}](../../postbox/).

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
* Плата за выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий ([тарифы {{ mmy-full-name }}](../../managed-mysql/pricing.md)).
* Плата за использование бакета для хранения медиафайлов ([тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).
* Плата за хранение секретов и операции с ними (тарифы [{{ lockbox-full-name }}](../../lockbox/pricing.md)).
* Плата за исходящие письма (тарифы [{{ postbox-full-name }}](../../postbox/pricing.md)).


## Создайте сеть и подсети {{ vpc-short-name }} {#create-network}

{% include [create-network](../_tutorials_includes/website/create-network.md) %}


## Настройте DNS-зону {#configure-dns}

{% include [wordpress-configure-dns](../_tutorials_includes/wordpress/configure-dns.md) %}

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}


## Создайте секреты {{ lockbox-name }} {#create-secret}

В [секретах](../../lockbox/concepts/secret.md) {{ lockbox-name }} будут храниться пароль базы данных {{ mmy-full-name }} и пароль администратора WordPress.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать секрет, в котором будет храниться пароль базы данных {{ mmy-full-name }}:

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.SecretsPage.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета: `db-password-secret`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}** выберите `{{ ui-key.yacloud.lockbox.FormFields.title_secret-type-custom }}`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** введите `db_password`.
  1. В поле **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}** вставьте пароль базы данных {{ mmy-full-name }}.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Аналогичным образом создайте секрет `wp-admin-password-secret`, в котором будет храниться пароль администратора WordPress. В поле **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}** укажите `wp_admin_password`.

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

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Нажмите **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. Выберите приложение **WordPress High Availability** и нажмите **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Задайте настройки приложения:

      {% note warning %}

      Логин администратора WordPress нельзя изменить после установки приложения.

      {% endnote %}

      #|
      || **Параметр** | **Обязательный** | **Значение по умолчанию** | **Описание** ||
      || **{{ ui-key.yacloud.common.name }}** | Да | — | Название вашего экземпляра WordPress High Availability. ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Описание экземпляра приложения. ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Да | — | Сервисный аккаунт с ролью `admin` на каталог. Чтобы сервисный аккаунт с необходимыми правами создался во время установки приложения, выберите `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **Идентификатор DNS-зоны** | Да | — | Идентификатор DNS-зоны, в которой будет находиться домен приложения. ||
      || **Поддомен сайта** | — | Пустой | Домен, на котором будет доступен основной сайт. Формируется добавлением поддомена к домену DNS-зоны: `site.example.com` или `example.com`, если поддомен не указан. ||
      || **Отправитель** | — | `noreply@<домен_сайта>` | Отправитель почты. Используется для настройки SMTP через {{ postbox-name }}. ||
      || **Логин администратора WordPress** | — | `admin` | Имя пользователя для учетной записи администратора WordPress. ||
      || **Электронная почта администратора WordPress** | Да | — | Адрес электронной почты, который будет использоваться для создания учетной записи администратора WordPress, отправки системных уведомлений и восстановления пароля. ||
      || **Идентификатор секрета с паролем администратора WordPress** | — | — | Идентификатор секрета `wp-admin-password-secret` с паролем администратора WordPress, созданный ранее. Если вы не укажете секрет, он создастся со случайным паролем автоматически во время установки приложения. ||
      || **Подсеть в {{ region-id }}-a** | Да | — | Подсеть в зоне доступности {{ region-id }}-a для развертывания кластера {{ mmy-name }} и виртуальных машин с файловой системой. ||
      || **Подсеть в {{ region-id }}-d** | Да | — | Подсеть в зоне доступности {{ region-id }}-d для развертывания кластера {{ mmy-name }} и виртуальных машин с файловой системой. ||
      || **Размер группы ВМ** | — | `2` | Количество виртуальных машин в группе. ||
      || **Количество vCPU** | — | `2` | Количество ядер vCPU. ||
      || **Объём RAM** | — | `2` | Объем RAM в ГБ. ||
      || **Гарантированная доля vCPU** | — | `100` | Гарантированная доля vCPU в процентах. Доступные значения: 20%, 50% или 100%. ||
      || **Публичный SSH-ключ** | — | — | Ключ добавится в `authorized_keys` пользователя WordPress.
      Рекомендуется указать публичный SSH-ключ, чтобы иметь доступ к ВМ по SSH. Пару ключей для подключения по SSH необходимо создать самостоятельно, см. [документацию](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). ||
      || **Размер файловой системы** | — | `100` | Размер файловой системы в ГБ. ||
      || **Идентификатор секрета с паролем БД** | Да | — | Идентификатор секрета `db-password-secret` с паролем для подключения к кластеру {{ mmy-name }}, созданного ранее. ||
      || **Размер диска кластера {{ mmy-name }}** | — | `20` | Размер диска кластера {{ mmy-name }} в ГБ. ||
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
1. [Удалите](../../storage/operations/objects/delete-all.md) все объекты из бакетов {{ objstorage-name }}, созданных при установке приложения, так как удалять можно только пустые бакеты.
1. Удалите установленное приложение WordPress High Availability:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором установлено приложение.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Найдите установленное приложение WordPress High Availability в списке.
   1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) рядом с приложением и выберите **{{ ui-key.yacloud.common.delete }}**.
   1. Подтвердите удаление приложения.

1. [Удалите](../../dns/operations/zone-delete.md) публичную DNS-зону.
1. [Удалите](../../lockbox/operations/secret-delete.md) секреты {{ lockbox-name }}.
1. Удалите [подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md) {{ vpc-short-name }}.
