---
title: API Gateway specification extensions. Overview
description: 'The x-yc-apigateway extension allows you to set high-level API gateway parameters, the values of which will be inherited by nested extensions. The x-yc-apigateway-integration extension is the entry point for integrating the API gateway with other services. '
---

# Overview

## x-yc-apigateway extension {#top-level}

The `x-yc-apigateway` extension lets you set top-level API gateway parameters whose values will be inherited by nested extensions.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `service_account_id` | `string` | ID of the [service account](../../../iam/concepts/users/service-accounts.md) on behalf of which the API gateway will perform operations. |

### Extension specification {#tl-spec}

```(yaml)
x-yc-apigateway:
  service_account_id: <service account ID>
```

## x-yc-apigateway-integration extension {#integration}

The `x-yc-apigateway-integration` extension is the entry point for integrating the API gateway with other services.

### Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
| ---- | ---- | ---- |
| `type` | `string` | Extension type. Possible values: `dummy`, `cloud_functions`, `http`, and `object_storage`. |

### Extension specification {#intg-spec}

```
<Request>:
  <Method>:
    x-yc-apigateway-integration:
      type: <Type>
      <List of parameters as key:value pairs>
```

The extension's content changes depending on the type (`type`) specified in the `x-yc-apigateway-integration` section:

* [dummy](dummy.md): returns fixed content with the specified response code and required headers without any third-party service involved.
* [cloud_functions](cloud-functions.md): invokes the specified function, passes the HTTP request data to it as input, and returns the result of this function to the client.
* [http](http.md): redirects the request to the specified URL.
* [object_storage](object-storage.md): passes the request handling control to {{ objstorage-name }} for distributing static files.

All types support parameter substitution when all keys are replaced with the appropriate value. A key should be defined as a parameter of the corresponding operation (all types of parameters defined in the [OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification) are allowed: `path`, `query`, `header`, and `cookie`).
Parameters are only substituted in some values, depending on the type of extension.
