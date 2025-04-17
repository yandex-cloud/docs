---
title: How to create a test with data from a bucket in {{ load-testing-full-name }}
description: Follow this guide to create a test with data from a bucket.
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
    1. In the [management console]({{ link-console-main }}), select the folder the bucket is in.
    1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the bucket and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
    1. In the window that opens, enter the service account name, select `READ` for bucket permissions, and click **{{ ui-key.yacloud.common.add }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

    This grants the service account permission to read data from this bucket only.

    {% note info %}

    As an alternative to editing the bucket ACL, you can [assign](../../iam/operations/roles/grant.md) the `storage.editor` [role](../../storage/security/#storage-editor) to the service account. 

    This method is less secure, since it allows the service account to perform any operations with all buckets in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder): creating, deleting, and updating a bucket, or granting public access to them.

    {% endnote %}

## Creating a test {#create-test}



{% list tabs group=instructions %}

- Management console {#console}
  1. In the [management console]({{ link-console-main }}), select the folder for testing.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. In the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-test }}**.
  1. [Select](../concepts/agent-select.md) a test agent or create a new one.
  1. Under **Attached files**:
      1. Click **{{ ui-key.yacloud.load-testing.label_choose-from-bucket }}**.
      1. Find the bucket in the drop-down list and specify the path to the payload file.

      Alternatively, you can **Select files** from your computer. In this case, you will have to reupload the files every time you run the test.

  1. Depending on the selected configuration type, set the parameters under **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

      {% include [test settings](../../_includes/load-testing/test-settings.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../cli/) command for creating a test:

     ```bash
     yc loadtesting test create --help
     ```

  1. Upload the YAML configuration file for your test:

     ```bash
     yc loadtesting test-config create --from-yaml-file <file_path>
     ```

  1. Upload the [test data](../../load-testing/concepts/payload). To do this, create an [IAM token](../../ydb/terraform/credentials):

     ```bash
     export YC_TOKEN=$(yc iam create-token)
     export TEST_PAYLOAD_FILE="sample/_requests.uri"
     export S3_PAYLOAD_BUCKET="my_bucket"
     export S3_PAYLOAD_FILENAME="my_requests.uri"
     curl -H "X-YaCloud-SubjectToken: ${$YC_TOKEN}" --upload-file - "https://storage.yandexcloud.net/${$S3_PAYLOAD_BUCKET}/${$S3_PAYLOAD_FILENAME}" < ${$TEST_PAYLOAD_FILE}
     ```

  1. Create a test in the default [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     loadtesting test create \
     --name "yc-examples-test" \
     --description "Test has been created using YC" \
     --labels source=gh,type=tutorial \
     --configuration id=ff6hvk749g71********,agent-id=ff633vbrst7a********,test-data=requests.uri \
     --test-data name=requests.uri,s3bucket=my_bucket,s3file=my_requests.uri
     ```

     Where:
     * `--name`: Test name.
     * `--description`: Test description.
     * `--labels`: Test [labels](../../resource-manager/concepts/labels.md).
     * `--configuration`: Test configuration parameters:
         * `id`: Test configuration ID. Specify the ID of the configuration file you uploaded in Step 2. To get the list of configuration IDs, run the `yc loadtesting test-config list` command.
         * `agent-id`: Test agent ID.
         * `test-data`: Test data file name.
     * `--test-data`: Test data settings:
         * `name`: Test data object name.
         * `s3bucket`: Name of the bucket storing the test data.
         * `s3file`: Name of the test data file in the bucket.

     For more information on how to create a test with the CLI, see the [Yandex Cloud Examples repository](https://github.com/yandex-cloud-examples/yc-load-testing-start-test).

  1. To view the list of tests in the folder for loadtesting using the CLI, run the following command:

     ```bash
     yc loadtesting test list
     ```

     For more information on using the CLI to view test info, see the [Yandex Cloud Examples repository](https://github.com/yandex-cloud-examples/yc-load-testing-list-tests).
    

{% endlist %}