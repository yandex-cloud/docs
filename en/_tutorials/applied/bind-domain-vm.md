# Assigning a domain name to a VM with a web server


In this tutorial, you will assign your own domain name to a [{{ compute-full-name }}](../../compute/) [VM](../../compute/concepts/vm.md) with a web server.

To create a VM, this tutorial uses a public [LAMP](/marketplace/products/yc/lamp) image with a pre-installed [Apache HTTP server](https://httpd.apache.org/). Using a public [LEMP](/marketplace/products/yc/lemp) image with an [NGINX](https://www.nginx.com/) web server is also possible.

The `example.com` domain name is used as an example. It will be mapped to the IP address of the VM using [DNS records](../../dns/concepts/resource-record.md) in [{{ dns-full-name }}](../../dns/). You can use any domain name registrar to register your domain name.

You can create an infrastructure for assigning a domain name to a VM with a web server using one of the following tools:
