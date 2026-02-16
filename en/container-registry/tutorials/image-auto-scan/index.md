---
title: How to run automatic Docker image scans on push
description: This guide describes how you can set up automatic Docker image scans on push to {{ container-registry-full-name }}.
---

# Automatic Docker image scan on push


{% note info %}

You can enable auto [scans](../../concepts/vulnerability-scanner.md) of [Docker images](../../concepts/docker-image.md) for vulnerabilities on push to [{{ container-registry-full-name }}](../../../container-registry/) in the [vulnerability scanner settings](../../operations/scanning-docker-image.md#automatically) without creating any [{{ sf-full-name }}](../../../functions/) [functions](../../../functions/concepts/function.md) and [triggers](../../../functions/concepts/trigger/index.md).

{% endnote %}

In this tutorial, you will create a {{ container-registry-name }} [registry](../../concepts/registry.md) to store a Docker image. You will also set up automatic scanning for vulnerabilities on push to the registry. A {{ sf-name}} trigger will track changes to the registry and invoke a function to start scanning when you push a Docker image to the registry.

To set up and run Docker image vulnerability [scanning](../../concepts/vulnerability-scanner.md) on push to {{ container-registry-name }}, use the following tools:

* [Management console, CLI, and API](console.md): Use the {{ yandex-cloud }} management console, CLI, or API to create your infrastructure step by step.
* [{{ TF }}](terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example from the GitHub repository and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).