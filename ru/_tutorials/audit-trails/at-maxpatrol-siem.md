# Загрузка аудитных логов в MaxPatrol SIEM

[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) может читать [аудитные логи](../../audit-trails/concepts/events.md) {{ yandex-cloud }} из потока данных [{{ yds-full-name }}](../../data-streams/). Для полного прохождения руководства у вас должен быть доступ к экземпляру MaxPatrol SIEM.

Чтобы настроить экспорт аудитных логов:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#environment-preparing).
1. [Создайте трейл, который отправляет логи в поток данных {{ yds-name }}](#create-trail).
1. [Настройте в MaxPatrol SIEM задачу по сбору данных из потока {{ yds-name }}](#configure-maxpatrol).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* использование потока данных (см. [тарифы {{ yds-name }}](../../data-streams/pricing.md)).
* использование {{ ydb-full-name }} в бессерверном режиме (см. [тарифы {{ ydb-name }}](../../ydb/pricing/serverless.md)).


## Подготовьте окружение {#environment-preparing}


### Создайте сервисный аккаунт и назначьте ему роли {#create-sa}

От имени сервисного аккаунта трейл будет собирать логи всех ресурсов организации и загружать их в поток данных {{ yds-name }}.

Создайте сервисный аккаунт в том же каталоге, в котором создадите трейл, например, в `example-folder`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта `maxpatrol-sa`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт:

      ```bash
      yc iam service-account create --name maxpatrol-sa
      ```

      Результат:

      ```text
      id: aje*****ckg
      folder_id: b1g*****rnj
      created_at: "2022-09-18..."
      name: maxpatrol-sa
      ```

      Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/service-account/create.md).

{% endlist %}

Назначьте сервисному аккаунту `maxpatrol-sa` роли `audit-trails.viewer` и `yds.editor`:

{% list tabs %}

- CLI
  
  1. Роль `audit-trails.viewer` на организацию:

      ```bash
      yc organization-manager organization add-access-binding \
      --role audit-trails.viewer \
      --id <идентификатор_организации> \
      --service-account-id <идентификатор_сервисного_аккаунта_maxpatrol-sa>
      ```

      Результат:

      ```text
      done (1s)
      ```

      Подробнее о команде `yc organization-manager organization add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/managed-services/organization-manager/organization/add-access-binding.md).

  1. Роль `yds.editor` на каталог `example-folder`:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --role yds.editor \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта_maxpatrol-sa>
      ```

      Результат:

      ```text
      done (1s)
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

{% endlist %}


### Создайте статические ключи доступа {#create-static-keys}

MaxPatrol SIEM использует [статические ключи доступа](../../iam/concepts/authorization/access-key.md) для авторизации запросов к потоку данных {{ yds-name }}.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт `maxpatrol-sa` и нажмите на строку с его именем.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.

  {% note alert %}

  Сохраните идентификатор и секретный ключ. После закрытия диалога значение ключа будет недоступно.

  {% endnote %}

- CLI

  Создайте статический ключ доступа для сервисного аккаунта `maxpatrol-sa`:

  ```bash
  yc iam access-key create --service-account-name maxpatrol-sa
  ```

  Результат:

  ```text
  access_key:
  id: YCd*****W7t
  service_account_id: aje*****ckg
  created_at: "2022-09-18..."
  key_id: YCA*****5Ws4
  secret: YCM76*******I3fk
  ```

  {% note alert %}

  Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение ключа снова невозможно.

  {% endnote %}

  Подробнее о команде `yc iam access-key create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/access-key/create.md).

{% endlist %}


### Создайте бессерверную БД {{ ydb-short-name }} {#serverless}

База данных необходима для потока данных `{{ yds-name }}`.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_ydb }}**.
  1. Укажите **{{ ui-key.yacloud.ydb.forms.label_field_name }}** — `maxpatrol-db`.
  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Для остальных параметров оставьте значения по умолчанию.
  1. Нажмите **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Дождитесь, когда статус базы данных изменится на `Running`.

- CLI

  1. Создайте базу данных:

      ```bash
      yc ydb database create --name maxpatrol-db --serverless --folder-name example-folder
      ```

      Где:
      * `name` — имя базы данных.
      * `serverless` — тип serverless.
      * `folder-name` — имя каталога.

      Результат:

      ```text
      done (7s)
      id: etn*****r5t
      folder_id: b1g*****rnj
      created_at: "2022-09-18..."
      name: maxpatrol-db
      status: PROVISIONING
      ...
      ```

      Подробнее о команде `yc ydb database create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/ydb/database/create.md).

  1. Проверьте статус созданной БД:

      ```bash
      yc ydb database get maxpatrol-db
      ```

      Дождитесь, когда статус базы данных изменится на `RUNNING`.

{% endlist %}


### Создайте поток данных {#create-stream}

В этот поток данных трейл будет загружать логи ресурсов организации.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_data-streams }}**.
  1. В поле **{{ ui-key.yacloud.data-streams.label_database }}** выберите `maxpatrol-db`.
  1. Укажите **{{ ui-key.yacloud.common.name }}** `maxpatrol-stream`.
  1. Для остальных параметров оставьте значения по умолчанию.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Дождитесь когда статус потока данных сменится на `Running`.

{% endlist %}


## Создайте трейл {#create-trail}

Трейл будет собирать аудитные логи всех ресурсов вашей организации и [загружать](../../audit-trails/operations/export-organization-data-streams.md) их в поток данных `maxpatrol-stream`.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_audit-trails }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** создаваемого трейла `maxpatrol-trail`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_filter }}** задайте параметры области сбора аудитных логов:
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}** — не требует заполнения (содержит имя организации, в котором будет находиться трейл).
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}** — выберите поток данных `maxpatrol-stream`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите сервисный аккаунт `maxpatrol-sa`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## Настройте MaxPatrol SIEM {#configure-maxpatrol}


### Создайте учетные записи {#static-key-account}

Учетные записи можно использовать как хранилища секретов. Создайте учетные записи `static-key-id` и `static-key-private`, чтобы сохранить в них идентификатор и [секретный ключ доступа](#create-static-keys):

1. Войдите в веб-интерфейс MaxPatrol SIEM.
1. В разделе **Сбор данных** нажмите **Учетные записи**.
1. Нажмите **Добавить учетную запись** → **Пароль** и укажите параметры:
    * **Название** — `static-key-id`;
    * **Пароль** — идентификатор [статического ключа](#create-static-keys);
    * **Подтверждение пароля** — повторите идентификатор статического ключа.
1. Нажмите **Сохранить**.

Аналогично создайте учетную запись `static-key-private`, содержащую секретный ключ.


### Создайте задачу на сбор данных {#create-task}

Создайте и запустите задачу на сбор данных с профилем {{ yds-full-name }}:
1. Войдите в веб-интерфейс MaxPatrol SIEM.
1. В разделе **Сбор данных** нажмите **Задачи**.
1. На странице **Задачи по сбору данных**:
    1. На панели инструментов нажмите **Создать задачу**.
    1. Нажмите **Сбор данных**.
1. На странице **Создание задачи на сбор данных** укажите параметры:
    1. **Название** — `YDS-logs-task`.
    1. **Профиль** — `{{ yds-full-name }}`.
    1. В иерархическом списке выберите **Запуск сценария**.
    1. В блоке **Подключение** укажите:
        * **Учетная запись** — `static-key-id`;
        * **Учетная запись для повышения привилегий** — `static-key-private`.
    1. **Параметры запуска сценария**:
        * **database** — <идентификатор_бд_maxpatrol-db>;
        * **folder** — <идентификатор_облака_для_каталога_example-folder>;
        * **region_name** — {{ region-id }};
        * **stream_name** — <имя_потока_maxpatrol-stream>.
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

* [удалите](../../data-streams/operations/manage-streams.md#delete-data-stream) поток данных `maxpatrol-stream`;
* [удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных `maxpatrol-db`.
