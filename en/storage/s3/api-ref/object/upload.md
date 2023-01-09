# upload method

Uploads an object and its metadata to {{ objstorage-full-name }}.

{% note info %}

{{ objstorage-name }} doesn't block objects for writing and can accept multiple requests to write to the same object in parallel, but the user can only get the latest object saved from {{ objstorage-name }} by default. To ensure that the history is saved when objects are overwritten or deleted, enable [versioning](../../../concepts/versioning.md).

{% endnote %}

To make sure an object is passed via the network without any corruption, use the `Content-MD5` header. {{ objstorage-name }} calculates the `MD5` value for a saved object and, if the calculated `MD5` value does not match the one passed in the header, it returns an error. You can also perform this check on the client side by comparing the `ETag` from the {{ objstorage-name }} response with the precalculated `MD5` value.


## Request {#request}

```
PUT /{bucket}/{key} HTTP/2
```

### Path parameters {#path-parameters}

| Parameter | Description |
----- | -----
| `bucket` | Bucket name. |
| `key` | Object key. ID for saving the object in {{ objstorage-name }}. |


### Headers {#request-headers}

Use the necessary [common request headers](../common-request-headers.md) in requests.

You can also use the headers listed in the table below.

| Header | Description |
----- | -----
| `X-Amz-Meta-*` | User-defined metadata.<br/><br/>{{ objstorage-name }} transforms all headers starting with `X-Amz-Meta-` as follows: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`.<br/><br/>Total user-defined header size must not exceed 2 KB. The size of user-defined data is determined as the length of the UTF-8 encoded string. The header names and their values are included when calculating the size. |
| `X-Amz-Storage-Class` | Object [storage class](../../../concepts/storage-class.md).<br/><br/>Possible values:<ul><li>`STANDARD`: Standard storage.</li><li>`COLD`, `STANDARD_IA`, or `NEARLINE`: Cold storage.</li>{% if audience != "internal" %}<li>`ICE` or `GLACIER`: Ice storage.</li>{% endif %}</ul>If the header isn't specified, the object is stored in the storage defined in the bucket settings. |
| `X-Amz-Server-Side-Encryption` | The encryption algorithm of an uploaded object. Possible values: `aws:kms`. |
| `X-Amz-Server-Side-Encryption-Aws-Kms-Key-Id` | The ID of the {% if audience != "internal" %}[{{ kms-short-name }} key](../../../../kms/concepts/key.md){% else %}{{ kms-short-name }} key{% endif %} for encrypting an uploaded object. |

By using the headers listed below, you can set the [ACL](../../../concepts/acl.md) for an object to be uploaded.

{% include [storage-acl-headers](../../../_includes_service/storage-acl-object-headers.md) %}


## Response {#response}

### Headers {#response-headers}

Responses can only contain [common response headers](../common-response-headers.md).

### Response codes {#response-codes}

For a list of possible responses, see [{#T}](../response-codes.md).
