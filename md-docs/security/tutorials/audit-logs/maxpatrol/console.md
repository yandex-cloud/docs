[Документация Yandex Cloud](../../../../index.md) > [Безопасность в Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > Сбор, мониторинг и анализ аудитных логов > [Загрузка аудитных логов в MaxPatrol SIEM](index.md) > Консоль управления

# Загрузка аудитных логов в MaxPatrol SIEM с помощью консоли управления или Yandex Cloud CLI


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) позволяет читать [аудитные логи](../../../../audit-trails/concepts/events.md) Yandex Cloud из потока данных [Yandex Data Streams](../../../../data-streams/index.md). Для полного прохождения руководства у вас должен быть доступ к экземпляру MaxPatrol SIEM.

Чтобы настроить экспорт аудитных логов с помощью консоли управления или Yandex Cloud CLI:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#environment-preparing).
1. [Создайте трейл, который отправляет логи в поток данных Data Streams](#create-trail).
1. [Настройте в MaxPatrol SIEM задачу по сбору данных из потока Data Streams](#configure-maxpatrol).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../../billing/quickstart/index.md) и [привяжите](../../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:
* использование потока данных ([тарифы Data Streams](../../../../data-streams/pricing.md)).
* использование Yandex Managed Service for YDB в бессерверном режиме ([тарифы Managed Service for YDB](../../../../ydb/pricing/serverless.md)).

## Подготовьте окружение {#environment-preparing}

### Создайте сервисные аккаунты {#create-sa}

От имени [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md) `maxpatrol-sa` [трейл](../../../../audit-trails/concepts/trail.md) будет собирать логи всех ресурсов организации и выгружать их в [поток данных](../../../../data-streams/concepts/glossary.md#stream-concepts) Data Streams. От имени сервисного аккаунта `maxpatrol-reader-sa` MaxPatrol SIEM будет загружать аудитные логи из потока данных.

Создайте сервисные аккаунты в том же каталоге, в котором будете создавать трейл, например, в каталоге `example-folder`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. В поле **Имя** укажите `maxpatrol-sa`.
  1. В поле **Роли в каталоге** нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` на каталог.
  1. Нажмите кнопку **Создать**.

  Аналогичным образом создайте сервисный аккаунт `maxpatrol-reader-sa` и назначьте ему [роль](../../../../data-streams/security/index.md#yds-viewer) `yds.viewer` на каталог.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт `maxpatrol-sa`:

      ```bash
      yc iam service-account create \
        --name maxpatrol-sa
      ```

      Результат:

      ```text
      done (2s)
      id: ajecq2artiv5********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-03-18T18:29:53Z"
      name: maxpatrol-sa
      ```

  1. Аналогичным образом создайте сервисный аккаунт `maxpatrol-reader-sa`.

  Подробнее о команде `yc iam service-account create` смотрите в [справочнике CLI](../../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

{% endlist %}

### Назначьте роли сервисным аккаунтам {#sa-assign-roles}

Назначьте сервисным аккаунтам недостающие роли:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#console}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../../../_assets/console-icons/persons-lock.svg) **Права доступа**.
  1. В правом верхнем углу страницы нажмите кнопку **Назначить роли**. В открывшемся окне выберите сервисный аккаунт `maxpatrol-sa`. При необходимости воспользуйтесь строкой поиска.
  1. Нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../../../audit-trails/security/index.md#at-viewer) `audit-trails.viewer`.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  1. Назначьте сервисному аккаунту `maxpatrol-sa` [роль](../../../../data-streams/security/index.md#yds-writer) `yds.writer` на каталог `example-folder`:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --role yds.writer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — назначаемая роль.
      * `--subject` — идентификатор сервисного аккаунта `maxpatrol-sa`.

  1. Аналогичным образом назначьте [роль](../../../../data-streams/security/index.md#yds-viewer) `yds.viewer` на каталог `example-folder` сервисному аккаунту `maxpatrol-reader-sa`.

      Подробнее о команде `yc resource-manager folder add-access-binding` смотрите в [справочнике CLI](../../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  1. Назначьте сервисному аккаунту `maxpatrol-sa` [роль](../../../../audit-trails/security/index.md#at-viewer) `audit-trails.viewer` на организацию:

      ```bash
      yc organization-manager organization add-access-binding \
        --role audit-trails.viewer \
        --id <идентификатор_организации> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — назначаемая роль.
      * `--id` — [идентификатор](../../../../organization/operations/organization-get-id.md) организации, в которой находится сервисный аккаунт.
      * `--service-account-id` — идентификатор сервисного аккаунта `maxpatrol-sa`.

      Подробнее о команде `yc organization-manager organization add-access-binding` смотрите в [справочнике CLI](../../../../cli/cli-ref/organization-manager/cli-ref/organization/add-access-binding.md).

{% endlist %}

### Создайте статический ключ доступа для MaxPatrol SIEM {#create-static-keys}

MaxPatrol SIEM использует [статические ключи доступа](../../../../iam/concepts/authorization/access-key.md) для авторизации запросов к потоку данных Data Streams.

Создайте статический ключ доступа для сервисного аккаунта `maxpatrol-reader-sa`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и в открывшемся списке выберите сервисный аккаунт `maxpatrol-reader-sa`.
  1. На панели сверху нажмите ![plus](../../../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите **Создать**.

  {% note alert %}

  Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

  {% endnote %}

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam access-key create \
    --service-account-name maxpatrol-reader-sa
  ```

  Результат:

  ```text
  access_key:
  id: aje38c5mjq11********
  service_account_id: ajegtlf2q28a********
  created_at: "2026-03-18T17:39:41.851532824Z"
  key_id: YCAJEnmnfsV8GpAMk********
  secret: YCMVxx-n0t8Y6s48zJDdKw9lWMB1iGU-********
  ```

  {% note alert %}

  Сохраните идентификатор `key_id` и секретный ключ `secret`. Повторно получить секретный ключ нельзя.

  {% endnote %}

  Подробнее о команде `yc iam access-key create` смотрите в [справочнике CLI](../../../../cli/cli-ref/iam/cli-ref/access-key/create.md).

{% endlist %}


### Создайте бессерверную БД YDB {#serverless}

База данных необходима для потока данных `Data Streams`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Нажмите **Создать ресурс** и выберите **База данных YDB**.
  1. Укажите **Имя** — `maxpatrol-db`.
  1. В блоке **Тип базы данных** выберите `Serverless`.
  1. Для остальных параметров оставьте значения по умолчанию.
  1. Нажмите **Создать базу данных**.

  Дождитесь, когда статус базы данных изменится на `Running`.

- CLI {#cli}

  1. Создайте базу данных:

      ```bash
      yc ydb database create \
        --name maxpatrol-db \
        --serverless \
        --folder-name example-folder
      ```

      Где:
      * `--name` — имя базы данных.
      * `--serverless` — тип базы данных `serverless`.
      * `--folder-name` — имя каталога.

      Результат:

      ```text
      done (36s)
      id: etnubo9ude8e********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-03-18T18:34:31Z"
      name: maxpatrol-db
      status: PROVISIONING
      ...
      ```

      Подробнее о команде `yc ydb database create` смотрите в [справочнике CLI](../../../../cli/cli-ref/ydb/cli-ref/database/create.md).

  1. Проверьте статус созданной БД:

      ```bash
      yc ydb database get maxpatrol-db
      ```

      Дождитесь, когда статус базы данных изменится на `RUNNING`.

{% endlist %}


### Создайте поток данных {#create-stream}

В этот поток данных трейл будет загружать логи ресурсов организации.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Нажмите **Создать ресурс** и выберите **Поток данных**.
  1. В поле **База данных** выберите `maxpatrol-db`.
  1. Укажите **Имя** `maxpatrol-stream`.
  1. Для остальных параметров оставьте значения по умолчанию.
  1. Нажмите кнопку **Создать**.

  Дождитесь, когда статус потока данных сменится на `Running`.

{% endlist %}


## Создайте трейл {#create-trail}

Трейл будет собирать аудитные логи уровня конфигурации всех ресурсов вашей организации и загружать их в поток данных `maxpatrol-stream`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Нажмите кнопку **Создать ресурс** и выберите пункт **Трейл**.
  1. Укажите **Имя** создаваемого трейла `maxpatrol-trail`.
  1. В блоке **Назначение** задайте параметры объекта назначения:
      * **Назначение** — `Data Streams`.
      * **Поток данных** — выберите поток данных `maxpatrol-stream`.
  1. В блоке **Сервисный аккаунт** выберите сервисный аккаунт `maxpatrol-sa`.
  1. В блоке **Сбор событий c уровня конфигурации** задайте параметры сбора аудитных логов уровня конфигурации:
      * **Сбор событий** — выберите `Включено`.
      * **Ресурс** — выберите `Организация`.
      * **Организация** — не требует заполнения (содержит имя организации, в которой будет находиться трейл).
      * **Облако** — оставьте значение по умолчанию `Все`.
  1. В блоке **Сбор событий с уровня сервисов** в поле **Сбор событий** выберите `Выключено`.
  1. Нажмите **Создать**.

- CLI {#cli}

  Создайте трейл `maxpatrol-trail`:

  ```bash
  yc audit-trails trail create \
    --name maxpatrol-trail \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --destination-yds-stream maxpatrol-stream \
    --destination-yds-database-id <идентификатор_базы_данных_YDS> \
    --filter-all-organisation-id <идентификатор_организации>
  ```

  Где:
  * `--name` — имя создаваемого трейла.
  * `--service-account-id` — идентификатор сервисного аккаунта `maxpatrol-sa`.
  * `--destination-yds-stream` — имя потока данных.
  * `--destination-yds-database-id` — идентификатор базы данных `maxpatrol-db`.
  * `--filter-all-organisation-id` — [идентификатор](../../../../organization/operations/organization-get-id.md) организации, в которой создается трейл и где будут собираться аудитные события.

  Результат:

  ```text
  done (1s)
  id: cnpvbmk64136********
  folder_id: b1g5bhjofg7o********
  created_at: "2026-03-18T10:57:33.322Z"
  updated_at: "2026-03-18T10:57:33.322Z"
  name: maxpatrol-trail
  destination:
    data_stream:
      database_id: etn5bfdglcn8********
      stream_name: maxpatrol-stream
      codec: RAW
  service_account_id: aje1jot7q7eh********
  status: ACTIVE
  cloud_id: b1gj9ja2h4ct********
  filtering_policy:
    management_events_filter:
      resource_scopes:
        - id: bpfaidqca8vd********
          type: organization-manager.organization
  ```

  Подробнее о команде `yc audit-trails trail create` смотрите в [справочнике CLI](../../../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

{% endlist %}

Подробнее о создании трейла смотрите в разделе [Создание трейла для загрузки аудитных логов](../../../../audit-trails/operations/create-trail.md).

## Настройте MaxPatrol SIEM {#configure-maxpatrol}

### Создайте учетные записи {#static-key-account}

Учетные записи можно использовать как хранилища секретов. Создайте учетные записи `static-key-id` и `static-key-private`, чтобы сохранить в них полученные ранее идентификатор и секретный ключ статического ключа доступа, созданного для сервисного аккаунта `maxpatrol-reader-sa`:

1. Войдите в веб-интерфейс MaxPatrol SIEM.
1. В разделе **Сбор данных** нажмите **Учетные записи**.
1. Нажмите **Добавить учетную запись** → **Пароль** и укажите параметры:
    * **Название** — `static-key-id`;
    * **Пароль** — идентификатор статического ключа;
    * **Подтверждение пароля** — повторите идентификатор статического ключа.
1. Нажмите **Сохранить**.

Аналогично создайте учетную запись `static-key-private`, содержащую секретный ключ.


### Создайте задачу на сбор данных {#create-task}

Создайте и запустите задачу на сбор данных с профилем Yandex Data Streams:
1. Войдите в веб-интерфейс MaxPatrol SIEM.
1. В разделе **Сбор данных** нажмите **Задачи**.
1. На странице **Задачи по сбору данных**:
    1. На панели инструментов нажмите **Создать задачу**.
    1. Нажмите **Сбор данных**.
1. На странице **Создание задачи на сбор данных** укажите параметры:
    1. **Название** — `YDS-logs-task`.
    1. **Профиль** — `Yandex Data Streams`.
    1. В иерархическом списке выберите **Запуск сценария**.
    1. В блоке **Подключение** укажите:
        * **Учетная запись** — `static-key-id`;
        * **Учетная запись для повышения привилегий** — `static-key-private`.
    1. **Параметры запуска сценария**:
        * **database** — `<идентификатор_БД_maxpatrol-db>`;
        * **folder** — `<идентификатор_облака_для_каталога_example-folder>`;
        * **region_name** — `ru-central1`;
        * **stream_name** — `maxpatrol-stream`.
    1. На панели **Цели сбора данных**:
        1. Выберите вкладку **Включить**.
        1. В поле **Сетевые адреса** укажите `yandex-cloud`.
    1. Нажмите **Сохранить и запустить**.

Чтобы просмотреть логи, перейдите на страницу просмотра событий:
1. Перейдите на страницу **Задачи по сбору данных**.
1. Нажмите на задачу `YDS-logs-task`.
1. Нажмите **Собранные события** → **Перейти**.

## Как удалить созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [удалите](../../../../data-streams/operations/manage-streams.md#delete-data-stream) поток данных `maxpatrol-stream`;
* [удалите](../../../../ydb/operations/manage-databases.md#delete-db) базу данных `maxpatrol-db`.

#### Полезные ссылки {#see-also}

* [Загрузка аудитных логов в MaxPatrol SIEM с помощью Terraform](terraform.md)