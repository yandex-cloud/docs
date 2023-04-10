# Multipart upload

{{ objstorage-name }} allows you to store objects up to several terabytes in size (see [{#T}](limits.md) for details). The larger the object, the more likely the upload will fail with a network error. For this reason, it is more efficient to upload larger objects in smaller parts. This method of sending objects to {{ objstorage-name }} is called a multipart upload. For more information about multipart upload support, see [{#T}](../s3/api-ref/multipart.md).

Multipart upload is supported by many of the [{#T}](../tools/index.md).

After opening a bucket overview in the {{ yandex-cloud }} management console, you might see the following messages:

- "N incomplete uploads."
- "Wait for the upload to complete or use the tool of your choice to end or delete the upload processes."
- "Some multipart uploads are not complete."

All these messages indicate that there are incomplete multipart uploads in your bucket. Do not ignore such messages, since the cost for storing an object is the same, regardless of whether it has fully uploaded. For details, see [{#T}](../pricing.md).

To delete an incomplete upload manually, follow [this guide](../operations/objects/deleting-multipart.md). You can also schedule auto-deletion of incomplete uploads for a bucket. To do this, create a [lifecycle](lifecycles.md) using the `AbortIncompleteMultipartUpload` action (for more information, see [this guide](../operations/buckets/lifecycles.md)).

