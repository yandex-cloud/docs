---
editable: false
noIndex: true
---

# yc beta loadtesting report calculate-kpi-values

Returns a list of KPI values for tests matching the specified filter.

#### Command Usage

Syntax:

`yc beta loadtesting report calculate-kpi-values <FOLDER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--folder-id` | `string`

ID of the folder containing tests. ||
|| `--kpi` | `shorthand/json`

KPI to be calculated.

Shorthand Syntax:

```hcl
{
  selector = {
    kind = imbalance-rps={} | instances={
      agg = AGGREGATION_MIN|AGGREGATION_MAX|AGGREGATION_AVG|AGGREGATION_MEDIAN|AGGREGATION_STD_DEV
    } | network-codes-absolute={
      codes-patterns = string,...
    } | network-codes-relative={
      codes-patterns = string,...
    } | protocol-codes-absolute={
      codes-patterns = string,...
    } | protocol-codes-relative={
      codes-patterns = string,...
    } | response-time={
      quantile = QUANTILE_TYPE_50|QUANTILE_TYPE_75|QUANTILE_TYPE_80|QUANTILE_TYPE_85|QUANTILE_TYPE_90|QUANTILE_TYPE_95|QUANTILE_TYPE_98|QUANTILE_TYPE_99|QUANTILE_TYPE_100
    }
  },
  threshold = {
    comparison = COMPARISON_LT|COMPARISON_LTE|COMPARISON_GT|COMPARISON_GTE,
    value = float64
  }
}
```

JSON Syntax:

```json
{
  "selector": {
    "kind": {
      "imbalance-rps": {},
      "instances": {
        "agg": "AGGREGATION_MIN|AGGREGATION_MAX|AGGREGATION_AVG|AGGREGATION_MEDIAN|AGGREGATION_STD_DEV"
      },
      "network-codes-absolute": {
        "codes-patterns": [
          "string", ...
        ]
      },
      "network-codes-relative": {
        "codes-patterns": [
          "string", ...
        ]
      },
      "protocol-codes-absolute": {
        "codes-patterns": [
          "string", ...
        ]
      },
      "protocol-codes-relative": {
        "codes-patterns": [
          "string", ...
        ]
      },
      "response-time": {
        "quantile": "QUANTILE_TYPE_50|QUANTILE_TYPE_75|QUANTILE_TYPE_80|QUANTILE_TYPE_85|QUANTILE_TYPE_90|QUANTILE_TYPE_95|QUANTILE_TYPE_98|QUANTILE_TYPE_99|QUANTILE_TYPE_100"
      }
    }
  },
  "threshold": {
    "comparison": "COMPARISON_LT|COMPARISON_LTE|COMPARISON_GT|COMPARISON_GTE",
    "value": "float64"
  }
}
```

Fields:

```
selector -> (struct)
  Kind of KPI.
  kind -> (oneof<imbalance-rps|instances|network-codes-absolute|network-codes-relative|protocol-codes-absolute|protocol-codes-relative|response-time>)
    Oneof kind field
    response-time -> (struct)
      Response time cummulative quantile (percentile).
      quantile -> (struct)
        Cummulative quantile (percentile).
    instances -> (struct)
      A number of instances throughout the test.
      agg -> (struct)
        Aggregation function.
    imbalance-rps -> (struct)
      An RPS at the moment the test has been auto-stopped.
    protocol-codes-absolute -> (struct)
      A total number of requests completed with certain protocol (HTTP, GRPC, etc.) codes.
      codes-patterns -> ([]string)
        Protocol (HTTP, GRPC) code patterns to match. All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].
    protocol-codes-relative -> (struct)
      A percentage of requests completed with certain protocol (HTTP, GRPC, etc.) codes.
      codes-patterns -> ([]string)
        Protocol (HTTP, GRPC) code patterns to match. All successful HTTP responses: ['2xx', '3xx']. All failed HTTP responses: ['0', '4xx', '5xx'].
    network-codes-absolute -> (struct)
      A total number of requests completed with certain network codes.
      codes-patterns -> ([]string)
        Network code patterns to match. All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].
    network-codes-relative -> (struct)
      A percentage of requests completed with certain network codes.
      codes-patterns -> ([]string)
        Network code patterns to match. All successful network responses: ['0']. All failed network responses: ['xx', 'xxx'].
threshold -> (struct)
  A condition that should be specified.
  comparison -> (struct)
    Comparison operator for comparing actual with the threshold value. Rule: actual (</<=/>/>=) reference
  value -> (float64)
    Value for comparison with an actual KPI value.
``` ||
|| `--test-case` | `string`

Test case to calculate KPI values for. If not specified, KPI values will be calculated for 'overall' case. ||
|| `--test-filter` | `string`

Test filter selector to calculate KPI values for. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#