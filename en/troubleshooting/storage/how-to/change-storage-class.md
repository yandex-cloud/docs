# How to change the storage class



## Case description {#case-description}

You need to change the storage class or figure out whether the change will apply to already stored objects.

## Solution {#case-resolution}

Changing the storage class in the bucket properties only applies to objects that are newly uploaded to the bucket. If the objects have already been uploaded using another storage class, their storage type will not be exposed to automatic changes.

You can change the storage class for such objects using the lifecycle policy. To learn how to do this, see [this guide](../../../storage/concepts/lifecycles.md).

{% note info %}

Lifecycle policies in {{ objstorage-name }} trigger at 00:00 UTC daily.

{% endnote %}

To change the storage class for previously uploaded objects, you can also use graphical or console S3 clients:

* [WinSCP](../../../storage/tools/winscp.md)
* [CyberDuck](../../../storage/tools/cyberduck.md)
* [AWS CLI](../../../storage/tools/aws-cli.md)
* [s3cmd](../../../storage/tools/s3cmd.md)