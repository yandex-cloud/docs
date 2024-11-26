---
title: How to use Prometheus recording rules
description: In this tutorial, you will learn to create and edit Prometheus files that define recording rules.
---

# Recording rules

_Recording rules_ allow you to compute new values based on the obtained metrics and save them as time series. This helps to configure data analysis to meet your needs and optimize {{ managed-prometheus-name }} performance.

## Rule computation highlights {#rule-specific}

* {{ managed-prometheus-name }} uses a global computation delay of 2 minutes to coordinate recording rules with the results of read requests. This means that the rules are applied two minutes after the data arrives. It allows all metrics collection agents to transmit the data before it is read by {{ managed-prometheus-name }} and recorded as a result of applying the recording rules.

* The default limit on the number of series as a result of rule computation is 1,000. The maximum limit value is 10,000.

## Requirements for recording rules {#rule-requirements}

In {{ prometheus-name }}, you can upload your existing files with [recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules). It supports all the fields described in the YAML file [specification](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/).

{% note info %}

The file name may contain lowercase Latin letters, numbers, hyphens, and underscores. The file may be up to 256 characters long. The group name may not be longer than 256 characters.

{% endnote %}

You can manage recording rule files via the [management console]({{ link-console-main }}) or API.

## Pre-configuring the service to work with the API {#api-set}

The API is represented by REST resources located at `https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules`. 

To start executing requests:

1. Install [cURL](https://curl.haxx.se/).
1. [Authenticate](../../api-ref/authentication.md) in the API.
1. [Create a workspace](index.md#access) and copy its ID to use it in the request address.

## Adding or replacing a recording rule file {#create}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select or create a workspace.
   1. Go to the **{{ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab.
   1. If you have not uploaded any files yet, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}** and select a `.yml` file with rules.
   1. To add another file, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}**.
   1. To replace an existing file, click **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_replace }}** to the right of it. 

- API {#api}

   1. Encode the file contents into [Base64](https://en.wikipedia.org/wiki/Base64) as defined in RFC 4648:

       ```bash
       cat recording-rule.yaml

       # groups:
       #   - name: example
       #     rules:
       #     - record: example
       #       expr: up

       base64 -i recording-rule.yaml

       # Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA==
       ```

   1. Save the result as a JSON file:

       **body.json**

       ```json
       {
           "name": "recording-rules",
           "content" : "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
       }
       ```

   1. Create or replace a recording rule file:

       ```bash
       export IAM_TOKEN=<IAM_token>

       curl \
         --request PUT \
         --header "Content-Type: application/json" \
         --header "Authorization: Bearer ${IAM_TOKEN}" \
         --data "@body.json" \
         "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules"
       ```

   If the request is successful, you will get the `204` HTTP code, if not, the error text.

{% endlist %}

If any rules or groups of rules are deleted when replacing a file, they will no longer be computed. All new rules and groups of rules will start to be computed.

## Viewing a list of files {#list}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab. 

- API {#api}

   Run this request:

   ```bash
   export IAM_TOKEN=<IAM_token>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules"
   ```

   Response example:

   ```json
   {
     "files": [
       "recording-rules"
     ]
   }
   ```

{% endlist %}

## Viewing the file contents {#get-content}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab. 
   1. To the right of the file, click **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_code }}**.

- API {#api}

   Run this request:

   ```bash
   export IAM_TOKEN=<IAM_token>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules/recording-rules"
   ```

   Response example:

   ```json
   {
     "name": "recording-rules",
     "content": "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
   }
   ```

{% endlist %}

## Viewing file computation status {#get-calculation-state}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab. 
   1. Select the file with rules. On the page that opens, you will see the state of the recent computations using this rule.

- API {#api}

   You can get the computation status for any rule in all file groups by using the `snapshots` REST resource. Each snapshot contains information about the status, error, rule name, and computation time.

   Run this request:

   ```bash
   export IAM_TOKEN=<IAM_token>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules/recording-rules/snapshots"
   ```

   Response example:

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

   Possible rule states:
   * `NOT_EVALUATED_YET`: File is uploaded but computation has not started yet.
   * `OK`: Computation successful.
   * `LIMIT_EXCEEDED`: Number of time series returned by the rule exceeds the `limit` specified in the YAML file. For such rules, partial computation result is not saved.
   * `TIMEOUT`: Rule computation timed out.
   * `UNEXPECTED_RESULT_TYPE`: Unexpected computation result, e.g., a string.
   * `UNKNOWN_ERROR`: Generic error not described by any of the above states.

{% endlist %}

## Deleting a file {#delete}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab. 
   1. To the right of the file, click **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_destroy }}**.

- API {#api}

   Run this request:

   ```bash
   export IAM_TOKEN=<IAM_token>

   curl \
     --request DELETE \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules/recording-rules"
   ```

{% endlist %}

## Downloading a file {#download}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab. 
   1. To the left of the file, click **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_download }}**.

{% endlist %}

{% include [trademark](../../../_includes/monitoring/trademark.md) %}
