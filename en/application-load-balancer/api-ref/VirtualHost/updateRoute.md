---
editable: false
apiPlayground:
  - url: https://alb.{{ api-host }}/apploadbalancer/v1/httpRouters/{httpRouterId}/virtualHosts/{virtualHostName}:updateRoute
    method: post
    path:
      type: object
      properties:
        httpRouterId:
          description: |-
            **string**
            Required field. ID of the HTTP router to update a route in.
            To get the HTTP router ID, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request.
          type: string
        virtualHostName:
          description: |-
            **string**
            Required field. Name of the virtual host to update a route in.
            To get the virtual host name, make a [VirtualHostService.List](/docs/application-load-balancer/api-ref/VirtualHost/list#List) request.
          type: string
      required:
        - httpRouterId
        - virtualHostName
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        routeName:
          description: |-
            **string**
            Required field. Name of the route to update.
            To get the route name, make a [VirtualHostService.Get](/docs/application-load-balancer/api-ref/VirtualHost/get#Get) request.
          type: string
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        http:
          description: |-
            **[HttpRoute](#yandex.cloud.apploadbalancer.v1.HttpRoute)**
            New settings of the HTTP route.
            Includes only one of the fields `http`, `grpc`.
            New settings of the route.
          $ref: '#/definitions/HttpRoute'
        grpc:
          description: |-
            **[GrpcRoute](#yandex.cloud.apploadbalancer.v1.GrpcRoute)**
            New settings of the gRPC route.
            Includes only one of the fields `http`, `grpc`.
            New settings of the route.
          $ref: '#/definitions/GrpcRoute'
        routeOptions:
          description: |-
            **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)**
            New route options for the route.
          $ref: '#/definitions/RouteOptions'
        disableSecurityProfile:
          description: |-
            **boolean**
            Whether set to 'true' disable security profile for the route.
          type: boolean
      required:
        - routeName
      additionalProperties: false
      oneOf:
        - required:
            - http
        - required:
            - grpc
    definitions:
      StringMatch:
        type: object
        properties:
          exactMatch:
            description: |-
              **string**
              Exact match string.
              Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.
              Match string for either exact or prefix match.
            type: string
          prefixMatch:
            description: |-
              **string**
              Prefix match string.
              Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.
              Match string for either exact or prefix match.
            type: string
          regexMatch:
            description: |-
              **string**
              Regular expression match string.
              Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.
              Match string for either exact or prefix match.
            type: string
        oneOf:
          - required:
              - exactMatch
          - required:
              - prefixMatch
          - required:
              - regexMatch
      HttpRouteHeaderMatch:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the HTTP Header to be matched.
            pattern: '[-0-9a-zA-Z]+'
            type: string
          value:
            description: |-
              **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**
              Value of HTTP Header to be matched.
            $ref: '#/definitions/StringMatch'
      HttpRouteQueryParamMatch:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the HTTP query parameter to be matched.
            pattern: '[-_0-9a-zA-Z]+'
            type: string
          value:
            description: |-
              **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**
              Value of HTTP query parameter to be matched.
            $ref: '#/definitions/StringMatch'
      HttpRouteMatch:
        type: object
        properties:
          httpMethod:
            description: |-
              **string**
              HTTP method specified in the request.
            type: array
            items:
              type: string
          path:
            description: |-
              **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**
              Match settings for the path specified in the request.
              If not specified, the route matches all paths.
            $ref: '#/definitions/StringMatch'
          headers:
            description: |-
              **[HttpRouteHeaderMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch)**
              Headers specify HTTP request header matchers. Multiple match values are
              ANDed together, meaning, a request must match all the specified headers
              to select the route. Headers must be unique.
            type: array
            items:
              $ref: '#/definitions/HttpRouteHeaderMatch'
          queryParameters:
            description: |-
              **[HttpRouteQueryParamMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch)**
              Query Parameters specify HTTP query parameter matchers. Multiple match
              values are ANDed together, meaning, a request must match all the
              specified query parameters to select the route. Query parameters must be unique.
            type: array
            items:
              $ref: '#/definitions/HttpRouteQueryParamMatch'
      Limit:
        type: object
        properties:
          perSecond:
            description: |-
              **string** (int64)
              PerSecond is a limit value specified with per second time unit.
              Includes only one of the fields `perSecond`, `perMinute`.
            type: string
            format: int64
          perMinute:
            description: |-
              **string** (int64)
              PerMinute is a limit value specified with per minute time unit.
              Includes only one of the fields `perSecond`, `perMinute`.
            type: string
            format: int64
        oneOf:
          - required:
              - perSecond
          - required:
              - perMinute
      RateLimit:
        type: object
        properties:
          allRequests:
            description: |-
              **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**
              AllRequests is a rate limit configuration applied to all incoming requests.
            $ref: '#/definitions/Limit'
          requestsPerIp:
            description: |-
              **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**
              RequestsPerIp is a rate limit configuration applied separately for each set of requests
              grouped by client IP address.
            $ref: '#/definitions/Limit'
      RegexMatchAndSubstitute:
        type: object
        properties:
          regex:
            description: |-
              **string**
              The regular expression used to find portions of a string that should be replaced.
            type: string
          substitute:
            description: |-
              **string**
              The string that should be substituted into matching portions of the subject string during a substitution operation
              to produce a new string.
            type: string
      HttpRouteAction:
        type: object
        properties:
          backendGroupId:
            description: |-
              **string**
              Required field. Backend group to forward requests to.
              Stream (TCP) backend groups are not supported.
            type: string
          timeout:
            description: |-
              **string** (duration)
              Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
              the maximum time the connection is kept alive for, regardless of whether data is transferred over it.
              If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.
              Default value: `60`.
            default: '60'
            type: string
            format: duration
          idleTimeout:
            description: |-
              **string** (duration)
              Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group:
              the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.
              Specifying meaningful values for both [timeout](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck) and `idle_timeout` is useful for implementing
              server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc.
              If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.
              If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see [timeout](/docs/application-load-balancer/api-ref/BackendGroup/get#yandex.cloud.apploadbalancer.v1.HealthCheck)).
            type: string
            format: duration
          hostRewrite:
            description: |-
              **string**
              Host replacement.
              Includes only one of the fields `hostRewrite`, `autoHostRewrite`.
              Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.
              If not specified, the host is not changed.
            type: string
          autoHostRewrite:
            description: |-
              **boolean**
              Automatically replaces the host with that of the target.
              Includes only one of the fields `hostRewrite`, `autoHostRewrite`.
              Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.
              If not specified, the host is not changed.
            type: boolean
          prefixRewrite:
            description: |-
              **string**
              Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).
              For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `prefix_rewrite` value is `/bar`,
              a request with `/foobaz` path is forwarded with `/barbaz` path.
              For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.
              If not specified, the path is not changed.
              Only one of regex_rewrite, or prefix_rewrite may be specified.
            type: string
          upgradeTypes:
            description: |-
              **string**
              Supported values for HTTP `Upgrade` header. E.g. `websocket`.
            type: array
            items:
              type: string
          rateLimit:
            description: |-
              **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**
              RateLimit is a rate limit configuration applied for route.
            $ref: '#/definitions/RateLimit'
          regexRewrite:
            description: |-
              **[RegexMatchAndSubstitute](#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute)**
              Replacement for portions of the path that match the pattern should be rewritten,
              even allowing the substitution of capture groups from the pattern into the new path as specified
              by the rewrite substitution string.
              Only one of regex_rewrite, or prefix_rewrite may be specified.
              Examples of using:
              - The path pattern ^/service/([^/]+)(/.*)$ paired with a substitution string of \2/instance/\1 would transform
              /service/foo/v1/api into /v1/api/instance/foo.
              - The pattern one paired with a substitution string of two would transform /xxx/one/yyy/one/zzz
              into /xxx/two/yyy/two/zzz.
              - The pattern ^(.*?)one(.*)$ paired with a substitution string of \1two\2 would replace only the first
              occurrence of one, transforming path /xxx/one/yyy/one/zzz into /xxx/two/yyy/one/zzz.
              - The pattern (?i)/xxx/ paired with a substitution string of /yyy/ would do a case-insensitive match and transform
              path /aaa/XxX/bbb to /aaa/yyy/bbb.
            $ref: '#/definitions/RegexMatchAndSubstitute'
        required:
          - backendGroupId
        oneOf:
          - required:
              - hostRewrite
          - required:
              - autoHostRewrite
      RedirectAction:
        type: object
        properties:
          replaceScheme:
            description: |-
              **string**
              URI scheme replacement.
              If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI,
              the port is also removed.
              If not specified, the original scheme and port are used.
            type: string
          replaceHost:
            description: |-
              **string**
              URI host replacement.
              If not specified, the original host is used.
            type: string
          replacePort:
            description: |-
              **string** (int64)
              URI host replacement.
              If not specified, the original host is used.
            type: string
            format: int64
          replacePath:
            description: |-
              **string**
              Replacement for the whole path.
              Includes only one of the fields `replacePath`, `replacePrefix`.
              URI path replacement.
              If not specified, the original path is used.
            type: string
          replacePrefix:
            description: |-
              **string**
              Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).
              For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `replace_prefix` value is `/bar`,
              a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`.
              For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.
              Includes only one of the fields `replacePath`, `replacePrefix`.
              URI path replacement.
              If not specified, the original path is used.
            type: string
          removeQuery:
            description: |-
              **boolean**
              Removes URI query.
            type: boolean
          responseCode:
            description: |-
              **enum** (RedirectResponseCode)
              HTTP status code to use in redirect responses.
              - `MOVED_PERMANENTLY`: `301 Moved Permanently` status code.
              - `FOUND`: `302 Found` status code.
              - `SEE_OTHER`: `303 See Other` status code.
              - `TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.
              - `PERMANENT_REDIRECT`: `308 Permanent Redirect` status code.
            type: string
            enum:
              - MOVED_PERMANENTLY
              - FOUND
              - SEE_OTHER
              - TEMPORARY_REDIRECT
              - PERMANENT_REDIRECT
        oneOf:
          - required:
              - replacePath
          - required:
              - replacePrefix
      Payload:
        type: object
        properties:
          text:
            description: |-
              **string**
              Payload text.
              Includes only one of the fields `text`.
              Payload.
            type: string
        oneOf:
          - required:
              - text
      DirectResponseAction:
        type: object
        properties:
          status:
            description: |-
              **string** (int64)
              HTTP status code to use in responses.
            type: string
            format: int64
          body:
            description: |-
              **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)**
              Response body.
            $ref: '#/definitions/Payload'
      HttpRoute:
        type: object
        properties:
          match:
            description: |-
              **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch)**
              Condition (predicate) used to select the route.
            $ref: '#/definitions/HttpRouteMatch'
          route:
            description: |-
              **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction)**
              Forwards the request to a backend group for processing as configured.
              Includes only one of the fields `route`, `redirect`, `directResponse`.
              Action performed on the request if the route is selected.
            $ref: '#/definitions/HttpRouteAction'
          redirect:
            description: |-
              **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction)**
              Redirects the request as configured.
              Includes only one of the fields `route`, `redirect`, `directResponse`.
              Action performed on the request if the route is selected.
            $ref: '#/definitions/RedirectAction'
          directResponse:
            description: |-
              **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction)**
              Instructs the load balancer to respond directly as configured.
              Includes only one of the fields `route`, `redirect`, `directResponse`.
              Action performed on the request if the route is selected.
            $ref: '#/definitions/DirectResponseAction'
        oneOf:
          - required:
              - route
          - required:
              - redirect
          - required:
              - directResponse
      GrpcRouteMatch:
        type: object
        properties:
          fqmn:
            description: |-
              **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**
              Match settings for gRPC service method called in the request.
              A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such.
              If not specified, the route matches all methods.
            $ref: '#/definitions/StringMatch'
      GrpcRouteAction:
        type: object
        properties:
          backendGroupId:
            description: |-
              **string**
              Required field. Backend group to forward requests to.
            type: string
          maxTimeout:
            description: |-
              **string** (duration)
              Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
              the maximum time the connection is kept alive for, regardless of whether data is transferred over it.
              If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.
              If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.
              Default value: `60`.
            default: '60'
            type: string
            format: duration
          idleTimeout:
            description: |-
              **string** (duration)
              Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
              the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.
              Specifying meaningful values for both [maxTimeout](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction) and `idle_timeout` is useful for implementing
              server-push mechanisms such as long polling, server-sent events etc.
              If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.
              If not specified, no idle timeout is used, and an alive connection may be idle for any duration
              (see [maxTimeout](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction)).
            type: string
            format: duration
          hostRewrite:
            description: |-
              **string**
              Host replacement.
              Includes only one of the fields `hostRewrite`, `autoHostRewrite`.
              Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.
              If not specified, the host is not changed.
            type: string
          autoHostRewrite:
            description: |-
              **boolean**
              Automatically replaces the host with that of the target.
              Includes only one of the fields `hostRewrite`, `autoHostRewrite`.
              Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.
              If not specified, the host is not changed.
            type: boolean
          rateLimit:
            description: |-
              **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**
              RateLimit is a rate limit configuration applied for route.
            $ref: '#/definitions/RateLimit'
        required:
          - backendGroupId
        oneOf:
          - required:
              - hostRewrite
          - required:
              - autoHostRewrite
      GrpcStatusResponseAction:
        type: object
        properties:
          status:
            description: |-
              **enum** (Status)
              gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses.
              - `OK`: `OK` (0) status code.
              - `INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.
              - `NOT_FOUND`: `NOT_FOUND` (5) status code.
              - `PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.
              - `UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.
              - `UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.
              - `INTERNAL`: `INTERNAL` (13) status code.
              - `UNAVAILABLE`: `UNAVAILABLE` (14) status code.
            type: string
            enum:
              - OK
              - INVALID_ARGUMENT
              - NOT_FOUND
              - PERMISSION_DENIED
              - UNAUTHENTICATED
              - UNIMPLEMENTED
              - INTERNAL
              - UNAVAILABLE
      GrpcRoute:
        type: object
        properties:
          match:
            description: |-
              **[GrpcRouteMatch](#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch)**
              Condition (predicate) used to select the route.
            $ref: '#/definitions/GrpcRouteMatch'
          route:
            description: |-
              **[GrpcRouteAction](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction)**
              Forwards the request to a backend group for processing as configured.
              Includes only one of the fields `route`, `statusResponse`.
              Action performed on the request if the route is selected.
            $ref: '#/definitions/GrpcRouteAction'
          statusResponse:
            description: |-
              **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction)**
              Instructs the load balancer to respond directly with a specified status.
              Includes only one of the fields `route`, `statusResponse`.
              Action performed on the request if the route is selected.
            $ref: '#/definitions/GrpcStatusResponseAction'
        oneOf:
          - required:
              - route
          - required:
              - statusResponse
      HeaderModification:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the header.
            type: string
          append:
            description: |-
              **string**
              Appends the specified string to the header value.
              Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
              are supported.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Operation to perform on the header.
            type: string
          replace:
            description: |-
              **string**
              Replaces the value of the header with the specified string.
              Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
              are supported.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Operation to perform on the header.
            type: string
          remove:
            description: |-
              **boolean**
              Removes the header.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Operation to perform on the header.
            type: boolean
          rename:
            description: |-
              **string**
              Replaces the name of the header with the specified string.
              This operation is only supported for ALB Virtual Hosts.
              Includes only one of the fields `append`, `replace`, `remove`, `rename`.
              Operation to perform on the header.
            type: string
        oneOf:
          - required:
              - append
          - required:
              - replace
          - required:
              - remove
          - required:
              - rename
      HeaderMatcher:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Specifies the name of the header in the request.
            type: string
          value:
            description: |-
              **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**
              Specifies how the header match will be performed to route the request.
              In the absence of value a request that has specified header name will match,
              regardless of the header's value.
            $ref: '#/definitions/StringMatch'
        required:
          - name
      Principal:
        type: object
        properties:
          header:
            description: |-
              **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher)**
              A header (or pseudo-header such as :path or :method) of the incoming HTTP request.
              Includes only one of the fields `header`, `remoteIp`, `any`.
            $ref: '#/definitions/HeaderMatcher'
          remoteIp:
            description: |-
              **string**
              A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .
              Includes only one of the fields `header`, `remoteIp`, `any`.
            type: string
          any:
            description: |-
              **boolean**
              When any is set, it matches any request.
              Includes only one of the fields `header`, `remoteIp`, `any`.
            type: boolean
        oneOf:
          - required:
              - header
          - required:
              - remoteIp
          - required:
              - any
      Principals:
        type: object
        properties:
          andPrincipals:
            description: |-
              **[Principal](#yandex.cloud.apploadbalancer.v1.Principal)**
              Required. A match occurs when all principals match the request.
            type: array
            items:
              $ref: '#/definitions/Principal'
      RBAC:
        type: object
        properties:
          action:
            description: |-
              **enum** (Action)
              Required field. The action to take if a principal matches. Every action either allows or denies a request.
              - `ACTION_UNSPECIFIED`
              - `ALLOW`: Allows the request if and only if there is a principal that matches the request.
              - `DENY`: Allows the request if and only if there are no principal that match the request.
            type: string
            enum:
              - ACTION_UNSPECIFIED
              - ALLOW
              - DENY
          principals:
            description: |-
              **[Principals](#yandex.cloud.apploadbalancer.v1.Principals)**
              Required. A match occurs when at least one matches the request.
            type: array
            items:
              $ref: '#/definitions/Principals'
        required:
          - action
      RouteOptions:
        type: object
        properties:
          modifyRequestHeaders:
            description: |-
              **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**
              Apply the following modifications to the request headers.
            type: array
            items:
              $ref: '#/definitions/HeaderModification'
          modifyResponseHeaders:
            description: |-
              **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**
              Apply the following modifications to the response headers.
            type: array
            items:
              $ref: '#/definitions/HeaderModification'
          rbac:
            description: '**[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC)**'
            $ref: '#/definitions/RBAC'
          securityProfileId:
            description: |-
              **string**
              Security profile that will take effect to all requests routed via particular virtual host.
            type: string
sourcePath: en/_api-ref/apploadbalancer/v1/api-ref/VirtualHost/updateRoute.md
---

# Application Load Balancer API, REST: VirtualHost.UpdateRoute

Updates the specified route of the specified virtual host.

## HTTP request

```
POST https://alb.{{ api-host }}/apploadbalancer/v1/httpRouters/{httpRouterId}/virtualHosts/{virtualHostName}:updateRoute
```

## Path parameters

#|
||Field | Description ||
|| httpRouterId | **string**

Required field. ID of the HTTP router to update a route in.

To get the HTTP router ID, make a [HttpRouterService.List](/docs/application-load-balancer/api-ref/HttpRouter/list#List) request. ||
|| virtualHostName | **string**

Required field. Name of the virtual host to update a route in.

To get the virtual host name, make a [VirtualHostService.List](/docs/application-load-balancer/api-ref/VirtualHost/list#List) request. ||
|#

## Body parameters {#yandex.cloud.apploadbalancer.v1.UpdateRouteRequest}

```json
{
  "routeName": "string",
  "updateMask": "string",
  // Includes only one of the fields `http`, `grpc`
  "http": {
    "match": {
      "httpMethod": [
        "string"
      ],
      "path": {
        // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
        "exactMatch": "string",
        "prefixMatch": "string",
        "regexMatch": "string"
        // end of the list of possible fields
      },
      "headers": [
        {
          "name": "string",
          "value": {
            // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            "regexMatch": "string"
            // end of the list of possible fields
          }
        }
      ],
      "queryParameters": [
        {
          "name": "string",
          "value": {
            // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
            "exactMatch": "string",
            "prefixMatch": "string",
            "regexMatch": "string"
            // end of the list of possible fields
          }
        }
      ]
    },
    // Includes only one of the fields `route`, `redirect`, `directResponse`
    "route": {
      "backendGroupId": "string",
      "timeout": "string",
      "idleTimeout": "string",
      // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
      "hostRewrite": "string",
      "autoHostRewrite": "boolean",
      // end of the list of possible fields
      "prefixRewrite": "string",
      "upgradeTypes": [
        "string"
      ],
      "rateLimit": {
        "allRequests": {
          // Includes only one of the fields `perSecond`, `perMinute`
          "perSecond": "string",
          "perMinute": "string"
          // end of the list of possible fields
        },
        "requestsPerIp": {
          // Includes only one of the fields `perSecond`, `perMinute`
          "perSecond": "string",
          "perMinute": "string"
          // end of the list of possible fields
        }
      },
      "regexRewrite": {
        "regex": "string",
        "substitute": "string"
      }
    },
    "redirect": {
      "replaceScheme": "string",
      "replaceHost": "string",
      "replacePort": "string",
      // Includes only one of the fields `replacePath`, `replacePrefix`
      "replacePath": "string",
      "replacePrefix": "string",
      // end of the list of possible fields
      "removeQuery": "boolean",
      "responseCode": "string"
    },
    "directResponse": {
      "status": "string",
      "body": {
        // Includes only one of the fields `text`
        "text": "string"
        // end of the list of possible fields
      }
    }
    // end of the list of possible fields
  },
  "grpc": {
    "match": {
      "fqmn": {
        // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
        "exactMatch": "string",
        "prefixMatch": "string",
        "regexMatch": "string"
        // end of the list of possible fields
      }
    },
    // Includes only one of the fields `route`, `statusResponse`
    "route": {
      "backendGroupId": "string",
      "maxTimeout": "string",
      "idleTimeout": "string",
      // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
      "hostRewrite": "string",
      "autoHostRewrite": "boolean",
      // end of the list of possible fields
      "rateLimit": {
        "allRequests": {
          // Includes only one of the fields `perSecond`, `perMinute`
          "perSecond": "string",
          "perMinute": "string"
          // end of the list of possible fields
        },
        "requestsPerIp": {
          // Includes only one of the fields `perSecond`, `perMinute`
          "perSecond": "string",
          "perMinute": "string"
          // end of the list of possible fields
        }
      }
    },
    "statusResponse": {
      "status": "string"
    }
    // end of the list of possible fields
  },
  // end of the list of possible fields
  "routeOptions": {
    "modifyRequestHeaders": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "boolean",
        "rename": "string"
        // end of the list of possible fields
      }
    ],
    "modifyResponseHeaders": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "boolean",
        "rename": "string"
        // end of the list of possible fields
      }
    ],
    "rbac": {
      "action": "string",
      "principals": [
        {
          "andPrincipals": [
            {
              // Includes only one of the fields `header`, `remoteIp`, `any`
              "header": {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                  "exactMatch": "string",
                  "prefixMatch": "string",
                  "regexMatch": "string"
                  // end of the list of possible fields
                }
              },
              "remoteIp": "string",
              "any": "boolean"
              // end of the list of possible fields
            }
          ]
        }
      ]
    },
    "securityProfileId": "string"
  },
  "disableSecurityProfile": "boolean"
}
```

#|
||Field | Description ||
|| routeName | **string**

Required field. Name of the route to update.

To get the route name, make a [VirtualHostService.Get](/docs/application-load-balancer/api-ref/VirtualHost/get#Get) request. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| http | **[HttpRoute](#yandex.cloud.apploadbalancer.v1.HttpRoute)**

New settings of the HTTP route.

Includes only one of the fields `http`, `grpc`.

New settings of the route. ||
|| grpc | **[GrpcRoute](#yandex.cloud.apploadbalancer.v1.GrpcRoute)**

New settings of the gRPC route.

Includes only one of the fields `http`, `grpc`.

New settings of the route. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions)**

New route options for the route. ||
|| disableSecurityProfile | **boolean**

Whether set to 'true' disable security profile for the route. ||
|#

## HttpRoute {#yandex.cloud.apploadbalancer.v1.HttpRoute}

An HTTP route configuration resource.

#|
||Field | Description ||
|| match | **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch)**

Condition (predicate) used to select the route. ||
|| route | **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| redirect | **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction)**

Redirects the request as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| directResponse | **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction)**

Instructs the load balancer to respond directly as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|#

## HttpRouteMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteMatch}

An HTTP route condition (predicate) resource.

#|
||Field | Description ||
|| httpMethod[] | **string**

HTTP method specified in the request. ||
|| path | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Match settings for the path specified in the request.

If not specified, the route matches all paths. ||
|| headers[] | **[HttpRouteHeaderMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch)**

Headers specify HTTP request header matchers. Multiple match values are
ANDed together, meaning, a request must match all the specified headers
to select the route. Headers must be unique. ||
|| queryParameters[] | **[HttpRouteQueryParamMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch)**

Query Parameters specify HTTP query parameter matchers. Multiple match
values are ANDed together, meaning, a request must match all the
specified query parameters to select the route. Query parameters must be unique. ||
|#

## StringMatch {#yandex.cloud.apploadbalancer.v1.StringMatch}

A string matcher resource.

#|
||Field | Description ||
|| exactMatch | **string**

Exact match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|| prefixMatch | **string**

Prefix match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|| regexMatch | **string**

Regular expression match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|#

## HttpRouteHeaderMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP Header to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Value of HTTP Header to be matched. ||
|#

## HttpRouteQueryParamMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP query parameter to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Value of HTTP query parameter to be matched. ||
|#

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction}

An HTTP route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to.

Stream (TCP) backend groups are not supported. ||
|| timeout | **string** (duration)

Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). ||
|| hostRewrite | **string**

Host replacement.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| autoHostRewrite | **boolean**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| prefixRewrite | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `prefix_rewrite` value is `/bar`,
a request with `/foobaz` path is forwarded with `/barbaz` path.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.

If not specified, the path is not changed.

Only one of regex_rewrite, or prefix_rewrite may be specified. ||
|| upgradeTypes[] | **string**

Supported values for HTTP `Upgrade` header. E.g. `websocket`. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

RateLimit is a rate limit configuration applied for route. ||
|| regexRewrite | **[RegexMatchAndSubstitute](#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute)**

Replacement for portions of the path that match the pattern should be rewritten,
even allowing the substitution of capture groups from the pattern into the new path as specified
by the rewrite substitution string.

Only one of regex_rewrite, or prefix_rewrite may be specified.

Examples of using:
- The path pattern ^/service/([^/]+)(/.*)$ paired with a substitution string of \2/instance/\1 would transform
/service/foo/v1/api into /v1/api/instance/foo.
- The pattern one paired with a substitution string of two would transform /xxx/one/yyy/one/zzz
into /xxx/two/yyy/two/zzz.
- The pattern ^(.*?)one(.*)$ paired with a substitution string of \1two\2 would replace only the first
occurrence of one, transforming path /xxx/one/yyy/one/zzz into /xxx/two/yyy/one/zzz.
- The pattern (?i)/xxx/ paired with a substitution string of /yyy/ would do a case-insensitive match and transform
path /aaa/XxX/bbb to /aaa/yyy/bbb. ||
|#

## RateLimit {#yandex.cloud.apploadbalancer.v1.RateLimit}

RateLimit is a set of settings for global rate limiting.

#|
||Field | Description ||
|| allRequests | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**

AllRequests is a rate limit configuration applied to all incoming requests. ||
|| requestsPerIp | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit)**

RequestsPerIp is a rate limit configuration applied separately for each set of requests
grouped by client IP address. ||
|#

## Limit {#yandex.cloud.apploadbalancer.v1.RateLimit.Limit}

Limit is a rate limit value settings.

#|
||Field | Description ||
|| perSecond | **string** (int64)

PerSecond is a limit value specified with per second time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|| perMinute | **string** (int64)

PerMinute is a limit value specified with per minute time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|#

## RegexMatchAndSubstitute {#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute}

#|
||Field | Description ||
|| regex | **string**

The regular expression used to find portions of a string that should be replaced. ||
|| substitute | **string**

The string that should be substituted into matching portions of the subject string during a substitution operation
to produce a new string. ||
|#

## RedirectAction {#yandex.cloud.apploadbalancer.v1.RedirectAction}

A redirect action resource.

#|
||Field | Description ||
|| replaceScheme | **string**

URI scheme replacement.

If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI,
the port is also removed.

If not specified, the original scheme and port are used. ||
|| replaceHost | **string**

URI host replacement.

If not specified, the original host is used. ||
|| replacePort | **string** (int64)

URI host replacement.

If not specified, the original host is used. ||
|| replacePath | **string**

Replacement for the whole path.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| replacePrefix | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch) value is `/foo` and `replace_prefix` value is `/bar`,
a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch), the whole path is replaced.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| removeQuery | **boolean**

Removes URI query. ||
|| responseCode | **enum** (RedirectResponseCode)

HTTP status code to use in redirect responses.

- `MOVED_PERMANENTLY`: `301 Moved Permanently` status code.
- `FOUND`: `302 Found` status code.
- `SEE_OTHER`: `303 See Other` status code.
- `TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.
- `PERMANENT_REDIRECT`: `308 Permanent Redirect` status code. ||
|#

## DirectResponseAction {#yandex.cloud.apploadbalancer.v1.DirectResponseAction}

A direct response action resource.

#|
||Field | Description ||
|| status | **string** (int64)

HTTP status code to use in responses. ||
|| body | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload)**

Response body. ||
|#

## Payload {#yandex.cloud.apploadbalancer.v1.Payload}

A health check payload resource.

#|
||Field | Description ||
|| text | **string**

Payload text.

Includes only one of the fields `text`.

Payload. ||
|#

## GrpcRoute {#yandex.cloud.apploadbalancer.v1.GrpcRoute}

A gRPC route configuration resource.

#|
||Field | Description ||
|| match | **[GrpcRouteMatch](#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch)**

Condition (predicate) used to select the route. ||
|| route | **[GrpcRouteAction](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|| statusResponse | **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction)**

Instructs the load balancer to respond directly with a specified status.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|#

## GrpcRouteMatch {#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch}

A gRPC route condition (predicate) resource.

#|
||Field | Description ||
|| fqmn | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Match settings for gRPC service method called in the request.

A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such.

If not specified, the route matches all methods. ||
|#

## GrpcRouteAction {#yandex.cloud.apploadbalancer.v1.GrpcRouteAction}

A gRPC route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to. ||
|| maxTimeout | **string** (duration)

Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `maxTimeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events etc.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration
(see `maxTimeout`). ||
|| hostRewrite | **string**

Host replacement.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| autoHostRewrite | **boolean**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit)**

RateLimit is a rate limit configuration applied for route. ||
|#

## GrpcStatusResponseAction {#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction}

A gRPC status response action resource.

#|
||Field | Description ||
|| status | **enum** (Status)

gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses.

- `OK`: `OK` (0) status code.
- `INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.
- `NOT_FOUND`: `NOT_FOUND` (5) status code.
- `PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.
- `UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.
- `UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.
- `INTERNAL`: `INTERNAL` (13) status code.
- `UNAVAILABLE`: `UNAVAILABLE` (14) status code. ||
|#

## RouteOptions {#yandex.cloud.apploadbalancer.v1.RouteOptions}

#|
||Field | Description ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Apply the following modifications to the request headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification)**

Apply the following modifications to the response headers. ||
|| rbac | **[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC)** ||
|| securityProfileId | **string**

Security profile that will take effect to all requests routed via particular virtual host. ||
|#

## HeaderModification {#yandex.cloud.apploadbalancer.v1.HeaderModification}

A header modification resource.

#|
||Field | Description ||
|| name | **string**

Name of the header. ||
|| append | **string**

Appends the specified string to the header value.

Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
are supported.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| replace | **string**

Replaces the value of the header with the specified string.

Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
are supported.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| remove | **boolean**

Removes the header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| rename | **string**

Replaces the name of the header with the specified string.
This operation is only supported for ALB Virtual Hosts.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|#

## RBAC {#yandex.cloud.apploadbalancer.v1.RBAC}

Role Based Access Control (RBAC) provides router, virtual host, and route access control for the ALB
service. Requests are allowed or denied based on the `action` and whether a matching principal is
found. For instance, if the action is ALLOW and a matching principal is found the request should be
allowed.

#|
||Field | Description ||
|| action | **enum** (Action)

Required field. The action to take if a principal matches. Every action either allows or denies a request.

- `ACTION_UNSPECIFIED`
- `ALLOW`: Allows the request if and only if there is a principal that matches the request.
- `DENY`: Allows the request if and only if there are no principal that match the request. ||
|| principals[] | **[Principals](#yandex.cloud.apploadbalancer.v1.Principals)**

Required. A match occurs when at least one matches the request. ||
|#

## Principals {#yandex.cloud.apploadbalancer.v1.Principals}

Principals define a group of identities for a request.

#|
||Field | Description ||
|| andPrincipals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal)**

Required. A match occurs when all principals match the request. ||
|#

## Principal {#yandex.cloud.apploadbalancer.v1.Principal}

Principal defines an identity for a request.

#|
||Field | Description ||
|| header | **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher)**

A header (or pseudo-header such as :path or :method) of the incoming HTTP request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| remoteIp | **string**

A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| any | **boolean**

When any is set, it matches any request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|#

## HeaderMatcher {#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher}

#|
||Field | Description ||
|| name | **string**

Required field. Specifies the name of the header in the request. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch)**

Specifies how the header match will be performed to route the request.
In the absence of value a request that has specified header name will match,
regardless of the header's value. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "httpRouterId": "string",
    "virtualHostName": "string",
    "routeName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "name": "string",
    "authority": [
      "string"
    ],
    "routes": [
      {
        "name": "string",
        // Includes only one of the fields `http`, `grpc`
        "http": {
          "match": {
            "httpMethod": [
              "string"
            ],
            "path": {
              // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
              "exactMatch": "string",
              "prefixMatch": "string",
              "regexMatch": "string"
              // end of the list of possible fields
            },
            "headers": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                  "exactMatch": "string",
                  "prefixMatch": "string",
                  "regexMatch": "string"
                  // end of the list of possible fields
                }
              }
            ],
            "queryParameters": [
              {
                "name": "string",
                "value": {
                  // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                  "exactMatch": "string",
                  "prefixMatch": "string",
                  "regexMatch": "string"
                  // end of the list of possible fields
                }
              }
            ]
          },
          // Includes only one of the fields `route`, `redirect`, `directResponse`
          "route": {
            "backendGroupId": "string",
            "timeout": "string",
            "idleTimeout": "string",
            // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
            "hostRewrite": "string",
            "autoHostRewrite": "boolean",
            // end of the list of possible fields
            "prefixRewrite": "string",
            "upgradeTypes": [
              "string"
            ],
            "rateLimit": {
              "allRequests": {
                // Includes only one of the fields `perSecond`, `perMinute`
                "perSecond": "string",
                "perMinute": "string"
                // end of the list of possible fields
              },
              "requestsPerIp": {
                // Includes only one of the fields `perSecond`, `perMinute`
                "perSecond": "string",
                "perMinute": "string"
                // end of the list of possible fields
              }
            },
            "regexRewrite": {
              "regex": "string",
              "substitute": "string"
            }
          },
          "redirect": {
            "replaceScheme": "string",
            "replaceHost": "string",
            "replacePort": "string",
            // Includes only one of the fields `replacePath`, `replacePrefix`
            "replacePath": "string",
            "replacePrefix": "string",
            // end of the list of possible fields
            "removeQuery": "boolean",
            "responseCode": "string"
          },
          "directResponse": {
            "status": "string",
            "body": {
              // Includes only one of the fields `text`
              "text": "string"
              // end of the list of possible fields
            }
          }
          // end of the list of possible fields
        },
        "grpc": {
          "match": {
            "fqmn": {
              // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
              "exactMatch": "string",
              "prefixMatch": "string",
              "regexMatch": "string"
              // end of the list of possible fields
            }
          },
          // Includes only one of the fields `route`, `statusResponse`
          "route": {
            "backendGroupId": "string",
            "maxTimeout": "string",
            "idleTimeout": "string",
            // Includes only one of the fields `hostRewrite`, `autoHostRewrite`
            "hostRewrite": "string",
            "autoHostRewrite": "boolean",
            // end of the list of possible fields
            "rateLimit": {
              "allRequests": {
                // Includes only one of the fields `perSecond`, `perMinute`
                "perSecond": "string",
                "perMinute": "string"
                // end of the list of possible fields
              },
              "requestsPerIp": {
                // Includes only one of the fields `perSecond`, `perMinute`
                "perSecond": "string",
                "perMinute": "string"
                // end of the list of possible fields
              }
            }
          },
          "statusResponse": {
            "status": "string"
          }
          // end of the list of possible fields
        },
        // end of the list of possible fields
        "routeOptions": {
          "modifyRequestHeaders": [
            {
              "name": "string",
              // Includes only one of the fields `append`, `replace`, `remove`, `rename`
              "append": "string",
              "replace": "string",
              "remove": "boolean",
              "rename": "string"
              // end of the list of possible fields
            }
          ],
          "modifyResponseHeaders": [
            {
              "name": "string",
              // Includes only one of the fields `append`, `replace`, `remove`, `rename`
              "append": "string",
              "replace": "string",
              "remove": "boolean",
              "rename": "string"
              // end of the list of possible fields
            }
          ],
          "rbac": {
            "action": "string",
            "principals": [
              {
                "andPrincipals": [
                  {
                    // Includes only one of the fields `header`, `remoteIp`, `any`
                    "header": {
                      "name": "string",
                      "value": {
                        // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                        "exactMatch": "string",
                        "prefixMatch": "string",
                        "regexMatch": "string"
                        // end of the list of possible fields
                      }
                    },
                    "remoteIp": "string",
                    "any": "boolean"
                    // end of the list of possible fields
                  }
                ]
              }
            ]
          },
          "securityProfileId": "string"
        },
        "disableSecurityProfile": "boolean"
      }
    ],
    "modifyRequestHeaders": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "boolean",
        "rename": "string"
        // end of the list of possible fields
      }
    ],
    "modifyResponseHeaders": [
      {
        "name": "string",
        // Includes only one of the fields `append`, `replace`, `remove`, `rename`
        "append": "string",
        "replace": "string",
        "remove": "boolean",
        "rename": "string"
        // end of the list of possible fields
      }
    ],
    "routeOptions": {
      "modifyRequestHeaders": [
        {
          "name": "string",
          // Includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": "boolean",
          "rename": "string"
          // end of the list of possible fields
        }
      ],
      "modifyResponseHeaders": [
        {
          "name": "string",
          // Includes only one of the fields `append`, `replace`, `remove`, `rename`
          "append": "string",
          "replace": "string",
          "remove": "boolean",
          "rename": "string"
          // end of the list of possible fields
        }
      ],
      "rbac": {
        "action": "string",
        "principals": [
          {
            "andPrincipals": [
              {
                // Includes only one of the fields `header`, `remoteIp`, `any`
                "header": {
                  "name": "string",
                  "value": {
                    // Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`
                    "exactMatch": "string",
                    "prefixMatch": "string",
                    "regexMatch": "string"
                    // end of the list of possible fields
                  }
                },
                "remoteIp": "string",
                "any": "boolean"
                // end of the list of possible fields
              }
            ]
          }
        ]
      },
      "securityProfileId": "string"
    },
    "rateLimit": {
      "allRequests": {
        // Includes only one of the fields `perSecond`, `perMinute`
        "perSecond": "string",
        "perMinute": "string"
        // end of the list of possible fields
      },
      "requestsPerIp": {
        // Includes only one of the fields `perSecond`, `perMinute`
        "perSecond": "string",
        "perMinute": "string"
        // end of the list of possible fields
      }
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateRouteMetadata](#yandex.cloud.apploadbalancer.v1.UpdateRouteMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[VirtualHost](#yandex.cloud.apploadbalancer.v1.VirtualHost)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateRouteMetadata {#yandex.cloud.apploadbalancer.v1.UpdateRouteMetadata}

#|
||Field | Description ||
|| httpRouterId | **string**

ID of the HTTP router that the route is being updated in. ||
|| virtualHostName | **string**

Name of the virtual host that the route is being updated in. ||
|| routeName | **string**

Name of the route that is being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## VirtualHost {#yandex.cloud.apploadbalancer.v1.VirtualHost}

A virtual host resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#virtual-host).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the virtual host. The name is unique within the HTTP router. ||
|| authority[] | **string**

List of domains that are attributed to the virtual host.

The host is selected to process the request received by the load balancer
if the domain specified in the HTTP/1.1 `Host` header or the HTTP/2 `:authority` pseudo-header matches a domain
specified in the host.

A wildcard asterisk character (`*`) matches 0 or more characters.

If not specified, all domains are attributed to the host, which is the same as specifying a `*` value.
An HTTP router must not contain more than one virtual host to which all domains are attributed. ||
|| routes[] | **[Route](#yandex.cloud.apploadbalancer.v1.Route)**

Routes of the virtual host.

A route contains a set of conditions (predicates) that are used by the load balancer to select the route
for the request and an action on the request.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

The order of routes matters: the first route whose predicate matches the request is selected.
The most specific routes should be at the top of the list, so that they are not overridden.
For example, if the first HTTP route is configured, via [HttpRoute.match](#yandex.cloud.apploadbalancer.v1.HttpRoute2), to match paths prefixed with just `/`,
other routes are never matched. ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Deprecated, use route_options.modify_request_headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Deprecated, use route_options.modify_response_headers. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions2)** ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for a whole virtual host. ||
|#

## Route {#yandex.cloud.apploadbalancer.v1.Route}

A route resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/http-router#routes).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the route. ||
|| http | **[HttpRoute](#yandex.cloud.apploadbalancer.v1.HttpRoute2)**

HTTP route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| grpc | **[GrpcRoute](#yandex.cloud.apploadbalancer.v1.GrpcRoute2)**

gRPC route configuration.

Includes only one of the fields `http`, `grpc`.

Route configuration. ||
|| routeOptions | **[RouteOptions](#yandex.cloud.apploadbalancer.v1.RouteOptions2)** ||
|| disableSecurityProfile | **boolean**

Whether set to 'true' disables security profile for the route. ||
|#

## HttpRoute {#yandex.cloud.apploadbalancer.v1.HttpRoute2}

An HTTP route configuration resource.

#|
||Field | Description ||
|| match | **[HttpRouteMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteMatch2)**

Condition (predicate) used to select the route. ||
|| route | **[HttpRouteAction](#yandex.cloud.apploadbalancer.v1.HttpRouteAction2)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| redirect | **[RedirectAction](#yandex.cloud.apploadbalancer.v1.RedirectAction2)**

Redirects the request as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|| directResponse | **[DirectResponseAction](#yandex.cloud.apploadbalancer.v1.DirectResponseAction2)**

Instructs the load balancer to respond directly as configured.

Includes only one of the fields `route`, `redirect`, `directResponse`.

Action performed on the request if the route is selected. ||
|#

## HttpRouteMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteMatch2}

An HTTP route condition (predicate) resource.

#|
||Field | Description ||
|| httpMethod[] | **string**

HTTP method specified in the request. ||
|| path | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Match settings for the path specified in the request.

If not specified, the route matches all paths. ||
|| headers[] | **[HttpRouteHeaderMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch2)**

Headers specify HTTP request header matchers. Multiple match values are
ANDed together, meaning, a request must match all the specified headers
to select the route. Headers must be unique. ||
|| queryParameters[] | **[HttpRouteQueryParamMatch](#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch2)**

Query Parameters specify HTTP query parameter matchers. Multiple match
values are ANDed together, meaning, a request must match all the
specified query parameters to select the route. Query parameters must be unique. ||
|#

## StringMatch {#yandex.cloud.apploadbalancer.v1.StringMatch2}

A string matcher resource.

#|
||Field | Description ||
|| exactMatch | **string**

Exact match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|| prefixMatch | **string**

Prefix match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|| regexMatch | **string**

Regular expression match string.

Includes only one of the fields `exactMatch`, `prefixMatch`, `regexMatch`.

Match string for either exact or prefix match. ||
|#

## HttpRouteHeaderMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteHeaderMatch2}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP Header to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Value of HTTP Header to be matched. ||
|#

## HttpRouteQueryParamMatch {#yandex.cloud.apploadbalancer.v1.HttpRouteQueryParamMatch2}

#|
||Field | Description ||
|| name | **string**

Name of the HTTP query parameter to be matched. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Value of HTTP query parameter to be matched. ||
|#

## HttpRouteAction {#yandex.cloud.apploadbalancer.v1.HttpRouteAction2}

An HTTP route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to.

Stream (TCP) backend groups are not supported. ||
|| timeout | **string** (duration)

Overall timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

Idle timeout for an HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `timeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events (`EventSource` interface) etc.

If a connection times out, the load balancer responds to the client with a `504 Gateway Timeout` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration (see `timeout`). ||
|| hostRewrite | **string**

Host replacement.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| autoHostRewrite | **boolean**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| prefixRewrite | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2) value is `/foo` and `prefix_rewrite` value is `/bar`,
a request with `/foobaz` path is forwarded with `/barbaz` path.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2), the whole path is replaced.

If not specified, the path is not changed.

Only one of regex_rewrite, or prefix_rewrite may be specified. ||
|| upgradeTypes[] | **string**

Supported values for HTTP `Upgrade` header. E.g. `websocket`. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for route. ||
|| regexRewrite | **[RegexMatchAndSubstitute](#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute2)**

Replacement for portions of the path that match the pattern should be rewritten,
even allowing the substitution of capture groups from the pattern into the new path as specified
by the rewrite substitution string.

Only one of regex_rewrite, or prefix_rewrite may be specified.

Examples of using:
- The path pattern ^/service/([^/]+)(/.*)$ paired with a substitution string of \2/instance/\1 would transform
/service/foo/v1/api into /v1/api/instance/foo.
- The pattern one paired with a substitution string of two would transform /xxx/one/yyy/one/zzz
into /xxx/two/yyy/two/zzz.
- The pattern ^(.*?)one(.*)$ paired with a substitution string of \1two\2 would replace only the first
occurrence of one, transforming path /xxx/one/yyy/one/zzz into /xxx/two/yyy/one/zzz.
- The pattern (?i)/xxx/ paired with a substitution string of /yyy/ would do a case-insensitive match and transform
path /aaa/XxX/bbb to /aaa/yyy/bbb. ||
|#

## RateLimit {#yandex.cloud.apploadbalancer.v1.RateLimit2}

RateLimit is a set of settings for global rate limiting.

#|
||Field | Description ||
|| allRequests | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2)**

AllRequests is a rate limit configuration applied to all incoming requests. ||
|| requestsPerIp | **[Limit](#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2)**

RequestsPerIp is a rate limit configuration applied separately for each set of requests
grouped by client IP address. ||
|#

## Limit {#yandex.cloud.apploadbalancer.v1.RateLimit.Limit2}

Limit is a rate limit value settings.

#|
||Field | Description ||
|| perSecond | **string** (int64)

PerSecond is a limit value specified with per second time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|| perMinute | **string** (int64)

PerMinute is a limit value specified with per minute time unit.

Includes only one of the fields `perSecond`, `perMinute`. ||
|#

## RegexMatchAndSubstitute {#yandex.cloud.apploadbalancer.v1.RegexMatchAndSubstitute2}

#|
||Field | Description ||
|| regex | **string**

The regular expression used to find portions of a string that should be replaced. ||
|| substitute | **string**

The string that should be substituted into matching portions of the subject string during a substitution operation
to produce a new string. ||
|#

## RedirectAction {#yandex.cloud.apploadbalancer.v1.RedirectAction2}

A redirect action resource.

#|
||Field | Description ||
|| replaceScheme | **string**

URI scheme replacement.

If `http` or `https` scheme is to be replaced and `80` or `443` port is specified in the original URI,
the port is also removed.

If not specified, the original scheme and port are used. ||
|| replaceHost | **string**

URI host replacement.

If not specified, the original host is used. ||
|| replacePort | **string** (int64)

URI host replacement.

If not specified, the original host is used. ||
|| replacePath | **string**

Replacement for the whole path.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| replacePrefix | **string**

Replacement for the path prefix matched by [StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2).

For instance, if [StringMatch.prefixMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2) value is `/foo` and `replace_prefix` value is `/bar`,
a request with `https://example.com/foobaz` URI is redirected to `https://example.com/barbaz`.
For [StringMatch.exactMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2), the whole path is replaced.

Includes only one of the fields `replacePath`, `replacePrefix`.

URI path replacement.

If not specified, the original path is used. ||
|| removeQuery | **boolean**

Removes URI query. ||
|| responseCode | **enum** (RedirectResponseCode)

HTTP status code to use in redirect responses.

- `MOVED_PERMANENTLY`: `301 Moved Permanently` status code.
- `FOUND`: `302 Found` status code.
- `SEE_OTHER`: `303 See Other` status code.
- `TEMPORARY_REDIRECT`: `307 Temporary Redirect` status code.
- `PERMANENT_REDIRECT`: `308 Permanent Redirect` status code. ||
|#

## DirectResponseAction {#yandex.cloud.apploadbalancer.v1.DirectResponseAction2}

A direct response action resource.

#|
||Field | Description ||
|| status | **string** (int64)

HTTP status code to use in responses. ||
|| body | **[Payload](#yandex.cloud.apploadbalancer.v1.Payload2)**

Response body. ||
|#

## Payload {#yandex.cloud.apploadbalancer.v1.Payload2}

A health check payload resource.

#|
||Field | Description ||
|| text | **string**

Payload text.

Includes only one of the fields `text`.

Payload. ||
|#

## GrpcRoute {#yandex.cloud.apploadbalancer.v1.GrpcRoute2}

A gRPC route configuration resource.

#|
||Field | Description ||
|| match | **[GrpcRouteMatch](#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch2)**

Condition (predicate) used to select the route. ||
|| route | **[GrpcRouteAction](#yandex.cloud.apploadbalancer.v1.GrpcRouteAction2)**

Forwards the request to a backend group for processing as configured.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|| statusResponse | **[GrpcStatusResponseAction](#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction2)**

Instructs the load balancer to respond directly with a specified status.

Includes only one of the fields `route`, `statusResponse`.

Action performed on the request if the route is selected. ||
|#

## GrpcRouteMatch {#yandex.cloud.apploadbalancer.v1.GrpcRouteMatch2}

A gRPC route condition (predicate) resource.

#|
||Field | Description ||
|| fqmn | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Match settings for gRPC service method called in the request.

A match string must be a fully qualified method name, e.g. `foo.bar.v1.BazService/Get`, or a prefix of such.

If not specified, the route matches all methods. ||
|#

## GrpcRouteAction {#yandex.cloud.apploadbalancer.v1.GrpcRouteAction2}

A gRPC route action resource.

#|
||Field | Description ||
|| backendGroupId | **string**

Required field. Backend group to forward requests to. ||
|| maxTimeout | **string** (duration)

Overall timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is kept alive for, regardless of whether data is transferred over it.

If a client specifies a lower timeout in HTTP `grpc-timeout` header, the `max_timeout` value is ignored.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

Default value: `60`. ||
|| idleTimeout | **string** (duration)

Idle timeout for an underlying HTTP connection between a load balancer node an a backend from the backend group:
the maximum time the connection is allowed to be idle, i.e. without any data transferred over it.

Specifying meaningful values for both `maxTimeout` and `idle_timeout` is useful for implementing
server-push mechanisms such as long polling, server-sent events etc.

If a connection times out, the load balancer responds to the client with an `UNAVAILABLE` status code.

If not specified, no idle timeout is used, and an alive connection may be idle for any duration
(see `maxTimeout`). ||
|| hostRewrite | **string**

Host replacement.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| autoHostRewrite | **boolean**

Automatically replaces the host with that of the target.

Includes only one of the fields `hostRewrite`, `autoHostRewrite`.

Value rewrite settings for HTTP/1.1 `Host` headers and HTTP/2 `:authority` pseudo-headers.

If not specified, the host is not changed. ||
|| rateLimit | **[RateLimit](#yandex.cloud.apploadbalancer.v1.RateLimit2)**

RateLimit is a rate limit configuration applied for route. ||
|#

## GrpcStatusResponseAction {#yandex.cloud.apploadbalancer.v1.GrpcStatusResponseAction2}

A gRPC status response action resource.

#|
||Field | Description ||
|| status | **enum** (Status)

gRPC [status code](https://grpc.github.io/grpc/core/md_doc_statuscodes.html) to use in responses.

- `OK`: `OK` (0) status code.
- `INVALID_ARGUMENT`: `INVALID_ARGUMENT` (3) status code.
- `NOT_FOUND`: `NOT_FOUND` (5) status code.
- `PERMISSION_DENIED`: `PERMISSION_DENIED` (7) status code.
- `UNAUTHENTICATED`: `UNAUTHENTICATED` (16) status code.
- `UNIMPLEMENTED`: `UNIMPLEMENTED` (12) status code.
- `INTERNAL`: `INTERNAL` (13) status code.
- `UNAVAILABLE`: `UNAVAILABLE` (14) status code. ||
|#

## RouteOptions {#yandex.cloud.apploadbalancer.v1.RouteOptions2}

#|
||Field | Description ||
|| modifyRequestHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Apply the following modifications to the request headers. ||
|| modifyResponseHeaders[] | **[HeaderModification](#yandex.cloud.apploadbalancer.v1.HeaderModification2)**

Apply the following modifications to the response headers. ||
|| rbac | **[RBAC](#yandex.cloud.apploadbalancer.v1.RBAC2)** ||
|| securityProfileId | **string**

Security profile that will take effect to all requests routed via particular virtual host. ||
|#

## HeaderModification {#yandex.cloud.apploadbalancer.v1.HeaderModification2}

A header modification resource.

#|
||Field | Description ||
|| name | **string**

Name of the header. ||
|| append | **string**

Appends the specified string to the header value.

Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
are supported.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| replace | **string**

Replaces the value of the header with the specified string.

Variables [defined for Envoy proxy](https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_conn_man/headers#custom-request-response-headers)
are supported.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| remove | **boolean**

Removes the header.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|| rename | **string**

Replaces the name of the header with the specified string.
This operation is only supported for ALB Virtual Hosts.

Includes only one of the fields `append`, `replace`, `remove`, `rename`.

Operation to perform on the header. ||
|#

## RBAC {#yandex.cloud.apploadbalancer.v1.RBAC2}

Role Based Access Control (RBAC) provides router, virtual host, and route access control for the ALB
service. Requests are allowed or denied based on the `action` and whether a matching principal is
found. For instance, if the action is ALLOW and a matching principal is found the request should be
allowed.

#|
||Field | Description ||
|| action | **enum** (Action)

Required field. The action to take if a principal matches. Every action either allows or denies a request.

- `ACTION_UNSPECIFIED`
- `ALLOW`: Allows the request if and only if there is a principal that matches the request.
- `DENY`: Allows the request if and only if there are no principal that match the request. ||
|| principals[] | **[Principals](#yandex.cloud.apploadbalancer.v1.Principals2)**

Required. A match occurs when at least one matches the request. ||
|#

## Principals {#yandex.cloud.apploadbalancer.v1.Principals2}

Principals define a group of identities for a request.

#|
||Field | Description ||
|| andPrincipals[] | **[Principal](#yandex.cloud.apploadbalancer.v1.Principal2)**

Required. A match occurs when all principals match the request. ||
|#

## Principal {#yandex.cloud.apploadbalancer.v1.Principal2}

Principal defines an identity for a request.

#|
||Field | Description ||
|| header | **[HeaderMatcher](#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher2)**

A header (or pseudo-header such as :path or :method) of the incoming HTTP request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| remoteIp | **string**

A CIDR block or IP that describes the request remote/origin address, e.g. ``192.0.0.0/24`` or``192.0.0.4`` .

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|| any | **boolean**

When any is set, it matches any request.

Includes only one of the fields `header`, `remoteIp`, `any`. ||
|#

## HeaderMatcher {#yandex.cloud.apploadbalancer.v1.Principal.HeaderMatcher2}

#|
||Field | Description ||
|| name | **string**

Required field. Specifies the name of the header in the request. ||
|| value | **[StringMatch](#yandex.cloud.apploadbalancer.v1.StringMatch2)**

Specifies how the header match will be performed to route the request.
In the absence of value a request that has specified header name will match,
regardless of the header's value. ||
|#