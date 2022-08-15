# Getting started with {{ objstorage-full-name }}

{{ objstorage-full-name }} is a universal scalable solution for data storage. It is the perfect choice both for high-load services that require reliable and fast access to data, and for projects with minimal requirements for storage infrastructure.

In {{ objstorage-name }} terms, files and folders are called [objects](concepts/object.md). All objects are stored in [buckets](concepts/bucket.md). The service has a flat storage structure for bucket objects, but GUI-based tools let you use Object Storage as a hierarchical file system.

The Object Storage API is partially compatible with the AWS S3 API, so you can use [tools](tools/index.md) designed to work with S3.

In this section, you'll learn how to:

1. [Create buckets](#the-first-bucket) for storing data.
1. [Upload files to buckets](#upload-files).
1. [Get links to download files](#get-link).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.
1. On the [Billing]({{ link-console-billing }}), make sure that a [billing account](../billing/concepts/billing-account.md) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the `editor` role or higher. The role must be assigned for the folder where you'll work or the cloud that the folder belongs to.

## Creating the first bucket {#the-first-bucket}

To create your first bucket in {{ objstorage-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.

1. Click **Create resource** and select **Bucket**.

1. Enter the name of the bucket.

    The bucket name must be unique across {{ objstorage-name }}. It's used as part of the data access URL and is visible to your data users.

1. If necessary, limit the maximum bucket size.

    {% include [storage-no-max-limit](_includes_service/storage-no-max-limit.md) %}

1. To make sure that uploaded files are always available from outside {{ yandex-cloud }}, select the public [access type](concepts/bucket.md#bucket-access). Otherwise, you'll need to create a temporary link to provide access to such files.

1. Choose the default [storage class](concepts/storage-class.md) to be used when uploading objects:
    * _Standard storage_ is designed for storing frequently used objects.
    * _Cold storage_ is designed for long-term storage of objects that are rarely read.

1. Click **Create bucket** to complete the operation.

## Uploading files to a bucket {#upload-files}

To upload an object to a bucket:

1. In the [management console]({{ link-console-main }}), select a folder.
1. Select **{{ objstorage-short-name }}**.
1. Click the name of the desired bucket.
1. To upload files to the bucket, drag them to the bucket screen or click **Upload**.

## Getting a file download link {#get-link}

To get a link to an uploaded object:

{% include [storage-get-link-for-download](_includes_service/storage-get-link-for-download.md) %}

You can share the received link or use it in your service to access the file.

To perform operations with buckets and objects, you can use [other tools](tools/index.md) in addition to the {{ yandex-cloud }} management console.
