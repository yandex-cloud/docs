1. [Prepare your cloud](#before-begin).
1. [Delegate your domain to {{ dns-name }}](#delegate-domain). 
1. [Create an infrastructure](#deploy).
1. [Test the website](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/bind-domain-vm/paid-resources.md) %}

## Delegate your domain to {{ dns-name }} {#delegate-domain}

{% include [dns-delegate](../_tutorials_includes/bind-domain-vm/dns-delegate.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare a file with the infrastructure description:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-compute-dns-binding
          ```

      1. Go to the directory with the repository. Make sure it contains the following files:
          * `bind-domain-to-vm.tf`: New infrastructure configuration.
          * `bind-domain-to-vm.auto.tfvars`: User data file.

    - Manually {#manual}

      1. Create a folder for the file with the infrastructure description.
      1. In the folder, create:
          1. `bind-domain-to-vm.tf` configuration file

              {% cut "bind-domain-to-vm.tf" %}

              {% include [bind-domain-to-vm-tf-config](../../_includes/web/bind-domain-to-vm-tf-config.md) %}

              {% endcut %}

          1. `bind-domain-to-vm.auto.tfvars` user data file:

              {% cut "bind-domain-to-vm.auto.tfvars" %}

              {% include [bind-domain-to-vm-tf-variables](../../_includes/web/bind-domain-to-vm-tf-variables.md) %}

              {% endcut %}

    {% endlist %}

    For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
    * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [VM](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. In the `bind-domain-to-vm.auto.tfvars` file, set the following user-defined properties:

    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM, e.g., `~/.ssh/id_ed25519.pub`. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain_name`: Your domain name, e.g., `example.com`.

1. Create resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Get the VM public IP address](../../compute/operations/vm-info/get-info.md#outside-instance): you will use it later [to test the hosting](#test).

After creating the infrastructure, [test the website](#test).

## Test the website {#test}

{% include [vm-test](../_tutorials_includes/bind-domain-vm/test.md) %}

## Delete the resources you created {#clear-out}

To shut down the hosting and stop paying for the created resources:

1. Open the `bind-domain-to-vm.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}