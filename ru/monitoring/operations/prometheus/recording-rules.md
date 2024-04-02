---
title: "Как использовать Prometheus recording rules"
description: "Следуя данному руководству, вы сможете создавать и редактировать файлы Prometheus с правилами записи (recording rules)."
---

# Правила записи

Вы можете использовать ваши существующие файлы с правилами записи ([recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules)) в {{ managed-prometheus-name }}. Поддерживаются все поля, описанные в [спецификации](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) YAML-файла.

{% note warning %}

Имя файла может содержать только буквы латинского алфавита, цифры, точки, тире и нижние подчеркивания. Максимальная длина файла — 256 символов. Длина имени группы не может превышать 256 символов.

{% endnote %}

API представлен набором REST-ресурсов, которые находятся по адресу `https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules`. Чтобы начать выполнять запросы:
1. Укажите идентификатор вашего воркспейса в адресе. Идентификатор воркспейса можно посмотреть в пользовательском интерфейсе {{ monitoring-name }} на вкладке **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
1. Установите [cURL](https://curl.haxx.se/).
1. [Аутентифицируйтесь](../../api-ref/authentication.md) в API.

## Создать или заменить файл с правилами записи {#create}

1. Закодируйте содержимое файла в [Base64](https://en.wikipedia.org/wiki/Base64) согласно RFC 4648:

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

1. Сохраните результат в JSON-файл:

    **body.json**

    ```json
    {
        "name": "recording-rules",
        "content" : "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
    }
    ```

1. Создайте или замените файл с правилами записи:

    ```bash
    export IAM_TOKEN=<IAM-токен>

    curl -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@body.json"  \
        "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules"
    ```

В случае успешного запроса будет возвращен HTTP-код `204`, иначе — текст ошибки.

Если в результате замены файла были удалены правила или группы правил, они перестанут вычисляться. Все новые правила и группы правил начнут вычисляться.

## Получить список файлов {#list}

Выполните запрос:

```bash
export IAM_TOKEN=<IAM-токен>

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules"
```

Пример ответа:

```json
{
  "files": [
    "recording-rules"
  ]
}
```

## Посмотреть содержимое файла {#get-content}

Выполните запрос:

```bash
export IAM_TOKEN=<IAM-токен>

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules/recording-rules"
```

Пример ответа:

```json
{
  "name": "recording-rules",
  "content": "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
}
```

## Просмотреть состояние вычисления файла {#get-calculation-state}

Вычисление каждого правила во всех группах файла можно получить, используя REST-ресурс `snapshots`. Каждый снимок содержит информацию о статусе, ошибке, имени правила и о том, как долго оно вычислялось.

Выполните запрос:

```bash
export IAM_TOKEN=<IAM-токен>

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules/recording-rules/snapshots"
```

Пример ответа:

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
* `NOT_EVALUATED_YET` — файл загружен, но вычисление еще не началось.
* `OK` — успешное вычисление.
* `LIMIT_EXCEEDED` — правило вернуло больше временных рядов, чем разрешено в поле `limit` в YAML-файле. Для таких правил не сохраняется частичный результат вычислений.
* `TIMEOUT` — правило вычислялось слишком долго.
* `UNEXPECTED_RESULT_TYPE` — вычисление вернуло неожиданный результат, например строку.
* `UNKNOWN_ERROR` — общая ошибка, которая не может быть описана предыдущими состояниями.

## Удалить файл {#delete}

Выполните запрос:

```bash
export IAM_TOKEN=<IAM-токен>

curl -X DELETE \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules/recording-rules"
```

{% include [trademark](../../../_includes/monitoring/trademark.md) %}
