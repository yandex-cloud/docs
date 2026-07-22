[Документация Yandex Cloud](../../index.md) > [Yandex Query](../index.md) > Источники и приемники данных > Работа с Yandex Monitoring > Чтение данных с помощью соединений

# Чтение данных из Monitoring с помощью соединений в Query

Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

[Monitoring](../../monitoring/concepts/index.md) — сервис для сбора и хранения метрик, а также их отображения на дашбордах. Данные в Monitoring содержат значения измеряемых величин — метрики — и описывающие их метки.

Например, чтобы отслеживать количество сбоев приложения, в качестве метрики можно использовать число сбоев за интервал времени. Название хоста и версия приложения при сбое являются метками. В интерфейсе Monitoring можно выполнять агрегацию метрик по меткам.

Пример чтения метрик из Monitoring:

```sql
SELECT
    *
FROM
    monitoring.ydb
WITH (
    program = @@max{method="DescribeTable"}@@,

    from = "2025-03-12T14:00:00Z",
    to = "2025-03-12T15:00:00Z"
);
```

## Настройка соединения {#setup-connection}

Чтобы настроить чтение метрик из Monitoring:

1. [Перейдите](https://yq.yandex.cloud) в сервис **Yandex Query**.
1. На панели слева выберите **Соединения**.
1. Нажмите **Создать**.
1. В открывшемся окне в поле **Имя** укажите название соединения с Monitoring.
1. В поле **Тип** выберите `Monitoring`.
1. В поле **Сервисный аккаунт** выберите сервисный аккаунт для чтения метрик или создайте новый и назначьте ему на облако роль [`monitoring.viewer`](../../monitoring/security/index.md#monitoring-viewer).

   Чтобы использовать сервисный аккаунт, пользователю нужна [роль](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user`.

1. Нажмите **Создать**.

## Модель данных {#data-model}

Чтение метрик из Monitoring выполняется с помощью SQL-выражения:

```sql
SELECT
    *
FROM
    <соединение>.<сервис>
WITH (
    (selectors|program) = "<запрос>",
    labels = "<метки>",
    from = "<время_от>",
    to = "<время_до>",
    <параметры прореживания>
)
```

Где:

- `<соединение>` — название соединения с Monitoring, созданного в предыдущем пункте.
- `<сервис>` — сервис Monitoring.
- `<запрос>` — запрос на [языке запросов](../../monitoring/concepts/querying.md) Monitoring.
- `<метки>` — список имен меток, значения которых нужно получить в отдельных столбцах.
- `<время_от>` — левая граница искомого временного интервала в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601).
- `<время_до>` — правая граница искомого временного интервала в формате ISO 8601.

Такой запрос вернет все точки всех метрик сервиса `<сервис>`, удовлетворяющих `<запросу>` и находящихся во временном интервале `[<время_от>, <время_до>)`. Результат запроса будет содержать колонки:

| Имя | Тип данных | Описание |
| --- | --- | --- |
| `ts` | `Datetime` | Время точки метрики |
| `value` | `Double?` | Значение точки метрики, соответствующее времени в столбце `ts` |
| `type` | `String` | Тип метрики, содержащей точку |
| `labels` | `YQL Dict` | Метки метрики, содержащей точку. Если в запросе указан параметр `labels`, данный столбец будет отсутствовать |
| `<label>` | `String` | Значение метки `<label>` метрики, содержащей точку |

{% note info %}

Запрос с параметром `selectors` работает без ограничений на количество метрик, но принимает на вход только набор селекторов. Если вам нужно использовать [функции](../../monitoring/concepts/querying.md#functions) языка запросов — используйте параметр `program`.

{% endnote %}

{% note info %}

Метки `folderId` и `service` в наборе селекторов можно не указывать. 

{% endnote %}

### Формат параметров запроса {#parameters-format}

| Имя параметра | Формат | Пример |
| --- | --- | --- |
| `selectors` | `["sensor_name"]{[label_name1 = "label_value1", label_name2 = "label_value2", ...]}` | `{name = "api.grpc.request.bytes", method="DescribeTable"}` |
| `program` | Запрос на [языке запросов](../../monitoring/concepts/querying.md) Monitoring | `series_sum{method="DescribeTable"}` |
| `labels` | `"label1 [as alias1], label2 [as alias2], ..."` | `"database.dedicated as db, database_path, api_service as api"` |
| `from / to` | Время в формате ISO 8601 | `"2025-05-20T12:00:00Z"` |

### Параметры прореживания {#downsampling-parameters}

В Yandex Query поддерживаются следующие [параметры прореживания](../../monitoring/concepts/decimation.md#decimation-methods):

| Имя параметра | Описание | Принимаемые значения | Значение по умолчанию |
| --- | --- | --- | --- |
| `downsampling.disabled` | В случае значения `true` указывает, что данные в ответе на запрос будут получены без прореживания. | `true`, `false` | `false` |
| `downsampling.aggregation` | Функция агрегации, которая используется для прореживания. | `MAX`, `MIN`, `SUM`, `AVG`, `LAST`, `COUNT` | `AVG` |
| `downsampling.fill` | Параметры заполнения пропусков в данных. | `NULL`, `NONE`, `PREVIOUS` | `PREVIOUS` |
| `downsampling.grid_interval` | Ширина временного окна (сетки) в секундах, используемая для прореживания. | Целое число | `15` |

## Пример чтения метрик {#example}

Пример запроса для чтения метрик из Monitoring:

```sql
SELECT
    *
FROM
    monitoring.compute
WITH (
    selectors = @@"cpu_utilization"{resource_type="vm"}@@,

    labels = "cpu_name as cpu, resource_id",

    from = "2025-03-12T14:00:00Z",
    to = "2025-03-12T15:00:00Z",

    `downsampling.aggregation` = "AVG",
    `downsampling.fill` = "PREVIOUS",
    `downsampling.grid_interval` = "15"
);
```

Где:

* `monitoring` — название соединения с Monitoring.
* `compute` — сервис, по которому проводится поиск.
* `cpu_name as cpu, resource_id` — список меток, значения которых вернутся в отдельных столбцах. Значение метки `cpu_name` будет возвращено в столбце `cpu`, `resource_id` — в столбце `resource_id`.
* `[2025-03-12T14:00:00Z – 2025-03-12T15:00:00Z)` — временной интервал, по которому проводится поиск.