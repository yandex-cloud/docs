---
title: "How to use Prometheus recording rules"
description: "In this tutorial, you will learn to create and edit Prometheus files that define recording rules."
---

# Recording rules

In {{ managed-prometheus-name }}, you can use your existing [recording rule](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/#recording-rules) files. It supports all the fields described in the YAML file [specification](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/).

{% note warning %}

The file name may contain lowercase Latin letters, numbers, hyphens, and underscores. The file may be up to 256 characters long. The group name may not be longer than 256 characters.

{% endnote %}

The API is represented by REST resources located at `https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules`. To start executing requests:
1. Specify the ID of your workspace in the URL. You can find the workspace ID in the {{ monitoring-name }} UI under **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
1. Install [cURL](https://curl.haxx.se/).
1. [Authenticate](../../api-ref/authentication.md) in the API.

## Creating or replacing a recording rule file {#create}

1. Create an RFC 4648 [Base64](https://en.wikipedia.org/wiki/Base64) encoding of the file contents:

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

    curl -X PUT \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@body.json"  \
        "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules"
    ```

If the request is successful, you will get the `204` HTTP code, if not, the error text.

If any rules or groups of rules are deleted when replacing a file, they will no longer be computed. All new rules and groups of rules will start to be computed.

## Getting a list of files {#list}

Run the following query:

```bash
export IAM_TOKEN=<IAM_token>

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
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

## Viewing the file contents {#get-content}

Run the following query:

```bash
export IAM_TOKEN=<IAM_token>

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules/recording-rules"
```

Response example:

```json
{
  "name": "recording-rules",
  "content": "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
}
```

## Viewing file computation status {#get-calculation-state}

You can get the computation status for any rule in all file groups by using the `snapshots` REST resource. Each snapshot contains information about the status, error, rule name, and computation time.

Run the following query:

```bash
export IAM_TOKEN=<IAM_token>

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
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

## Deleting a file {#delete}

Run the following query:

```bash
export IAM_TOKEN=<IAM_token>

curl -X DELETE \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/<workspace_ID>/extensions/v1/rules/recording-rules"
```

{% include [trademark](../../../_includes/monitoring/trademark.md) %}
