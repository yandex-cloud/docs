# upload method

Uploads a static website hosting configuration for a bucket.

## Request {#request}

```bash
PUT /{bucket}?website HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
----- | -----
| `website` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

### Data schema {#request-scheme}

You can configure a bucket:

{% list tabs %}

- As a website

  Sample configuration:

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

  | Element | Description |
  ----- | -----
  | `WebsiteConfiguration` | Top-level header of the website description. |
  | `IndexDocument/Suffix` | The website homepage.<br/><br/>Path: `/WebsiteConfiguration/IndexDocument/Suffix`. |
  | `ErrorDocument/Key` | Document that the user sees if a `4xx` error occurs.<br/><br/>Path: `/WebsiteConfiguration/ErrorDocument/Key`. |

- To redirect all requests

  Sample configuration:

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

  | Element | Description |
  ----- | -----
  | `WebsiteConfiguration` | Top-level header of the website description. |
  | `RedirectAllRequestsTo` | Contains a redirect configuration for all requests.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo`. |
  | `HostName` | Host to which all requests to the bucket are redirected.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`. |
  | `Protocol` | Protocol used for redirects: `http` or `https`. Optional element.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`. |

- For conditionally redirecting requests

  Sample configuration:

  ```xml
  <!--Configuration for conditional redirect of all requests-->
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

  | Element | Description |
  ----- | -----
  | `WebsiteConfiguration` | Top-level header of the website description. |
  | `IndexDocument/Suffix` | Home page of the website. |
  | `ErrorDocument/Key` | Document that the user sees if a `4xx` error occurs. |
  | `RoutingRules` | Routing rule container `RoutingRule`.<br/>It must include at least one rule. |
  | `RoutingRule` | Routing rule.<br/>Defines the conditions and conditional redirects. |
  | `Condition` | Container used for conditions that trigger the redirect.<br/>If a routing rule doesn't contain any conditions, all the requests are redirected.<br/>A container must include at least one rule. |
  | `KeyPrefixEquals` | The condition sets the name prefix for the request-originating object.<br/>`KeyPrefixEquals` is required if `HttpErrorCodeReturnedEquals` is not set. If `KeyPrefixEquals` and `HttpErrorCodeReturnedEquals` are set, the condition is met when both the parameters are `true`. |
  | `HttpErrorCodeReturnedEquals` | The condition specifies the error code that triggers a redirect.<br/>`HttpErrorCodeReturnedEquals` is required if `KeyPrefixEquals` is not set. If `KeyPrefixEquals` and `HttpErrorCodeReturnedEquals` are set, the condition is met when both the parameters are `true`. |
  | `Redirect` | Redirect container.<br/>You can redirect a request to a different page, different host, or change the protocol.<br/>The `RoutingRule` rule must contain at least one `Redirect` element.<br/>A redirect must contain at least one of the following elements: `Protocol`, `HostName`, `ReplaceKeyPrefixWith`, `ReplaceKeyWith`, or `HttpRedirectCode`. |
  | `Protocol` | In the `Location` response header, a redirect indicates the protocol scheme (`http` or `https`) to be used.<br/>This parameter is optional if other redirects are used. |
  | `HostName` | In the `Location` response header, a redirect indicates the host name to be used.<br/>This parameter is optional if other redirects are used. |
  | `ReplaceKeyPrefixWith` | A redirect specifies the name prefix of the object key replacing `KeyPrefixEquals` in the redirect request.<br/>Incompatible with `ReplaceKeyWith`.<br/>This parameter is optional if other redirects are used. |
  | `ReplaceKeyWith` | A redirect specifies the object key to be used in the `Location` header.<br/>Incompatible with `ReplaceKeyPrefixWith`.<br/>This parameter is optional if other redirects are used. |
  | `HttpRedirectCode` | In the `Location` response header, a redirect specifies the `HTTP redirect code`.<br/>Possible values: any `3xx` code.<br/>This parameter is optional if other redirects are used. |

{% endlist %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).
