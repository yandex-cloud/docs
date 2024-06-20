# Website on a LAMP or LEMP stack

[LAMP](https://en.wikipedia.org/wiki/LAMP_(software_bundle)) ([Linux](https://www.linux.org/), [Apache HTTP Server](https://httpd.apache.org/), [{{ MY }}](https://www.mysql.com/), [PHP](https://www.php.net/)) and LEMP (its variation where Apache is replaced with [Nginx](https://www.nginx.com/)) are popular sets of components for deploying web applications and dynamic websites.

In this tutorial, you will learn how to deploy [LAMP](/marketplace/products/yc/lamp) ([LEMP](/marketplace/products/yc/lemp)) in the {{ yandex-cloud }} infrastructure. Follow it to launch a [VM](../../compute/concepts/vm.md) for your website's web server and configure DNS.

You can create a website infrastructure using one of these tools:
* [Management console](../../tutorials/web/lamp-lemp/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/web/lamp-lemp/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).