# Загрузка аудитных логов в MaxPatrol SIEM с помощью консоли управления или {{ yandex-cloud }} CLI


[MaxPatrol SIEM](https://www.ptsecurity.com/ru-ru/products/mpsiem/) позволяет читать [аудитные логи](../../audit-trails/concepts/events.md) {{ yandex-cloud }} из потока данных [{{ yds-full-name }}](../../data-streams/index.yaml). Для полного прохождения руководства у вас должен быть доступ к экземпляру MaxPatrol SIEM.

Чтобы настроить экспорт аудитных логов с помощью консоли управления или {{ yandex-cloud }} CLI:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#environment-preparing).
1. [Создайте трейл, который отправляет логи в поток данных {{ yds-name }}](#create-trail).
1. [Настройте в MaxPatrol SIEM задачу по сбору данных из потока {{ yds-name }}](#configure-maxpatrol).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/at-maxpatrol-siem/paid-resources.md) %}

## Подготовьте окружение {#environment-preparing}

### Создайте сервисные аккаунты {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) `maxpatrol-sa` [трейл](../../audit-trails/concepts/trail.md) будет собирать логи всех ресурсов организации и выгружать их в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}. От имени сервисного аккаунта `maxpatrol-reader-sa` MaxPatrol SIEM будет загружать аудитные логи из потока данных.

Создайте сервисные аккаунты в том же каталоге, в котором будете создавать трейл, например, в каталоге `example-folder`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `maxpatrol-sa`.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_roles }}** нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_billing.iam.folder.service-account.label_add-role }}** и выберите [роль](../../data-streams/security/index.md#yds-writer) `yds.writer` на каталог.
  1. Нажмите кнопку **{{ ui-key.yacloud_billing.iam.folder.service-account.popup-robot_button_add }}**.

  Аналогичным образом создайте сервисный аккаунт `maxpatrol-reader-sa` и назначьте ему [роль](../../data-streams/security/index.md#yds-viewer) `yds.viewer` на каталог.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

  Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

{% endlist %}

### Назначьте роли сервисным аккаунтам {#sa-assign-roles}

Назначьте сервисным аккаунтам недостающие роли:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#console}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud_org.cloud-components.AclDashboard.action_assign-roles_41Nj1 }}**. В открывшемся окне выберите сервисный аккаунт `maxpatrol-sa`. При необходимости воспользуйтесь строкой поиска.
  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите [роль](../../audit-trails/security/index.md#at-viewer) `audit-trails.viewer`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Назначьте сервисному аккаунту `maxpatrol-sa` [роль](../../data-streams/security/index.md#yds-writer) `yds.writer` на каталог `example-folder`:

      ```bash
      yc resource-manager folder add-access-binding example-folder \
        --role yds.writer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — назначаемая роль.
      * `--subject` — идентификатор сервисного аккаунта `maxpatrol-sa`.

  1. Аналогичным образом назначьте [роль](../../data-streams/security/index.md#yds-viewer) `yds.viewer` на каталог `example-folder` сервисному аккаунту `maxpatrol-reader-sa`.

      Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

  1. Назначьте сервисному аккаунту `maxpatrol-sa` [роль](../../audit-trails/security/index.md#at-viewer) `audit-trails.viewer` на организацию:

      ```bash
      yc organization-manager organization add-access-binding \
        --role audit-trails.viewer \
        --id <идентификатор_организации> \
        --service-account-id <идентификатор_сервисного_аккаунта>
      ```

      Где:

      * `--role` — назначаемая роль.
      * `--id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, в которой находится сервисный аккаунт.
      * `--service-account-id` — идентификатор сервисного аккаунта `maxpatrol-sa`.

      Подробнее о команде `yc organization-manager organization add-access-binding` см. в [справочнике CLI](../../cli/cli-ref/organization-manager/cli-ref/organization/add-access-binding.md).

{% endlist %}

### Создайте статический ключ доступа для MaxPatrol SIEM {#create-static-keys}

MaxPatrol SIEM использует [статические ключи доступа](../../iam/concepts/authorization/access-key.md) для авторизации запросов к потоку данных {{ yds-name }}.

Создайте статический ключ доступа для сервисного аккаунта `maxpatrol-reader-sa`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и в открывшемся списке выберите сервисный аккаунт `maxpatrol-reader-sa`.
  1. На панели сверху нажмите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.

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

  Подробнее о команде `yc iam access-key create` см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

{% endlist %}


### Создайте бессерверную БД {{ ydb-short-name }} {#serverless}

База данных необходима для потока данных `{{ yds-name }}`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_ydb }}**.
  1. Укажите **{{ ui-key.yacloud.ydb.forms.label_field_name }}** — `maxpatrol-db`.
  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Для остальных параметров оставьте значения по умолчанию.
  1. Нажмите **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

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

      Подробнее о команде `yc ydb database create` см. в [справочнике CLI](../../cli/cli-ref/ydb/cli-ref/database/create.md).

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

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_data-streams }}**.
  1. В поле **{{ ui-key.yacloud.data-streams.label_database }}** выберите `maxpatrol-db`.
  1. Укажите **{{ ui-key.yacloud.common.name }}** `maxpatrol-stream`.
  1. Для остальных параметров оставьте значения по умолчанию.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  Дождитесь, когда статус потока данных сменится на `Running`.

{% endlist %}


## Создайте трейл {#create-trail}

Трейл будет собирать аудитные логи уровня конфигурации всех ресурсов вашей организации и загружать их в поток данных `maxpatrol-stream`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `example-folder`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_audit-trails }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** создаваемого трейла `maxpatrol-trail`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_dataStream }}`.
      * **{{ ui-key.yacloud.audit-trails.label_stream-name }}** — выберите поток данных `maxpatrol-stream`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите сервисный аккаунт `maxpatrol-sa`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}** — не требует заполнения (содержит имя организации, в которой будет находиться трейл).
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** — оставьте значение по умолчанию `{{ ui-key.yacloud.common.all }}`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** в поле **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** выберите `{{ ui-key.yacloud.common.disabled }}`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

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
  * `--filter-all-organisation-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, в которой создается трейл и где будут собираться аудитные события.

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

  Подробнее о команде `yc audit-trails trail create` см. в [справочнике CLI](../../cli/cli-ref/audit-trails/cli-ref/trail/create.md).

{% endlist %}

Подробнее о создании трейла см. в разделе [{#T}](../../audit-trails/operations/create-trail.md).

## Настройте MaxPatrol SIEM {#configure-maxpatrol}

{% include [the-maxpatrol-part](../_tutorials_includes/at-maxpatrol-siem/the-maxpatrol-part.md) %}

## Как удалить созданные ресурсы {#clear-out}

Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

* [удалите](../../data-streams/operations/manage-streams.md#delete-data-stream) поток данных `maxpatrol-stream`;
* [удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных `maxpatrol-db`.