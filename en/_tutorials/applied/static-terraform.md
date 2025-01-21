1. [Prepare your cloud environment](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud environment {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [static-paid-resources](../_tutorials_includes/static-paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To host a static website in {{ objstorage-name }} using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Create a folder for configuration files.
     1. Download the [archive](https://{{ s3-storage-host }}/doc-files/static.zip) (2 KB).
     1. Unpack the archive to the folder. It should now contain the `static.tf` configuration file, plus `index.html` and `error.html`.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `static.tf` configuration file

           {% cut "static.tf" %}

           {% include [static-tf-config](../../_includes/web/static-tf-config.md) %}

           {% endcut %}

        1. `index.html` file containing the text `Hello world!`:

           {% cut "index.html" %}

           {% include [static-tf-config](../../_includes/web/index-html-config.md) %}

           {% endcut %}

        1. `error.html` file containing the text `Error!`:

           {% cut "error.html" %}

           {% include [static-tf-config](../../_includes/web/error-html-config.md) %}

           {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:
    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Role](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Static access key](../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Bucket](../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. Under `locals` in the `static.tf` file, set the following user-defined properties:
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) (if you are using a [Yandex account](../../iam/concepts/users/accounts.md#passport)) or [{{ iam-short-name }} token](../../iam/concepts/authorization/iam-token.md) (if you are using a Yandex account or [federated account](../../iam/concepts/users/accounts.md#saml-federation)) to access {{ yandex-cloud }}. The {{ iam-short-name }} token is valid for up to 12 hours but cannot exceed the federation cookie lifetime.
   * `cloud_id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) to create the resources in.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create the resources in.
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [test the website](#test-site).

## Test the website {#test-site}

{% include [static-test-site](../_tutorials_includes/static-test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `static.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}