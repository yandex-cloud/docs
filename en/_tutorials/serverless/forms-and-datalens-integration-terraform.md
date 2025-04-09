# Delivering data from {{ forms-full-name }} to {{ datalens-full-name }} using {{ sf-full-name }} and {{ yq-full-name }} via {{ TF }}


To set up {{ forms-name }} and {{ datalens-name }} integration via {{ TF }}:

1. [Set up your infrastructure](#prepare-infrastructure).
1. [Create and configure a function in {{ sf-full-name }}](#create-function).
1. [Create and set up a form in {{ forms-name }}](#create-form).
1. [Configure a connection and binding to data in {{ yq-full-name }}](#yq-integration).
1. [Set up fetching data in {{ datalens-name }}](#set-up-datalens).
1. [Test the new resource integration](#test-forms-integration).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/forms-and-datalens-paid-resources.md) %}

## Set up your infrastructure {#prepare-infrastructure}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To set up your infrastructure via {{ TF }}:

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Download the [forms-and-datalens-integration.tf](https://github.com/yandex-cloud-examples/yc-serverless-forms-datalens-integration/blob/main/forms-and-datalens-integration.tf) configuration file to the same working directory.

    This file describes:

    * Network and subnet for deploying the infrastructure for your function in {{ sf-name }}.
    * Service account with the following roles:
        * `lockbox.payloadViewer`: For reading {{ lockbox-full-name }} secrets.
        * `functions.functionInvoker`: For calling the function in {{ sf-name }}.
        * `storage.admin`: For reading data from and writing data to an {{ objstorage-name }} bucket, as well as managing the bucket’s ACL.
        * `yq.viewer` and `yq.invoker`: For integrating {{ datalens-name }} and {{ yq-name }}.      
    * Static key for the service account used for creating the {{ objstorage-name }} bucket.
    * Static key for the service account used for creating the function in {{ sf-name }}.
    * {{ lockbox-name }} secret for storing data on the service account static key for the function from {{ sf-name }}.
    * `data` resource for the {{ lockbox-name }} secret the function in {{ sf-name }} uses to retrieve the secret version ID.
    * {{ objstorage-name }} bucket to store function results.
    * Publicly accessible function in {{ sf-name }}.

1. In the local variables section of the `forms-and-datalens-integration.tf` file, specify the following:
    * Your folder ID in the `sa_folder_id` variable.
    * Name of the {{ objstorage-name }} bucket in the `bucket-name` variable.

1. Make sure the {{ TF }} configuration files are correct using this command:

    ```bash
    terraform validate
    ```

    If there are any errors in the configuration files, {{ TF }} will point them out.

1. Create the required infrastructure:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}


## Create and configure a function in {{ sf-name }} {#create-function}

1. Download the [function code archive](https://github.com/yandex-cloud-examples/yc-serverless-forms-datalens-integration/blob/main/function-zip) to the directory with the `forms-and-datalens-integration.tf` file.    

1. Under the local variables section of the `forms-and-datalens-integration.tf` file, specify the following values:

    * `content_path` = `function.zip`.
    * `create-function` = `1`.

1. Make sure the {{ TF }} configuration files are correct using this command:

    ```bash
    terraform validate
    ```

    If there are any errors in the configuration files, {{ TF }} will point them out.

1. Create the required infrastructure:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

## Create and set up a {{ forms-name }} form {#set-up-form}

{% include [set-up-form](../_tutorials_includes/forms-and-datalens-set-up-form.md) %}

## Configure a connection and binding to data in {{ yq-name }} {#yq-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-yq-integration.md) %}

## Set up fetching data in {{ datalens-name }} {#set-up-datalens}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-set-up-datalens.md) %}

## Test the new resource integration {#test-forms-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-test-integration.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them.

{% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}
