---
title: How to set up multiple domain name support for a website
description: Follow this guide to set up multiple domain name support for a website.
---

# Support for multiple domain names

This guide describes how to set up support for a website's primary domain name and its secondary domain, e.g., `example.com` and `example2.com`. You will create [buckets](../../../concepts/backup.md) for your primary and secondary domains. In the first bucket, you will configure [static website hosting](../../../concepts/hosting.md) on your primary domain name; in the second bucket, you will enable redirection from the secondary domain name to the first bucket. You can use [{{ dns-full-name }}](../../../../dns/) to manage your domains.

You can configure support for multiple domain names for a static website in {{ objstorage-name }} using one of these tools:
* [Management console, CLI, API](console.md): Create your infrastructure step by step from the {{ yandex-cloud }} management console, CLI, or API.
* [{{ TF }}](terraform.md): Streamline creating and managing your resources using the _Infrastructure as Code_ (IaC) approach. Download a {{ TF }} configuration example from the GitHub repository and then deploy your infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).
