# Creating an OpenCart online store


[OpenCart](https://ru.wikipedia.org/wiki/OpenCart) is a platform where you can create your own online store. The platform is free and open-source. With OpenCart, you can create an online store of any complexity using a broad selection of community-supported extensions.

In this tutorial, you will learn how to create and configure an OpenCart online store. You will deploy a [VM](../../compute/concepts/vm.md) with pre-installed OpenCart and the software it needs to run, specifically the MySQL server.

The guide describes both configuring a local MySQL server and deploying a [{{ mmy-full-name }} database cluster](../../managed-mysql/concepts/index.md) in case your local DBMS does not provide sufficient performance or functionality.

You can create an OpenCart online store infrastructure using one of these tools:
* [Management console](../../tutorials/internet-store/opencart/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/internet-store/opencart/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download the {{ TF }} configuration example from the GitHub repository, and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
