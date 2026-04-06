# Особенности OTLP в {{ monium-name }}

{{ monium-name }} поддерживает прием телеметрии по протоколу [OTLP](https://opentelemetry.io/docs/specs/otlp/) (OpenTelemetry Protocol), что позволяет напрямую отправлять данные из приложений с OpenTelemetry SDK или через OpenTelemetry Collector.

## Эндпоинты {#endpoints}

{{ monium-name }} предоставляет следующие эндпоинты для приема телеметрии в формате OTLP:

#|
|| **Протокол** | **Эндпоинт** | **Описание** ||
|| HTTP | `https://{{ api-host-monium }}/otlp/v1/metrics` | HTTP-эндпоинт для приема метрик ||
|| HTTP | `https://{{ api-host-monium }}/otlp/v1/logs` | HTTP-эндпоинт для приема логов ||
|| HTTP | `https://{{ api-host-monium }}/otlp/v1/traces` | HTTP-эндпоинт для приема трейсов ||
|| gRPC | `{{ api-host-monium }}:443` | gRPC эндпоинт для приема всей телеметрии ||
|#

Эндпоинты gRPC и HTTP полностью совместимы со [спецификацией OTLP](https://opentelemetry.io/docs/specs/otlp/).

## Авторизация {#authorization}

Для авторизации запросов используется API-ключ, передаваемый в заголовке `Authorization`:

```
Authorization: Api-Key <API_ключ>
```

API-ключ создается для сервисного аккаунта с ролью `monium.telemetry.writer`. Ключ должен иметь область действия `yc.monium.telemetry.write` для записи любого вида телеметрии, либо одну или несколько из `yc.monium.metrics.write`, `yc.monium.logs.write`, `yc.monium.traces.write` для гранулированного доступа. Подробнее о [создании API-ключа](../../iam/operations/iam-token/create-for-sa.md).

## Заголовки {#headers}

### Обязательные заголовки {#required-headers}

#|
|| **Заголовок** | **Описание** | **Пример** ||
|| `Authorization` | API-ключ для аутентификации | `Api-Key AQVN...` ||
|| `x-monium-project` | Имя проекта {{ monium-name }} | `folder__b1...` ||
|#

### Опциональные заголовки {#optional-headers}

#|
|| **Заголовок** | **Описание** | **Пример** | **Значение по умолчанию** ||
|| `x-monium-cluster` | Имя кластера | `production` | `default` ||
|| `x-monium-service` | Имя сервиса | `payment-gateway` | `default` ||
|#

## Распределение по шардам {#shard-distribution}

{% include [shard-distribution](../../_includes/monium/shard-distribution.md) %}

Подробнее о параметрах шардирования см. в разделе [Основные понятия](../concepts/glossary.md#shard).

## Компрессия данных {#compression}

{{ monium-name }} поддерживает следующие методы компрессии:

#|
|| **Метод** | **HTTP заголовок** | **gRPC** | **Рекомендация** ||
|| Без сжатия | – | – | Для отладки либо при небольшом потоке данных ||
|| gzip | `Content-Encoding: gzip` | `grpc-encoding: gzip` | Поддерживается по умолчанию ||
|| zstd | `Content-Encoding: zstd` | `grpc-encoding: zstd` | **Рекомендуется**: эффективнее по вычислительным ресурсам ||
|#

## Сопоставление типов метрик {#metric-type-mapping}

В разделе приведено отображение типов данных в OpenTelemetry в типы {{ monium-name }}.

### Типы метрик OTLP {#otlp-types}

OpenTelemetry использует следующие типы метрик:

#|
|| **Тип OTLP** | **Характеристика** | **Примеры использования** ||
|| `Gauge` | Мгновенное значение | Использование памяти, температура ||
|| `Counter` | Монотонный счетчик | Количество запросов, размер запроса ||
|| `UpDownCounter` | Аддитивный счетчик | Количество активных подключений ||
|| `Histogram` | Распределение значений | Длительность запроса, размер ответа ||
|| `Summary` (deprecated) | Квантили и сумма | Процентили задержки ||
|#

### Сопоставление типов {{ monium-name }} {#monium-mapping}

{{ monium-name }} преобразует типы OTLP в свои внутренние типы метрик в зависимости от темпоральности (temporality):

#### Temporality = Delta (дельта) {#delta-temporality}

#|
|| **Тип OTLP** | **Монотонность** | **Тип в {{ monium-name }}** | **Примечание** ||
|| `Gauge` | — | `GAUGE` | Мгновенное значение ||
|| `Sum` | Monotonic | `RATE` | Сумма делится на длину интервала в секундах ||
|| `Histogram` | — | `HIST_RATE` для бакетов, `GAUGE` для статистик | `name={metric}, bin={bound}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|| `Summary` | — | `GAUGE` | `name={metric}.quantile, quantile={q}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|#

#### Temporality = Cumulative (кумулятивная) {#cumulative-temporality}

#|
|| **Тип OTLP** | **Монотонность** | **Тип в {{ monium-name }}** | **Примечание** ||
|| `Gauge` | — | `GAUGE` | Мгновенное значение ||
|| `Sum` | Non-monotonic | `GAUGE` | Абсолютное значение счетчика ||
|| `Sum` | Monotonic | `GAUGE` | Абсолютное значение счетчика ||
|| `Histogram` | — | `HIST` для бакетов, `GAUGE` для статистик | `name={metric}, bin={bound}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|| `Summary` | — | `GAUGE` | `name={metric}.quantile, quantile={q}` + `name={metric}.count` + `name={metric}.sum` + `name={metric}.min` + `name={metric}.max` ||
|#

## Примеры обработки сумм {#sum-examples}

### Кумулятивная сумма (Cumulative Sum) {#cumulative-sum-example}

#|
|| **Период** | **Инкременты** | **Сумма** | **Значение в {{ monium-name }}** | **Тип** | **Примечание** ||
|| #1 | `[1,1,1,2,2,2,3,3]` | 15 | 15 | `GAUGE` | Используется значение суммы ||
|| #2 | `[3,4,1,2,-15]` | 10 | 10 | `GAUGE` | Используется значение суммы ||
|| #3 | `[]` | 10 | 10 | `GAUGE` | Последнее значение сохраняется ||
|#

### Монотонная дельта сумма (Delta Sum, Monotonic) {#delta-sum-monotonic-example}

#|
|| **Период** | **Инкременты** | **Сумма, интервал** | **Значение в {{ monium-name }}** | **Тип** | **Примечание** ||
|| #1 | `[1,1,1,2,2,2,3,3]` | `15, (0, 5]` | 3 (15 / 5) | `RATE` | Сумма делится на интервал ||
|| #2 | `[3,4,1,2]` | `10, (5, 10]` | 2 (10 / 5) | `RATE` | Сумма делится на интервал ||
|| #3 | `[]` | `0, (10, 15]` | 0 (0 / 5) | `RATE` | Нулевое значение ||
|#

Немонотонные дельта‑суммы в OpenTelemetry, как правило, не используются.

## Обработка ресурсных атрибутов {#resource-attributes}

{{ monium-name }} обрабатывает ресурсные атрибуты OTLP следующим образом:

### Сохраняемые атрибуты {#preserved-attributes}

Следующие ресурсные атрибуты сохраняются как метки метрик:

**Атрибуты хоста** (приоритет от высшего к низшему):
* `host`
* `host.name`
* `hostname`

Эти атрибуты сохраняются в метку `host`.

**Атрибуты окружения** (приоритет от высшего к низшему):
* `env`
* `deployment.environment.name`
* `deployment.environment`

Эти атрибуты сохраняются в метку `env`.

**Атрибуты Kubernetes и Cloud** (сохраняются без изменения имени):
* `cloud.availability_zone`
* `cloud.region`
* `container.name`
* `k8s.cluster.name`
* `k8s.container.name`
* `k8s.cronjob.name`
* `k8s.daemonset.name`
* `k8s.deployment.name`
* `k8s.job.name`
* `k8s.namespace.name`
* `k8s.pod.name`
* `k8s.replicaset.name`
* `k8s.statefulset.name`

### Зарезервированные метки {#reserved-labels}

Если в атрибутах точек данных (data point attributes) используются зарезервированные имена меток, они автоматически переименовываются:

#|
|| **Исходное имя** | **Переименованное** ||
|| `project` | `_project_` ||
|| `cluster` | `_cluster_` ||
|| `service` | `_service_` ||
|#

### Остальные атрибуты {#other-attributes}

Ресурсные атрибуты, не входящие в вышеперечисленные списки, отбрасываются.
Все атрибуты точек данных сохраняются как метки метрик {{ monium-name }}.

## Формат данных {#data-format}

{{ monium-name }} поддерживает формат **OTLP Protobuf** для всех видов телеметрии. Формат OTLP JSON в настоящее время поддерживается для логов и трейсов.

## См. также {#see-also}

* [{#T}](otlp-sdk.md)
* [{#T}](opentelemetry.md)
* [Спецификация OTLP](https://opentelemetry.io/docs/specs/otlp/)
* [OpenTelemetry Metrics](https://opentelemetry.io/docs/concepts/signals/metrics/)
