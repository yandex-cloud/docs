# Чтение данных из {{ monitoring-name }} с помощью соединений в {{ yq-name }}

[{{ monitoring-name }}](../../monitoring/concepts/index.md) — это сервис, позволяющий собирать и хранить метрики, а также отображать их в виде графиков на дашбордах. Отправляемые в {{ monitoring-name }} данные представляют из себя значения измеряемых величин (`метрики`) и метки (`labels`), их описывающие. 

Например, чтобы следить за количеством сбоев приложения, в качестве метрики можно использовать число сбоев за интервал времени. Данные, описывающие это падение: название хоста, версия приложения — являются метками. В интерфейсе {{ monitoring-name }} можно проводить различные агрегации метрик по меткам.

Пример чтения метрик из {{ monitoring-name }}.

```sql
SELECT
    *
FROM
    `monitoring`.ydb
WITH (
    program = @@max{method="DescribeTable"}@@,

    from = "2025-03-12T14:00:00Z",
    to = "2025-03-12T15:00:00Z",
);
```

## Настройка соединения {#setup-connection}

Для чтения метрик из {{ monitoring-name }} необходимо:
1. Перейти в интерфейс {{ yq-full-name }} в раздел **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}** и нажать кнопку **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
1. В открывшемся окне в поле **{{ ui-key.yql.yq-connection-form.connection-name.input-label }}** указать название соединения с {{ monitoring-name }}.
1. В выпадающем поле **{{ ui-key.yql.yq-connection-form.connection-type.input-label }}** выбрать `{{ ui-key.yql.yq-connection.action_monitoring }}`.
1. В поле **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** выбрать сервисный аккаунт, который будет использоваться для чтения метрик, или создать новый, выдав ему права [`monitoring.viewer`](../../monitoring/security/index.md#monitoring-viewer).

   {% include [service accounts role](../../_includes/query/service-accounts-role.md) %}

1. Создать соединение, нажав кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

## Модель данных {#data-model}

Чтение метрик из {{ monitoring-name }} выполняется с помощью SQL-выражения:

```sql
SELECT
    <выражение>
FROM
    <соединение>.<сервис>
WITH (
    (selectors|program) = "<запрос>",
    labels = "<метки>",
    from = "<время_от>",
    to = "<время_до>",
    <параметры прореживания>
);
```

Где:

- `<соединение>` — название соединения с {{ monitoring-name }}, созданного в предыдущем пункте.
- `<сервис>` — сервис {{ monitoring-name }}.
- `<запрос>` — запрос на [языке запросов](../../monitoring/concepts/querying.md) {{ monitoring-name }}.
- `<метки>` — список имен меток, которые нужно вернуть в отдельных столбцах. Параметр `labels` можно опустить, тогда все метки будут возвращены в формате `yql dict` в колонке `labels`.
- `<время_от>` — левая граница искомого временного интервала в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601).
- `<время_до>` — правая граница искомого временного интервала в формате ISO 8601.

{% note info %}

Параметр `selectors` работает без ограничений на количество метрик, но принимает на вход только набор селекторов. Метки `folderId`, `cloudId` и `service` в наборе селекторов указывать не нужно. Если вам нужно использовать [функции](../../monitoring/concepts/querying.md#functions) языка запросов — используйте параметр `program`.

{% endnote %}

В {{ yq-full-name }} поддерживаются следующие [параметры прореживания](../../monitoring/concepts/decimation.md#decimation-methods):

| Имя параметра | Описание | Принимаемые значения | Значение по умолчанию |
| --- | --- | --- | --- |
| `downsampling.disabled` | В случае значения `true` указывает, что данные в ответе на запрос будут получены без прореживания. | `true`, `false` | `false` |
| `downsampling.aggregation` | Функция агрегации, которая используется для прореживания. | `MAX`, `MIN`, `SUM`, `AVG`, `LAST`, `COUNT` | `AVG` |
| `downsampling.fill` | Параметры заполнения пропусков в данных. | `NULL`, `NONE`, `PREVIOUS` | `PREVIOUS` |
| `downsampling.grid_interval` | Ширина временного окна (сетки) в секундах, используемая для прореживания. | Целое число | `15` |

## Пример записи метрик {#example}

Пример запроса для чтения метрик из {{ monitoring-name }}:

```sql
SELECT
    *
FROM
    `monitoring`.ydb
WITH (
    selectors = @@{name = "api.grpc.request.bytes"}@@,

    labels = "database.dedicated, database_path, api_service",

    from = "2025-03-12T14:00:00Z",
    to = "2025-03-12T15:00:00Z",

    `downsampling.aggregation` = "AVG",
    `downsampling.fill` = "PREVIOUS",
    `downsampling.grid_interval` = "15"
);
```

Где:

* `monitoring` — название соединения с {{ monitoring-name }}.
* `ydb` — искомый сервис {{ monitoring-name }}.
