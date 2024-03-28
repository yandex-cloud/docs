---
title: "How to use Prometheus recording rules"
description: "Use this guide to learn how to upload and edit Prometheus recording rules."
---

# Recording rules


You can use your existing recording rules files with {{ managed-prometheus-name }}. All fields defined in YAML file [specification](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/) are supported.

API is a set of REST endpoints located at `https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules`. Replace `$WORKSPACE` with your own, to start making queries.


## Create or replate recording rules file

Encode file contents using [Base64](https://en.wikipedia.org/wiki/Base64) according to RFC 4648

```bash
cat recording-rule.yaml

# groups:
#   - name: example
#     rules:
#    - record: example
#       expr: up

base64 -i recording-rule.yaml

# Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA==
```

Paste resulting text to the JSON file

**body.json**
```json
{
    "name": "recording-rules",
    "content" : "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
}
```

Create or replace file using cURL

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X PUT \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d "@body.json"  \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules"
```

Succesful response will return HTTP code 204. Otherwise detailed error description will be returned.

This method can be used to either create file or update its content. If you remove some rules or groups from file content their evaluation will be stopped. Any new rules or groups will be evaluated.

## List uploaded files

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules"
```

Example response

```json
{
  "files": [
    "recording-rules"
  ]
}
```

{% endcut %}

## List file contents

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules/recording-rules"
```

Example response

```json
{
  "name": "recording-rules",
  "content": "Z3JvdXBzOgogIC0gbmFtZTogZXhhbXBsZQogICAgcnVsZXM6CiAgICAtIHJlY29yZDogZXhhbXBsZQogICAgICBleHByOiB1cA=="
}
```

## List rules evaluation results

Evaluation status of each rule in the group can be checked using `/snapshots` REST resource. Each rule evaluation snapshot contain information about its status, error message, which rule that is, and how long it took to evaluate it.

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X GET \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules/recording-rules/snapshots"
```

Example response

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

Possible evaluations states:
* `NOT_EVALUATED_YET` — rule was just uploaded and not evaluated
* `OK` — successful evaluation
* `LIMIT_EXCEEDED` — rule evaluation returned more series, than allowed by `limit` field in YAML definition. No partial result is stored for such evaluation
* `TIMEOUT` — rule took too long to evaluate
* `UNEXPECTED_RESULT_TYPE` — evaluation resulted in unexpected result type (for example, a string literal)
* `UNKNOWN_ERROR` — generic error, which cannot be defined using previous states


## Delete rules file

```bash
export IAM_TOKEN=CggaATEVAgA...

curl -X DELETE \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    "https://monitoring.{{ api-host }}/prometheus/workspaces/$WORKSPACE/extensions/v1/rules/recording-rules"
```

## Limits and validations

File name can consist only of symbols, that are not URL encoded: a-z, A-Z, 0-9, and dot (.), dash (-), underscore(_). Max length of file name is 256 symbols. Group names cannot be longer than 256 symbols.

{% include [trademark](../../../../_includes/monitoring/trademark.md) %}
