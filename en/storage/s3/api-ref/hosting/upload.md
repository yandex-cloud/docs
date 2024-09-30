# upload method

Uploads a static website hosting configuration for a bucket.

{% include [s3-api-intro-include](../../../../_includes/storage/s3-api-intro-include.md) %}

## Request {#request}

```bash
PUT /{bucket}?website HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.

### Query parameters {#request-params}

Parameter | Description
----- | -----
`website` | Required parameter that indicates the type of operation.

### Headers {#request-headers}

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

  Element | Description
  ----- | -----
  `WebsiteConfiguration` | Top-level header of the website description.
  `IndexDocument/Suffix` | Website home page.<br/><br/>Path: `/WebsiteConfiguration/IndexDocument/Suffix`.
  `ErrorDocument/Key` | Document the user sees in case of `4xx` errors.<br/><br/>Path: `/WebsiteConfiguration/ErrorDocument/Key`.

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

  Element | Description
  ----- | -----
  `WebsiteConfiguration` | Top-level header of the website description.
  `RedirectAllRequestsTo` | It contains a redirect configuration for all requests.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo`.
  `HostName` | Host to which all requests to the bucket are redirected.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`.
  `Protocol` | Protocol used for redirects: `http` or `https`. This is an optional parameter.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`.

- For conditionally redirecting requests

  Configuration example:

  ```xml
  <!--Configuration for conditionally redirecting requests-->
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

  Element | Description
  ----- | -----
  `WebsiteConfiguration` | Top-level header of the website description.
  `IndexDocument/Suffix` | Home page of the website.
  `ErrorDocument/Key` | Document the user sees in case of `4xx` errors.
  `RoutingRules` | `RoutingRule` container.<br/>It must include at least one rule.
  `RoutingRule` | Routing rule.<br/>It defines the conditions and conditional redirects.
  `Condition` | Container of conditions to trigger the redirect.<br/>If a routing rule does not contain any conditions, all requests are redirected.<br/>The container must include at least one rule.
  `KeyPrefixEquals` | The condition sets the name prefix for the object the requests are redirected from.<br/>`KeyPrefixEquals` is required if `HttpErrorCodeReturnedEquals` is not set. If `KeyPrefixEquals` and `HttpErrorCodeReturnedEquals` are set, the condition is met when both the parameters are `true`.
  `HttpErrorCodeReturnedEquals` | The condition specifies the error code that triggers a redirect.<br/>`HttpErrorCodeReturnedEquals` is required if `KeyPrefixEquals` is not set. If `KeyPrefixEquals` and `HttpErrorCodeReturnedEquals` are set, the condition is met when both the parameters are `true`.
  `Redirect` | Redirect container.<br/>You can redirect a request to a different page, different host, or change the protocol.<br/>`RoutingRule` must contain at least one `Redirect` element.<br/>A redirect must contain at least one of the following elements: `Protocol`, `HostName`, `ReplaceKeyPrefixWith`, `ReplaceKeyWith`, or `HttpRedirectCode`.
  `Protocol` | In the `Location` response header, the redirect indicates the protocol to use (`http` or `https`).<br/>This parameter is optional if other redirects apply.
  `HostName` | In the `Location` response header, the redirect indicates the host name to use.<br/>This parameter is optional if other redirects apply.
  `ReplaceKeyPrefixWith` | The redirect specifies the object key name prefix to replace the `KeyPrefixEquals` value in the redirect request.<br/>It is incompatible with `ReplaceKeyWith`.<br/>This parameter is optional if other redirects apply.
  `ReplaceKeyWith` | The redirect specifies the object key to use in the `Location` header.<br/>It is incompatible with `ReplaceKeyPrefixWith`.<br/>This parameter is optional if other redirects apply.
  `HttpRedirectCode` | In the `Location` response header, the redirect specifies the `HTTP redirect code`.<br/>Possible values: any `3xx` code.<br/>This parameter is optional if other redirects apply.

{% endlist %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}