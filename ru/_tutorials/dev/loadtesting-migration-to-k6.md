# Миграция нагрузочного тестирования с {{ load-testing-name }} на k6

{% include [loadtesting-sunset-warning](../../_includes/load-testing/sunset-warning.md) %}

{% include [k6-legal-note](../../_includes/load-testing/k6-legal-note.md) %}

В качестве замены рекомендуется использовать [k6](https://k6.io/) — открытый инструмент нагрузочного тестирования от Grafana Labs. k6 поддерживает HTTP, gRPC, WebSocket и другие протоколы, легко встраивается в CI/CD и предоставляет гибкие средства анализа результатов.

В этом руководстве описано, как перенести существующие сценарии нагрузочного тестирования на k6 с сохранением привычных возможностей: профилей нагрузки, автостопа, мониторинга и регрессионного анализа.

Чтобы перенести сценарии нагрузочного тестирования на k6:
1. [Изучите соответствие возможностей](#overview).
1. [Подготовьте окружение](#before-begin).
1. [Проверьте установку k6](#quick-start).
1. [Настройте инфраструктуру для генерации нагрузки](#agents).
1. [Перенесите профили нагрузки](#load-profiles).
1. [Перенесите тестовые данные и сценарии](#test-data).
1. [Настройте автостоп](#autostop).
1. [Настройте визуализацию результатов](#test-results).
1. [Настройте регрессионный анализ](#regression).
1. [Настройте мониторинг ресурсов генератора](#monitoring).
1. [Настройте запуск в CI/CD](#cicd).

## Соответствие возможностей {{ load-testing-name }} и k6 {#overview}

#|
|| **Возможность в {{ load-testing-name }}** | **Аналог в k6** | **Подробнее** ||
|| **Агент** — управляемая ВМ для генерации нагрузки
| Любая машина с установленным k6: локальный компьютер, ВМ в облаке, контейнер в CI/CD
| [Инфраструктура для генерации нагрузки](#agents) ||
|| **Генераторы нагрузки** — Pandora, Phantom, JMeter
| Единый встроенный генератор k6 с поддержкой HTTP/1.1, HTTP/2, gRPC, WebSocket
| [Тестовые данные и сценарии](#test-data) ||
|| **Профиль нагрузки** — `const`, `line`, `step`, `once`
| Сценарии (scenarios) с executor'ами: `constant-arrival-rate`, `ramping-arrival-rate`, `shared-iterations` и др.
| [Профили нагрузки](#load-profiles) ||
|| **Тестирующие потоки** — параллельные соединения для генерации RPS
| Виртуальные пользователи (VU) — каждый выполняет сценарий в цикле; RPS = VU / время итерации
| [Профили нагрузки](#load-profiles) ||
|| **Тестовые данные** — форматы URI, HTTP_JSON, GRPC_JSON, файлы из {{ objstorage-name }}
| Запросы описываются в JavaScript-скрипте; внешние данные загружаются через `SharedArray`
| [Тестовые данные и сценарии](#test-data) ||
|| **Автостоп** — остановка теста по времени ответа, HTTP-кодам, квантилям
| Thresholds с параметром `abortOnFail` — аналогичные критерии остановки
| [Автостоп](#autostop) ||
|| **Результаты тестирования** — графики квантилей, кодов ответов, RPS
| Встроенная сводка в терминале; визуализация через Grafana + InfluxDB/Prometheus
| [Результаты тестирования](#test-results) ||
|| **Дашборд регрессий** — отслеживание деградации между запусками
| Grafana-дашборд с историей запусков и алерты на пороговые значения
| [Регрессионный анализ](#regression) ||
|| **Мониторинг агента** — CPU, память, диск, сеть через Telegraf/{{ monitoring-name }}
| Telegraf, node_exporter и Prometheus или {{ monitoring-name }} для ВМ в облаке
| [Мониторинг ресурсов генератора](#monitoring) ||
|| **Консоль управления** — веб-интерфейс для настройки и запуска тестов
| CLI `k6 run` для запуска; Grafana для визуализации; CI/CD для автоматизации
| [Запуск в CI/CD](#cicd) ||
|| **Конфигурация теста** — YAML-файл с параметрами генератора
| JavaScript-файл с объектом `options` — профили, пороги и сценарии в одном месте
| [Профили нагрузки](#load-profiles) ||
|#

## Подготовьте окружение {#before-begin}

1. [Установите k6](https://grafana.com/docs/k6/latest/set-up/install-k6/) на машину, с которой планируете запускать тесты:

   {% list tabs %}

   - Linux

     ```bash
     sudo gpg -k
     sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg \
       --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
     echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" \
       | sudo tee /etc/apt/sources.list.d/k6.list
     sudo apt-get update && sudo apt-get install k6
     ```

   - macOS

     ```bash
     brew install k6
     ```

   - Docker

     ```bash
     docker pull grafana/k6
     ```

   {% endlist %}

1. Если вы планируете визуализировать результаты, подготовьте стек мониторинга — например, [Grafana](https://grafana.com/) с [InfluxDB](https://www.influxdata.com/) или [Prometheus](https://prometheus.io/).

## Проверьте установку k6 {#quick-start}

Убедитесь, что k6 установлен и работает. Следующая команда запустит короткий тест — десять виртуальных пользователей в течение 30 секунд будут отправлять GET-запросы и проверять код ответа:

```bash
k6 run - << 'EOF'
import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  vus: 10,
  duration: '30s',
};

export default function () {
  const res = http.get('https://test.k6.io/');
  check(res, { 'статус 200': (r) => r.status === 200 });
  sleep(1);
}
EOF
```

По завершении k6 выведет сводку: количество запросов, среднее время ответа, процент успешных проверок и другие метрики. Это тот же формат результатов, с которым вы будете работать в дальнейшем.

Чтобы посмотреть полный список команд и флагов, выполните:

```bash
k6 --help
```

## Настройте инфраструктуру для генерации нагрузки {#agents}

В {{ load-testing-name }} тесты запускались на управляемых агентах — виртуальных машинах, которые создавались и настраивались автоматически.

В k6 генератор нагрузки запускается на любой машине: локальном компьютере, виртуальной машине в облаке или в контейнере CI/CD-пайплайна.

Если вашим тестам требовался доступ к целевому приложению через внутреннюю сеть {{ yandex-cloud }}, создайте виртуальную машину в нужной подсети и запускайте k6 на ней.

Ориентировочные рекомендации по ресурсам для генератора нагрузки (для простых HTTP-сценариев без тяжелой обработки ответов):

#|
|| **Профиль нагрузки** | **vCPU** | **RAM** ||
|| До 10 000 RPS | 2 | 2 ГБ ||
|| До 20 000 RPS | 4 | 4 ГБ ||
|| До 40 000 RPS | 8 | 8 ГБ ||
|#

Для сценариев с JSON-парсингом, множественными проверками или большими телами ответов потребуется больше ресурсов. Подробнее в руководстве по [запуску масштабных тестов](https://grafana.com/docs/k6/latest/testing-guides/running-large-tests/).

Для нагрузки свыше 40 000 RPS используйте [распределенное выполнение k6](https://grafana.com/docs/k6/latest/testing-guides/running-large-tests/).

## Перенесите профили нагрузки {#load-profiles}

В {{ load-testing-name }} нагрузка задавалась в единицах RPS через профили `line`, `const`, `step` и `once`. В k6 нагрузка управляется через количество виртуальных пользователей (VU) и сценарии. Каждый VU выполняет тестовый сценарий в цикле — итоговый RPS зависит от числа VU и времени выполнения одной итерации.

### const — постоянная нагрузка {#profile-const}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {duration: 300s, type: const, ops: 10000}
```

k6 — фиксированное число VU:

```javascript
export const options = {
  scenarios: {
    constant_load: {
      executor: 'constant-vus',
      vus: 100,
      duration: '5m',
    },
  },
};
```

Если требуется точный контроль RPS, используйте executor `constant-arrival-rate`:

```javascript
export const options = {
  scenarios: {
    constant_load: {
      executor: 'constant-arrival-rate',
      rate: 10000,
      timeUnit: '1s',
      duration: '5m',
      preAllocatedVUs: 200,
      maxVUs: 500,
    },
  },
};
```

### line — линейный рост {#profile-line}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {duration: 180s, type: line, from: 1, to: 10000}
```

k6:

```javascript
export const options = {
  scenarios: {
    ramp_up: {
      executor: 'ramping-arrival-rate',
      startRate: 1,
      timeUnit: '1s',
      preAllocatedVUs: 200,
      maxVUs: 500,
      stages: [
        { duration: '3m', target: 10000 },
      ],
    },
  },
};
```

### step — ступенчатый рост {#profile-step}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {duration: 30s, type: step, from: 10, to: 100, step: 5}
```

k6 — эквивалент через несколько стадий. В исходном профиле 18 ступеней (от 10 до 100 с шагом 5) за 30 секунд — примерно 1,7 с на ступень:

```javascript
export const options = {
  scenarios: {
    stepped_load: {
      executor: 'ramping-arrival-rate',
      startRate: 10,
      timeUnit: '1s',
      preAllocatedVUs: 50,
      maxVUs: 200,
      stages: [
        { duration: '1.7s', target: 15 },
        { duration: '1.7s', target: 20 },
        { duration: '1.7s', target: 25 },
        { duration: '1.7s', target: 30 },
        { duration: '1.7s', target: 35 },
        { duration: '1.7s', target: 40 },
        { duration: '1.7s', target: 45 },
        { duration: '1.7s', target: 50 },
        { duration: '1.7s', target: 55 },
        { duration: '1.7s', target: 60 },
        { duration: '1.7s', target: 65 },
        { duration: '1.7s', target: 70 },
        { duration: '1.7s', target: 75 },
        { duration: '1.7s', target: 80 },
        { duration: '1.7s', target: 85 },
        { duration: '1.7s', target: 90 },
        { duration: '1.7s', target: 95 },
        { duration: '1.7s', target: 100 },
      ],
    },
  },
};
```

### once — единоразовый всплеск {#profile-once}

{{ load-testing-name }}:

```yaml
load_profile:
  load_type: rps
  schedule:
    - {type: once, times: 133}
```

k6:

```javascript
export const options = {
  scenarios: {
    burst: {
      executor: 'shared-iterations',
      vus: 133,
      iterations: 133,
    },
  },
};
```

## Перенесите тестовые данные и сценарии {#test-data}

### HTTP-запросы {#http}

Если ваши тесты использовали формат URI или HTTP_JSON, перенесите запросы в скрипт k6:

```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export default function () {
  // GET-запрос
  const res = http.get('https://my-app.example.com/api/items');
  check(res, {
    'статус 200': (r) => r.status === 200,
  });

  // POST-запрос
  const payload = JSON.stringify({ title: 'Новая задача', completed: false });
  const params = { headers: { 'Content-Type': 'application/json' } };
  const postRes = http.post('https://my-app.example.com/api/items', payload, params);
  check(postRes, {
    'создано': (r) => r.status === 201,
  });

  sleep(1);
}
```

### gRPC-запросы {#grpc}

Если вы тестировали gRPC-сервисы через Pandora с форматом GRPC_JSON, в k6 используйте встроенный модуль `k6/net/grpc`.

{{ load-testing-name }} (формат GRPC_JSON):

```json
{"tag": "/api.Adder/Add", "call": "api.Adder.Add", "metadata": {"Authorization": ["Bearer ..."]}, "payload": {"x": 21, "y": 12}}
```

k6:

```javascript
import grpc from 'k6/net/grpc';
import { check } from 'k6';

const client = new grpc.Client();
client.load(['proto'], 'adder.proto');

export default () => {
  if (__ITER === 0) {
    client.connect('my-grpc-service.example.com:8080', { plaintext: true });
  }

  const response = client.invoke('api.Adder/Add', { x: 21, y: 12 }, {
    metadata: { authorization: 'Bearer ...' },
  });

  check(response, {
    'статус OK': (r) => r.status === grpc.StatusOK,
  });

};
```

### Данные из файлов {#data-from-files}

Если тестовые данные хранились в {{ objstorage-name }}, загрузите их локально и используйте в скрипте через `SharedArray`:

```javascript
import http from 'k6/http';
import { SharedArray } from 'k6/data';

const data = new SharedArray('urls', function () {
  return JSON.parse(open('./test-data.json'));
});

export default function () {
  const item = data[Math.floor(Math.random() * data.length)];
  http.get(item.url);
}
```

## Настройте автостоп {#autostop}

В {{ load-testing-name }} автостоп прерывал тест при нарушении заданных условий. В k6 аналогичную функцию выполняют [пороговые значения (thresholds)](https://grafana.com/docs/k6/latest/using-k6/thresholds/) с параметром `abortOnFail`.

### Остановка по времени ответа {#autostop-time}

{{ load-testing-name }}:

```yaml
autostop:
  - time(1s, 30s)
```

k6 — используйте высокий квантиль (например, p(99)), чтобы приблизиться к поведению оригинала, где проверяется время каждого запроса:

```javascript
export const options = {
  thresholds: {
    http_req_duration: [
      { threshold: 'p(99)<1000', abortOnFail: true, delayAbortEval: '30s' },
    ],
  },
};
```

### Остановка по HTTP-кодам {#autostop-http}

{{ load-testing-name }}:

```yaml
autostop:
  - http(5xx, 10%, 30s)
```

Встроенная метрика `http_req_failed` учитывает все ответы с кодом >= `400` (`4xx` и `5xx`). Чтобы отслеживать только `5xx`, создайте кастомную метрику:

```javascript
import http from 'k6/http';
import { Rate } from 'k6/metrics';

const errors5xx = new Rate('errors_5xx');

export const options = {
  thresholds: {
    errors_5xx: [
      { threshold: 'rate<0.1', abortOnFail: true, delayAbortEval: '30s' },
    ],
  },
};

export default function () {
const res = http.get('https://my-app.example.com/api/endpoint');
errors5xx.add(res.status >= 500);
}
```

### Остановка по квантилям {#autostop-quantile}

{{ load-testing-name }}:

```yaml
autostop:
  - quantile(95, 100ms, 10s)
```

k6:

```javascript
export const options = {
  thresholds: {
    http_req_duration: [
      { threshold: 'p(95)<100', abortOnFail: true, delayAbortEval: '10s' },
    ],
  },
};
```

### Ограничение по времени {#autostop-limit}

{{ load-testing-name }}:

```yaml
autostop:
  - limit(10m)
```

k6 — задается через `duration` в параметрах сценария:

```javascript
export const options = {
  scenarios: {
    default: {
      executor: 'constant-vus',
      vus: 50,
      duration: '10m',
    },
  },
};
```

## Настройте визуализацию результатов {#test-results}

### Встроенный вывод {#builtin-output}

По завершении теста k6 выводит сводку с основными метриками в терминал:

* `http_req_duration` — время ответа (avg, min, med, max, p90, p95);
* `http_req_failed` — доля неуспешных запросов;
* `http_reqs` — общее количество запросов и RPS;
* `iterations` — количество выполненных итераций;
* `vus` — количество виртуальных пользователей.

### Экспорт в JSON {#json-output}

Чтобы сохранить детальные результаты, выполните команду:

```bash
k6 run --out json=results.json test.js
```

### Визуализация в Grafana {#grafana}

Для получения графиков, аналогичных тем, что предоставлял {{ load-testing-name }} (квантили времени ответа, коды ответов, RPS), настройте экспорт метрик в одну из поддерживаемых систем.

**InfluxDB v1 + Grafana:**

```bash
k6 run --out influxdb=http://localhost:8086/k6 test.js
```

{% note warning %}

Встроенный вывод `--out influxdb` поддерживает только InfluxDB v1. Для InfluxDB v2 используйте расширение [xk6-output-influxdb](https://github.com/grafana/xk6-output-influxdb).

{% endnote %}

Используйте готовый [дашборд для k6](https://grafana.com/grafana/dashboards/2587-k6-load-testing-results/) в Grafana. Он включает графики:

* квантили времени ответа (аналог графика «Квантили» в {{ load-testing-name }});
* количество виртуальных пользователей (аналог «Тестирующие потоки»);
* HTTP-коды ответов;
* RPS.

**Prometheus + Grafana:**

```bash
K6_PROMETHEUS_RW_SERVER_URL=http://localhost:9090/api/v1/write \
  k6 run -o experimental-prometheus-rw test.js
```

## Настройте регрессионный анализ {#regression}

В {{ load-testing-name }} дашборды регрессий позволяли отслеживать деградацию показателей от запуска к запуску. В k6 аналогичный результат достигается двумя способами.

### Thresholds в CI/CD {#regression-ci}

Задайте пороговые значения в скрипте — k6 завершится с ненулевым кодом возврата при их нарушении:

```javascript
export const options = {
  thresholds: {
    http_req_duration: ['p(95)<200', 'p(99)<500'],
    http_req_failed: ['rate<0.01'],
  },
};
```

В CI/CD-пайплайне проверяйте код возврата k6:

```yaml
load-test:
  script:
    - k6 run test.js
  # При нарушении порогов задание упадет автоматически
```

### Хранение истории в Grafana {#regression-grafana}

При экспорте результатов в InfluxDB или Prometheus история всех запусков сохраняется автоматически. Настройте в Grafana:

1. Дашборд с графиками ключевых метрик (p95, p99, RPS, процент ошибок).
1. [Алерты](https://grafana.com/docs/grafana/latest/alerting/) на превышение пороговых значений.
1. Аннотации для отметки моментов запуска тестов.

Это обеспечит наглядное отслеживание тренда производительности, аналогичное дашбордам регрессий {{ load-testing-name }}.

## Настройте мониторинг ресурсов генератора {#monitoring}

В {{ load-testing-name }} мониторинг агента (CPU, память, диск, сеть) был встроен в сервис. При использовании k6 для мониторинга машины-генератора используйте стандартные средства:

* **Telegraf + Grafana** — если мониторинг уже настроен, данные продолжат собираться.
* **{{ monitoring-name }}** — если генератор работает на виртуальной машине {{ compute-name }}, метрики ВМ доступны в {{ monitoring-name }} без дополнительной настройки.
* **node_exporter + Prometheus** — стандартный подход для мониторинга Linux-машин.

## Настройте запуск в CI/CD {#cicd}

k6 легко встраивается в любой CI/CD-пайплайн.

Пример для GitLab CI:

```yaml
load-test:
  stage: test
  image: grafana/k6
  script:
    - k6 run
        -u ${K6_VUS:-50}
        -d ${K6_DURATION:-5m}
        --env BASE_URL="${BASE_URL}"
        test.js
  artifacts:
    paths:
      -load-performance.json
```

Для сохранения результатов в файл используйте функцию `handleSummary()` в скрипте:

```javascript
export function handleSummary(data) {
  return {
    'load-performance.json': JSON.stringify(data, null, 2),
  };
}
```

Пример для GitHub Actions:

```yaml
- name: Нагрузочное тестирование
  uses: grafana/k6-action@v0.3.1
  with:
    filename: test.js
    flags: -u 50 -d 5m
```

## Что дальше {#whats-next}

* [Документация k6](https://grafana.com/docs/k6/latest/) — полное руководство по возможностям инструмента.
* [Примеры скриптов k6](https://github.com/grafana/k6/tree/master/examples) — готовые сценарии для различных протоколов.
* [k6 Extensions](https://grafana.com/docs/k6/latest/extensions/) — расширения для поддержки дополнительных протоколов (SQL, Kafka, Redis и других).
* [Grafana Cloud k6](https://grafana.com/products/cloud/k6/) — управляемый сервис для запуска k6 с визуализацией и хранением результатов.
