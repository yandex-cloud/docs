1. [Get your cloud ready](#before-you-begin).
1. [Create your infrastructure](#deploy).
1. [Upload the website files](#upload-files).
1. [Test the website](#test-site).

We will use the `example.com` domain name as an example.

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [lamp-lemp-paid-resources](../_tutorials_includes/lamp-lemp-paid-resources.md) %}

## Create your infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and [get the authentication data](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).
1. Specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Set up your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made archive {#ready}

      1. Create a directory.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/lamp-lemp.zip) (1 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `lamp-lemp.tf` configuration file and the `lamp-lemp.auto.tfvars` user data file.

    - Manually {#manual}

      1. Create a folder for the infrastructure description file.
      1. In the directory, create a configuration file named `lamp-lemp.tf`:

          {% cut "lamp-lemp.tf" %}

          {% include [lamp-lemp-tf-config](../../_includes/web/lamp-lemp-tf-config.md) %}

          {% endcut %}

      1. In the directory, create a user data file named `lamp-lemp.auto.tfvars`:

          {% cut "lamp-lemp.auto.tfvars" %}

          {% include [lamp-lemp-tf-variables](../../_includes/web/lamp-lemp-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the relevant provider guides:
    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [VM](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

  1. In the `lamp-lemp.auto.tfvars` file, set the following user parameters:
      * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) the VM will reside in.
      * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * `family_id`: Specify the family of a VM [image](../../compute/concepts/image.md) with the required components:
        * `lamp`: [LAMP](/marketplace/products/yc/lamp) (Linux, Apache, {{ MY }}, and PHP).
        * `lemp`: [LEMP](/marketplace/products/yc/lemp) (Linux, Nginx, {{ MY }}, and PHP).
      * `vm_user`: VM user name.
      * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
      * `dns_zone`: [DNS zone](../../dns/concepts/dns-zone.md). Specify your registered domain with a period at the end, e.g., `example.com.`.
          To use domain names in the public DNS zone, you need to delegate it to authoritative name servers. Specify `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` server addresses in your registrar's account settings.

1. Create the resources:

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

1. Open the `lamp-lemp.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
