# How to change the storage class


## Scenario description {#case-description}

You need to change the storage class and figure out whether the change will apply to already stored objects.

## Solution {#case-resolution}

Changing the storage class in the bucket properties only applies to objects that are newly uploaded to the bucket.
If objects have already been uploaded previously using another storage class, the storage type for them will not automatically change to the new one.

You can change the storage class for such objects using the lifecycle policy. To learn how to do this, see the [documentation](https://server-yfm.website.yandexcloud.net/server-yfm-512b5eed-aa26-4020-9137-a0cd5f030640-yc/ru/ru/storage/concepts/lifecycles).

{% note info "Note title" %}

Lifecycle policies in {{ objstorage-short-name }} trigger at 00:00 UTC daily.

{% endnote %}

To change the storage class for previously uploaded objects, you can also use graphical or console S3 clients:

* [WinSCP](../../../storage/tools/winscp.md)

* [CyberDuck](../../../storage/tools/cyberduck.md)

* [AWS CLI](../../../storage/tools/aws-cli.md);

* [s3cmd](../../../storage/tools/s3cmd.md).