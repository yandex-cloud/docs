# Getting started with [!KEYREF objstorage-full-name]

## Before you start {#preparations}

1. Sign up for Yandex.Cloud.

   For more information, see the section [Getting started](../billing/quickstart/index.md) in the documentation on Billing.

1. Select the roles required to work with [!KEYREF objstorage-name]. There are the following options:
    * The `resource-manager.cloud.owner` role for the cloud.
    * A pair of roles:  `resource-manager.cloud.member`  for the cloud and `admin` for the cloud or folder.
    * A pair of roles: `resource-manager.cloud.member` for the cloud and `editor` for the cloud or folder.

1. To assign selected roles:

    [!INCLUDE [grant-role-console](../_includes/grant-role-console.md)]

1. Select the folder where you want to perform the operations. If there is no such folder, create one:

    [!INCLUDE [create-folder](../_includes/create-folder.md)]

1. Click on the **Yandex Object Storage** tile to get to the bucket management page.

## Creating the first bucket {#the-first-bucket}

To create your first bucket in [!KEYREF objstorage-name]:

1. Click **Create bucket**.

1. Enter the bucket name.

   The name must meet the following requirements:

   [!INCLUDE [bucket-name-reqs](../_includes/bucket-name-reqs.md)]

1. Click **Create bucket**.

1. In the bucket, click **Upload objects**.

You can perform operations with buckets and objects not only in the Yandex.Cloud management console, but also using [other tools](instruments/index.md).

