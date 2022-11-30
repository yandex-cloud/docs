---
title: "Extensions of the {{ api-gw-name }} specification. Overview"
description: "The x-yc-apigateway extension lets you set top-level API gateway parameters whose values will be inherited by nested extensions. The x-yc-apigateway-integration extension is the entry point for integrating the API gateway with other services."
---

# Specification extensions{{ api-gw-name }}. Overview

## x-yc-apigateway extension {#top-level}

The `x-yc-apigateway` extension lets you set top-level API gateway parameters whose values will be inherited by nested extensions.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `service_account_id` | `string` | The ID of the [service account](../../../iam/concepts/users/service-accounts.md) on behalf of which the API gateway will perform operations. |

### Extension specification {#tl-spec}

```yaml
x-yc-apigateway:
  service_account_id: <ID of service account>
```

## x-yc-apigateway-integration extension {#integration}

The `x-yc-apigateway-integration` extension is the entry point for integrating the API gateway with other services.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `type` | `string` | Extension type. Legal values: `dummy`, `cloud_functions`, `http`, `object_storage`, `cloud_datasphere`, `cloud_datastreams`, and `serverless_containers`. |

### Extension specification {#intg-spec}

```
<Request>:
  <Method>:
    x-yc-apigateway-integration:
      type: <Type>
      <List of parameters as key:value pairs>
```

The extension's content changes depending on the `type` specified in the `x-yc-apigateway-integration` section:
* [dummy](dummy.md): Returns fixed content with the specified response code and required headers without any third-party service involved.
* [cloud-functions](cloud-functions.md): Invokes the specified function, passes it the HTTP request data as input, and returns this function's results to the client.
* [http](http.md): Redirects the request to the specified URL.
* [object_storage](object-storage.md): Passes request handling control to {{ objstorage-name }} to share static files.
* [cloud_datasphere](datasphere.md): Calls the specified {{ ml-platform-name }} node, passing it the request body with input variable values and returning the node output in the response body.
* [cloud_datastreams](datastreams.md): Accesses {{ yds-full-name }} to perform an operation with the specified stream.
* [serverless_containers](containers.md): Redirects a request to a specified container.
* [cloud_ymq](ymq.md): Accesses {{ message-queue-full-name }} to perform an operation with the specified queue.
* [cloud_ydb](ydb.md): Accesses {{ ydb-full-name }} to perform an operation with the specified [document tables](../../../ydb/concepts/dynamodb-tables.md).

All types support parameter substitution when all keys are replaced with the appropriate value. A key should be defined as a parameter of the corresponding operation (all types of parameters defined in the [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification) are allowed: `path`, `query`, `header`, and `cookie`).


Parameters are only substituted in some values, depending on the type of extension.
