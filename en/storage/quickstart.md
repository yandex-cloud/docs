# Getting started with {{ objstorage-full-name }}

This section describes how to create your first bucket in {{ objstorage-name }}.

The Object Storage API is partially compatible with the AWS S3 API, so you can use [tools](instruments/index.md) designed to work with S3.

## Before you start {#preparations}

1. Sign up for Yandex.Cloud.

   For more information, see the section [Getting started](../billing/quickstart/index.md) in the documentation on Billing.

1. Get the roles required to work with {{ objstorage-name }}. Select one of the options:
    * The `resource-manager.clouds.owner` role for the cloud.
    * Role pair: `resource-manager.clouds.member` for the cloud and `admin` for the cloud or folder.
    * Role pair: `resource-manager.clouds.member` for the cloud and `editor` for the cloud or folder.

1. To assign roles:

    {% include [grant-role-console](../_includes/grant-role-console.md) %}

1. Select the folder where you want to perform the operations. If there is no such folder, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. Select **Yandex Object Storage** to go to the bucket management page.

## Creating the first bucket {#the-first-bucket}

To create your first bucket in {{ objstorage-name }}:

1. Click **Create bucket**.

1. Enter the name of the bucket.

   The name must meet the following requirements:

   {% include [bucket-name-reqs](../_includes/bucket-name-reqs.md) %}

1. Click **Create bucket**.

1. In the bucket, click **Upload objects**.

To perform operations with buckets and objects, you can use [alternative tools](instruments/index.md) in addition to the Yandex.Cloud management console.

