---
title: "How to create a test with data from a bucket in {{ load-testing-full-name }}"
description: "Follow this guide to create a test with data from a bucket."
---

# Creating a test with data from a bucket

You can upload payloads from a [{{ objstorage-full-name }}](../../storage/) [bucket](../../storage/concepts/bucket.md) to {{ load-testing-name }}. This method allows you to:
* Handle large volumes of payloads (over 100 MB).
* Store payloads and reuse them easily.
* Ensure maximum security (payloads remain in the user's cloud and associated networks).

## Preparing the infrastructure {#infrastructure-prepare}

1. [Create](create-agent.md) a test agent.
1. [Create](../../storage/operations/buckets/create.md) a bucket and [upload](../../storage/operations/objects/upload.md) the test data file into it.
1. Grant the service account linked to the [agent](../concepts/agent.md) read permission in the bucket. To do this, edit the bucket's [ACL](../../storage/concepts/acl.md):
   1. In the [management console]({{ link-console-main }}), select the folder where the bucket is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate bucket and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
   1. In the window that opens, enter the service account name, select the `READ` permissions to the bucket, and click **{{ ui-key.yacloud.common.add }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

   This grants the service account permission to read data from this bucket only.

   {% note info %}

   As an alternative to editing the bucket ACL, you can [assign](../../iam/operations/roles/grant.md#access-to-sa) the service account the `storage.editor` [role](../../storage/security/#storage-editor).

   This method is less secure, since it allows the service account to perform any operations with all buckets in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder): creating, deleting, and updating a bucket, or granting public access to them.

   {% endnote %}

## Creating a test {#create-test}


1. In the [management console]({{ link-console-main }}), select the folder for testing.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. Select a test agent or create a new one.
1. (Optional) Select or create a [log group](../../logging/concepts/log-group.md).
1. Under **Attached files**:
   1. Click **{{ ui-key.yacloud.load-testing.label_choose-from-bucket }}**.
   1. Find the bucket in the drop-down list and specify the path to the payload file.

   Alternatively, you can **Select files** from your computer. In this case, you will have to reupload the files every time you run the test.

1. Depending on the selected configuration type, set the parameters under **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

   {% include [test settings](../../_includes/load-testing/test-settings.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.