# Чтение данных из {{ objstorage-name }} с помощью привязок к данным {{ yq-name }}

Иногда одни и те же запросы к данным нужно выполнять регулярно. Чтобы не указывать все детали работы с этими данными при каждом вызове запроса, используйте привязки.

Пример запроса для чтения данных с использованием привязки к данным:

```sql
SELECT
    *
FROM
    `logs`
WHERE
    version>1
```

## Настройка привязки к данным {#binding-settings}

Чтобы создать привязку для чтения данных из {{ objstorage-short-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать привязку.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. На панели слева перейдите на вкладку **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. В блоке **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

   1. В поле **{{ ui-key.yql.yq-binding-form.connection-type.title }}** выберите `{{ ui-key.yql.yq-connection.action_object-storage }}`.
   1. В поле **{{ ui-key.yql.yq-binding-form.connection.title }}** выберите соединение или [создайте новое](./object-storage.md#create_connection).

1. В блоке **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:

   1. В поле **{{ ui-key.yql.yq-binding-form.binding-name.title }}** укажите название привязки к данным.
   1. В поле **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** укажите [путь к данным внутри бакета](object-storage.md#path_format). Поддерживается указание частей имен файлов через `/*`, например, `yellow/*.csv`.
   1. В поле **{{ ui-key.yql.yq-binding-info.compression.label-text }}** укажите способ [сжатия данных](formats.md#compression).
   1. В поле **{{ ui-key.yql.yq-binding-info.format.label-text }}** укажите [формат хранения данных](formats.md#formats).
   1. Укажите список колонок данных и их типы.
   1. Выберите режим партицирования и укажите список [колонок партицирования](../concepts/partitioning.md) и их типы.

      При использовании режима **{{ ui-key.yql.yq-binding-form.projection-radio.enabled.label }}** укажите колонки [расширенного партицирования](../concepts/partition-projection.md).

1. Для проверки данных нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Модель данных {#data-model}

В {{ objstorage-short-name }} данные хранятся в файлах в бинарном виде. Для чтения данных используйте SQL-выражение:

```sql
SELECT
    <выражение>
FROM
    `<привязка>`
WHERE
    <фильтр>;
```

Где:

* `<привязка>` — название ранее созданной привязки к данным.

## Пример чтения данных c помощью привязок к данным {#binding-example}

Пример запроса для чтения данных из {{ objstorage-short-name }} с помощью привязок к данным:

```sql
SELECT
    *
FROM
    `binding_name`
```

Где `binding_name` — название привязки к данным в {{ objstorage-short-name }}.
