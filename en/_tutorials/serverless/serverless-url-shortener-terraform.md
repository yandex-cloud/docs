1. [Get your cloud ready](#before-begin).
1. [Create the infrastructure](#deploy).
1. [Test the URL shortener](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [serverless-paid-resources](../../_includes/serverless/serverless-url-shortener/paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create your infrastructure via {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [obtain authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider. For details, see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1.
1. Set up your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository containing the configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-serverless-url-shortener.git
        ```

     1. Navigate to the repository directory. It should now contain the following files:
         * `serverless-url-shortener.tf`: New infrastructure configuration.
         * `serverless-url-shortener.auto.tfvars`: User data file.
         * `index.html`: Your service HTML page.
         * `function.zip`: {{ sf-name }} function code archive.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `serverless-url-shortener.tf` configuration file:

           {% cut "serverless-url-shortener.tf" %}

           {% include [serverless-url-shortener](../../_includes/serverless/serverless-url-shortener/tf-config.md) %}

           {% endcut %}

        1. `serverless-url-shortener.auto.tfvars` user data file:

           {% cut "serverless-url-shortener.auto.tfvars" %}

           ```hcl
           cloud_id    = "<cloud_ID>" 
           folder_id   = "<folder_ID>"
           bucket_name = "<bucket_name>"
           ```

           {% endcut %}

        1. The `index.html` page of your service:

           {% cut "index.html" %}

           {% include [serverless-index-html-config](../../_includes/serverless/serverless-url-shortener/html-config.md) %}

           {% endcut %}

        1. `index.py` file with the {{ sf-name }} function code:

           {% cut "index.py" %}

           {% include [serverless-function-config](../../_includes/serverless/serverless-url-shortener/function-config.md) %}

           {% endcut %}

        1. The `requirements.txt` file with environment parameters for the function in {{ sf-name }}:

           {% include [serverless-requirements](../../_includes/serverless/serverless-url-shortener/requirements.md) %}

     1. In the folder, create an archive named `function.zip` containing the files `requirements.txt` and `index.py`.

     1. In the `serverless-url-shortener.auto.tfvars` file, specify these custom settings:

          * `cloud_id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
          * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
          * `bucket_name`: Name of the [bucket](../../storage/concepts/bucket.md) to create the resources in.

   {% endlist %}
   
   For more information about {{ TF }} resource properties, see the relevant provider guides:
   
   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Static key](../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
   * [Bucket](../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket)
   * [Object](../../storage/concepts/object.md): [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object)
   * [{{ ydb-name }} database](../../ydb/concepts/resources.md#database): [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless).
   * [{{ ydb-name }} table](../../ydb/concepts/dynamodb-tables.md): [yandex_ydb_table]({{ tf-provider-resources-link }}/ydb_table).
   * [Function](../../functions/concepts/function.md): [yandex_function]({{ tf-provider-resources-link }}/function).
   * [API gateway](../../api-gateway/concepts/index.md): [yandex_api_gateway]({{ tf-provider-resources-link }}/api_gateway).

1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. Copy the `URL` you got after creating the infrastructure to test the [URL shortener](#test).

## Test the URL shortener {#test}

{% include [serverless-test-shortener](../../_includes/serverless/serverless-url-shortener/test-shortener.md) %}

## How to delete the resources you created {#clear-out}

To stop incurring charges for the resources you created:

1. Open the `serverless-url-shortener.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}