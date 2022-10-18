# Creating a test with data from a bucket

You can upload payloads from a [{{ objstorage-full-name }}](../../storage/) [bucket](../../storage/concepts/bucket.md) to {{ load-testing-name }}. This method allows you to:
* Handle large volumes of payloads (over 100 MB).
* Store payloads and reuse them easily.
* Ensure maximum security (payloads remain in the user's cloud and associated networks).

## Preparing an infrastructure {#infrastructure-prepare}

1. [Create](create-agent.md) a test agent.
1. Link a bucket to {{ load-testing-name }}:
   1. In the [management console]({{ link-console-main }}), select the folder for testing.
   1. In the list of services, select **{{ load-testing-name }}**.
   1. On the ![image](../../_assets/load-testing/storage.svg) **Test data storage** tab, click **Link bucket**.
   1. Select the bucket.
1. [Upload](../../storage/operations/objects/upload.md) a payload file to the bucket.
1. Grant the service account linked to the [agent](../concepts/agent.md) read permission in the bucket. To do this, edit the bucket's [ACL](../../storage/concepts/acl.md):
   1. In the [management console]({{ link-console-main }}), select the folder where the bucket is located.
   1. In the list of services, select **{{ objstorage-name }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate bucket and select **Bucket ACL**.
   1. In the window that opens, enter the service account name, select the `READ` permissions to the bucket, and click **Add**.
   1. Click **Save**.

   This grants the service account permission to read data from this bucket only.

   {% note info %}

   As an alternative to editing the bucket's ACL, you can [assign](../../iam/operations/roles/grant.md#access-to-sa) the service account the `storage.editor` [role](../../storage/security/#storage-editor).

   This method is less secure, since it allows the service account to perform any operations with all buckets in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder): creating, deleting, and updating a bucket, or granting public access to them.

   {% endnote %}

## Creating a test {#create-test}

1. In the [management console]({{ link-console-main }}), select the folder for testing.
1. In the list of services, select **{{ load-testing-name }}**.
1. On the ![image](../../_assets/load-testing/test.svg) **Tests** tab, click **Create test**.
1. Select a test agent and [log group](../../logging/concepts/log-group.md) or create them.
1. Under **Test data**:
   1. Select a data transfer method: **Bucket**.
   1. Find the bucket in the drop-down list and specify the path to the payload file. If the file was not uploaded before:

      1. Select a data transfer method: **Local file**.
      1. Click **Select file** and upload a payload file from your computer.
      1. Enable the **Save to {{ objstorage-name }}** option.
      1. Select or [create](../../storage/operations/buckets/create.md) a bucket to save data to.

1. Depending on the selected configuration type, set the parameters under **Test settings**:

   {% include [test settings](../../_includes/load-testing/test-settings.md) %}

1. Click **Create**.