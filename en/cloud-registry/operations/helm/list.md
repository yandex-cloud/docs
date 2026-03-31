---
title: Getting information about existing Helm charts in {{ cloud-registry-name }}
description: Follow this guide to get a list of Helm charts in {{ cloud-registry-name }}.
---

# Getting information about existing Helm charts

You can get a list of [Helm charts](https://helm.sh/docs/topics/charts/) from a [registry](../../concepts/registry.md) in {{ cloud-registry-name }}. Helm charts in {{ cloud-registry-name }} are stored as [Docker images](../../concepts/artifacts/docker.md).

## Getting information about local Helm charts {#helm-list-local}

{% list tabs group=instructions %}

- CLI {#cli}

  To view a Helm chart list locally, run the command below:

  ```bash
  helm repo list
  ```

{% endlist %}

## Getting information about Helm charts in a registry {#helm-list-registry}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To view a list of Helm charts uploaded to {{ cloud-registry-name }}, run the same command you would use to view a list of [Docker images](../../concepts/artifacts/docker.md):

  ```bash
  yc container image list
  ```

{% endlist %}