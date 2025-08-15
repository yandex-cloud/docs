# Using file storages

With {{ ml-platform-name }} [file storages](../../concepts/filestores.md), you can store large amounts of information and access it from your notebooks.

## Creating a file storage {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. Click **{{ ui-key.yc-ui-datasphere.filestore.create-filestore }}**.
1. In the window that opens, enter a name for the file storage in the **{{ ui-key.yc-ui-datasphere.common.name }}** field.

   {% include [name-format-2](../../../_includes/name-format-2.md) %}

1. In the **{{ ui-key.yc-ui-datasphere.filestore.mount-path-key-value }}** field, enter the name you are going to use to connect to the file storage. The connection name may contain only Latin letters and digits and must begin with a slash, e.g., `/filestore`.
1. Under **Storage volume, GB**, set the storage size you need. At the bottom of the window, you will see the total cost of storage per month.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. This will open the page with information on the file storage you just created.

## Attaching a file storage to a project {#mount}

Go to the file storage page and click **{{ ui-key.yc-ui-datasphere.common.activate }}**. Once activated, the file storage will be available in the `/filestore/` folder of the {{ jlab }}Lab file browser, and you will be able to view it as a file system.

## Using a file storage in a project {#usage}

You can access files in the storage from your project code. Right-click the file you need and select **Copy path**. This will copy the file path to the clipboard. Paste the copied path wherever you need in the project.

## Detaching a file storage {#deactivate}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. Next to the file storage, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.deactivate }}**.

## Updating a file storage {#change}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. Next to the file storage, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Update the file storage: edit its name and connection name and add a description as needed.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Sharing a file storage {#share}

{% include [zones](../../../_includes/datasphere/zones.md) %}

To share a file storage within a community, you need the `Editor` role for the project and the `Developer` role for the community. To learn more about roles in {{ ml-platform-name }}, see [{#T}](../../security/index.md).

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. Select the file storage from the list.
1. Navigate to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community you want to share the file storage in.

To make a file storage available in a different project, the project admin has to [add](../projects/use-shared-resource.md) that storage on the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

{% include [filestore-upload-warning](../../../_includes/datasphere/filestore-upload-warning.md) %}

## Deleting a file storage {#delete}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![filestore](../../../_assets/console-icons/cube.svg) **{{ ui-key.yc-ui-datasphere.resources.filestore }}**.
1. Next to the file storage, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

You will see a message stating that the file storage has been deleted.

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}