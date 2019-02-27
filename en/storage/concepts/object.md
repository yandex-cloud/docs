# Object

Objects are placed in buckets and contain user data in whatever format it was uploaded in.

The object ID is the string [key](#key).

Along with the object, [!KEYREF objstorage-name] stores [user-defined ](#user-meta) and [system](#system-meta) metadata.

[!KEYREF objstorage-name] allows you to store objects in standard and cold storage. For more information, see the section [[!TITLE]](storage-class.md).

[!KEYREF objstorage-name] supports the following operations with objects:

- Uploading an object to storage
- Downloading an object from storage.
- Copying an object inside the storage (for example, from one bucket to another).

All other operations that can be performed using [tools](../instruments/index.md) are combinations of the above.

## Key {#key}

Key is the ID of an object in a bucket.

The structure for storing objects is flat, but GUI-based [tools](../instruments/index.md) allow you to work with [!KEYREF objstorage-name] like a hierarchical file system. The hierarchical view is possible because keys can be written as paths in a file system (for example, `top_level_prefix/subprefix/text_data.txt`). In the Yandex.Cloud management console, prefixes are called folders.

A key must:

- Be UTF-8 encoded.
- Be less than 1024 bytes.
- Not contain the characters `: * ? " < > | !`.

The following characters are safe to use in a key: `[a-zA-Z0-9]`, `-`, `_`, `/`, `\`. Other characters may cause various problems when using [!KEYREF objstorage-name].

### Folder

There are no folders in [!KEYREF objstorage-name], but GUI-based file management clients like [CyberDuck](../instruments/cyberduck.md) or the interface to [!KEYREF objstorage-name] simulate folders in the Yandex.Cloud management console. A zero-size object, whose key is included in the keys of other objects as a prefix, serves as a folder. For example, an object with an `x` key and zero size will be a folder in the management console, while an object with an `x/y.txt` key will be a `y.txt` object located in the `x` folder.

Each of the [tools](../instruments/index.md) manages objects and folders according to their own logic described in their respective documentation.

The management console allows you to create folders and fill them with objects, but you can only delete an empty folder.

## Metadata {#metadata}

Metadata is stored with an object as `name-value` pairs.

Metadata can be system or user-defined.

### System metadata {#system-meta}

System metadata is defined by [!KEYREF objstorage-name].

| Name | Description |
| ----- | ----- |
| Datе | Date and time of sending a request to upload an object to [!KEYREF objstorage-name]. |
| Content-Length | Object size in bytes. |
| Last-Modified | Date when the object was created or last modified. |
| Content-MD5 | Object MD5 hash value, base64 encoded. |

### User-defined metadata {#user-meta}

When uploading an object to [!KEYREF objstorage-name], you can pass a set of metadata as `name-value` pairs along with the object.

In the HTTP API compatible with Amazon S3, metadata is passed as HTTP headers. The header name must start with `x-amz-meta-`. When an object is requested via the HTTP API, Yandex Object Storage returns metadata in the form of HTTP headers with the same prefix.

Metadata names must conform to the HTTP header naming convention and be in lowercase.

> [!NOTE]
>
> The PUT request header must not exceed 8 KB. The maximum size of user-defined metadata in this header is 2 KB.

