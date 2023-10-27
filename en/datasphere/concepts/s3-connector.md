# S3 connector

{{ ml-platform-name }} allows you to connect to an S3 object storage using a special type of resource, _S3 connector_.

An S3 connector is a resource that stores settings for connection to buckets of cloud services, such as [{{ objstorage-full-name }}](../../storage/). Upon connection to a bucket, you will see its objects in the {{ jlab }} Notebook interface.

Connectors are created in the project and assigned to it. The connector's static key value is stored in a [secret](secrets.md)-encrypted format.

{% include [fuse-disclaimer](../../_includes/datasphere/fuse-disclaimer.md) %}

## Information on an S3 connector as a resource {#info}

The system stores the following information about each S3 connector:

* Unique resource ID
* Description
* Endpoint
* Bucket name
* ID and static key value
* Operating mode
* Backend
* Resource creator
* Date when the resource was created and last modified, in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, such as `July 18, 2022, 14:23`.

## Working with S3 connectors {#work}

You can [create](../operations/data/s3-connectors.md) an S3 connector in the [{{ ml-platform-name }} interface]({{ link-datasphere-main }}). To make objects from the bucket visible in {{ jlab }}, [activate](../operations/data/s3-connectors.md#mount) the S3 connector. If you no longer need the connection, [deactivate it](../operations/data/s3-connectors.md#unmount).

Once created, your S3 connector becomes available for the project. The community administrator can share an S3 connector with other community projects. For this, they should grant access to it under the **{{ ui-key.yc-ui-datasphere.common.access }}** tab on the S3 connector view page. The resource available to the community will appear on the community page under **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

#### See also {#see-also}

* [Connecting to an S3 storage using an S3 connector](../operations/data/s3-connectors.md)