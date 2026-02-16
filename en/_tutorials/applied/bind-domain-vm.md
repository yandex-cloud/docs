# Assigning a domain name to a web server VM


In this tutorial, you will assign your own domain name to a [{{ compute-full-name }}](../../compute/) web server [VM](../../compute/concepts/vm.md).

To create a VM, you will use a public [LAMP](/marketplace/products/yc/lamp) image with a pre-installed [Apache HTTP server](https://httpd.apache.org/). Alternatively, you can use a public [LEMP](/marketplace/products/yc/lemp) image with an [NGINX](https://www.nginx.com/) web server.

As an example, we will use the `example.com` domain name mapped to your VM IP address through [DNS records](../../dns/concepts/resource-record.md) in [{{ dns-full-name }}](../../dns/). You can register your domain name at any domain name registrar.

You can use one of the following tools to create an infrastructure for assigning a domain name to your web server VM:
