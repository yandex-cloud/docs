# Multipart upload

{{ objstorage-name }} allows storing objects that are up to several terabytes{% if audience != "internal" %} in size (see the section [{#T}](limits.md)){% endif %}. The larger the object, the more likely the upload will fail with a network error. For this reason, it is more efficient to upload larger objects in smaller parts. Sending objects to {{ objstorage-name }} like this is called a multipart upload. For more information about multipart upload support, see [{#T}](../s3/api-ref/multipart.md).

Multipart upload is supported by many of the tools listed in the section [{#T}](../tools/index.md).

You might see the following messages in a bucket overview in the {{ yandex-cloud }} management console:

- "N incomplete uploads."
- "Wait for uploading to finish, or use the tool of your choice to end or delete the upload processes."
- "Some multipart uploads are incomplete."

All of these messages indicate that there are incomplete multipart uploads in your bucket. Pay attention to these messages, since space for storing an object that is not fully uploaded costs the same as usual.{% if audience != "internal" %} Read the section [{#T}](../pricing.md).{% endif %}

To delete an incomplete upload manually, follow the [instructions](../operations/objects/deleting-multipart.md). You can also set up scheduled auto deletion of incomplete uploads for a bucket. To do this, create a [lifecycle](lifecycles.md) (the `AbortIncompleteMultipartUpload` action, for more information, see the [instructions](../operations/buckets/lifecycles.md)).

