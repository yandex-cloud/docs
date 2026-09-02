---
title: Integration with {{ objstorage-name }} in {{ mgl-full-name }}
description: Follow this guide to enable storing {{ GL }} data in {{ objstorage-name }}.
---

# Integration with {{ objstorage-name }}

{% include [objstorage-pricing-warning](../../_includes/managed-gitlab/objstorage-pricing-warning.md) %}

{% note warning %}

Before enabling integration with {{ objstorage-name }}, make sure the [security group](configure-security-group.md) of the {{ mgl-name }} instance allows incoming connections on port `80` from external IP addresses of {{ lets-encrypt }}. Read more on [{{ objstorage-name }} integration limitations](../concepts/s3-integration.md#restrictions).

{% endnote %}

Integration with {{ objstorage-name }} allows you to reduce the amount of data on the [instance](../concepts/index.md#instance) disks to prevent their overflow. You can select data types to store in {{ objstorage-name }}:

{% include [s3-object-type](../../_includes/managed-gitlab/s3-object-type.md) %}

You can learn more about integration with {{ objstorage-name }} [here](../concepts/s3-integration.md).

## Viewing a list of data stored in {{ objstorage-name }} {#objstorage-list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.gitlab.title_object-storage }}**.

{% endlist %}

## Enabling storing data in {{ objstorage-name }} {#enable-objstorage}

{% include [objstorage-disable-note](../../_includes/managed-gitlab/objstorage-disable-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-gitlab) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Click the instance name and select ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.gitlab.title_object-storage }}**.
  1. Click **{{ ui-key.yacloud.gitlab.button_configure-data-types }}**.
  1. Select the data types you want to store in {{ objstorage-name }}.
    
      You can enable file proxying for each data type you select. In which case your files will be uploaded via a {{ GL }} server.

  1. Click **{{ ui-key.yacloud.common.save }}**.

      {% include [objstorage-note](../../_includes/managed-gitlab/objstorage-note.md) %}

{% endlist %}
