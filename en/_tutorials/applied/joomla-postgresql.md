
# Creating a Joomla website with a {{ PG }} database


This tutorial will teach you how to deploy a [Joomla](https://{{ lang }}.wikipedia.org/wiki/Joomla!) website with a [{{ PG }}](../../managed-postgresql/) database in your {{ yandex-cloud }} infrastructure. The website will be hosted on an [Apache2](https://{{ lang }}.wikipedia.org/wiki/Apache_HTTP_Server) server installed on a [CentOS Stream](/marketplace/products/yc/centos-stream-8) VM. You can use [{{ dns-full-name }}](../../dns/) to manage your domain.

You can create the infrastructure for your Joomla-based website with a {{ PG }} database using one of these tools:

* [Management console](../../tutorials/web/joomla-postgresql/console.md): Create your infrastructure step by step from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/web/joomla-postgresql/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
