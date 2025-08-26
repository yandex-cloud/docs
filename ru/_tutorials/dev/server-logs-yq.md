# Получение статистики запросов к объектам {{ objstorage-full-name }} с использованием {{ yq-full-name }}


Из этого руководства вы узнаете, как получить статистику запросов к объектам [{{ objstorage-full-name }}](../../storage/) с использованием [{{ yq-full-name }}](../../query/). Вы создадите бакет и настроите логирование в {{ objstorage-name }}, создадите соединение в {{ yq-name }} и получите статистику с помощью SQL-запросов.

Чтобы получить статистику:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакеты](#create-buckets).
1. [Включите механизм логирования](#enable-logging).
1. [Настройте подключения в {{ yq-name }}](#create-connection).
1. [Получите статистику запросов](#get-statistics).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за объем считанных данных (см. [тарифы {{ yq-full-name }}](../../query/pricing.md)).

### Создайте сервисный аккаунт {#create-sa}

С помощью сервисного аккаунта {{ yq-name }} сможет отправлять запросы к {{ objstorage-name }}.

[Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с именем `yq-sa` и [назначьте](../../iam/operations/roles/grant.md) ему роли `storage.viewer` и `yq.editor`.

## Создайте бакеты {#create-buckets}

Создайте два бакета: `object-bucket` и `logs-bucket`. Один бакет будет служить источником данных, другой — хранилищем логов. 

Чтобы создать бакет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета `object-bucket`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

  Аналогичным образом создайте бакет с именем `logs-bucket`.

{% endlist %}

## Включите механизм логирования {#enable-logging}

Чтобы получать информацию о запросах к объектам, включите [механизм логирования действий с бакетом](../../storage/concepts/server-logs.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали бакеты.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет `object-bucket`.
  1. [Включите механизм логирования](../../storage/operations/buckets/enable-logging.md#enable):

      1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}**.
      1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_server-logs_mfGpj }}**.
      1. В поле **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_target-bucket_jEJ5E }}** выберите бакет `logs-bucket`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** и [загрузите](../../storage/operations/objects/upload.md) объекты. Например, пару простых текстовых файлов.

{% endlist %}

## Настройте подключения в {{ yq-name }} {#create-connection}

Чтобы получать данные из {{ objstorage-name }}, создайте [соединение](../../query/concepts/glossary.md#connection) и [привязку](../../query/concepts/glossary.md#binding):

{% list tabs group=instructions %}

- Интерфейс {{ yq-full-name }} {#console}

  1. Перейдите в сервис [{{ yq-name }}](https://yq.yandex.cloud/).
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Введите имя соединения, например `bucket-logs-connection`.
  1. Выберите тип соединения **{{ ui-key.yql.yq-connection.action_object-storage }}** и укажите **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**.
  1. В поле **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** выберите `{{ ui-key.yql.yq-connection-form.private.button-text }}` и задайте параметры:

      * **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** — выберите облако и каталог, в которых вы создали бакеты.
      * **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** — `logs-bucket`.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — `yq-sa`.

  1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.test.button-text }}**. После успешной проверки нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
  1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-fields-templates.button.label }}** и в выпадающем списке выберите **Object Storage Access Logs**.

      1. Введите имя привязки, например `bucket-logs-binding`.
      1. В поле **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** укажите путь к данным статистики внутри бакета. Если данные статистики хранятся в корневой директории бакета, укажите `/`.
      1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}** для проверки правильности настроек.
      1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}** для завершения создания привязки.

{% endlist %}

## Получите статистику запросов {#get-statistics}

Используйте соединение, чтобы создать SQL-запросы и получить статистику запросов к объектам {{ objstorage-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ yq-full-name }} {#console}

  1. Перейдите в сервис [{{ yq-name }}](https://yq.yandex.cloud/).
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Выберите соединение `bucket-logs-connection`.
  1. В редакторе справа введите запрос:

      ```sql
      SELECT `timestamp`, request_id, handler, object_key, status, request_time
      FROM `bucket-logs-binding`
      LIMIT 100;
      ```

      Такой запрос вернет 100 записей со статистикой запросов к объектам {{ objstorage-name }}. Лимит записей можно снять, а результаты фильтровать с помощью `WHERE`.

  1. Нажмите кнопку ![image](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}** и посмотрите результат.

{% endlist %}

### Примеры запросов {#examples}

#### Поиск запросов по коду ответа {#request-code}

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM `bucket-logs-binding`
WHERE status >= 400
```

#### Поиск долго обрабатываемых запросов {#request-long}

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM `bucket-logs-binding`
WHERE request_time >= 1000
```

#### Среднее время обработки запросов {#request-average}

В примере используется агрегатная функция `AVG`.

```sql
SELECT AVG(request_time) AS `avg` FROM `bucket-logs-binding`
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу инфраструктуры и перестать платить за созданные ресурсы:

1. [Удалите](../../query/operations/binding.md#delete) привязку.
1. [Удалите](../../query/operations/connection.md#delete) соединение.
1. [Удалите](../../storage/operations/objects/delete.md) объекты в бакетах.
1. [Удалите](../../storage/operations/buckets/delete.md) бакеты.
