# Objects

Objects are hosted in buckets and contain user data in the format it was uploaded in.

The object ID is the string [key](#key).

{{ objstorage-name }} stores [user-defined](#user-meta) and [system](#system-meta) metadata along with the object.

{{ objstorage-name }} lets you store objects in standard and cold storage. For more information, see [{#T}](storage-class.md).

{{ objstorage-name }} supports the following operations with objects:

- Uploading an object to storage
- Downloading an object from storage.
- Copying an object inside the storage (for example, from one bucket to another).

All other operations that can be performed using [tools](../tools/index.md) are combinations of the ones given above.

You can configure [lifecycles](lifecycles.md) for bucket objects.

{{ objstorage-name }} restricts the size of objects and their metadata. For more information, see [{#T}](limits.md)).

## Keys {#key}

The key is the ID of an object in a bucket.

Objects are stored in a flat structure, but GUI-based [tools](../tools/index.md) let you use {{ objstorage-name }} as a hierarchical file system. Hierarchical view is possible because keys can be written as paths in a file system (for example, `top_level_prefix/subprefix/text_data.txt`). In the Yandex.Cloud management console, prefixes are called directories.

A key must:

- Be UTF-8 encoded.
- Be less than 1024 bytes in size.
- Not contain the characters `: * ? " < > | !`.

The following characters are safe to use in a key: `[a-zA-Z0-9]`, `-`, `_`, `/`, `\`. Other characters may cause various problems in {{ objstorage-name }}.

### Directory {#folder}

There are no directories in {{ objstorage-name }}, but GUI-based file management clients like [CyberDuck](../tools/cyberduck.md) and the {{ objstorage-name }} interface in the Yandex.Cloud management console emulate them. A zero-size object serves as a directory. Its key is included as a prefix in the keys of other objects. For example, an object with the `x` key and zero size is a directory in the management console, while an object with the `x/y.txt` key is the `y.txt` object located in the `x` directory.

Each [tool](../tools/index.md) manages objects and directories according to their own logic, which is described in their respective documentation.

{% note info %}

Deleting directories with objects is an asynchronous operation. At the start of the operation, {{ objstorage-name }} prepares a list of objects to delete and then deletes them. If during the deletion process, you upload an object to {{ objstorage-name }} that should be in the directory being deleted, the object will still be uploaded successfully. After both operations in {{objstorage-name}} are complete, you're left with the directory that was supposed to be deleted and the newly uploaded file.

{% endnote %}

## Object URL {#object-url}

Object URLs can take one of the following forms:

- `https://{{ s3-storage-host }}/<bucket>/<key>?<parameters>`
- `https://<bucket>.{{ s3-storage-host }}/<key>?<parameters>`

{% include [storage-dotnet-host](../_includes_service/storage-dotnet-host.md) %}

## Metadata {#metadata}

Metadata is stored with an object as `name-value` pairs.

Metadata can be system or user-defined.

### System metadata {#system-meta}

System metadata is defined by {{ objstorage-name }}.

| Name | Description |
| ----- | ----- |
| `Date` | Date and time a request is sent to upload an object to {{ objstorage-name }}. |
| `Content-Length` | Object size in bytes. |
| `Last-Modified` | Date when the object was created or last modified. |
| `Content-MD5` | Object MD5 hash value, base64 encoded. |
| `Cache-Control` | The value of the `Cache-Control` HTTP header passed by the client when saving the object to the bucket. {{ objstorage-name }} later returns this header to clients when responding to a request for an object or its metadata.<br/><br/>For example, the `Cache-Control: max-age=200` header indicates that the object expires 200 seconds after the client receives it. Read more about this header in [RFC 7234](https://tools.ietf.org/html/rfc7234#section-5.2). |
| `Expires` | The value of the `Expires` HTTP header passed by the client when saving the object to the bucket. {{ objstorage-name }} later returns this header to clients when responding to a request for an object or its metadata. <br/><br/>For example, the `Expires: Thu, 15 Apr 2020 20:00:00 GMT` header indicates that the object expires at 20:00:00 (GMT) on April 15, 2020. Read more about this header in [RFC 7234](https://tools.ietf.org/html/rfc7234#section-5.3). |

### User-defined metadata {#user-meta}

When uploading an object to {{ objstorage-name }}, you can pass a set of metadata as a `name-value` pair along with the object.

In the Amazon S3-compatible HTTP API, metadata is passed as HTTP headers. The header name must start with `x-amz-meta-`. When an object is requested via the HTTP API, Yandex Object Storage returns metadata in the form of HTTP headers with the same prefix.

Metadata names must conform to the HTTP header naming convention and be in lowercase.

{% note info %}

The PUT request header must not exceed 8 KB. The maximum size of user-defined metadata in this header is 2 KB.

{% endnote %}

