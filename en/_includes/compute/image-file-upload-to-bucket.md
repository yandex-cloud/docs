Upload your image file to {{ objstorage-name }} and get a shareable link:

1. If you have no [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md) yet, [create](../../storage/operations/buckets/create.md) one with restricted access.
1. Upload your image to the bucket via the [management console](../../storage/operations/objects/upload.md), [AWS CLI](../../storage/tools/aws-cli.md), or [WinSCP](../../storage/tools/winscp.md). In {{ objstorage-name }} terminology, your uploaded image will be called an _object_.
1. [Get](../../storage/operations/objects/link-for-download.md) a signed [link](../../storage/concepts/pre-signed-urls.md) to download the image from the bucket. Use this link when creating an image in {{ compute-name }}.