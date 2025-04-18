# x-yc-apigateway-authorizer:jwt extension

The `x-yc-apigateway-authorizer:jwt` extension is used within the [securityScheme](https://swagger.io/docs/specification/authentication/) component schemas of the [OpenId Connect](https://swagger.io/docs/specification/authentication/openid-connect-discovery/) type. For HTTP request authorization, {{ api-gw-short-name }} validates a token and verifies its signature using public keys the extension refers to. You can learn more about the JWT standard [here](https://www.rfc-editor.org/rfc/rfc7519).

## Supported parameters {#parameters}

{% include [param-table](../../../_includes/api-gateway/parameters-table.md) %}


Parameter                            | Type              | Required   | Description
------------------------------------|------------------|-----------------------|---------
`jwksUri`                           | `string`         | No                   | Address to get a public key for JWT signature verification. Keys must be in [JWKS](https://www.rfc-editor.org/rfc/rfc7517) format. If you skip this parameter, the address specified in the `jwks_uri` field of the configuration file will be used. The configuration file is available at the address specified in the `openIdConnectUrl` standard parameter.
`identitySource`                    | `IdentitySource` | Yes                    | Identifies the token position in the request.
`issuers`                           | `string[]`       | No                   | Possible values of the `iss` field of the token being validated.
`audiences`                         | `string[]`       | No                   | Possible values of the `aud` field of the token being validated.
`requiredClaims`                    | `string[]`       | No                   | JWT body fields that must be available in any token being validated.
`authorizer_result_ttl_in_seconds`  | `int`            | No                   | Time limit on storing the authorization result in the {{ api-gw-short-name }} local cache. If this parameter is not specified, the response is not cached.
`authorizer_result_caching_mode`    | `string`         | No                   | Defines the authorization result caching mode. To use it, make sure to specify the `authorizer_result_ttl_in_seconds` parameter. It can be either `path` or `uri`.
`jwkTtlInSeconds`                   | `int`            | No                   | Time limit on storing the public key from the response to a request whose address is specified in the `jwksUri` parameter, in the {{ api-gw-short-name }} local cache. If this parameter is not specified, the key is not cached.

You do not need to to specify `openIdConnectUrl`, which is standard for the [OpenAPI 3.0 specification](https://github.com/OAI/OpenAPI-Specification), if `jwksUri` is specified.

The `IdentitySource` object may contain the following parameters:

Parameter | Type | Description
----|----|----
`in` | `string` | Token position. The possible values are `header`, `query`, or `cookie`; the token is provided in the header, query parameter, or cookie, respectively.
`name` | `string` | Name of the variable that stores the token. This may be a header or request variable name.
`prefix` | `string` | This is an optional parameter. It sets the token prefix. The default value is an empty string.

## Supported signature algorithms {#algorithms}

Signature algorithm | `alg` field value
----|----
`RSASSA-PKCS1-v1_5` and `SHA-256` | `RS256`
`RSASSA-PKCS1-v1_5` and `SHA-384` | `RS384`
`RSASSA-PKCS1-v1_5` and `SHA-512` | `RS512`
`ECDSA` with the `P-256` and `SHA-256` function | `ES256`
`ECDSA` with the `P-384` and `SHA-384` function | `ES384`
`ECDSA` with the `P-521` and `SHA-512` function | `ES512`

## API call authorization algorithm {#authorizing-alg}

JWT request authorization uses the following algorithm:

1. {{ api-gw-short-name }} checks whether there is a token in `identitySource` and removes its prefix if it is provided in the specification.
1. If the specification allows caching the authorization result and a cached record is still valid, {{ api-gw-short-name }} returns the cached authorization result. Otherwise, it decodes the token header and body.
1. {{ api-gw-short-name }} specifies the receiving address of the public key required to validate the [JWS electronic signature](https://en.wikipedia.org/wiki/JSON_Web_Signature) of the token. It does this using the `jwksUri` parameter value. If the `jwksUri` parameter is not provided in the specification, {{ api-gw-short-name }} uses the `openIdConnectUrl` parameter, which is standard for OpenAPI, to send a request to the address specified in the parameter and retrieves the public key address from the `jwks_uri` field located in the body of the response.
1. If the specification allows caching public keys and the cached record is still valid, {{ api-gw-short-name }} uses the receiving address of the public keys and the public key ID (`kid` [field](https://www.rfc-editor.org/rfc/rfc7515#section-4.1.4) of the JWT header) to try and retrieve the public key from the local cache. Otherwise, it queries the public key at its address. The public key whose ID matches the `kid` field value in the JWT header is selected from the response body. The retrieved public key is cached if the specification allows this.
1. {{ api-gw-short-name }} checks whether the token signature algorithms and the public key match.
1. {{ api-gw-short-name }} verifies the token signature.
1. {{ api-gw-short-name }} checks the token body fields:
    * `exp`: Must be after the current time in UTC.
    * `nbf`: Must be before the current time in UTC.
    * `iat`: Must be before the current time in UTC.
    * `iss`: Must match one of the values specified in the `issuers` specification parameter.
    * `aud`: Must match one of the values specified in the `audiences` specification parameter.

    For more information about the fields, see the [JWT standard](https://www.rfc-editor.org/rfc/rfc7519).
1. {{ api-gw-short-name }} checks that the token body contains the fields set in the `requiredClaims` specification parameter.
1. {{ api-gw-short-name }} checks that the token owner (token's `scope` field value) has all permissions required to get the requested resource.

If any check fails, {{ api-gw-short-name }} denies access to the requested resource and returns the 403 status code.

## Extension specification {#spec}

Extension specification example:
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

In the above example, {{ api-gw-short-name }} validates the token in the `Authorization` header when accessing the `/jwt/query/authorize` resource. To get the token, remove the `Bearer` prefix from the target header value.

For successful authorization:
* The token signature and all common fields must be correct.
* The token must contain the `role` and `email` fields.
* The `iss` field value must be `https://example.com` or `https://example2.com`.
* The `aud` field value must be `audience-1` or `audience-2`.
* The token must have the `profile:read` and `profile:write` permissions specified.

## Caching authorization results {#response-caching}

The authorization result is stored in the {{ api-gw-short-name }} local cache if the extension has the `authorizer_result_ttl_in_seconds` parameter specified. If, during the time specified in `authorizer_result_ttl_in_seconds`, another HTTP request with similar caching key components is received, {{ api-gw-short-name }} will use the cached response without validating the token signature.

The caching key contents depend on the `authorizer_result_caching_mode` value.

`path` caching mode  | `uri` caching mode | No caching mode specified
--------------------------|-------------------------|----------------------------
`path`, `operation` (HTTP method), and token | `uri`, `operation` (HTTP method), and token | `path`, `operation` (HTTP method), and token

For example, for the resource ID in the `/user/{id}` specification and in the `/user/1234` request, if `authorizer_result_caching_mode` is `path`, `/user/{id}` will be used to generate a caching key; if it is `uri`, `/user/123` will be used.

## Caching public keys {#jwks-caching}

A public key you get at the address specified in the `jwksUri` parameter or the configuration file's `jwks_uri` field, is stored in the {{ api-gw-short-name }} local cache if the extension has the `jwkTtlInSeconds` parameter specified.

When generating the caching key, the public key ID (the `kid` field value from the JWT header) and the public key address are used.

If an HTTP request requiring a public key with the same address and the `kid` key ID is received again within the time specified in `jwkTtlInSeconds`, {{ api-gw-short-name }} will use the cached response and will not request the public key again.

## Authorization context {#context}

If the authorization is successful, the JWT authorization context will be provided in the request in the `requestContext.authorizer.jwt` field when invoking a user-defined integration function. The JWT authorization context contains the following parameters:

Parameter | Type | Description
----|-----|----
`claims` | `map[string]string` | Token body fields.
`scopes` | `list` | Token owner permissions.

## Possible errors {#errors}

* `401 Unauthorized`: The client did not provide authorization data in the HTTP request or the provided token is incorrect, e.g., it has an invalid signature, required fields are missing, token lifetime is expired, etc.
* `403 Forbidden`: The token has no permissions (the `scope` field) to access the requested resource.
* `500 Internal Server Error`: Either {{ api-gw-short-name }} failed to retrieve the OpenID Connect configuration, or the public key or returned value structure is invalid.

## Use cases {#examples}

* [{#T}](../../tutorials/jwt-authorizer-firebase.md)
