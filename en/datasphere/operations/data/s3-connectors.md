# Connecting to an S3 storage

You can manage your connection to an S3 object storage by using the **{{ ui-key.yc-ui-datasphere.resources.s3 }}** resource on your project page in the {{ ml-platform-name }} interface.

To connect to an object storage from the notebook code, follow the steps given in [{#T}](connect-to-s3.md).

{% include [fuse-disclaimer](../../../_includes/datasphere/fuse-disclaimer.md) %}

## Getting started {#before-begin}

Get an access key from your S3 storage provider. To do this in [{{ objstorage-full-name }}](../../../storage/), follow these steps:

1. [Create a service account](../../../iam/operations/sa/create.md).
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the new account a [role](../../../storage/security/) with either read or read and write permissions.
1. [Create an access key](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account.

## Creating an S3 connector {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Optionally, in the top-right corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.secret }}** and [create a secret](secrets.md#create) with the secret part of the static access key for your service account. You can also create a secret when creating an S3 connector.
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Fill in the fields as follows:
   * **{{ ui-key.yc-ui-datasphere.common.name }}**: Name of the new connector. Follow these naming requirements:

     {% include [name-format](../../../_includes/name-format-2.md) %}

   * **{{ ui-key.yc-ui-datasphere.common.description }}**: Description of the new connector. This is an optional parameter.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}**: Storage host. For {{ objstorage-name }}, set it to `https://{{ s3-storage-host }}/`.
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}**: Name of the storage bucket.

     {% note warning %}

     Do not use buckets with periods in their names for connection. You can learn more about buckets [here](../../../storage/concepts/bucket.md).

     {% endnote %}

   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}**: Name of the volume for mounting the bucket into the project file system. The naming requirements are as follows:

     {% include [name-format](../../../_includes/name-format.md) %}

   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}**: ID of the static access key used to connect to the storage.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}**: In the list, select a [secret](../../concepts/secrets.md) that contains the secret part of the static access key or create a new secret.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mode }}**: Object storage access mode, **{{ ui-key.yc-ui-datasphere.s3-page.mode-read }}** or **{{ ui-key.yc-ui-datasphere.s3-page.mode-read-write }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

{% include [s3-connectors-nat-gateway](../../../_includes/datasphere/s3-connectors-nat-gateway.md) %}

## Attaching an S3 storage to a project {#mount}

Go to the S3 connector page and click **{{ ui-key.yc-ui-datasphere.common.activate }}**. Once activated, the bucket will be available in the `/s3/` folder of the {{ jlab }}Lab file browser, and you will be able to view it as a file system.

## Using an S3 storage in a project {#usage}

You can access files in the connected bucket from your project code. Select the file you need in the attached S3 storage on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click it, and select **Copy path**. This will copy the file path to the clipboard. Paste the copied path wherever you need in the project.

## Detaching an S3 storage {#unmount}

1. On the project page, under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Select the connector and go to the resource page.
1. Click **{{ ui-key.yc-ui-datasphere.common.deactivate }}** in the top-right corner of the page.

You can re-attach the S3 storage to your project whenever you need it.

## Sharing an S3 connector {#share}

{% include [zones](../../../_includes/datasphere/zones.md) %}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/console-icons/bucket.svg) **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Select the S3 connector from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community you want to share the S3 connector with.

To make an S3 connector available for use in a different project, the project admin needs to [add](../projects/use-shared-resource.md) it on the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

## Deleting an S3 connector {#delete}

You can only delete a [deactivated](#unmount) connector that is not available to any community.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../../_assets/console-icons/bucket.svg)**{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Next to the S3 storage, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

You will see a message saying that the secret has been deleted.

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}
