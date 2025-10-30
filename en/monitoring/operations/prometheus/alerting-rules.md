---
title: How to use {{ prometheus-name }} alerting rules
description: In this guide, you will learn to create and edit {{ prometheus-name }} files that define alerting rules.
sourcePath: en/monitoring_includes/operations/prometheus/alerting-rules.md
---

# Alerting rules

{{ managed-prometheus-name }} allows adding alerting rules and serving notifications when these rules trigger.

To use alerting:

* [Add alerting rules](#alerting-rule-add).
* [Set up Alert Manager](#alert-manager-set) to process and deliver notifications.

This section describes some aspects of alerting rules and Alert Manager configuration. For file management, see [{#T}](./recording-rules.md).

You can set up alerting via the [management console]({{ link-console-main }}) or API.

## Pre-configuration for using the API {#api-set}

The API consists of REST resources available at `https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules`. 

To start running requests:

1. Install [cURL](https://curl.haxx.se/).
1. [Authenticate](../../api-ref/authentication.md) with the API.
1. [Create a workspace](index.md#access) and copy its ID to then use it in the request address.

## Adding alerting rules {#alerting-rule-add}

### Requirements for alerting rules {#rule-requirements}

In {{ managed-prometheus-name }}, you can use PromQL-based [alerting rules](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) created for your other {{ prometheus-name }} installations.

When describing the rules, consider the following:

* All YAML file [specification](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) fields are supported.
* There is support for annotation [templating](https://prometheus.io/docs/prometheus/latest/configuration/template_examples/) through the `$value` and `$labels` variables.
* Iterations and functions are not supported.

### Alerting rule file example {#alert-rule-example}

To test alerting, copy the code below into the `host-cpu-usage-alert.yml` file:

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

This example describes the `CPU_Usage_Alerts` rule with the `HighCPUUsage` alert: The alert goes off when CPU usage remains above 80% for more than five minutes. CPU usage percentage is calculated by the formula in the `expr` field.

The alert comes with the `severity: critical` label, which is used to route notification channels. In the Alert Manager configuration, you can map specific labels with channels so that notifications for different alerts are sent to different channels.

### Adding or replacing an alerting rule file {#create}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select or create a workspace.
   1. Navigate to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab.
   1. If you have not uploaded any files yet, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}** and select a `.yml` file with rules.
   1. To add another file, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}**.
   1. To replace the existing file, click **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_replace }}** to its right.

- API {#api}

   1. Create a file named `host-cpu-usage-alert.yml` and encode its contents in [Base64](https://en.wikipedia.org/wiki/Base64) as per [RFC 4648](https://www.ietf.org/rfc/rfc4648.txt):

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

   1. Save the result as a JSON file:

       **body.json**

       ```json
       {
           "name": "host-cpu-usage-alert.yml",
           "content" : "Z3JvdXBzOgotIG5hbWU6I******"
       }
       ```

   1. Create or replace an alerting rule file:

       ```bash
       export IAM_TOKEN=<IAM_token>

       curl -X PUT \
           -H "Content-Type: application/json" \
           -H "Authorization: Bearer ${IAM_TOKEN}" \
           -d "@body.json"  \
           "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules"
       ```

Once you create the alerting rules, they will start to be computed to generate the `ALERTS` and `ALERTS_FOR_STATE` metrics. Set up Alert Manager to send notifications.

For more on file operations and rule computation, see [{#T}](./recording-rules.md).

{% endlist %}

## Setting up Alert Manager {#alert-manager-create}

[Alert Manager](https://prometheus.io/docs/alerting/latest/alertmanager/) is a notifications delivery component you set up separately from the alerting rules. For setup, you can use [configuration files](https://prometheus.io/docs/alerting/latest/configuration/) created for your other {{ prometheus-name }} installations.

### Notification channel settings {#rule-processing}

* Notification channels from the configuration file are mapped against the {{ monitoring-full-name }} [notification channels](../../concepts/alerting/notification-channel.md) specified in the workspace folder.
* Currently, only the [email](https://prometheus.io/docs/alerting/latest/configuration/#email_config), [Telegram](https://prometheus.io/docs/alerting/latest/configuration/#telegram_config), SMS, and push channels are supported. All other channels will be ignored without any error notifications.
* The channel is selected under the [routing rules](https://prometheus.io/docs/alerting/latest/configuration/#route) in the Alert Manager configuration, in the `routes` section. In the routing rules, channels are mapped to labels specified in the alerting rules in the `labels` section, e.g., `severity: critical`.

### Sample configuration file {#config-example}

This example is configured to send Telegram, email, SMS, and push notifications.

```yaml
global:
  resolve_timeout: 5m
# Routing and grouping alerts
route:
  # Default receiver
  receiver: 'default-receiver'
  routes:
    # Alert notifications with the following label are sent to this channel: severity="warning"
    - receiver: 'warning-receiver'
      matchers:
        - severity="warning"
    # Alert notifications with the following label are sent to this channel: severity="critical"
    - receiver: 'critical-receiver'
      matchers:
        - severity="critical"

receivers:
# Default receiver; this channel is used to send notifications for alerts that have no matches in the _routes_ section
- name: 'default-receiver'
  yandex_monitoring_configs:
    # Channels are not specified, alerts without labels are not sent
    - channel_names: []
# Receiver for alerts with the severity="warning" label; instead of an email, specify the name of the channel specified in the workspace folder
- name: 'warning-receiver'
  yandex_monitoring_configs:
    - channel_names: [ 'email', 'push-channel' ]
# Receiver for alerts with the severity="critical" label; instead of Telegram, specify the name of the channel specified in the workspace folder
- name: 'critical-receiver'
  yandex_monitoring_configs:
    - channel_names: [ 'telegram', 'sms-channel' ]
```

For more information on setting up dynamic notification routing, see [this Prometheus guide](https://prometheus.io/docs/alerting/latest/configuration/#route).

### Adding or replacing a configuration file {#alert-manager-create}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select or create a workspace.
   1. Navigate to the **{{ ui-key.yacloud_monitoring.prometheus.tab.alert-manager-key-value }}** tab.
   1. If you have no uploaded configuration files yet, click **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.upload-config }}** and select a `.yml` file.
   1. To download a file, click **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.config-action.download }}**.
   1. To replace a file, click **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.config-action.replace }}**. 

- API {#api}

   1. Save the configuration to the `alertmanager.yml` file and encode it in [Base64](https://en.wikipedia.org/wiki/Base64) as per [RFC 4648](https://www.ietf.org/rfc/rfc4648.txt):

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

   1. Save the result as a JSON file:

       **alertmanager-body.json**

       ```json
       {
           "content" : "Z2xvYmFsOgogIHJlc29sdmVfdGltZW91******"
       }
       ```

   1. Create or replace a configuration file:

       ```bash
       export IAM_TOKEN=<IAM_token>

       curl -X PUT \
           -H "Content-Type: application/json" \
           -H "Authorization: Bearer ${IAM_TOKEN}" \
           -d "@alertmanager-body.json"  \
           "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/alertmanager"
       ```

   If the request is successful, you will get the `204` HTTP code, if not, the error text. A file without a single match with current notification channels in the folder will not be accepted.

{% endlist %}