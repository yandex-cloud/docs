# Getting started with {{ objstorage-full-name }}

{{ yandex-cloud }} provides a universal scalable solution for data storage, {{ objstorage-full-name }}. The solution is a perfect choice both for high-load services that require reliable and fast access to data, and for projects with minimal requirements for storage infrastructure.

In {{ objstorage-name }} terms, files and folders are called [objects](concepts/object.md). All objects are stored in [buckets](concepts/bucket.md). The service has a flat storage structure for bucket objects, but GUI-based tools let you use Object Storage as a hierarchical file system.

The Object Storage API is partially compatible with the AWS S3 API, so you can use the [tools](tools/index.md) designed to work with S3.

In this section, you will learn how to:

1. [Create buckets](#the-first-bucket) for storing data.
1. [Upload files to buckets](#upload-files).
1. [Get a file download link](#get-link).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and sign in to {{ yandex-cloud }} or sign up if you are not signed up yet.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. On the [{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}]({{ link-console-access-management }}) page, make sure you have the `editor` role or higher. The role must be assigned to the folder you will be working with or the cloud the folder belongs to.

## Creating the first bucket {#the-first-bucket}

To create your first bucket in {{ objstorage-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
1. Enter the name of the bucket.

   The bucket name must be unique across {{ objstorage-name }}. It is used as part of the data access URL and is visible to your data users.
1. Limit the maximum bucket size, if required.

   {% include [storage-no-max-limit](_includes_service/storage-no-max-limit.md) %}

1. To make sure the uploaded files are always available from outside {{ yandex-cloud }}, select the public [access type](concepts/bucket.md#bucket-access). Otherwise, you will need to create a temporary link to provide access to such files.
1. Choose the default [storage class](concepts/storage-class.md) to be used when uploading objects:
   * _Standard storage_ is designed for storing frequently used objects.
   * _Cold storage_ is designed for long-term storage of objects that are rarely read.
   * _Ice storage_ is designed for storing objects that are very rarely read for one year and longer.
1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}** to complete the operation.

## Uploading files to a bucket {#upload-files}

To upload an object to a bucket:

1. In the [management console]({{ link-console-main }}), select the appropriate folder.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Click the name of the bucket you need.
1. To upload files to the bucket, drag them to the bucket screen or click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.

## Getting a file download link {#get-link}

To get a link to an uploaded object:

{% include [storage-get-link-for-download](_includes_service/storage-get-link-for-download.md) %}

You can share the received link or use it in your service to access the file.

To perform operations with buckets and objects, you can use [other tools](tools/index.md) in addition to the {{ yandex-cloud }} management console.
