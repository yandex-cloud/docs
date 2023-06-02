# Мониторинг сервисов Envoy

Сервисы Envoy – это собирательное название компонентов {{ sk-hybrid-name }} Envoy и License server. Подробнее о компонентах {{ sk-hybrid-name }} см. в [{#T}](architecture.md).

Сервисы Envoy собирают и хранят метрики в формате Prometheus. Подробнее о типах метрик см. в [документации Prometheus](https://prometheus.io/docs/concepts/metric_types/).

## Метрики License server {#license-metrics}

Метрики License server доступны по URL-адресу:

```text
<IP-адрес>:<порт>
```

Где:

* `<IP-адрес>` — IP-адрес компонента License server {{ sk-hybrid-name }} в вашей сети.
* `<порт>` — порт Prometheus. По умолчанию используется порт `8003`, его можно изменить в настройках {{ sk-hybrid-name }}.

### Общие метрики {#metrics-common}

| Метрика                 | Тип       | Описание                                            | Метки                                                                                                                                                                                                                                                        |
|:------------------------|:----------|:----------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `active_services`       | GAUGE     | Количество работающих сервисов {{ sk-hybrid-name }} | `type`, тип сервиса: `stt` / `tts`.                                                                                                                                                                                                                          |
| `log4j2_appender_total` | COUNTER   | Количество логов с данным уровнем                   | `level`, [уровень логирования](operations/logging.md)                                                                                                                                                                                                        |
| `grpc_statuses`         | COUNTER   | Состояние работы GRPC-методов                       | `app` (приложение), `method` (GRPC-метод), `status` (статус запроса). Для отслеживания связи с Yandex Billing в метке `method` укажите значения `yandex.cloud.ds.billing.BillingService/Register`, `yandex.cloud.ds.billing.BillingService/SendBillingData`. |
| `grpc_durations`        | HISTOGRAM | Гистограмма времени обработки GRPC-запросов         | `app` (приложение), `method` (GRPC-метод), `status` (статус запроса).                                                                                                                                                                                        |
| `grpc_requests`         | GAUGE     | Различные метрики GRPC-запросов                     | `app` (приложение), `method` (GRPC-метод), `status` (статус запроса).                                                                                                                                                                                        |

### Метрики для модели лицензирования Cloud Billing {#metrics-cloud-billing}

| Метрика                                | Тип     | Описание                                                                       | Метки                                    |
|:---------------------------------------|:--------|:-------------------------------------------------------------------------------|:-----------------------------------------|
| `billing_agent_billing_units_sent`     | COUNTER | Количество отправленных биллинг-пакетов в Yandex Billing                       | `unit_type`, тип сервиса: `stt` / `tts`. |
| `billing_agent_requests_sent`          | COUNTER | Количество запросов, отправленных на сервер Cloud Billing {{ sk-hybrid-name }} |                                          |
| `billing_agent_entries_sent`           | COUNTER | Число отправленных записей биллинга                                            |                                          |
| `billing_agent_queue_size`             | GAUGE   | Текущий размер очереди Cloud Billing {{ sk-hybrid-name }}                      |                                          |
| `billing_agent_billing_units_received` | COUNTER | Количество биллинг-пакетов, полученных от сервисов `stt`/`tts`                 | `unit_type`, тип сервиса: `stt` / `tts`. |
| `billing_agent_last_entry_serial`      | GAUGE   | Серийный номер последней отправленной записи биллинга                          |                                          |
| `billing_agent_last_entry_unixtime`    | GAUGE   | Стандартное время Unix time последней отправленной записи биллинга             |                                          |

### Метрики для модели лицензирования Yubikey {#metrics-yubikey}

| Метрика              | Тип   | Описание                                                                 | Метки                                                                                                                                                 |
|:---------------------|:------|:-------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------|
| `license_active`     | GAUGE | Статус лицензии (значение `0` для неактивной лицензии, `1` для активной) |                                                                                                                                                       |
| `license_parameters` | GAUGE | Параметры лицензии                                                       | `type`, тип параметра: `max_stt_connections` – максимальное количество соединений к сервису `stt`; `max_tts_rps` – максимальный RPS для сервиса `tts` |

## Метрики Envoy {#envoy-metrics}

Для получения информации о состоянии сервиса Envoy доступен административный интерфейс по URL-адресу:

```text
<IP-адрес>:9091
```

Где:

* `<IP-адрес>` — IP-адрес сервиса Envoy {{ sk-hybrid-name }} в вашей сети.

Подробнее об интерфейсе см. в [документации Envoy](https://www.envoyproxy.io/docs/envoy/latest/operations/admin).

Метрики Envoy в формате Prometheus доступны через административный интерфейс по URL-адресу:

```text
<IP-адрес>:9091/stats/prometheus
```

{% note info %}

Чтобы получить только значимые метрики, которые менялись хотя бы однократно, используйте URL-адрес `<IP-адрес>:9091/stats?format=prometheus&usedonly`.

{% endnote %}

Информативные метрики Envoy для мониторинга {{ sk-hybrid-name }}:

* [Upstream-метрики](https://www.envoyproxy.io/docs/envoy/latest/configuration/upstream/cluster_manager/cluster_stats) коммуникации Envoy с кластерами сервисов `stt` / `tts`.
* [Downstream-метрики](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/stats) коммуникаций Envoy с внешними ресурсами. Например:

  | Метрика                        | Тип     | Описание                                                              | Метки                                                                                                |
  |:-------------------------------|:--------|:----------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------|
  | `downstream_cx_total`          | COUNTER | Количество HTTP-соединений за время работы сервиса                    | `envoy_http_conn_manager_prefix`                                                                     |
  | `downstream_cx_active`         | GAUGE   | Количество активных HTTP-соединений                                   | `envoy_cluster_name`, имя кластера: `upstream_stt`, `upstream_tts` для сервисов {{ sk-hybrid-name }} |
  | `downstream_cx_rx_bytes_total` | COUNTER | Количество полученной информации (в байтах) за время работы сервиса   | `envoy_http_conn_manager_prefix`                                                                     |
  | `downstream_cx_tx_bytes_total` | COUNTER | Количество отправленной информации (в байтах) за время работы сервиса | `envoy_http_conn_manager_prefix`                                                                     |
  | `downstream_rq_total`          | COUNTER | Количество отправленных запросов за время работы сервиса              | `envoy_http_conn_manager_prefix`                                                                     |
  | `downstream_rq_active`         | GAUGE   | Количество активных запросов                                          | `envoy_http_conn_manager_prefix`                                                                     |
