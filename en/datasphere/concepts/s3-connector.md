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
* Creation and last update date in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, such as `July 18, 2022, 14:23`

## Working with S3 connectors {#work}

You can [create](../operations/data/s3-connectors.md) an S3 connector in the [{{ ml-platform-name }} interface]({{ link-datasphere-main }}). To make objects from the bucket visible in {{ jlab }}, [activate](../operations/data/s3-connectors.md#mount) the S3 connector. If you no longer need the connection, [deactivate it](../operations/data/s3-connectors.md#unmount).

Once created, your S3 connector becomes available for the project. Like any other resource, you can publish the S3 connector in the community to use it in other projects. To do this, you need at least the `Editor` role in the project and the `Developer` role in the community in which you want to publish it. You can open the access on the **{{ ui-key.yc-ui-datasphere.common.access }}** tab on the S3 connector view page. The resource available to the community will appear on the community page under **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

{% include [s3-connectors-nat-gateway](../../_includes/datasphere/s3-connectors-nat-gateway.md) %}

## Use cases {#examples}

* [Connecting to an S3 storage using an S3 connector](../operations/data/s3-connectors.md)
* [{#T}](../tutorials/s3-to-datasphere.md)
