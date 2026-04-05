1. [Get your cloud ready](#before-begin).
1. [Create your infrastructure](#deploy).
1. [Create a table](#create-table).
1. [Test the application](#test-app).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](paid-resources.md) %}


## Create an infrastructure {#deploy}

{% include [terraform-definition](../terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing {{ yandex-cloud }} (see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-serverless-video-gif-converter.git
        ```

     1. Navigate to the repository directory. It should now contain the following files:
        * `video-converting.tf`: New infrastructure configuration.
        * `ffmpeg-api.zip`: API function archive.
        * `src.zip`: Converter function archive.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `video-converting.tf` configuration file:

           {% cut "video-converting.tf" %}

           {% include [video-converting-tfconfig](video-converting-tfconfig.md) %}

           {% endcut %}

        1. For an API function:
           1. Create a file named `index.py` and paste this content into it:

              {% cut "index.py for an API function" %}

              {% include [index-api-code](index-api-code.md) %}

              {% endcut %}

           1. Create a file named `requirements.txt` and specify these libraries in it:

               ```text
               boto3
               yandexcloud
               ```

           1. In the folder, create an archive named `ffmpeg-api.zip` containing the files `requirements.txt` and `index.py`.

        1. For a converter function:
           1. Create a file named `index.py` and paste this content into it:

              {% cut "index.py for a converter function" %}

              {% include [index-converter-code](index-converter-code.md) %}

              {% endcut %}

           1. Create a file named `requirements.txt` and specify these libraries in it:

               ```text
               boto3
               requests
               yandexcloud
               ```

           1. Prepare the FFmpeg executable. On [FFmpeg's official website](http://ffmpeg.org/download.html), navigate to the **Linux Static Builds** section, download the 64-bit FFmpeg archive, and make the file executable by running the `chmod +x ffmpeg` command.

           1. In the folder, create an archive named `src.zip` containing the files `requirements.txt` and `index.py`, and the FFmpeg executable.

   {% endlist %}

   Learn more about the properties of {{ TF }} resources in the relevant provider guides:
   * [Service account](../../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Role](../../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Secret]({{ tf-provider-resources-link }}/lockbox_secret): [yandex_lockbox_secret](../../../lockbox/concepts/secret.md).
   * [Secret version](../../../lockbox/concepts/secret.md#version): [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/yandex_lockbox_secret_version).
   * [Message queue](../../../message-queue/concepts/queue.md): [yandex_message_queue]({{ tf-provider-resources-link }}/message_queue).
   * [Database (YDB)](../../../message-queue/concepts/queue.md): [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless).
   * [Bucket](../../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/yandex_storage_bucket)
   * [Bucket object](../../../storage/concepts/object.md): [yandex_storage_object]({{ tf-provider-resources-link }}/yandex_storage_object).
   * [Function](../../../functions/concepts/function.md): [yandex_function]({{ tf-provider-resources-link }}/yandex_function).
   * [Trigger](../../../functions/concepts/trigger/ymq-trigger.md): [yandex_function_trigger]({{ tf-provider-resources-link }}/yandex_function_trigger).

1. In the `video-converting.tf` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `bucket`: Bucket name.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

After you have created the infrastructure, [create a table](#create-table) in YDB.




## Create a table {#create-table}

1.  [Create a table](../../../ydb/operations/schema.md#create-table)  in YDB:

    * **{{ ui-key.yacloud.ydb.table.form.field_name }}**: `tasks`.
    * **{{ ui-key.yacloud.ydb.table.form.field_type }}**: [{{ ui-key.yacloud.ydb.table.form.label_document-table }}](../../../ydb/operations/schema.md#create-table).
    * **{{ ui-key.yacloud.ydb.table.form.label_columns }}**: One column named `task_id` of the `String` type. Set the [{{ ui-key.yacloud.ydb.table.form.column_shard }}](../../../ydb/operations/schema.md#create-table) attribute.

After you have created the table, [test the application](#test-app).



## Test the application {#test-app}

{% include [test-app](test-app.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `video-converting.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}
