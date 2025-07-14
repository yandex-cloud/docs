---
title: Viewing the execution log in {{ api-gw-full-name }}
description: You can view the execution log in {{ api-gw-full-name }} using the management console. To do this, select {{ api-gw-name }}, then select the API gateway for which you want to view the execution log. In the window that opens, go to **Logs** and specify the time period. The default time period is one hour. The execution log uses UTC time.
---

# Viewing the execution log in {{ api-gw-name }}

The execution log uses [UTC time](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Select the API gateway for which you want to view the execution log.
    1. In the window that opens, go to **{{ ui-key.yacloud.serverless-functions.gateways.item.switch_logs }}** and specify the time period. The default time period is one hour.

{% endlist %}

Each log event contains the `release` parameter set to `canary` if a request was handled by the canary release, and to `stable` if it was handled by the current release.

Learn more about working with logs in the [{{ cloud-logging-full-name }} documentation](../../logging/).

