1. [Create](../../monitoring/operations/alert/create-channel.md) a notification channel by selecting an available [sending method](../../monitoring/operations/prometheus/alerting-rules.md#rule-processing).
1. Set up the [Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/) responsible for sending notifications:

    1. Open the {{ monitoring-name }} [home page]({{ link-monitoring }}).
    1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
    1. Select a {{ prometheus-name }} workspace.
    1. Navigate to the **{{ ui-key.yacloud_monitoring.prometheus.tab.alert-manager-key-value }}** tab.
    1. Click **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.upload-config }}** and upload the [configuration](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) file in `YAML` format.

        {% cut "Sample configuration file" %}

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
                - "<notification_channel_name>"
          - name: "null"
            yandex_monitoring_configs:
              - channel_names: []
        ```

        {% endcut %}

1. Add a test alerting rule:

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

1. Wait until you get alerted through the selected notification channel or check the alert status in the management console:

    1. Open the {{ monitoring-name }} [home page]({{ link-monitoring }}).
    1. Select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
    1. Select a {{ prometheus-name }} workspace.
    1. Navigate to the **{{ ui-key.yacloud_monitoring.prometheus.tab.managing-rules }}** tab.
    1. Click the test alert name.
    1. Navigate to the **{{ ui-key.yacloud_monitoring.prometheus.managing-rule.tabs.alerts }}** tab.
    1. Make sure the test alert status changed to `FIRING`.