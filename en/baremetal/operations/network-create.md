---
title: How to create a VRF in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to create a virtual routing and forwarding (VRF) segment in {{ baremetal-full-name }}.
---

# Creating a VRF

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [VRF](../concepts/network.md#vrf-segment).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}**.
  1. At the top right, click **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. In the **{{ ui-key.yacloud.baremetal.field_name }}** field, specify your VRF name. The naming requirements are as follows:

     {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, you can add a VRF **{{ ui-key.yacloud.baremetal.field_description }}**.
  1. Optionally, you can add labels.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-network }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. View the description of the command to create a [virtual network segment (VRF)](../concepts/network.md#vrf-segment):

     ```bash
     yc baremetal vrf create --help
     ```
  
  1. Create a VRF:
     
     ```bash
     yc baremetal vrf create \
       --name <VRF_name> \
       --description "<VRF_description>" \
       --labels <key>=<value>
     ```

     Where:
     * `--name`: VRF name. The naming requirements are as follows:
       
       {% include [name-format](../../_includes/name-format.md) %}

     * `--description`: VRF description. This is an optional parameter.
     * `--labels`: VRF labels. This is an optional parameter.

{% endlist %}

## Example {#examples}

Create a virtual routing and forwarding segment with a name, description, and label:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal vrf create \
    --name demo-vrf \
    --description "My first VRF" \
    --labels env=test
  ```

  Result:  
  
  ```text
  id: ly52l2lzaq5uw********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-vrf
  description: My first VRF
  created_at: "2025-07-01T21:37:08.740581Z"
  labels:
    env: test
  ```

{% endlist %}