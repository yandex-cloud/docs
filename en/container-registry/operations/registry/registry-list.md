---
title: "How to get information about existing registries in {{ container-registry-full-name }}"
description: "Follow this guide to get information about existing registries."
---

# Getting information about existing registries

Find out how to get:
* [Folder registry list](#registry-list).
* [Detailed information about a registry](#registry-get).

## Getting a list of registries in a folder {#registry-list}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Get a list of [registries](../../concepts/registry.md) in the default folder:

   ```bash
   yc container registry list
   ```

   Result:

   ```bash
   +----------------------+--------+----------------------+
   |          ID          |  NAME  |      FOLDER ID       |
   +----------------------+--------+----------------------+
   | crpd50616s9a******** | my-reg | b1g88tflru0e******** |
   +----------------------+--------+----------------------+
   ```

- API

   To get a list of registries in the default folder, use the [list](../../api-ref/Registry/list.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}

## Getting detailed information about a registry {#registry-get}

To access a registry, use the `id` or `name` parameters from the [previous](#registry-list) item.

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Get detailed information about the registry:

   ```bash
   yc container registry get my-reg
   ```

   Result:

   ```bash
   id: crpd50616s9a********
   folder_id: b1g88tflru0e********
   name: my-reg
   status: ACTIVE
   created_at: "2019-01-09T14:34:06.601Z"
   ```

- API

   You can get detailed information about a registry by using the [get](../../api-ref/Registry/get.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}