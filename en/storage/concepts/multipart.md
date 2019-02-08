# Multipart upload

[!KEYREF objstorage-name] allows storing objects of the size up to several terabytes (see the section [[!TITLE]](limits.md)). The larger the object, the more likely it is that the download will fail with a network error. Therefore, larger objects are more efficiently uploaded in smaller parts. This way of sending objects to [!KEYREF objstorage-name] is called multipart upload. For more information about multipart upload support, see the section [[!TITLE]](../s3/api-ref/multipart.md).

Multipart upload is supported by many of the tools listed in the section [[!TITLE]](../instruments/index.md).

In the Cloud management console, you can see the following messages in the overview of a bucket:

- "N incomplete downloads."
- "Wait for the downloads to finish, or complete/delete them using whatever tool is convenient for you."
- "There are unfinished multipart uploads."

All of these messages indicate that there are incomplete multipart downloads in your bucket. Pay attention to these messages, since space for storing an object that is not fully uploaded costs the same as usual. Read the section [[!TITLE]](../pricing.md).

