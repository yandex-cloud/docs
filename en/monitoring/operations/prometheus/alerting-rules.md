---
title: How to use {{ prometheus-name }} alerting rules
description: In this tutorial, you will learn to create and edit {{ prometheus-name }} files which define the alerting rules.
---

# Alerting rules

{% include [alerting-rules-preview](../../../_includes/monitoring/alerting-rules-preview.md) %}

With {{ managed-prometheus-name }} alerting, you can add alert calculation rules and send notifications when these are triggered. To configure alerting in {{ prometheus-name }}, you need to create alerting rules and set up the alert manager to process and deliver notifications.

## Requirements for alerting rules {#rule-requirements}

In {{ prometheus-name }}, you can use your existing PromQL-based [alerting rule](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) files.

For rules, it supports all the fields described in the YAML file [specification](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/). It also supports annotation [templates](https://prometheus.io/docs/prometheus/latest/configuration/template_examples/) using the `$value` and `$labels` variables. Iterations and functions are not supported.

This section describes some aspects related to alerting rules and the alert manager configuration. For how to upload and work with files, see [{#T}](./recording-rules.md).

## Alert manager

[Alert manager](https://prometheus.io/docs/alerting/latest/alertmanager/) is a {{ prometheus-name }} component responsible for sending notifications. It is configured separately from the rule files. You can use your existing [configuration](https://prometheus.io/docs/alerting/latest/configuration/) files.

Rule processing highlights:

* Notification channels from the configuration file are mapped against the {{ monitoring-full-name }} [notification channels](../../concepts/alerting/notification-channel.md) specified in the workspace folder.
* Notifications to the [email](https://prometheus.io/docs/alerting/latest/configuration/#email_config) and [Telegram](https://prometheus.io/docs/alerting/latest/configuration/#telegram_config) channels is supported. Other channels will be ignored without error notifications. There are plans to add support for all channels available in {{ monitoring-full-name }} later on.
* The channel is selected according to the specified type; [dynamic routing](https://prometheus.io/docs/alerting/latest/configuration/#route) is currently not supported but is planned for upcoming releases.
* If the configuration has no channels matching the folder channels, the file will not be accepted.

You can use alerting rules without loading a configuration file. In this case, the alerting rules will be calculated and will create the `ALERTS` and `ALERTS_FOR_STATE` metrics, but no alert notifications will be sent.

You can manage recording rule files via the [management console]({{ link-console-main }}) or API.

## Pre-configuration for using the API {#api-set}

The API is represented by REST resources located at `https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules`. 

To start executing requests:

1. Install [cURL](https://curl.haxx.se/).
1. [Authenticate](../../api-ref/authentication.md) in the API.
1. [Create a workspace](index.md#access) and copy its ID to use it in the request address.

## Adding or replacing an alerting rule file {#create}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select or create a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab.
   1. If you have not uploaded any files yet, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}** and select a `.yml` file with rules.
   1. To add another file, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}**.
   1. To replace the existing file, click **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_replace }}** to its right. 

- API {#api}

   1. Encode the file contents as [Base64](https://en.wikipedia.org/wiki/Base64) [RFC 4648](https://www.ietf.org/rfc/rfc4648.txt):

       ```bash
       cat alerting-rule.yaml

       # groups:
       #   - name: example
       #     rules:
       #     - alert: HighRequestLatency
       #       expr: job:request_latency_seconds:mean5m{job="myjob"} > 0.5
       #       for: 10m
       #       labels:
       #         severity: page
       #       annotations:
       #         summary: High request latency

       base64 -i alerting-rule.yaml

       # Z3JvdXBzOgotIG5hbWU6IGV4YW1wbGUKICBydWxlczoKICAtIGFsZXJ0OiBIaW...CBsYXRlbmN5Cg==
       ```

   1. Save the result as a JSON file:

       **body.json**

       ```json
       {
           "name": "alerting-rules",
           "content" : "Z3JvdXBzOgotIG5hbWU6IGV4YW1wbGUKICBydWxlczoKICAtIGFsZXJ0OiBIaW...CBsYXRlbmN5Cg=="
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

For more information about operations with files and computing rules, see [{#T}](./recording-rules.md).

{% endlist %}

## Adding or replacing an alert manager configuration file {#alert-manager-create}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select or create a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.tab.alert-manager-key-value }}** tab.
   1. If you have no uploaded configuration files yet, click **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.upload-config }}** and select a `.yml` file.
   1. To download the file, click **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.config-action.download }}**.
   1. To replace the file, click **{{ ui-key.yacloud_monitoring.prometheus.alert-manager.config-action.replace }}**. 

- API {#api}

   1. Encode the file contents as Base64 RFC 4648:

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

   1. Save the result as a JSON file:

       **body.json**

       ```json
       {
           "content" : "cmVjZWl2ZXJzOgogIC0gbmFtZTogJ2VtYWlsJwogICA...sOiBodHRwczovL2FwaS50ZWxlZ3JhbS5vcmcKCg=="
       }
       ```

   1. Create or replace a configuration file:

       ```bash
       export IAM_TOKEN=<IAM_token>

       curl -X PUT \
           -H "Content-Type: application/json" \
           -H "Authorization: Bearer ${IAM_TOKEN}" \
           -d "@body.json"  \
           "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/alertmanager"
       ```

   If the request is successful, you will get the `204` HTTP code, if not, the error text. A file without a single match with current notification channels in the folder will not be accepted.

{% endlist %}