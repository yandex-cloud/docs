# x-yc-apigateway-authorizer:jwt extension

The `x-yc-apigateway-authorizer:jwt` extension is used inside the [securityScheme](https://swagger.io/docs/specification/authentication/) component schemes with the [OpenId Connect](https://swagger.io/docs/specification/authentication/openid-connect-discovery/) type. For HTTP request authorization, {{ api-gw-short-name }} validates a token and verifies its signature using public keys the extension refers to. You can learn more about the JWT standard [here](https://www.rfc-editor.org/rfc/rfc7519).

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}


| Parameter | Type | Required | Description |
------------------------------------|------------------|-----------------------|---------
| `jwksUri` | `string` | No | Address at which one can get a public key for JWT signature verification. The keys must be in [JWKS](https://www.rfc-editor.org/rfc/rfc7517) format. If you skip this parameter, the address specified in the `jwks_uri` field of the configuration file is used. The configuration file is available at the address specified in the standard `openIdConnectUrl` parameter. |
| `IdentitySource` | `IdentitySource` | Yes | Identifies where the token is located in the request. |
| `issuers` | `string[]` | No | Possible `iss` field values of the token being validated. |
| `audiences` | `string[]` | No | Possible `aud` field values of the token being validated. |
| `requiredClaims` | `string[]` | No | JWT body fields that must be available in any token being validated. |
| `authorizer_result_ttl_in_seconds` | `int` | No | Time limit on keeping authorization results stored in the local {{ api-gw-short-name }} cache. If the parameter is omitted, the response is not cached. |
| `authorizer_result_caching_mode` | `string` | No | Authorization result caching mode To use it, make sure to specify the `authorizer_result_ttl_in_seconds` parameter. Possible values: `path` or `URI`. |
| `jwkTtlInSeconds` | `int` | No | Time limit on keeping a public key from a response to the request, whose address is specified in the `jwksUri` parameter; it is stored in the local {{ api-gw-short-name }} cache. If the parameter is not specified, the key is not cached. |

It is not required to specify the `openIdConnectUrl` parameter that is standard for the [OpenAPI 3.0 Specification](https://github.com/OAI/OpenAPI-Specification) if the `jwksUri` parameter is set.

The `IdentitySource` object may contain the following parameters:

| Parameter | Type | Description |
----|----|----
| `in` | `string` | Token location. Possible values: `header`, `query`, or `cookie` (the token is in the header, request parameter, or cookie, respectively). |
| `name` | `string` | Name of the variable that stores the token. This may be a header or request variable name. |
| `prefix` | `string` | This is an optional parameter. Token prefix. The default value is an empty string. |

## Supported signature algorithms {#algorithms}

| Signature algorithm | `Alg` field value. |
----|----
| `RSASSA-PKCS1-v1_5` and `SHA-256` | `RS256` |
| `RSASSA-PKCS1-v1_5` and `SHA-384` | `RS384` |
| `RSASSA-PKCS1-v1_5` and `SHA-512` | `RS512` |
| `ECDSA` with `P-256` and `SHA-256` functions | `ES256` |
| `ECDSA` with `P-384` and `SHA-384` functions | `ES384` |
| `ECDSA` with `P-512` and `SHA-512` functions | `ES512` |

## API call authorization algorithm {#authorizing-alg}

Request authorization with a JWT is based on the following algorithm:

1. {{ api-gw-short-name }} checks if there is a token in `identitySource` and removes its prefix if it is set in the specification.
1. If the specification allows caching the authorization result and a cached record is still valid, {{ api-gw-short-name }} returns the cached authorization result. Otherwise, it decodes the token header and body.
1. {{ api-gw-short-name }} identifies the public key source address to validate the token signature. It uses the `jwksUri` parameter value for that. If no `jwksUri` parameter is set in the specification, {{ api-gw-short-name }} uses the value of the `openIdConnectUrl` parameter, which is standard for the OpenAPI, to make a request to the address specified in it and retrieves the public key address from the `jwks_uri` response body field.
1. If the specification allows caching public keys and a cached record is still valid, {{ api-gw-short-name }} uses the public key source address and ID (the `kid` field of the token) to try to retrieve the public key from the local cache. Otherwise, it queries the public key at its address. The public key with the ID matching the token's `kid` field value is selected from the response body. The retrieved public key is cached if the specification allows this.
1. {{ api-gw-short-name }} checks whether the token signature algorithms and the public key match.
1. {{ api-gw-short-name }} verifies the token signature.
1. {{ api-gw-short-name }} checks the token body fields:
   * `exp`: Must be later than the current time (UTC).
   * `nbf`: Must be earlier than the current time (UTC).
   * `iat`: Must be earlier than the current time (UTC).
   * `iss`: Must take one of the values set in the `issuers` specification parameter.
   * `aud`: Must take one of the values set in the `audiences` specification parameter.

   For more information about the fields, see the [JWT standard](https://www.rfc-editor.org/rfc/rfc7519).
1. {{ api-gw-short-name }} checks that the token body contains the fields set in the `requiredClaims` specification parameter.
1. {{ api-gw-short-name }} checks if the token owner (the token `scope` field value) has all permissions required to get the requested resource.

If any of the checks fails, {{ api-gw-short-name }} denies access to the requested resource and returns the 403 status code.

## Extension specification {#spec}

Sample extension specification:
```yaml
paths:
  /jwt/header/authorize:
    get:
      summary: Authorized operation with OpenId Connect security scheme and JWT in header
      operationId: httpOpenIdAuthorizeWithJwtInHeader
      security:
        - jwtHeaderAuthorizer:
          - profile:read
          - profile:write
      x-yc-apigateway-integration:
        type: dummy
        content:
          '*': "Authorized!"
        http_code: 200
        http_headers:
          'Content-Type': "text/plain"
components:
  securitySchemes:
    jwtHeaderAuthorizer:
      type: openIdConnect
      openIdConnectUrl: https://example.com/.well-known/openid-configuration
      x-yc-apigateway-authorizer:
        type: jwt
        authorizer_result_ttl_in_seconds: 3000
        jwkTtlInSeconds: 5000
        jwksUri: https://example.com/.well-known/jwks.json
        issuers:
          - https://example.com
          - https://example2.com
        audiences:
          - audience-1
          - audience-2
        identitySource:
          in: header
          name: Authorization
          prefix: "Bearer "
        requiredClaims:
          - role
          - email
```

In the above example, {{ api-gw-short-name }} validates the token in the `Authorization` header at an attempt to access the `/jwt/query/authorize` resource. To get the token, the `Bearer` prefix is removed from the target header value.

For successful authorization:
* The token signature and standard fields must be correct.
* The token must contain the `role` and `email` fields.
* The `iss` field value must be either `https://example.com` or `https://example2.com`.
* The `aud` field value must be either `audience-1` or `audience-2`.
* The token must have the `profile:read` and `profile:write` permissions set.

## Caching authorization results {#response-caching}

The authorization result is stored in the local {{ api-gw-short-name }} cache if the extension specifies the `authorizer_result_ttl_in_seconds` parameter. If, during the time specified in `authorizer_result_ttl_in_seconds`, another HTTP request with similar caching key components is received again, {{ api-gw-short-name }} will use the cached response without validating the token signature.

The contents of a caching key depend on the `authorizer_result_caching_mode` parameter value.

| `Path` caching mode | `URI` caching mode | No caching mode specified |
--------------------------|-------------------------|----------------------------
| `Path`, `operation` (HTTP method) , and token | `URI`, `operation` (HTTP method), and token | `Path`, `operation` (HTTP method) , and token |

For example, for the resource ID in the `/user/{id}` specification and in the `/user/1234` request, if the `authorizer_result_caching_mode` parameter value is `path`, the `/user/{id}` will be used to generate a caching key, and if the parameter value is `URI`, `/user/123` will be used for that.

## Caching public keys {#jwks-caching}

A public key obtained when accessing the address specified in the `jwksUri` parameter or the configuration file's `jwks_uri` field, is stored in the local {{ api-gw-short-name }} cache if the extension has the `jwkTtlInSeconds` parameter specified.

To generate a caching key, the public key's `kid` value and source address are used.

If, during the time specified in `jwkTtlInSeconds`, another HTTP request checking which requires obtaining a public key with the same address and `kid` is received again, {{ api-gw-short-name }} will use the cached response without requesting the public key again.

## Authorization context {#context}

If the authorization is successful, the JWT authorization context will be provided in the request using the `requestContext.authorizer.jwt` field when invoking a user-defined integration function. The JWT authorization context contains the following parameters:

| Option | Type | Description |
----|-----|----
| `claims` | `map[string]string` | Token body fields. |
| `scopes` | `list` | Token owner permissions. |

## Possible errors {#errors}

* `401 Unauthorized`: Client failed to send the authorization data in the HTTP request.
* `403 Forbidden`: Token being transmitted is incorrect, e.g., its signature is invalid, the required fields are missing, the token's TTL has expired, or the permissions (the `scope` field) required to access the requested resource are not granted.
* `500 Internal Server Error`: {{ api-gw-short-name }} failed to retrieve the OpenID Connect configuration or the structure of the public key or returned value is incorrect.
