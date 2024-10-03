---
title: Filter expression language in {{ cloud-logging-full-name }}
description: You can filter log group records using the filter expression language. With the filter expression language, you can search records by one or more parameters and use comparison and boolean operations in the filters.
---

# Filter expression language

You can filter log group records using the filter expression language. With the filter expression language, you can:
* Search for records by [one](#parameters) or [multiple](#multiple-values) parameter values.
* Use the [comparison operators](#comparison-operations) and [logical operators](#multiple-conditions) in filters.

## How to set a filter {#how-to}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder containing your log group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
   1. Go to the **{{ ui-key.yacloud.logging.label_groups }}** tab.
   1. Click the row with the log group you want to filter.
   1. Go to the **{{ ui-key.yacloud.common.logs }}** tab.
   1. Set a filter and press **Enter**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To set a filter using the filter expression language, run the command:

   ```
   yc logging read --group-name=default --filter="<filter>"
   ```

   {% note info %}

   You can filter records using the `--filter` and other flags of the `yc logging read` command at the same time. This combines the conditions with the `AND` operator. For example, you can set a filter using the `--resource-types` flag and the `level` parameter of the `--filter` flag:


   ```
   yc logging read --group-name=default --resource-types=serverless.function --filter="level=INFO"
   ```

   This filter will output records with the `INFO` logging level sent in the previous hour by {{ sf-name }} functions.



   {% endnote %}

- API {#api}

   You can set a filter using the [LogReadingService/Read](../api-ref/grpc/log_reading_service.md#Read) gRPC API call.

{% endlist %}

#### Examples of filters {#examples}

>* Records whose messages contain `warning` or `error dialing endpoint`:
>   ```
>   message: warning "error dialing endpoint"
>   ```
>* Records created after June 8, 2023:
>   ```
>   timestamp > "2023-06-08T00:00:00Z"
>   ```
>* Records whose logging level is higher than or equal to `INFO`:
>   ```
>   level >= INFO
>   ```

## Filter parameters {#parameters}

| Parameter | Filter format | Description | Sample filter |
| --- | --- | --- | --- |
| `message` | ```parameter: "value"``` | Search for records whose messages have values specified. The `message` is the default parameter, so you can omit it in the request. | ```"Hello world!" Error Exception``` |
| `resource_type` | ```parameter: "value"```<br>```parameter <comparison operator> "value"``` | Search for records sent by resources of the specified type, such as functions. | ```resource_type = "serverless.function"``` |
| `resource_id` | ```parameter: "value"```<br>```parameter <comparison operator> "value"``` | Search for records sent by a service with the specified ID. | ```resource_id: "d4e155orh3nu********"``` |
| `json_payload` | ```parameter: "value"``` | Search for records with `json_payload` set to certain values. The search is done by text. | ```json_payload: "error"``` |
| `json_payload.<element>` | ```parameter: "value"```<br>```parameter <comparison operator> "value"``` | Search for records by `json_payload` elements. If the filter uses a comparison operator, the element can be a string, a number, or a Boolean value; otherwise, it can only be a string. You can omit the `json_payload` prefix if the tree root element does not match any of the parameters. Check if `json_payload` contains a certain element using the `EXISTS` operator, e.g., ```json_payload.result EXISTS```. This filter outputs records whose `json_payload` contains the `result` element. | ```json_payload.flag = FALSE``` |
| `timestamp` | ```parameter <comparison operator> "value"``` | Search for records created within the specified interval. | ```timestamp >= "2023-06-08T00:00:00Z"``` |
| `ingested_at` | ```parameter <comparison operator> "value"``` | Search for records delivered to the {{ cloud-logging-name }} system within the specified interval. | ```ingested_at = "2023-06-22T05:15:03Z"``` |
| `saved_at` | ```parameter <comparison operator> "value"``` | Search for records saved to the {{ cloud-logging-name }} database within the specified interval. | ```saved_at >= 1622198048``` |
| `level` | ```parameter <comparison operator> "value"``` | Search for records with the specified logging levels. Possible logging levels: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, and `FATAL`. | ```level >= WARN``` |
| `stream_name` | ```parameter <comparison operator> "value"``` | Search for records by custom log streams. | ```stream_name = input``` |
| `request_id` | ```parameter <comparison operator> "value"``` | Search for records by the request ID in `json_playload`. | ```request_id <= "145"``` |


### Parameter value requirements {#requirements}

It is not required to enclose a value in quotation marks if:
* It starts with a Latin letter and only contains Latin letters, numbers, and underscores.
* It is an unsigned integer.

`TRUE`, `FALSE`, `true`, and `false` are used for Boolean values. Enclose them in quotation marks to find them in the text.

Possible types of `timestamp`, `ingested_at`, and `saved_at` parameter values:
* A string in RFC3339 format:
   ```bash
   saved_at > "2023-05-28T15:20:31Z"
   ```
* Number of seconds after 00:00 1970-01-01:
   ```
   saved_at >= 1622198048
   ```

### Searching for occurrences {#multiple-values}

To filter records by multiple values of the same parameter, list the values one by one:
```
parameter: "value1" "value2" "value3"
```

For case-sensitive search, use the `:!` operator:
```
parameter:! "vAlUe1" "vaLuE2"
```

Search for boolean values and floating-point and fixed-point numbers works as search for substring matching across multiple strings.

## Comparison operators {#comparison-operations}

Apart from checking for an exact match, the filter expression language supports the following comparison operators:

* **Equal to**

    ```
    parameter = "value"
    ```

* **Not equal to**

    ```
    parameter <> "value"
    ```

* **Greater than**, **Less than**, **Less than or equal to**, and **Greater than or equal to**

    ```
    parameter > "value"
    parameter < "value"
    parameter >= "value"
    parameter <= "value"
    ```

Strings are compared in lexicographic order.

## Filters with multiple conditions {#multiple-conditions}

You can combine multiple conditions in a single filter using logical operators:

* `AND`: Conditions combined with the logical operator **AND** must be fulfilled simultaneously.

   For example:
   ```
   parameter1: "value1" AND parameter2: "value2"
   ```
   This request returns records with `parameter1` set to `value1` and `parameter2` set to `value2`.

* `OR`: If you use the logical operator **OR**, at least one of the conditions must be fulfilled.

   For example:
   ```
   parameter1: "value1" OR parameter2 > "value2"
   ```
   This request returns records that have at least one of the conditions met: `parameter1` is set to `value1` or `parameter2` is greater than `value2`.

* `NOT`: With the logical operator **NOT**, a condition that is inverse of the specified one must be fulfilled.

   For example:
   ```
   NOT parameter1: "value1"
   ```
   This request returns records with `parameter1` not equal to `value1`.

You can create complex filters by combining multiple operators in a single request:

```
parameter1: "value1" AND parameter2: "value2" OR parameter3: "value3"
```

## Computation order {#calculation-order}

* Search for occurrences, comparison operators, the `EXISTS` operator
* Logical `NOT`
* Logical `AND`
* Logical `OR`

You can change the order of computations using parentheses:

```
parameter1: "value1" AND (parameter2 = "value2" OR parameter3 < "value3")
```
