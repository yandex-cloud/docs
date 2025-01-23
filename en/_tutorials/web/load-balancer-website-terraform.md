1. [Prepare your cloud environment](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Upload the website files](#upload-files).
1. [Run a fault tolerance test](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud environment {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [load-balancer-website-paid-resources](../_tutorials_includes/load-balancer-website/paid-resources.md) %}


## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare files with the infrastructure description:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-nlb-fault-tolerant-site.git
         ```

      1. Go to the directory with the repository. It should now contain the `load-balancer.tf` file with the new infrastructure configuration.

    - Manually {#manual}

      1. Create a folder for the files.
      1. In the directory, create a configuration file named `load-balancer.tf`:

          {% cut "load-balancer.tf" %}

          {% include [load-balancer-tf-config](../../_includes/web/load-balancer-tf-config.md) %}

          {% endcut %}

    {% endlist %}

    For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * [Role](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Instance group](../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
    * [Network load balancer](../../network-load-balancer/concepts/index.md): [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer).
    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-link }}/vpc_network).
    * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-link }}/vpc_subnet).


1. Under `variable`, specify `folder_id`, i.e., the ID of the folder the resources are created in.
1. Under `metadata`, specify the [metadata](../../compute/concepts/vm-metadata.md) for creating a VM and the contents of the SSH key. Use this format for the key: `<any_name>:<SSH_key_contents>`. Regardless of the username specified, the key is assigned to the user set in the LAMP (LEMP) image configuration. Such users vary depending on an image. For more information, see [{#T}](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).

    You need to [create](../../compute/operations/vm-connect/ssh.md) an SSH key pair youself.

1. Under `boot_disk`, specify the ID of a VM [image](../../compute/operations/images-with-pre-installed-software/get-list.md) with relevant components:

    * [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, PHP).
    * [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, PHP).

1. Create resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [upload the website files](#upload-files).


## Upload the website files {#upload-files}

{% include [load-balancer-website-upload-files](../_tutorials_includes/load-balancer-website/upload-files.md) %}

Once you upload all files, [run a fault tolerance test](#test).


## Run a fault tolerance test {#test}

{% include [load-balancer-website-test](../_tutorials_includes/load-balancer-website/test.md) %}


## How to delete the resources you created {#clear-out}

To shut down the website and stop paying for the resources you created:

1. Open the `load-balancer.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}