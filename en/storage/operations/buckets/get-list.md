---
title: Getting a list of buckets in {{ objstorage-full-name }}
description: Follow this guide to get a list of buckets in {{ objstorage-name }}.
---

# Getting a list of buckets

## Getting a list of buckets {#get-list}

To view the complete list of [buckets](../../concepts/bucket.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. The page that opens will display the complete list of buckets.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for getting a list of buckets:

     ```bash
     yc storage bucket --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}

{% endlist %}
