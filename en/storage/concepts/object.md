# Objects

Objects are hosted in buckets and contain user data in the format it was uploaded in.

An object ID is a string [key](#key).

Along with the object, {{ objstorage-name }} stores [user](#user-meta) and [system](#system-meta) metadata.

{{ objstorage-name }} allows you to store objects in storages belonging to various classes depending on your requirements for the storage duration and frequency of object operations. For more information, see [{#T}](storage-class.md).

{{ objstorage-name }} supports the following operations with objects:

* Uploading an object to a storage.
* Downloading an object from a storage.
* Copying an object within a storage, e.g., from one bucket to another.
* Deleting an object.
* [Partial object update](object-patch.md) in a storage.

You can also combine these operations using the [tools](../tools/index.md).

You can configure [lifecycles](lifecycles.md) for bucket objects.

{{ objstorage-name }} restricts the size of objects and their metadata. For more information, see [{#T}](limits.md).

## Key {#key}

A key is an ID of an object in a bucket.

Objects are stored in a flat structure, although GUI-based [tools](../tools/index.md) allow you to use {{ objstorage-name }} as a hierarchical file system. Hierarchical view is possible because keys can be written as paths in a file system, e.g., `top_level_prefix/subprefix/text_data.txt`. In the {{ yandex-cloud }} management console, prefixes are called folders.

A key must:

- Be UTF-8 encoded.
- Be less than 1024 bytes in size.
- Not contain these characters: `: * ? " < > | !`.

The following characters are safe to use in a key: `[a-zA-Z0-9]`, `-`, `_`, `/`, `\`. Other characters may cause various issues in {{ objstorage-name }}.

### Directory {#folder}

There are no directories in {{ objstorage-name }}, but GUI-based file management clients, such as [CyberDuck](../tools/cyberduck.md) and the {{ objstorage-name }} interface in the {{ yandex-cloud }} management console, can emulate them. Such an emulated directory is a zero-size object. Its key is included as a prefix in the keys of other objects. For example, an object with the `x` key and zero size is a directory in the management console, while an object with the `x/y.txt` key is the `y.txt` object located in the `x` folder.

Each [tool](../tools/index.md) manages objects and directories according to its own logic, which is described in the respective documentation.

{% note info %}

Deleting folders with objects is an asynchronous operation. Once it starts, {{ objstorage-name }} prepares a list of objects to delete, and then deletes them. If during the process you upload an object to {{ objstorage-name }} to a directory marked for deletion, the object will upload successfully. After both operations in {{ objstorage-name }} are complete, the directory marked for deletion will remain and contain the newly uploaded file.

{% endnote %}

## Object URL {#object-url}

You can specify a link to a bucket object in one of the following formats:
- For a bucket with public access:
  - `http(s)://<bucket>.{{ s3-storage-host }}/<key>`
  - `https://{{ s3-storage-host }}/<bucket>/<key>`
- For a bucket with restricted access:
  - `http(s)://<bucket>.{{ s3-storage-host }}/<key>?<parameters>`
  - `https://{{ s3-storage-host }}/<bucket>/<key>?<parameters>`

Where:

* `bucket`: Bucket name.
* `key`: [Key](#key) (file path).
* `parameters`: Additional parameters for accessing a bucket with restricted access, e.g., a signature and validity period.

{% include [public-link](../../_includes/storage/public-link.md) %}

For buckets with restricted access, the service generates temporary pre-signed URLs that allow you to download an object even from a bucket with restricted access. You can read more about pre-signed URLs, their generation, and their use [here](pre-signed-urls.md).

{% include [bucket-https](../../_includes/storage/bucket-https.md) %}

{% include [storage-dotnet-host](../_includes_service/storage-dotnet-host.md) %}

## Metadata {#metadata}

Metadata is stored with an object as `name-value` pairs.

This can be either system or user metadata.

### System metadata {#system-meta}

System metadata is defined by {{ objstorage-name }}.

| Name | Description |
----- | -----
| `Date` | Date and time the request to upload an object to {{ objstorage-name }} was sent. |
| `Content-Length` | Object size in bytes. |
| `Last-Modified` | Date the object was created or last modified. |
| `Content-MD5` | Object MD5 hash value, Base64-encoded. |
| `Cache-Control` | Value of the `Cache-Control` HTTP header provided by the client when saving the object to the bucket. Afterwards, {{ objstorage-name }} returns this header to clients when responding to a request for an object or its metadata.<br/><br/>For example, the `Cache-Control: max-age=200` header means the object expires 200 seconds after the client receives it. You can read more about it in [RFC 7234](https://tools.ietf.org/html/rfc7234#section-5.2). |
| `Expires` | Value of the `Expires` HTTP header provided by the client when saving the object to the bucket. Afterwards, {{ objstorage-name }} returns this header to clients when responding to a request for an object or its metadata.<br/><br/>For example, the `Expires: Thu, 15 Apr 2020 20:00:00 GMT` header means the object expires at 8 pm GMT on April 15, 2020. You can read more about it in [RFC 7234](https://tools.ietf.org/html/rfc7234#section-5.3). |


### User-defined metadata {#user-meta}

When uploading an object to {{ objstorage-name }}, you can provide its metadata as `name-value` pairs.

In an Amazon S3-compatible HTTP API, metadata is provided as HTTP headers. The header name must start with `X-Amz-Meta-`. When an object is requested via HTTP API, {{ objstorage-name }} returns metadata as HTTP headers with the same prefix.

Metadata names must consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII) only. The headers being provided are transformed as follows: `X-Amz-Meta-foo-bar_baz` → `X-Amz-Meta-Foo-Bar_baz`, where `Foo-Bar_baz` is the name of the metadata to store with the object.

{% note info %}

The PUT request header must not exceed 8 KB. The maximum size of user-defined metadata in this header is 2 KB.

{% endnote %}

