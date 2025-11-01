1. [Создайте](../../monitoring/operations/alert/create-channel.md) канал уведомлений, выбрав доступный [способ отправки](../../monitoring/operations/prometheus/alerting-rules.md#rule-processing).
1. Настройте [Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/), который отвечает за отправку уведомлений:

    1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
    1. Слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
    1. Выберите воркспейс {{ prometheus-name }}.
    1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.tab.alert-manager-key-value }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.upload-config }}** и загрузите файл [конфигурации](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) в формате `YAML`.

        {% cut "Пример файла конфигурации" %}

        ```yml
        global:
          resolve_timeout: 5m
        route:
          receiver: telegram
          routes:
            - receiver: "null"
              matchers:
                - severity="none"
              continue: false

        receivers:
          - name: telegram
            yandex_monitoring_configs:
              - channel_names:
                - "<имя канала уведомлений>"
          - name: "null"
            yandex_monitoring_configs:
              - channel_names: []
        ```

        {% endcut %}

1. Добавьте тестовое правило алертинга:

    ```bash
    cat <<EOF | kubectl apply -f -
    apiVersion: monitoring.coreos.com/v1                                                        
    kind: PrometheusRule
    metadata:
      labels:
        release: kube-prometheus-stack
      name: test
    spec:
      groups:
      - name: test
        rules:
          - alert: Test
            annotations:
              description: this is a test alert
              summary: test alert
            expr: vector(1)
            labels:
              severity: warning
    EOF
    ```

1. Дождитесь, пока в выбранный канал уведомлений придет алерт, или проверьте статус алерта в консоли управления:

    1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
    1. Слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
    1. Выберите воркспейс {{ prometheus-name }}.
    1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.tab.managing-rules }}**.
    1. Нажмите на имя тестового алерта.
    1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.alerts }}**.
    1. Убедитесь, что тестовый алерт перешел в состояние `FIRING`.