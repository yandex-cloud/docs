# Мониторинг

On-premises Yandex Object Storage предоставляет комплексную систему мониторинга для наблюдения за состоянием всех компонентов хранилища. Мониторинг реализован на базе Grafana с хранением метрик и логов непосредственно в S3.

Чтобы перейти в Grafana:

{% list tabs group=instructions %}

- Графический интерфейс {#console}

  1. На левой панели перейдите в раздел ![image](../_assets/console-icons/display-pulse.svg) **Статус**.
  1. Найдите и нажмите ссылку для перехода в Grafana

{% endlist %}


## Мониторинг кластера метаданных {#metadata-cluster-monitoring}

Для мониторинга кластеров метаданных на базе PostgreSQL используется дашборд **CloudNativePG** в Grafana. На нем собраны метрики по всем кластерам:

* `s3-background` — фоновые операции.
* `s3-db` — хранилище метаданных объектов, загруженных S3.
* `s3-meta` — метаданные кластера S3.

Дашборд предоставляет набор приборов для наблюдения за состоянием и производительностью кластеров метаданных.


## Мониторинг серверов и дисков {#hardware-monitoring}

Общее состояние оборудования доступно в консоли администрирования.

![hardware-status](../_assets/monitoring/hardware-status.png)


### Статусы нод {#nodes-status}

Диаграмма с нодами отображает состояние всех нод кластера:

* **Зеленый** — все компоненты работают корректно.
* **Желтый** — на ноде обнаружены критичные ошибки с оборудованием, требуется вмешательство администратора.
* **Красный** — нода не работает или отсутствует связность с кластером.


### Статусы дисков {#disks-status}

Диаграмма с дисками отображает состояние дисков в кластере:

* **Зеленый** — диск работает корректно.
* **Желтый** — с диском есть проблемы, автоматика пытается вернуть диск в работу или подготавливает его к замене.
* **Красный** — диск требует замены.

Подробнее о замене дисков см. в документации по обслуживанию.


### Метрики потребления ресурсов {#consumption-metrics}

В консоли отображаются следующие метрики:

* Потребление CPU — `cpu`.
* Потребление памяти — `mem`.
* Потребление сети — `net`.
* Потребление квоты хранилища.
* Использование физического места хранилища.


### Дашборд Autoadmin {#autoadmin}

В Grafana доступен дашборд с теми же проверками Autoadmin.

![autoadmin](../_assets/monitoring/autoadmin.png)


## Журналы аудита {#audit-logs}

Access-логи S3 API собираются отдельным кластером Loki и хранятся в системном бакете S3.

Бакет называется `loki-chunks`. За потреблением места можно следить в Grafana.

![loki-chunks](../_assets/monitoring/loki-chunks.png)

Время хранения (TTL) для этих логов составляет 30 дней.

Прочитать логи можно через внутреннюю Grafana. Приложение называется **Loki-Access**.

![loki-access](../_assets/monitoring/loki-access.png)

{% cut "Пример записи" %}

```json
{
  "ts": "2026-02-26T17:50:08+03:00",
  "status": "200",
  "protocol": "HTTP/1.1",
  "method": "GET",
  "request": "/fake/d2e6ac9d********/19c99ece310:19c9a5afaa9:********",
  "referer": "",
  "cookies": "",
  "user_agent": "aws-sdk-go/1.55.5 (go1.23.4; linux; amd64)",
  "vhost": "loki-chunks.goose-proxy.s3-goose-proxy.svc.cluster.local",
  "ip": "fcff:0:6399:1:4767:bf83:****:****",
  "x_forwarded_for": "",
  "x_real_ip": "",
  "request_id": "985bdac7********",
  "args": "",
  "scheme": "http",
  "port": "80",
  "ssl_handshake_time": "",
  "ssl_protocol": "",
  "upstream_cache_status": "",
  "upstream_addr": "127.0.0.1:3344",
  "upstream_status": "200",
  "http_y_service": "",
  "tcpinfo_rtt": "155",
  "tcpinfo_rttvar": "47",
  "tcpinfo_snd_cwnd": "10",
  "tcpinfo_rcv_space": "56716",
  "tcpinfo_lost": "0",
  "tcpinfo_retrans": "0",
  "tcpinfo_retransmits": "0",
  "tcpinfo_total_retrans": "0",
  "origin": "",
  "x_s3_storage_class": "STANDARD",
  "x_s3_shard_id": "3",
  "x_s3_chunk_id": "4",
  "x_s3_handler": "GET Object",
  "x_s3_cloud_id": "895",
  "x_s3_folder_id": "895",
  "x_s3_requester": "uid:1",
  "x_s3_access_key": "MntgxiIJHwkp********",
  "x_s3_bucket": "loki-chunks",
  "x_s3_bucket_tags": "",
  "x_s3_object_key": "fake/d2e6ac9d********/19c99ece310:19c9a5afaa9:********",
  "x_s3_version_id": "",
  "x_yandex_yarl_limit": "",
  "elliptics_cache": "",
  "range": "",
  "request_completion": "OK",
  "bytes_received": "567",
  "bytes_sent": "33939",
  "content_length": "",
  "upstream_content_length": "33535",
  "upstream_response_time": "0.003",
  "request_time": "0.004"
}
```

{% endcut %}


## Экспорт метрик {#metrics-export}

Система предоставляет два эндпоинта для сбора метрик: _Federation_ и _Raw Prometheus_, сетевые адреса которых (IP и FQDN) определяются на этапе предварительного опросника перед инсталляцией.

### Federation {#federation-ednpoint}

Эндпоинт Federation предназначен для получения строго ограниченного и стабильного набора метрик, чьи имена сохраняются неизменными между версиями, а сами данные хранятся с обеспечением высокой отказоустойчивости.

Пример запроса:

```bash
curl -g 'http://10.0.0.***/federate?match[]={__name__="rps"}'
```

Текущий список метрик в Federation эндпонт:

* `active_multipart_count`
* `deleted_objects_count`
* `deleted_objects_size`
* `multipart_objects_count`
* `multipart_objects_size`
* `objects_parts_count`
* `objects_parts_size`
* `rps`
* `scrape_duration_seconds`
* `scrape_samples_post_metric_relabeling`
* `scrape_samples_scraped`
* `scrape_series_added`
* `simple_objects_count`
* `simple_objects_size`
* `target_info`
* `timings_bucket`
* `timings_count`
* `traffic`
* `up`
* `used_size`


### Raw Prometheus {#raw-prometheus-endpoint}

Эндпоинт Raw Prometheus предоставляет доступ ко всему массиву сырых данных. Следует учитывать, что состав и именование этих метрик могут меняться после обновлений ПО, а сами данные подвержены риску потери при авариях, ребилдах или операциях файловера.

Пример запроса:

```bash
curl -G "http://10.0.0.***/api/v1/query" \
  --data-urlencode "query=up"
```


## Журналы компонентов ПО {#component-logs}

Internal-логи S3 и других компонентов хранилища собираются отдельным кластером Loki и хранятся в отдельном экземпляре Minio.

Время хранения (TTL) для этих логов составляет 7 дней.

Прочитать логи можно через внутреннюю Grafana. Приложение называется **Loki-Internal**.