1. In the [management console]({{ link-console-main }}), go to the VM page, find the VM public IP address under **Network**, and add it to the [type A](../../../dns/concepts/resource-record.md#a) [resource record](../../../dns/concepts/dns-zone.md) you created earlier.

   ![add-ssh](../../../_assets/tutorials/wordpress/vm-create-5.png)

1. In your browser, open the WordPress admin panel using the domain name you configured or the VM's address: `http://<domain_name_or_VM_public_address>/wp-admin`.
1. Enter the username and password you saved earlier.