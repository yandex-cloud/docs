---
title: 'Website powered by Joomla CMS on {{ PG }}: Installation and setup'
description: Joomla is a website management system written in PHP and JavaScript. This tutorial will teach you to deploy websites powered by Joomla CMS on a {{ PG }} database.
keywords:
  - joomla
  - CMS Joomla
  - '{{ PG }}'
  - joomla installation
  - joomla setup
  - joomla website hosting
---

# Creating a Joomla website with a {{ PG }} database


In this tutorial, you will learn how to deploy a [Joomla-based](https://{{ lang }}.wikipedia.org/wiki/Joomla!) website with a database managed by [{{ PG }}](../../managed-postgresql/) in the {{ yandex-cloud }} infrastructure. The website will be hosted on an [Apache2](https://{{ lang }}.wikipedia.org/wiki/Apache_HTTP_Server) server installed on a [CentOS Stream](/marketplace/products/yc/centos-stream-8) VM. You can use [{{ dns-full-name }}](../../dns/) to manage your domain.

You can create the infrastructure for your Joomla-based website with a {{ PG }} database using one of these tools:

* [Management console](../../tutorials/web/joomla-postgresql/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/web/joomla-postgresql/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download the {{ TF }} configuration example and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
