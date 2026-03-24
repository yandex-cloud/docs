# Установка Ghost CMS High Availability с помощью {{ cloud-apps-name }}


В этом руководстве вы установите и настроите [Ghost CMS High Availability](https://ghost.org/) — платформу для публикации контента и ведения блогов. Приложение будет развернуто с помощью [{{ cloud-apps-full-name }}](../../cloud-apps/) на виртуальной машине с автоматической настройкой всех необходимых ресурсов, включая базу данных, веб-сервер и интеграцию с почтовым сервисом.

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

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


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

{% include [create-network](../_tutorials_includes/website/create-network.md) %}


## Настройте DNS-зону {#configure-dns}

Создайте [публичную DNS-зону](../../dns/concepts/dns-zone.md#public-zones) и делегируйте на нее домен. Подробнее о делегировании домена читайте в [инструкции](../../troubleshooting/dns/how-to/delegate-public-zone.md).

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}


## Создайте секрет {{ lockbox-name }} {#create-secret}

Создайте секрет [{{ lockbox-name }}](../../lockbox/) для хранения пароля базы данных [{{ mmy-name }}](../../managed-mysql/).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета: `db-password-secret`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** выберите `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `db_password`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** укажите пароль, который будет использоваться для базы данных {{ mmy-name }}. Требования к паролю:

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

Установите [Ghost CMS High Availability](/marketplace/products/yc/ghost-cms-ha) с помощью {{ cloud-apps-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. Нажмите **{{ ui-key.yacloud.cloud-apps.button_empty-install-application }}**.
  1. В открывшемся окне выберите приложение **Ghost CMS High Availability**.
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

    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
    1. Найдите установленное приложение Ghost CMS High Availability в списке.
    1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) рядом с приложением и выберите **{{ ui-key.yacloud.common.delete }}**.
    1. Подтвердите удаление приложения.

        Дождитесь завершения удаления.

1. [Удалите](../../dns/operations/zone-delete.md) публичную DNS-зону.
1. [Удалите](../../lockbox/operations/secret-delete.md) секрет {{ lockbox-name }}.
1. Удалите [подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md) {{ vpc-short-name }}.
1. Удалите адрес {{ postbox-name }} и связанную с ним [DNS-запись](../../dns/operations/resource-record-delete.md) — они не удалятся автоматически при удалении приложения.