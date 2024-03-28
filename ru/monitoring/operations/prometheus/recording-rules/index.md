---
title: "Как использовать Prometheus recording rules"
description: "Следуя данному руководству, вы сможете создавать и редактировать файлы Prometheus recording rules."
---

# Recording rules


Вы можете использовать ваши существующие файлы с recording rules в {{ managed-prometheus-name }}. Поддерживаются все поля, описанные в [спецификации](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) YAML файла.

API представлен набором REST ресурсов, которые находятся под адресу `https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules`. Замените `$WORKSPACE` на ваш, чтобы начать выполнять запросы.


## Создать или заменить файл recording rules

Закодируйте содержимое файла в [Base64](https://en.wikipedia.org/wiki/Base64) согласно RFC 4648

```bash
cat recording-rule.yaml

# groups:
#   - name: example
#     rules:
#    - record: example
#       expr: up

base64 -i recording-rule.yaml

# Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA==
```

Сохраните результат в JSON файл

**body.json**
```json
{
    "name": "recording-rules",
    "content" : "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
}
```

Создайте или замените файл, используя cURL

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X PUT \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d "@body.json"  \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules"
```

В случае успешного запроса, будет возвращёт HTTP код 204. Иначе будет возвращён детальный текст ошибки.

С помощью этого метода можно как создавать файлы, так и редактировать их. Если в результате редактирования были удалены правила или группы, то они перестанут вычисляться. Все новые правила или группы начнут вычисляться.

## Получить список файлов

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules"
```

Пример ответа

```json
{
  "files": [
    "recording-rules"
  ]
}
```

{% endcut %}

## Просмотреть содержимое файла


```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules/recording-rules"
```


Пример ответа

```json
{
  "name": "recording-rules",
  "content": "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
}
```

## Просмотреть состояние вычисления файла

Вычисление каждого правила во всех группах файла может быть получено с использованием REST ресурса `/snapshots`. Каждый слепок содержит в себе информацию о статусе, ошибке, имени правила и о том, как долго оно вычислялось.

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules/recording-rules/snapshots"
```

Пример ответа

```json
{
  "snapshotByGroup": {
    "example": [
      {
        "state": "OK",
        "error": "",
        "evaluationTimeMs": 21,
        "evaluatedAtTimeEpochMs": 1710490243322,
        "record": "example"
      }
    ]
  }
}
```

Возможные состояния правила:
* `NOT_EVALUATED_YET` — файл был только что загружен, и вычисление ещё не началось
* `OK` — успешное вычисление
* `LIMIT_EXCEEDED` — правило вернуло больше временных рядов, чем разрешено в поле `limit` в YAML-определении файла. Для таких правил не сохраняется частичный результат вычислений
* `TIMEOUT` — правило вычислялось слишком долго
* `UNEXPECTED_RESULT_TYPE` — вычисление вернуло неожиданный результат (например, строчку)
* `UNKNOWN_ERROR` — общая ошибка, которая не может быть описана предыдущими состояниями


## Удалить файл recording rules

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X DELETE \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules/recording-rules"
```


{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
