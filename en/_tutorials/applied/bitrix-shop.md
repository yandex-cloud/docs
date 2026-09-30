# Creating an online store on 1C-Bitrix: Site Management

[1C-Bitrix: Site Management](https://ru.wikipedia.org/wiki/1С-Битрикс:_Управление_сайтом) is a content management system (CMS) you can use to create an online store, a corporate website, or a news portal, as well as manage its structure and content.

In this tutorial, you will learn how to deploy and configure a 1C-Bitrix online store. For this, you will create a [virtual machine](../../compute/concepts/vm.md) in {{ yandex-cloud }} to deploy 1C-Bitrix on and launch the required services. As a database, you will be using a fault-tolerant [{{ mmy-full-name }} cluster](../../managed-mysql/concepts/index.md).

You can create an infrastructure for an online store on 1C-Bitrix: Website Management using one of the following tools:
* [Management console](../../tutorials/internet-store/bitrix-shop/console.md): Use this method to create your infrastructure step by step in the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/internet-store/bitrix-shop/terraform.md): Use to streamline creating and managing your resources with the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example from the GitHub repository and deploy your infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).