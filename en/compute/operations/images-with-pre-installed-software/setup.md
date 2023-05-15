# Configuring software

[VMs](../../concepts/vm.md) with [LAMP]https://en.wikipedia.org/wiki/LAMP_(software_bundle), LEMP, and Node.js do not require any initial configuration. The pre-installed software is ready for use.

For VMs with content management systems to deploy, such as Drupal, {{ GL }}, Joomla, or WordPress, use a [web setup wizard](#web-setup) to perform the initial configuration.

## Configuring software via a web setup wizard {#web-setup}

To run the web setup wizard:
1. Get the VM's [public IP address](../../../vpc/concepts/address.md#public-addresses). You can find out the IP address in the management console under the **Network** section on the VM page.
1. Type `http://<IP address>` in the browser address bar. The authorization window opens.

   {% note info %}

   If you cannot connect to the VM, try again in a few minutes.

   {% endnote %}

1. Complete the steps of the web setup wizard while following the developer recommendations for [Drupal](https://drupal.org/), [{{ GL }}](https://about.gitlab.com), [Joomla](https://joomla.org/), or [WordPress](https://wordpress.org/).

During software configuration, you may need the DB connection parameters. To find out these parameters, [connect to the VM](operate.md) over SSH and run the following command:

```bash
sudo cat /root/default_passwords.txt
```
