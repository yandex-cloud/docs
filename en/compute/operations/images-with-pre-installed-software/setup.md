# Configuring software

Virtual machines with LEMP, LAMP, and Node.js do not require any initial configuration. The pre-installed software is ready for use.

For VMs with content management systems to deploy, such as Drupal, GitLab, Joomla, or WordPress, use a [web setup wizard](#web-setup) to perform the initial configuration.

## Configuring software via web setup wizard {#web-setup}

To run the web setup wizard:

1. Specify the VM's public IP address. You can find out the IP address in the management console. Go to the **Network** section on the virtual machine's page.
1. Type `http://<IP address>` in the browser address bar. The authorization window opens.
   {% note info %}

   If you can't connect to the VM, try again in a few minutes.

   {% endnote %}
1. Complete the steps of the web setup wizard while following the developer recommendations: [Drupal](https://drupal.org/), [GitLab](https://about.gitlab.com), [Joomla](https://joomla.org/), or [WordPress](https://wordpress.org/).

During software configuration, you may need the DB connection parameters. To find out these parameters, [connect to the VM](operate.md) over SSH and run the command:

```
sudo cat /root/default_passwords.txt
```

