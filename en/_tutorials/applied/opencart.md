# Creating an OpenCart online store


[OpenCart](https://ru.wikipedia.org/wiki/OpenCart) is a free and open-source platform where you can create an online store of any complexity with a broad selection of community-supported extensions.

In this tutorial, you will create and configure an OpenCart online store by setting up a [VM](../../compute/concepts/vm.md) with pre-installed required software, e.g., OpenCart and MySQL server.

The guide describes how to configure a local MySQL server or, if you need higher performance, how to deploy a [{{ mmy-full-name }}](../../managed-mysql/concepts/index.md) database cluster.

You can create an OpenCart online store with one of these tools:
* [Management console](../../tutorials/internet-store/opencart/console.md): Create your infrastructure step by step in the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/internet-store/opencart/terraform.md): Streamline creating and managing your resources with the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example from GitHub and deploy your infrastructure with the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
