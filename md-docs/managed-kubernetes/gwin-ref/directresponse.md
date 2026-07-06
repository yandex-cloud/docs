[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > Инструменты Application Load Balancer > Gwin > Конфигурация ресурсов (англ.) > DirectResponse

# DirectResponse

DirectResponse is a Gwin custom resource that instructs the load balancer to return a fixed HTTP response directly to the client, without forwarding the request to any backend service.

It is referenced from an [HTTPRoute](httproute.md) rule via an `ExtensionRef` filter. This makes it conceptually similar to `RequestRedirect` — both are terminal route actions that short-circuit normal backend routing.

Typical use cases: returning `404 Not Found` for unknown paths, `503 Service Unavailable` during maintenance, or any other static response.

* [Cheatsheet](#cheatsheet)
* [DirectResponseSpec](#directresponsespec)
  * [DirectResponseBody](#directresponsebody)

## Cheatsheet

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: DirectResponse
metadata:
  name: not-found-response
  namespace: example-ns
spec:
  responseCode: 404          # HTTP status code to return
  responseBody:
    text: "Path not found"   # optional plain-text body
```

Reference from an HTTPRoute rule via `ExtensionRef` filter:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: example-route
  namespace: example-ns
spec:
  parentRefs:
    - name: example-gateway
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /unknown
      filters:
        - type: ExtensionRef
          extensionRef:
            group: gwin.yandex.cloud
            kind: DirectResponse
            name: not-found-response  # must be in the same namespace as the HTTPRoute
```

{% note info %}

A rule that uses a `DirectResponse` filter must not include `backendRefs` — the direct response replaces normal backend routing entirely.

{% endnote %}

| Field | Description |
|-------|-------------|
| metadata | **ObjectMeta** <br> Standard Kubernetes metadata. |
| spec | **[DirectResponseSpec](#directresponsespec)** <br> Direct response specification. |

## DirectResponseSpec

DirectResponseSpec defines the HTTP response to be returned to the client.

*Appears in*: [DirectResponse](#directresponse)

| Field | Description |
|-------|-------------|
| responseCode | **integer** <br> HTTP status code to return. <br> Example: `404`, `503`. |
| responseBody | **[DirectResponseBody](#directresponsebody)** <br> Optional response body. If omitted, the response has an empty body. |

### DirectResponseBody

DirectResponseBody defines the plain-text content of the response body.

*Appears in*: [DirectResponseSpec](#directresponsespec)

| Field | Description |
|-------|-------------|
| text | **string** <br> Plain-text body content. <br> Example: `Path not found` |