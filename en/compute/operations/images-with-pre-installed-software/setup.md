# Configuring software

[VMs](../../concepts/vm.md) with [LAMP](/marketplace/products/yc/lamp), [LEMP](/marketplace/products/yc/lemp), and [Node.js](/marketplace/products/yc/nodejs) do not require any initial configuration. The pre-installed software is ready for use.

For VMs requiring the deployment of content management systems, such as [Drupal](/marketplace/products/yc/drupal-8), [{{ GL }}](/marketplace/products/yc/gitlab), [Joomla](/marketplace/products/yc/joomla), and [WordPress](/marketplace/products/yc/wordpress), use a [web setup wizard](#web-setup) to perform the initial configuration.

## Configuring software via a web setup wizard {#web-setup}

To run the web setup wizard:
1. Get the VM's [public IP address](../../../vpc/concepts/address.md#public-addresses). You can find out the IP address in the [management console]({{ link-console-main }}) by going to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM's page.
1. Type `http://<IP address>` in the browser address bar. This will open the authorization window.

   {% note info %}

   If you cannot connect to the VM, try again in a few minutes.

   {% endnote %}

1. Complete the steps of the web setup wizard while following the developer recommendations for [Drupal](https://drupal.org/), [{{ GL }}](https://about.gitlab.com), [Joomla](https://joomla.org/), or [WordPress](https://wordpress.org/).

During software configuration, you may need the DB connection parameters. To find out these parameters, [connect to the VM](operate.md) over SSH and run the following command:

```bash
sudo cat /root/default_passwords.txt
```
