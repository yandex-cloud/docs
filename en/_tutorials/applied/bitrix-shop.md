# Creating an online store with 1C-Bitrix: Site Management


[1C-Bitrix: Site Management](https://ru.wikipedia.org/wiki/1С-Битрикс:_Управление_сайтом) is a content management system (CMS) you can use to create an online store, a corporate website, or a news portal, as well as manage its structure and content.

In this tutorial, you will learn how to deploy and configure a 1C-Bitrix online store. For this, you will create a [virtual machine](../../compute/concepts/vm.md) in {{ yandex-cloud }} to deploy 1C-Bitrix on and launch the required services. As a database, you will be using a fault-tolerant [{{ mmy-full-name }} cluster](../../managed-mysql/concepts/index.md).

You can create the infrastructure for your 1C-Bitrix online store using one of these tools:
* [Management console](../../tutorials/internet-store/bitrix-shop/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/internet-store/bitrix-shop/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download the {{ TF }} configuration example from the GitHub repository, and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).