---
title: How to run automatic Docker image scans on push
description: Follow this tutorial to set up automatic Docker image scans on push to {{ container-registry-full-name }}.
---

# Automatic Docker image scan on push


{% note info %}

You can enable automatic vulnerability [scans](../../concepts/vulnerability-scanner.md) of [Docker images](../../concepts/docker-image.md) on push to [{{ container-registry-full-name }}](../../../container-registry/) in the [vulnerability scanner settings](../../operations/scanning-docker-image.md#automatically) without creating any [{{ sf-full-name }}](../../../functions/) [functions](../../../functions/concepts/function.md) and [triggers](../../../functions/concepts/trigger/index.md).

{% endnote %}

In this tutorial, you will create a [registry](../../concepts/registry.md) in {{ container-registry-name }} to store a Docker image. You will also set up automatic vulnerability scans on push to the registry. A {{ sf-name }} trigger will track changes to the registry and invoke a function to start scanning when you push a Docker image to the registry.

To set up and run Docker image vulnerability [scans](../../concepts/vulnerability-scanner.md) on push to {{ container-registry-name }}, use the following tools:

* [{{ yandex-cloud }} management console, CLI, and API](console.md): Use one of these methods to create your infrastructure step by step.
* [{{ TF }}](terraform.md): Streamline creating and managing your resources with the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example from the GitHub repository and deploy your infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).