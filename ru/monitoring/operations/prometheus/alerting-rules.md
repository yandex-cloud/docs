---
title: Как использовать {{ prometheus-name }} Alerting Rules
description: Следуя данному руководству, вы сможете создавать и редактировать файлы {{ prometheus-name }} с правилами алертинга (alerting rules).
---

# Правила алертинга

{{ managed-prometheus-name }} позволяет добавить правила вычисления алертов и отправлять уведомления об их срабатывании. 

Для использования алертинга:

* [Добавьте правила алертинга](#alerting-rule-add).
* [Настройте Alert Manager](#alert-manager-set) для обработки и доставки уведомлений.

В этом разделе описаны особенности работы с правилами алертинга и конфигурацией Alert Manager. Управление файлами см. в разделе [{#T}](./recording-rules.md).

Вы можете настраивать алертинг через [консоль управления]({{ link-console-main }}) или API.

## Предварительная настройка для работы с API {#api-set}

API представлен набором REST-ресурсов, которые находятся по адресу `https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules`. 

Чтобы начать выполнять запросы:

1. Установите [cURL](https://curl.haxx.se/).
1. [Аутентифицируйтесь](../../api-ref/authentication.md) в API.
1. [Создайте воркспейс](index.md#access) и скопируйте его идентификатор, чтобы использовать в адресе запросов.

## Добавление правил алертинга {#alerting-rule-add}

### Требования к правилам алертинга {#rule-requirements}

В {{ managed-prometheus-name }} можно использовать правила алертинга ([alerting rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/)) на основе PromQL, созданные для других ваших инсталляций {{ prometheus-name }}.

При описании правил учитывайте особенности:

* Поддерживаются все поля из [спецификации](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) YAML-файла.
* Поддерживается [шаблонизация](https://prometheus.io/docs/prometheus/latest/configuration/template_examples/) аннотаций с помощью переменных `$value` и `$labels`.
* Не поддерживаются итерации и функции.

### Пример файла с правилами алертинга {#alert-rule-example}

Чтобы проверить работу алертинга, скопируйте код ниже в файл `host-cpu-usage-alert.yml`.

```yaml
groups:
  - name: CPU_Usage_Alerts
    rules:
      - alert: HighCPUUsage
        expr: 100 * (1 - avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m]))) > 80
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High CPU usage detected on {{$labels.instance}}"
          description: "CPU usage on instance {{$labels.instance}} has been above 80% for the last 5 minutes."
```

В примере описано правило `CPU_Usage_Alerts` с алертом `HighCPUUsage`. Алерт срабатывает, когда загрузка процессора выше 80% сохраняется более 5 минут. Процент загрузки процессора вычисляется по формуле в поле `expr`.

Для алерта задана метка `severity: critical`, которая используется для маршрутизации каналов уведомлений. В конфигурации Alert Manager можно сопоставить каналам определенные метки, чтобы уведомления по разным алертам отправлялись в разные каналы.

### Добавление и замена файла с правилами алертинга {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На странице сервиса [{{ monitoring-name }}]({{ link-monitoring }}) слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
   1. Выберите или создайте воркспейс.
   1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.rules }}**.
   1. Если у вас еще нет загруженных файлов, нажмите **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}** и выберите файл `.yml` с правилами.
   1. Чтобы добавить еще один файл, нажмите **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}**.
   1. Чтобы заменить существующий файл, справа от него нажмите **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_replace }}**.

- API {#api}

   1. Создайте файл `host-cpu-usage-alert.yml` и закодируйте его содержимое в [Base64](https://en.wikipedia.org/wiki/Base64) согласно [RFC 4648](https://www.ietf.org/rfc/rfc4648.txt):

      ```bash
      # cat <<EOF > host-cpu-usage-alert.yml
      groups:
      - name: CPU_Usage_Alerts
      rules:
          - alert: HighCPUUsage
          expr: 100 * (1 - avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m]))) > 80
          for: 5m
          labels:
              severity: critical
          annotations:
              summary: "High CPU usage detected on {{$labels.instance}}"
              description: "CPU usage on instance {{$labels.instance}} has been above 80% for the last 5 minutes."
      EOF

      # base64 -iw0 host-cpu-usage-alert.yml
      Z3JvdXBzOgotIG5hbWU6I******
      ```

   1. Сохраните результат в JSON-файл:

       **body.json**

       ```json
       {
           "name": "host-cpu-usage-alert.yml",
           "content" : "Z3JvdXBzOgotIG5hbWU6I******"
       }
       ```

   1. Создайте или замените файл с правилами алертинга:

       ```bash
       export IAM_TOKEN=<IAM-токен>

       curl -X PUT \
           -H "Content-Type: application/json" \
           -H "Authorization: Bearer ${IAM_TOKEN}" \
           -d "@body.json"  \
           "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/rules"
       ```

{% endlist %}

После создания правил алертинга они будут вычисляться и создавать метрики `ALERTS` и `ALERTS_FOR_STATE`. Для отправки уведомлений настройте Alert Manager.

Следить за статусами алертов можно на отдельной вкладке **{{ prometheus-name }}** → **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.alerts }}** в [консоли управления]({{ link-monitoring }}).

Подробнее о действиях с файлами и вычислении правил см. в разделе [{#T}](./recording-rules.md).

## Настройка Alert Manager {#alert-manager-create}

[Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/) отвечает за отправку уведомлений и настраивается отдельно от правил алертинга. Для настройки можно использовать файлы [конфигурации](https://prometheus.io/docs/alerting/latest/configuration/), созданные для других ваших инсталляций {{ prometheus-name }}.

### Особенности настройки каналов уведомлений {#rule-processing}

* Каналы уведомлений из файла конфигурации сопоставляются с [каналами уведомлений](../../concepts/alerting/notification-channel.md) в {{ monitoring-full-name }}, которые заданы в каталоге воркспейса.
* Сейчас поддерживается отправка в каналы [Email](https://prometheus.io/docs/alerting/latest/configuration/#email_config), [Telegram](https://prometheus.io/docs/alerting/latest/configuration/#telegram_config), SMS и Push. Остальные каналы будут проигнорированы без уведомлений об ошибках.
* Канал выбирается согласно [правилам маршрутизации](https://prometheus.io/docs/alerting/latest/configuration/#route) в конфигурации Alert Manager, в секции `routes`. В правилах маршрутизации каналы сопоставляются меткам, заданным в правилах алертинга в секции `labels`. Например `severity: critical`.

### Пример файла конфигурации {#config-example}

В этом примере настроена отправка уведомлений в Telegram, Email, SMS и Push.

```yaml
global:
  resolve_timeout: 5m
# Маршрутизация и группировка алертов
route:
  # Получатель по умолчанию
  receiver: 'default-receiver'
  routes:
    # В этот канал отправляются уведомления по алертам с меткой severity="warning"
    - receiver: 'warning-receiver'
      matchers:
        - severity="warning"
    # В этот канал отправляются уведомления по алертам с меткой severity="critical"
    - receiver: 'critical-receiver'
      matchers:
        - severity="critical"

receivers:
# Получатель по умолчанию, в этот канал отправляются уведомления по алертам, для которых нет совпадений в секции routes
- name: 'default-receiver'
  yandex_monitoring_configs:
    # Каналы не указаны, алерты без меток не отправляются
    - channel_names: []
# Получатель для алертов с меткой severity="warning", вместо email укажите имя канала, заданного в каталоге воркспейса
- name: 'warning-receiver'
  yandex_monitoring_configs:
    - channel_names: [ 'email', 'push-channel' ]
# Получатель для алертов с меткой severity="critical", вместо telegram укажите имя канала, заданного в каталоге воркспейса
- name: 'critical-receiver'
  yandex_monitoring_configs:
    - channel_names: [ 'telegram', 'sms-channel' ]
```

Подробнее о настройке динамической маршрутизации уведомлений см. в [документации Prometheus](https://prometheus.io/docs/alerting/latest/configuration/#route).

### Добавление и замена файла конфигурации {#alert-manager-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На странице сервиса [{{ monitoring-name }}]({{ link-monitoring }}) слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
   1. Выберите или создайте воркспейс.
   1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.tab.alert-manager-key-value }}**.
   1. Если у вас еще нет загруженного файла конфигурации, нажмите кнопку **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.upload-config }}** и выберите файл `.yml`.
   1. Чтобы скачать файл, нажмите **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.config-action.download }}**.
   1. Чтобы заменить файл, нажмите **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.config-action.replace }}**. 

- API {#api}

   1. Сохраните конфигурацию в файл `alertmanager.yml` и закодируйте в [Base64](https://en.wikipedia.org/wiki/Base64) согласно [RFC 4648](https://www.ietf.org/rfc/rfc4648.txt):

       ```bash
        # cat <<EOF > alertmanager.yml
        global:
          resolve_timeout: 5m
        route:
          receiver: 'default-receiver'
          routes:
            - receiver: 'warning-receiver'
              matchers:
                - severity="warning"
            - receiver: 'critical-receiver'
              matchers:
                - severity="critical"

          receivers:
          - name: 'default-receiver'
            yandex_monitoring_configs:
              - channel_names: []
          - name: 'warning-receiver'
            yandex_monitoring_configs:
              - channel_names: [ 'email', 'push-channel' ]
          - name: 'critical-receiver'
            yandex_monitoring_configs:
              - channel_names: [ 'telegram', 'sms-channel' ]

        EOF

        # base64 -iw0 alertmanager.yml

        # Z2xvYmFsOgogIHJlc29sdmVfdGltZW91******
       ```

   1. Сохраните результат в JSON-файл:

       **alertmanager-body.json**

       ```json
       {
           "content" : "Z2xvYmFsOgogIHJlc29sdmVfdGltZW91******"
       }
       ```

   1. Создайте или замените файл конфигурации:

       ```bash
       export IAM_TOKEN=<IAM-токен>

       curl -X PUT \
           -H "Content-Type: application/json" \
           -H "Authorization: Bearer ${IAM_TOKEN}" \
           -d "@alertmanager-body.json"  \
           "https://monitoring.{{ api-host }}/prometheus/workspaces/<идентификатор_воркспейса>/extensions/v1/alertmanager"
       ```

   В случае успешного запроса будет возвращен HTTP-код `204`, иначе — текст ошибки. Файл, в котором не удалось найти ни одного соответствия текущим каналам уведомлений в каталоге, не будет принят.

{% endlist %}

## Просмотр алертов {#view-alerts}

Состояние алертов можно отслеживать в [консоли управления]({{ link-console-main }}). Вкладка **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.rules }}** показывает только правила вычисления алертов. Вкладка **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.alerts }}** отображает все алерты и их статусы.

Чтобы просмотреть алерты:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. На странице сервиса [{{ monitoring-name }}]({{ link-monitoring }}) слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
   1. Выберите или [создайте воркспейс](index.md#access).
   1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.alerts }}** и посмотрите списки правил с алертами.
   1. (Опционально) Настройте фильтрацию алертов по имени и статусу.

   Список статусов алертов:
     * `OK` — условие алерта не выполняется.
     * `PENDING` — условие алерта выполняется, но не прошло время из параметра `for`.
     * `FIRING` — условие алерта выполняется и прошло время из параметра `for`. Отправляются уведомления.
     * `ERROR` — ошибка при вычислении правила алерта.

{% endlist %}