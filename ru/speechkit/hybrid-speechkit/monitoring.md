# Мониторинг {{ sk-hybrid-name }} через Prometheus

Метрики {{ sk-hybrid-name }} доступны по URL `{$IP}:17002/metrics/prometheus`.

## Описание метрик {{ sk-hybrid-name }}

* `synthesis_sps` — Seconds per second — количество секунд синтезированного текста, которое генерируется за секунду работы.
* `synthesis_latency_bucket` — время ответа.
* `TYPE grpc_code_*` — коды ответов протокола gRPC. См. [документацию](https://grpc.github.io/grpc/core/md_doc_statuscodes.html).
