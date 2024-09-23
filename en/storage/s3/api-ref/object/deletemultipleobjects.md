# deleteMultipleObjects method

Deletes objects based on a list of keys passed in a request.

It takes less time than deleting the same objects one by one via separate requests.

The delete list may contain up to 1,000 keys.

If an object does not exist, {{ objstorage-name }} marks it as deleted in the response.

You can configure responses so that {{ objstorage-name }} returns one of the following selections:

- Statuses of all delete operations.
- Only statuses with errors deleting objects. In this case, if no errors occurred, an empty response is returned.



## Request {#request}

```http
POST /{bucket}?delete HTTP/2
```

### Path parameters {#path-parameters}

Parameter | Description
----- | -----
`bucket` | Bucket name.


### Query parameters {#request-parameters}

Parameter | Description
----- | -----
`delete` | Flag indicating a delete operation.


### Headers {#request-headers}

Use the appropriate [common headers](../common-request-headers.md) in your request.

For this request, the `Content-MD5` and `Content-Length` headers are required.

Moreover, if governance-mode [retention](../../../concepts/object-lock.md) is put on object versions in a versioned bucket, make sure to use the below-specified header to bypass retention and confirm deletion. Only users with the [`storage.admin` role](../../../security/index.md) can delete a retained object version. To check retention status, use the [getObjectRetention](getobjectretention.md) method.

Header | Description
--- | ---
`X-Amz-Bypass-Governance-Retention` | Header that confirms bypassing of the governance retention. Set it to `true`.

### Data schema {#request-scheme}

The list of keys to delete is passed in XML format.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Delete>
    <Quiet>true</Quiet>
    <Object>
         <Key>Key</Key>
    </Object>
    ...
</Delete>
```

Tag | Description
----- | -----
`Delete` | It contains the response body.<br/><br/>Path: `/Delete`.
`Quiet` | `<Quiet>true</Quiet>` sets the <q>quiet</q> mode.<br/><br/>{{ objstorage-name }} will only include deletion errors in the response. If there are no errors, the query will not return the response body. If the specified object does not exist at the time of the query, `Deleted` will be returned.><br/>If omitted, the default value is `false`.><br/>Path: `/Delete/Quiet`.
`Object` | It contains object deletion parameters.<br/><br/>Path: `/Delete/Object`.
`Key` | Object key.<br/><br/>Path: `/Delete/Object/Key`.



## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).

A successful response contains additional data in XML format with the schema described below.

### Data structure {#response-scheme}

```xml
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

Tag | Description
----- | -----
`DeleteResult` | Response body.<br/><br/>Path: `/DeleteResult`.
`Deleted` | Successfully deleted object.<br/><br/>Missing if the request was set to `<Quiet>true</Quiet>`.<br/><br/>Path: `/DeleteResult/Deleted`.
`Key` | Object key.<br/><br/>Path: `/DeleteResult/Deleted/Key` or `/DeleteResult/Error/Key`.
`Error` | Object deletion error.<br/><br/>Path: `/DeleteResult/Error`.
`Code` | Error code.<br/>Path: `/DeleteResult/Error/Code`.
`Message` | Error description.<br/>Path: `/DeleteResult/Error/Message`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}