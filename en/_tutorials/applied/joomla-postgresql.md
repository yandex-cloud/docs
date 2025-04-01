
# Creating a Joomla website with a {{ PG }} database


This tutorial will teach you to deploy a [Joomla CMS](https://{{ lang }}.wikipedia.org/wiki/Joomla!) website with a [{{ PG }}](../../managed-postgresql/index.yaml)-controlled database in your {{ yandex-cloud }} infrastructure. The website will be hosted on an [Apache HTTP web server](https://{{ lang }}.wikipedia.org/wiki/Apache_HTTP_Server) installed on an [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts) [VM](../../compute/concepts/vm.md). [{{ dns-full-name }}](../../dns/index.yaml) will be responsible for domain management, while TLS encryption of traffic will be involve a [TLS certificate](../../certificate-manager/concepts/managed-certificate.md) issued in [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml).

{% note info %}

The steps detailed here were checked for Joomla CMS version `5.2.4`, {{ PG }} DBMS version `17`, and an Ubuntu `24.04` VM. The sequence of actions may vary for other versions of these products.

{% endnote %}

You can create the infrastructure for your Joomla-based website with a {{ PG }} database using one of these tools:

* [Management console](../../tutorials/web/joomla-postgresql/console.md): Create your infrastructure step by step in the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/web/joomla-postgresql/terraform.md): Streamline creating and managing your resources with the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example and deploy your infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
