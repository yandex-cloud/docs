1. [Prepare your cloud environment](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Upload the website files](#upload-files).
1. [Test the website](#test-site).

We will use the `example.com` domain name as an example.

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud environment {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [lamp-lemp-paid-resources](../_tutorials_includes/lamp-lemp-paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and [get the authentication data](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

    {% list tabs group=infrastructure_description %}

    - Ready-made archive {#ready}

      1. Create a folder for the files.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/lamp-lemp.zip) (1 KB).
      1. Unpack the archive to the folder. As a result, it should contain the `lamp-lemp.tf` configuration file and the `lamp-lemp.auto.tfvars` user data file.

    - Manually {#manual}

      1. Create a folder for the file with the infrastructure description.
      1. In the directory, create a configuration file named `lamp-lemp.tf`:

          {% cut "lamp-lemp.tf" %}

          {% include [lamp-lemp-tf-config](../../_includes/web/lamp-lemp-tf-config.md) %}

          {% endcut %}

      1. In the directory, create a user data file named `lamp-lemp.auto.tfvars`:

          {% cut "lamp-lemp.auto.tfvars" %}

          {% include [lamp-lemp-tf-variables](../../_includes/web/lamp-lemp-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    For more information about the parameters of resources used in {{ TF }}, see the provider documentation:
    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/yandex_vpc_security_group).
    * [VM](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

  1. In the `lamp-lemp.auto.tfvars` file, set the following user-defined properties:
      * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) the VM will be in.
      * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * `family_id`: Specify the family of a VM [image](../../compute/concepts/image.md) with the required components:
        * `lamp`: [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, and PHP).
        * `lemp`: [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, and PHP).
      * `vm_user`: VM username.
      * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
      * `dns_zone`: [DNS zone](../../dns/concepts/dns-zone.md). Specify your registered domain with a period at the end, e.g., `example.com.`.
          To get access to public zone domain names, you need to delegate the domain. Specify the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your account on your registrar's website.

1. Create resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Get the VM public IP address](../../compute/operations/vm-info/get-info.md): you will need it later to [upload the website files](#upload-files).

After creating the infrastructure, [upload the website files](#upload-files).

## Upload the website files {#upload-files}

{% include [lamp-lemp-paid-upload-files](../_tutorials_includes/lamp-lemp-upload-files.md) %}

After uploading the files, [test the website](#test-files).

## Test the website {#test-site}

{% include [lamp-lemp-paid-test](../_tutorials_includes/lamp-lemp-test.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `lamp-lemp.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
