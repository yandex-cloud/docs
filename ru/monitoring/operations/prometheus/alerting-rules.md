---
title: Как использовать {{ prometheus-name }} Alerting Rules
description: Следуя данному руководству, вы сможете создавать и редактировать файлы {{ prometheus-name }} с правилами алертинга (alerting rules).
---

# Правила алертинга

{% include [alerting-rules-preview](../../../_includes/monitoring/alerting-rules-preview.md) %}

Правила алертинга позволяют создавать алерты на основе PromQL и отправлять уведомления об их срабатывании.

В {{ managed-prometheus-name }} вы можете использовать ваши существующие файлы с правилами записи ([recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules)) и правилами алертинга ([alerting rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/)).

Для описания правил поддерживаются все поля из [спецификации](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) YAML-файла. Поддерживается [шаблонизация](https://prometheus.io/docs/prometheus/latest/configuration/template_examples/) аннотаций с помощью переменных `$value` и `$labels`. Итерации и функции не поддерживаются.

В этом разделе описаны особенности работы с правилами алертинга и конфигурацией алерт-менеджера. Способы загрузки и работы с файлами см. в разделе [{#T}](./recording-rules.md).


## Алерт-менеджер

[Алерт-менеджер](https://prometheus.io/docs/alerting/latest/alertmanager/) — компонент в составе {{ prometheus-name }}, который отвечает за отправку уведомлений и настраивается отдельно от файлов правил. Вы можете использовать ваши существующие файлы [конфигурации](https://prometheus.io/docs/alerting/latest/configuration/).

Особенности обработки правил:

* Каналы уведомлений из файла конфигурации сопоставляются с [каналами уведомлений](../../concepts/alerting/notification-channel.md) в {{ monitoring-full-name }}, которые заданы в каталоге воркспейса.
* Поддерживается отправка в каналы [email](https://prometheus.io/docs/alerting/latest/configuration/#email_config) и [Telegram](https://prometheus.io/docs/alerting/latest/configuration/#telegram_config). Остальные каналы будут проигнорированы без уведомлений об ошибках. В будущем планируется поддержка всех каналов уведомлений, доступных в {{ monitoring-full-name }}.
* Канал выбирается согласно заданному типу, [динамическая маршрутизация](https://prometheus.io/docs/alerting/latest/configuration/#route) пока не поддерживается, но запланирована.
* Если в конфигурации нет каналов, соответствующих каналам в каталоге, файл не будет принят.

Вы можете использовать правила алертинга, не загружая файл конфигурации. В этом случае они будут рассчитываться и создавать метрики `ALERTS` и `ALERTS_FOR_STATE`, но отправки уведомлений по алертам не будет.

## Создать или заменить файл с правилами алертинга {#create}

1. Закодируйте содержимое файла в [Base64](https://en.wikipedia.org/wiki/Base64) согласно [RFC 4648](https://www.ietf.org/rfc/rfc4648.txt):

    ```bash
    cat alerting-rule.yaml

    # groups:
    #   - name: example
    #     rules:
    #     - record: example
    #       expr: up

    base64 -i recording-rule.yaml

    # Z3JvdXBzOgotIG5hbWU6IGV4YW1wbGUKICBydWxlczoKICAtIGFsZXJ0OiBIaW...CBsYXRlbmN5Cg==
    ```

1. Сохраните результат в JSON-файл:

    **body.json**

    ```json
    {
        "name": "alerting-rules",
        "content" : "Z3JvdXBzOgotIG5hbWU6IGV4YW1wbGUKICBydWxlczoKICAtIGFsZXJ0OiBIaW...CBsYXRlbmN5Cg=="
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

Подробнее о вычислении правил см. в разделе [{#T}](./recording-rules.md).

## Создать или заменить файл с конфигурацией алерт-менеджера {#alert-manager-create}

1. Закодируйте содержимое файла в Base64 согласно RFC 4648:

    ```bash
    cat alert-manager.yaml

    # receivers:
    #   - name: 'email'
    #     email_configs:
    #       - to: 'alerts@monitoring.org'
    #   - name: 'telegram'
    #     telegram_configs:
    #     - api_url: https://api.telegram.org

    base64 -i alert-manager.yaml

    # cmVjZWl2ZXJzOgogIC0gbmFtZTogJ2VtYWlsJwogICA...sOiBodHRwczovL2FwaS50ZWxlZ3JhbS5vcmcKCg==
    ```

1. Сохраните результат в JSON-файл:

    **body.json**

    ```json
    {
        "content" : "cmVjZWl2ZXJzOgogIC0gbmFtZTogJ2VtYWlsJwogICA...sOiBodHRwczovL2FwaS50ZWxlZ3JhbS5vcmcKCg=="
    }
    ```

1. Создайте или замените файл конфигурации:

    ```bash
    export IAM_TOKEN=<IAM-токен>

    curl -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@body.json"  \
        "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/alertmanager"
    ```

В случае успешного запроса будет возвращен HTTP-код `204`, иначе — текст ошибки. Файл, в котором не удалось найти ни одного соответствия текущим каналам уведомлений в каталоге, не будет принят.