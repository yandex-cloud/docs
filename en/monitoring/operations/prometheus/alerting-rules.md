---
title: How to use {{ prometheus-name }} alerting rules
description: In this tutorial, you will learn to create and edit {{ prometheus-name }} files which define the alerting rules.
---

# Alerting rules

{% include [alerting-rules-preview](../../../_includes/monitoring/alerting-rules-preview.md) %}

Alerting rules allow you to create PromQL based alerts and send notifications when they are triggered.

In {{ managed-prometheus-name }}, you can use your existing [recording rule](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules) and [alerting rule](https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/) files.

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

## Creating or replacing an alerting rule file {#create}

1. Encode the file contents as [Base64](https://en.wikipedia.org/wiki/Base64) [RFC 4648](https://www.ietf.org/rfc/rfc4648.txt):

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

1. Save the result as a JSON file:

    **body.json**

    ```json
    {
        "name": "alerting-rules",
        "content" : "Z3JvdXBzOgotIG5hbWU6IGV4YW1wbGUKICBydWxlczoKICAtIGFsZXJ0OiBIaW...CBsYXRlbmN5Cg=="
    }
    ```

1. Create or replace a recording rule file:

    ```bash
    export IAM_TOKEN=<IAM_token>

    curl -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@body.json"  \
        "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules"
    ```

For more information about rule calculating, see [{#T}](./recording-rules.md).

## Creating or replacing an alert manager configuration file {#alert-manager-create}

1. Create an RFC 4648 Base64 encoding of the file contents:

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