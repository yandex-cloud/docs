1. [Set up your environment](#prepare).
1. [Create an infrastructure](#deploy).
1. [Use the key from the {{ lockbox-name }} secret for your operations with the service](#use-key).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/static-key-in-lockbox/paid-resources.md) %}


## Set up your environment {#prepare}

{% include [prepare](../_tutorials_includes/static-key-in-lockbox/prepare.md) %}


## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare the infrastructure description file:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-static-keys-in-lockbox
          ```

      1. Navigate to the repository directory. It should now contain the `static-key-in-lockbox-config.tf` file with the new infrastructure configuration.

    - Manually {#manual}

      1. Create a folder for configuration files.
      1. Create a configuration file named `static-key-in-lockbox-config.tf` in the folder:

          {% cut "static-key-in-lockbox-config.tf" %}

          {% include [static-key-in-lockbox-config](../../_tutorials/_tutorials_includes/static-key-in-lockbox/config.md) %}

          {% endcut %}

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the provider documentation:

    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Assigning a [role](../../iam/concepts/access-control/roles.md) to a service account: [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Secret]({{ tf-provider-resources-link }}/lockbox_secret): [yandex_lockbox_secret](../../lockbox/concepts/secret.md).
    * [Static access key](../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Secret version](../../lockbox/concepts/secret.md#version): [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version).

1. In the `static-key-in-lockbox-config.tf` file, set the following user-defined properties:
    * `zone_id`: [Availability zone](../../overview/concepts/geo-scope.md).
    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

1. Create resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

Once the infrastructure is created, [use the key from the secret for your operations with the service](#use-key).


## Use the key from the {{ lockbox-name }} secret for your operations with the service {#use-key}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

Use the key from the {{ lockbox-name }} secret and create a bucket in {{ objstorage-name }}:

1. Save the key ID, secret key, and placement region to the AWS CLI environment variables:

    ```bash
    AWS_ACCESS_KEY_ID=$(terraform output key_id)
    AWS_SECRET_ACCESS_KEY=$(terraform output key)
    AWS_DEFAULT_REGION="{{ region-id }}"
    ```

    The AWS CLI will use the environment variables you created for authentication when performing operations with the service resources.

1. Create a bucket in {{ objstorage-name }} by specifying a unique [bucket name](../../storage/concepts/bucket.md#naming) in the command:

    {% include [create-bucket](../_tutorials_includes/static-key-in-lockbox/create-bucket.md) %}

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      AWS_ACCESS_KEY_ID=$(terraform output key_id) \
      AWS_SECRET_ACCESS_KEY=$(terraform output key) \
      AWS_DEFAULT_REGION="{{ region-id }}" \
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<bucket_name>
      ```

      Result:

      ```bash
      make_bucket: my-first-bucket
      ```

    {% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
1. Open the `static-key-in-lockbox-config.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}