# Multipart upload

{{ objstorage-name }} lets you store objects that are up to several terabytes in size (see [{#T}](limits.md)). The larger the object, the more likely the upload will fail with a network error. For this reason, it is more efficient to upload larger objects in smaller parts. Sending objects to {{ objstorage-name }} like this is called a multipart upload. For more information about multipart upload support, see [{#T}](../s3/api-ref/multipart.md).

Many of the tools listed in [{#T}](../tools/index.md) support multipart uploads.

You might see the following messages in a bucket overview in the {{ yandex-cloud }} management console:

- "N incomplete uploads."
- "Wait for uploading to finish, or use the tool of your choice to end or delete the upload processes."
- "Some multipart uploads are incomplete."

All of these messages indicate that there are incomplete multipart uploads in your bucket. Pay attention to these messages, since space for storing an object that is not fully uploaded costs the same as usual. See [{#T}](../pricing.md).

To automatically delete all parts of an incomplete multipart upload, configure the `AbortIncompleteMultipartUpload` parameter.

{% note info %}

You can't see or delete partially uploaded objects in the management console. To do this, use tools that support multipart uploads. You can find an example of how to delete objects in [operations](../operations/objects/deleting-multipart.md).

{% endnote %}

