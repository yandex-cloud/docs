# Object Storage API, Amazon S3-compatible REST: PutBucketWebsite

Uploads a static website hosting configuration for a bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```bash
PUT /{bucket}?website HTTP/2
```

### Path parameters {#path-parameters}

{% include [path-parameters](../../../_includes_service/storage-path-parameters.md) %}

### Query parameters {#request-params}

{% include [query-parameters](../../../_includes_service/storage-hosting-query-parameters.md) %}

### Headings {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

### Data schema {#request-scheme}

You can configure a bucket:

{% list tabs %}

- As a website

  Configuration example:

  ```xml
  <!--Website configuration-->
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <IndexDocument>
          <Suffix>index.html</Suffix>
      </IndexDocument>
      <ErrorDocument>
          <Key>Error.html</Key>
      </ErrorDocument>
  </WebsiteConfiguration>
  ```

  Possible elements:

  #|
  || **Element** | **Description** ||
  || `WebsiteConfiguration` | Top-level header of the website description. ||
  || `IndexDocument/Suffix` | Website home page.
  
  Path: `/WebsiteConfiguration/IndexDocument/Suffix`. ||
  || `ErrorDocument/Key` | Document the user sees in case of `4xx` errors.
  
  Path: `/WebsiteConfiguration/ErrorDocument/Key`. ||
  |#

- To redirect all requests

  Configuration example:

  ```xml
  <!--Configuration for redirecting all requests-->
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <RedirectAllRequestsTo>
          <HostName>example.com</HostName>
          <Protocol>http</Protocol>
      </RedirectAllRequestsTo>
  </WebsiteConfiguration>
  ```

  Possible elements:

  #|
  || **Element** | **Description** ||
  || `WebsiteConfiguration` | Top-level header of the website description. ||
  || `RedirectAllRequestsTo` | Contains the configuration for redirecting all requests.
  
  Path: `/WebsiteConfiguration/RedirectAllRequestsTo`. ||
  || `HostName` | Host to which all requests to the bucket are redirected.
  
  Path: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`. ||
  || `Protocol` | Protocol used for redirects: `http` or `https`. This is an optional parameter.
  
  Path: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`. ||
  |#

- For conditional redirects

  Configuration example:

  ```xml
  <!--Configuration for conditional redirects-->
  <WebsiteConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
      <IndexDocument>
          <Suffix>index.html</Suffix>
      </IndexDocument>
      <ErrorDocument>
          <Key>Error.html</Key>
      </ErrorDocument>
      <RoutingRules>
          <RoutingRule>
              <Condition>
                  <KeyPrefixEquals>k8s/</KeyPrefixEquals>
              </Condition>
              <Redirect>
                  <ReplaceKeyPrefixWith>kubernetes/</ReplaceKeyPrefixWith>
              </Redirect>
          </RoutingRule>
      </RoutingRules>
  </WebsiteConfiguration>
  ```

  Possible elements:

  #|
  || **Element** | **Description** ||
  || `WebsiteConfiguration` | Top-level header of the website description. ||
  || `IndexDocument/Suffix` | Website home page. ||
  || `ErrorDocument/Key` | Document the user sees in case of `4xx` errors. ||
  || `RoutingRules` | `RoutingRule` container.
  It must include at least one rule. ||
  || `RoutingRule` | Routing rule.
  It defines the conditions and conditional redirects. ||
  || `Condition` | Container of conditions to trigger the redirect. If a routing rule does not contain any conditions, all requests are redirected.
  If a request matches the conditions of more than one redirect rule, the last matching one will apply regardless of how closely the object key matches the condition prefix.
  The container must include at least one rule. ||
  || `KeyPrefixEquals` | The condition specifies the prefix of the object key the requests are redirected from.
  `KeyPrefixEquals` is required if `HttpErrorCodeReturnedEquals` is not set. If `KeyPrefixEquals` and `HttpErrorCodeReturnedEquals` are set, the condition is met when both the parameters are `true`. ||
  || `HttpErrorCodeReturnedEquals` | This condition specifies the error code that triggers a redirect.
  `HttpErrorCodeReturnedEquals` is required if `KeyPrefixEquals` is not set. If `KeyPrefixEquals` and `HttpErrorCodeReturnedEquals` are set, the condition is met when both the parameters are `true`. ||
  || `Redirect` | Redirect container.
  You can redirect a request to a different page, different host, or change the protocol.
  `RoutingRule` must contain at least one `Redirect` element.
  A redirect must contain at least one of the following elements: `Protocol`, `HostName`, `ReplaceKeyPrefixWith`, `ReplaceKeyWith`, or `HttpRedirectCode`. ||
  || `Protocol` | In the `Location` header of the response, a redirect indicates which protocol, `http` or `https`, should be used.
  This parameter is optional if other redirects apply. ||
  || `HostName` | In the `Location` response header, the redirect indicates the host name to use.
  This parameter is optional if other redirects apply. ||
  || `ReplaceKeyPrefixWith` | The redirect specifies the object key prefix to replace the `KeyPrefixEquals` value in the redirect request.
  It is incompatible with `ReplaceKeyWith`.
  This parameter is optional if other redirects apply. ||
  || `ReplaceKeyWith` | The redirect specifies the object key to use in the `Location` header.
  It is incompatible with `ReplaceKeyPrefixWith`.
  This parameter is optional if other redirects apply. ||
  || `HttpRedirectCode` | In the `Location` response header, the redirect specifies the `HTTP redirect code`.
  The possible value is any `3xx` code.
  This parameter is optional if other redirects apply. ||
  |#

{% endlist %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

#### Related articles {#related-articles}

[{#T}](../../../operations/hosting/setup.md)

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}
