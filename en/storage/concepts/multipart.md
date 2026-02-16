# Multipart upload

{{ objstorage-name }} allows you to store objects that are up to several terabytes in size (see [{#T}](limits.md) for details). The larger the object, the more likely the upload will fail with a network error. For this reason, it is more efficient to upload large objects in smaller parts. This method of sending objects to {{ objstorage-name }} is called a multipart upload. For more information about multipart upload support, see [{#T}](../s3/api-ref/multipart.md).

Many of the tools listed in [{#T}](../tools/index.md) support multipart uploads.

After opening a bucket overview in the {{ yandex-cloud }} management console, you may see the following messages:

- "N incomplete uploads."
- "Wait for the upload to complete or use the tool of your choice to end or delete the upload processes."
- "Some multipart uploads are not complete."

All these messages indicate that there are incomplete multipart uploads in your bucket. Do not ignore such messages, since you pay for storing an object even if it has not been fully uploaded. See [{#T}](../pricing.md).

To delete an incomplete upload manually, follow [this guide](../operations/objects/deleting-multipart.md). You can also schedule auto-deletion of incomplete uploads for a bucket. To do this, create a [lifecycle](lifecycles.md) using the `AbortIncompleteMultipartUpload` action (for more information, see [this guide](../operations/buckets/lifecycles.md)).

