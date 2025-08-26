1. [Get your cloud ready](#before-begin).
1. [Create your infrastructure](#deploy).
1. [Get credentials for authenticating in the web interface](#get-auth-data).
1. [Connect to the WordPress web interface](#connect-wordpress-interface).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

{% include [network-is-exist](../../_tutorials_includes/network-is-exist.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources-wp](../../_tutorials_includes/wordpress/paid-resources-wp.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare the infrastructure description files.

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

     1. Create a directory.
     1. Download the [archive](https://{{ s3-storage-host }}/doc-files/wordpress.zip) (1 KB).
     1. Unpack the archive to the directory. As a result, the `wordpress.tf` configuration file should appear in it.

   - Manually {#manual}

     1. Create a directory.
     1. Create a configuration file named `wordpress.tf` in the folder:

        {% cut "wordpress.tf" %}

        {% include [wordpress-tf-config](../../../_includes/web/wordpress-tf-config.md) %}

        {% endcut %}

   {% endlist %}

   Learn more about the properties of {{ TF }} resources in the relevant {{ TF }} guides:
    * [VM instance](../../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)
    * [Security groups](../../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/yandex_vpc_security_group)
    * [Network](../../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [Subnets](../../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [DNS zone](../../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
    * [DNS resource record](../../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)
1. Under `metadata`, specify the metadata for creating a VM: `<username>:<SSH_key_contents>`. Regardless of the username specified, the key is assigned to the user set in the WordPress image configuration. Such users differ depending on the image. For more information, see [{#T}](../../../compute/concepts/metadata/public-image-keys.md).
1. Create the resources:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

## Get credentials for authenticating in the web interface {#get-auth-data}

{% include [get-auth-data](get-auth-data.md) %}

## Connect to the WordPress web interface {#connect-wordpress-interface}

To connect to the WordPress web interface, do the following:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [connect-wordpress-interface](connect-wordpress-interface.md) %}

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `wordpress.tf` file and delete your infrastructure description from it.
1. Apply the changes:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

