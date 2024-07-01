# Building a 1C-Bitrix website


[1C-Bitrix: Website Management](https://www.1c-bitrix.ru/products/cms/) is a web project management system by 1C-Bitrix. It enables you to easily manage the structure and content of your website without any specialized programming or web design skills. 1C-Bitrix: Site Management does the technical work for you.

In this tutorial, you will learn how to deploy and configure a website using the 1C-Bitrix information portal template. For this, you will create a [virtual machine](../../compute/concepts/vm.md) in your {{ yandex-cloud }} infrastructure and use it to deploy a 1C-Bitrix [image](../../compute/concepts/image.md) and the required services. As a database, you will deploy a [{{ mmy-full-name }}](../../managed-mysql/) [cluster](../../managed-mysql/concepts/index.md) and ensure its fault tolerance.

Resources required for 1C-Bitrix to run correctly:
* VM running [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) with access to an external [network](../../vpc/concepts/network.md#network) to host 1C-Bitrix.
* {{ mmy-name }} cluster which serves as a database for your 1C-Bitrix website.

You can create the infrastructure for your 1C Bitrix website using one of these tools:
* [Management console](../../tutorials/web/bitrix-website/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/web/bitrix-website/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download the {{ TF }} configuration example from the GitHub repository, and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
