---
title: "How to get information about an origin in {{ cdn-full-name }}"
---

# Getting information about origins

You can get information about an individual [origin](#get-origin) or an [origin group](#get-origin-group).

## Getting information about an origin {#get-origin}

To get the URL and other details of an origin:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about an origin:

      ```bash
      yc cdn origin get --help
      ```

   1. Get information about the origin by specifying its ID or name:

      ```bash
      yc cdn origin get <origin_ID>
      ```

      Result:

      ```bash
      id: "152152********"
      origin_group_id: "2128********"
      source: test-cdn-1.storage.yandexcloud.net
      enabled: true
      meta:
        bucket:
          name: test-cdn-1
      ```

{% endlist %}

## Getting information about an origin group {#get-origin-group}

To get the name, set of origins, and other details of an origin group:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get information about an origin group:

      ```bash
      yc cdn origin-group get --help
      ```

   1. Get information about the origin group by specifying its ID or name:

      ```bash
      yc cdn origin-group get <origin_group_ID>
      ```

      Result:

      ```bash
      id: "2149********"
      folder_id: b1ggmp8es27t********
      name: test-cdn-group
      use_next: true
      origins:
      - id: "2741********"
        origin_group_id: "2149********"
        source: test-cdn-1-2.storage.yandexcloud.net
        enabled: true
        backup: true
        meta:
          bucket:
            name: test-cdn-1-2
      - id: "2742********"
        origin_group_id: "2149********"
        source: test-cdn-1-1.storage.yandexcloud.net
        enabled: true
        meta:
          bucket:
            name: test-cdn-1-1
      ```

{% endlist %}
