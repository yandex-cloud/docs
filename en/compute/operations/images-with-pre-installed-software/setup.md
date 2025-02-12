# Software setup

[VMs](../../concepts/vm.md) with [LAMP](/marketplace/products/yc/lamp), [LEMP](/marketplace/products/yc/lemp), and [Node.js](/marketplace/products/yc/nodejs) come pre-configured and ready to use.

For VMs with content management systems to deploy, e.g., [Drupal](/marketplace/products/yc/drupal-8), [{{ GL }}](/marketplace/products/yc/gitlab), [Joomla](/marketplace/products/yc/joomla), and [WordPress](/marketplace/products/yc/wordpress), use a [web installer](#web-setup) for the initial setup.

## Software setup via a web installer {#web-setup}

To run a web installer:
1. Get the VM [public IP address](../../../vpc/concepts/address.md#public-addresses). You can find the IP address in the [management console]({{ link-console-main }}), on the VM page under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.
1. Type `http://<IP_address>` into the address bar of your browser. This will open the authorization window.

   {% note info %}

   If the connection to the VM fails, wait a few minutes and try again.

   {% endnote %}

1. Complete the steps of the web installer by following the developer recommendations for [Drupal](https://drupal.org/), [{{ GL }}](https://about.gitlab.com), [Joomla](https://joomla.org/), [WordPress](https://wordpress.org/).

You may need to enter DB connection parameters when setting up the software. To get these parameters, [connect to the VM](operate.md) via SSH and run the following command:

```bash
sudo cat /root/default_passwords.txt
```