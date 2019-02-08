# upload method

Uploads configuration of static website hosting for a bucket.

## Request {#request}

```
PUT /{bucket}?website HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Name of the bucket. |

### Query parameters {#request-params}

| Parameter | Description |
| ----- | ----- |
| `website` | Mandatory parameter to indicate the type of operation. |

### Headers {#request-headers}

In a request, use the necessary [common request headers](../common-request-headers.md).

### Data schema {#request-scheme}

You can configure a bucket:

---

**[!TAB As a website]**

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
| `IndexDocument/Suffix` | The website's home page.<br/><br/>Path: `/WebsiteConfiguration/IndexDocument/Suffix`. |
| `ErrorDocument/Key` | Document that the user will see if a 4xx error occurs.<br/><br/>Path: `/WebsiteConfiguration/ErrorDocument/Key`. |

**[!TAB To redirect all requests]**

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
| `RedirectAllRequestsTo` | Contains redirect configuration for all requests.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo`. |
| `HostName` | Host to which all requests to the bucket are redirected.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/HostName`. |
| `Protocol` | Protocol used for redirects: `http` or `https`. Optional element.<br/><br/>Path: `/WebsiteConfiguration/RedirectAllRequestsTo/Protocol`. |

---

## Response {#response}

### Headers {#response-headers}

A response can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [[!TITLE]](../response-codes.md).

