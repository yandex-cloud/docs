---
title: How to use Prometheus recording rules
description: In this guide, you will learn to create and edit Prometheus files that define recording rules.
---

# Recording rules

_Recording rules_ allow you to compute new values based on the obtained metrics and save them as time series. This helps to configure data analysis to meet your needs and optimize {{ managed-prometheus-name }} performance.

## Rule evaluation highlights {#rule-specific}

* {{ managed-prometheus-name }} uses a two-minute global evaluation delay to keep recording rules in sync with read query results. This means that the rules take effect two minutes after the data arrives. It allows all metrics collection agents to transmit the data before it is read by {{ managed-prometheus-name }} and recorded as a result of applying the recording rules.

* The default series limit for rule evaluation results is 1,000. The maximum limit value is 10,000.

## Requirements for recording rules {#rule-requirements}

In {{ prometheus-name }}, you can upload your custom files with [recording rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules). It supports all fields described in the YAML file [specification](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/).

{% note info %}

The file name can only contain Latin letters, numbers, dots, hyphens, and underscores. It may be up to 256 characters long. The group name may not be longer than 256 characters.

{% endnote %}

You can manage recording rule files via the [management console]({{ link-console-main }}) or API.

## Pre-configuration for using the API {#api-set}

The API consists of REST resources available at `https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules`. 

To start running requests:

1. Install [cURL](https://curl.haxx.se/).
1. [Authenticate](../../api-ref/authentication.md) with the API.
1. [Create a workspace](index.md#access) and copy its ID to then use it in the request address.

## Adding or replacing a recording rule file {#create}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select or create a workspace.
   1. Navigate to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab.
   1. If you have not uploaded any files yet, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}** and select a `.yml` file with rules.
   1. To add another file, click **{{ ui-key.yacloud_monitoring.prometheus.recording-rules.action_add-file }}**.
   1. To replace the existing file, click **![options](../../../_assets/horizontal-ellipsis.svg)** > **{{ ui-key.yacloud_monitoring.prometheus.common.action_replace }}** to its right. 

- API {#api}

   1. Encode the file contents to [Base64](https://en.wikipedia.org/wiki/Base64) as defined in RFC 4648:

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

If any rules or rule groups are deleted when replacing a file, they will no longer be evaluated. Evaluation will now cover all new rules and rule groups.

## Viewing a list of files {#list}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select a workspace.
   1. Navigate to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab. 

- API {#api}

   Run this request:

   ```bash
   export IAM_TOKEN=<IAM_token>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules"
   ```

   Here is a response example:

   ```json
   {
     "files": [
       "recording-rules"
     ]
   }
   ```

{% endlist %}

## Viewing file contents {#get-content}

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

   Here is a response example:

   ```json
   {
     "name": "recording-rules",
     "content": "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
   }
   ```

{% endlist %}

## Checking file evaluation status {#get-calculation-state}

{% list tabs group=instructions %}

- Management console {#console}

   1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}** on the left.
   1. Select a workspace.
   1. Go to the **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.recording-rules }}** tab. 
   1. Select the file with rules. On the page that opens, you will see the status of the latest evaluations for this rule.

- API {#api}

   You can get the evaluation info for any rule across all file groups by using the `snapshots` REST resource. Each snapshot contains information about the status, error, rule name, and evaluation time.

   Run this request:

   ```bash
   export IAM_TOKEN=<IAM_token>

   curl \
     --request GET \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules/recording-rules/snapshots"
   ```

   Here is a response example:

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
   * `NOT_EVALUATED_YET`: File is uploaded but evaluation has not started yet.
   * `OK`: Rule is successfully evaluated.
   * `LIMIT_EXCEEDED`: Number of time series returned by the rule exceeds the `limit` specified in the YAML file. Partial evaluation results are not saved for such rules.
   * `TIMEOUT`: Rule evaluation timed out.
   * `UNEXPECTED_RESULT_TYPE`: Unexpected evaluation result, e.g., a string.
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
