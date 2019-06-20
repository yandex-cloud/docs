# Multipart upload

{{ objstorage-name }} allows storing objects that are up to several terabytes in size (see the section [#T](limits.md)). The larger the object, the more likely it is that the upload will fail with a network error. For this reason, it is more efficient to upload larger objects in smaller parts. This way of sending objects to {{ objstorage-name }} is called multipart upload. For more information about multipart upload support, see the section [#T](../s3/api-ref/multipart.md).

Multipart upload is supported by many of the tools listed in the section [#T](../instruments/index.md).

You might see the following messages in a bucket overview in the Cloud management console:

- "N incomplete uploads."
- "Wait for uploading to finish, or use the tool of your choice to end or delete the upload processes."
- "Some multipart uploads are incomplete."

All of these messages indicate that there are incomplete multipart uploads in your bucket. Pay attention to these messages, since space for storing an object that is not fully uploaded costs the same as usual. Read the section [#T](../pricing.md).

