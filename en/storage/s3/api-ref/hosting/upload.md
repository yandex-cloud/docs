# upload method

Uploads a static website hosting configuration for a bucket.

## Request {#request}

```
PUT /{bucket}?website HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `website` | Required parameter that indicates the type of operation. |

### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

### Data schema {#request-scheme}

You can configure a bucket:

{% list tabs %}

- As a website

  Sample configuration:

  ```
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
  | ----- | ----- |
  | `IndexDocument/Suffix` | The website homepage.<br/><br/>Path: `/WebsiteConfiguration/IndexDocument/Suffix`. |
  | `ErrorDocument/Key` | Document that the user sees if a 4xx error occurs.<br/><br/>Path: `/WebsiteConfiguration/ErrorDocument/Key`. |

- To redirect all requests

  Sample configuration:

  ```
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
  | ----- | ----- |
  | `RedirectAllRequestsTo` | Contains a redirect configuration for all requests.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo`. |
  | `HostName` | Host to which all requests to the bucket are redirected.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`. |
  | `Protocol` | Protocol used for redirects: `http` or `https`. Optional element.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`. |

{% endlist %}

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

