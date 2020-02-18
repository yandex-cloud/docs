# deleteMultipleObjects method

Deletes objects based on a list of keys passed in a request.

It takes less time than deleting the same objects one by one via separate requests.

The delete list may contain a maximum of 1000 keys.

If an object doesn't exist, {{ objstorage-name }} marks it as deleted in the response.

You can configure responses so that {{ objstorage-name }} returns one of the following selections:

- Statuses of all delete operations.
- Only statuses with errors deleting objects. In this case, if no errors occurred, an empty response is returned.

## Request {#request}

```
POST /{bucket}?delete HTTP/1.1
```

### Path parameters {#path-parameters}

| Parameter | Description |
| ----- | ----- |
| `bucket` | Bucket name. |

### Query parameters {#request-parameters}

| Parameter | Description |
| ----- | ----- |
| `delete` | Flag indicating a delete operation. |

### Headers {#request-headers}

Use only [common request headers](../common-request-headers.md) in requests.

For this request, the `Content-MD5` and `Content-Length` headers are required.

### Data schema {#request-scheme}

The list of keys to delete is passed in XML format.

```
<?xml version="1.0" encoding="UTF-8"?>
<Delete>
    <Quiet>true</Quiet>
    <Object>
         <Key>Key</Key>
    </Object>
    ...
</Delete>
```

| Tag | Description |
| ----- | ----- |
| `Delete` | Contains the response body.<br/><br/>Path: `/Delete`. |
| `Quiet` | `<Quiet>true</Quiet>` enables <q>quiet</q> mode.<br/><br/>{{ objstorage-name }} only includes deletion errors in the response. If there are no errors, there won't be a response body.<br/><br/>If omitted, the default value is `false`.<br/><br/>Path: `/Delete/Quiet`. |
| `Object` | Contains parameters for deleting an object.<br/><br/>Path: `/Delete/Object`. |
| `Key` | Object key.<br/><br/>Path: `/Delete/Object/Key`. |

## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data structure {#response-scheme}

```
<DeleteResult>
  <Deleted>
    <Key>some/key.txt</Key>
  </Deleted>
  <Error>
    <Key>some/another/key.txt</Key>
    <Code>TextErrorCode</Code>
    <Message>Describing message</Message>
  </Error>
</DeleteResult>
```

| Tag | Description |
| ----- | ----- |
| `DeleteResult` | Response body.<br/><br/>Path: `/DeleteResult`. |
| `Deleted` | Successfully deleted object.<br/><br/>Missing if the request was set to `<Quiet>true</Quiet>`.<br/><br/>Path: `/DeleteResult/Deleted`. |
| `Key` | Object key.<br/><br/>Path: `/DeleteResult/Deleted/Key` or `/DeleteResult/Error/Key` |
| `Error` | Error deleting an object.<br/><br/>Path: `/DeleteResult/Error`. |
| `Code` | Error code.<br/>Path: `/DeleteResult/Error/Code`. |
| `Message` | Error description.<br/>Path: `/DeleteResult/Error/Message`. |

