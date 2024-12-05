---
title: How to run automatic Docker image scans on push using {{ TF }}
description: Follow this guide to run automatic Docker image scans on push to {{ container-registry-full-name }} using {{ TF }}.
---

# Automatic Docker image scan on push using {{ TF }}


{% note info %}

You can enable auto [scans](../../concepts/vulnerability-scanner.md) of [Docker images](../../concepts/docker-image.md) for vulnerabilities on push to [{{ container-registry-full-name }}](../../../container-registry/) in the [vulnerability scanner settings](../../operations/scanning-docker-image.md#automatically) without creating any [{{ sf-full-name }}](../../../functions/) [functions](../../../functions/concepts/function.md) and [triggers](../../../functions/concepts/trigger/index.md).

{% endnote %}

To configure automatic [Docker image](index.md) [scans](../../concepts/vulnerability-scanner.md) for vulnerabilities on push to [{{ container-registry-full-name }}](../../../container-registry/) using {{ TF }}:

1. [Prepare your cloud](#before-you-begin).
1. [Prepare the environment](#prepare).
1. [Create an infrastructure](#deploy).
1. [Push the Docker image](#download-image).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../../../_tutorials/_tutorials_includes/image-auto-scan/paid-resources.md) %}

## Prepare the environment {#prepare}

1. [Install and configure](../../operations/configure-docker.md) Docker.

## Create an infrastructure {#deploy}

{% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

To create an infrastructure to automatically scan a Docker image on push using {{ TF }}:
1. [Install {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and [get the authentication data](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-cr-image-scanning
        ```

     1. Go to the directory with the repository. Make sure it contains the following files:
        * `image-auto-scan.tf`: New infrastructure configuration.
        * `image-auto-scan.auto.tfvars`: User data file.
        * `function.zip`: ZIP archive with the function code.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the directory, create a configuration file named `image-auto-scan.tf`:

        {% cut "image-auto-scan.tf" %}

        {% include [image-auto-scan-tf-config](../../../_tutorials/_tutorials_includes/image-auto-scan/tf-config.md) %}

        {% endcut %}

     1. Create a file with user data named `image-auto-scan.auto.tfvars`:

        {% cut "image-auto-scan.auto.tfvars" %}

        {% include [image-auto-scan-tf-variables](../../../_tutorials/_tutorials_includes/image-auto-scan/tf-variables.md) %}

        {% endcut %}

     1. Prepare a ZIP archive with the function code.
        1. Create the `handler.sh` file and paste the following code to it:

           {% cut "handler.sh" %}

           {% include [warning-unix-lines](../../../_tutorials/_tutorials_includes/warning-unix-lines.md) %}

           {% include [handler-sh-function](../../../_tutorials/_tutorials_includes/handler-sh-function.md) %}

           {% endcut %}

        1. Create a ZIP archive named `function.zip` with the `handler.sh` file.

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:
   * [Service account](../../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Assigning access permissions for a folder](../../../iam/concepts/access-control/index.md#access-bindings): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Registry](../../../container-registry/concepts/registry.md): [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry).
   * [Function](../../../functions/concepts/function.md): [yandex_function]({{ tf-provider-resources-link }}/function).
   * [Trigger](../../../functions/concepts/trigger/index.md): [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger).

1. In the `image-auto-scan.auto.tfvars` file, set the following user-defined properties:
   * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) to create the infrastructure in.
   * `folder_id`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) to create the infrastructure in.

1. Create resources:

   {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

## Push the Docker image {#download-image}

{% include [upload-image](../../../_tutorials/_tutorials_includes/image-auto-scan/upload-image.md) %}

## Check the result {#check-result}

{% include [check-result](../../../_tutorials/_tutorials_includes/image-auto-scan/check-result.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `image-auto-scan.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

#### See also {#see-also}

* [{#T}](console.md)