---
title: Creating a {{ baremetal-extend-stackland-name }} cluster
description: Follow this guide to create a {{ baremetal-extend-stackland-name }} cluster on {{ baremetal-name }} servers.
---

# Creating a {{ baremetal-extend-stackland-name }} cluster

{{ baremetal-extend-stackland-name }} automatically provisions servers and deploys a {{ stackland-name }} cluster on them. You can request access to the solution via the management console. If your access is already approved, you can create the cluster using the CLI.

Before submitting your request, prepare a brief description of your use case and decide which {{ stackland-name }} components you will require.

Before creating the cluster via the CLI, prepare the following:

* {{ stackland-name }} license key.
* Private {{ baremetal-name }} subnet and CIDR for the cluster nodes.
* Base DNS domain for the cluster.
* SSH key and password for bastion host access. You can store the password in a [{{ lockbox-name }} secret](../../../lockbox/concepts/secret.md).
* Configurations and server counts for each node role.

{% note warning %}

If you add previously provisioned servers to the cluster, {{ baremetal-extend-stackland-name }} will reinstall their OS. All data stored on their disks will be deleted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to submit the request from.
  1. [Navigate]({{ link-console-main }}/link/baremetal) to **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select **{{ ui-key.yacloud.baremetal.label_extend }}**, then **{{ ui-key.yacloud.baremetal.label_extend-stackland }}**.
  1. Click **{{ ui-key.yacloud.baremetal.extend.StacklandListPage.leaveRequest }}**.
  1. Describe how you plan to use {{ stackland-name }}.
  1. Select the {{ stackland-name }} components you intend to deploy.
  1. Fill in your contact details and click **{{ ui-key.yacloud.baremetal.extend.RequestClusterDialog.actionSubmit }}**.

  A {{ yandex-cloud }} specialist will contact you using the information you provided to finalize the requirements and access provision steps.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a YAML template for the request:

      ```bash
      yc baremetal v2 extend stackland-cluster create --example-yaml > stackland-cluster.yaml
      ```

  1. Open the `stackland-cluster.yaml` file and specify:

      * Cloud and folder IDs.
      * Cluster name, description, and labels.
      * Server pool ID, {{ stackland-name }} preset and version.
      * License key and the base DNS domain.
      * Node groups along with their roles, configurations, counts, and IDs of any pre-rented servers.
      * Bastion host settings, SSH key, and one password provision method.
      * Private subnet CIDR.
      * Public network access, if required.

      For a description of fields, see [this command reference](../../cli-ref/v2/extend/stackland-cluster/create.md).

      {% note info %}

      You can enable public network access only when creating the cluster. In fields that offer multiple value provision methods, e.g., for an SSH key or password, keep only one method.

      {% endnote %}

  1. Create a cluster:

      ```bash
      yc baremetal v2 extend stackland-cluster create \
        --request-file stackland-cluster.yaml
      ```

  1. Check the cluster state:

      ```bash
      yc baremetal v2 extend stackland-cluster list \
        --cloud-id <cloud_ID> \
        --folder-id <folder_ID>
      ```

{% endlist %}

It takes time to create servers and get them ready. When the cluster is ready, open its page in the **{{ ui-key.yacloud.baremetal.label_extend-stackland }}** subsection. On the page, you can view the nodes, their roles, configurations, private IP addresses, and the bastion host.

#### See also {#see-also}

* [{#T}](../../concepts/extend/stackland.md)
* [Getting started with {{ stackland-name }}](../../../stackland/quickstart.md#prerequisites)
* [Installing {{ stackland-name }} on {{ baremetal-name }}](../../../stackland/tutorials/install-on-yc-bms.md)
