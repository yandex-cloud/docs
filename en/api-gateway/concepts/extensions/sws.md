# x-yc-apigateway:smartWebSecurity extension

`x-yc-apigateway:smartWebSecurity` protects the [API gateway](../../concepts/index.md) based on rules set in the [{{ sws-full-name }} security profile](../../../smartwebsecurity/concepts/profiles.md). You are not charged for blocked API gateway requests.

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}

| Parameter | Type | Description |
----|----|----
| `securityProfileId` | `string` | {{ sws-name }} [security profile](../../../smartwebsecurity/concepts/profiles.md) ID |

## Extension specification {#spec}

Specification example:

```yaml
openapi: "3.0.0"

x-yc-apigateway:
  smartWebSecurity:
    securityProfileId: fev6q4qqnn2q********

info:
  version: 1.0.0
  title: Protected pet store
  license:
    name: MIT
paths:
  /:
    get:
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "This pet store is protected by SWS!"
        http_code: 200
```
