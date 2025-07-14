---
title: How to get started with {{ dataproc-full-name }}
description: In this tutorial, you will learn how to set up and configure a {{ dataproc-name }} cluster.
---

# Getting started with {{ dataproc-name }}

To get started:

1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).
1. [Connect to component interfaces](#connect-components).


## Getting started {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and either log in to {{ yandex-cloud }} or sign up if you do not have an account yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the following roles to your {{ yandex-cloud }} account:

    * [dataproc.editor](security/index.md#dataproc-editor): Required for cluster creation.
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user): Required to access the cluster [network](../vpc/concepts/network.md#network).
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user): Required to attach a [service account](../iam/concepts/users/service-accounts.md) to the cluster and create resources using its permissions.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Set up a NAT gateway](../vpc/operations/create-nat-gateway.md) in the subnet where your cluster will be deployed.

1. If you use security groups, [configure them](operations/cluster-create.md#change-security-groups).

1. You can access a {{ dataproc-name }} cluster both from within the {{ yandex-cloud }} infrastructure and from external networks:

   * To connect from within {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md) VM in the cluster’s network.

   * To connect to the cluster from the internet, enable public access for subclusters during cluster creation.

   {% note info %}

   The next step requires connecting to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to your VM over SSH.


## Create a cluster {#cluster-create}

To create a cluster:

1. In the management console, navigate to the folder where you want to create your cluster, then select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_empty-create }}**.
1. Specify your cluster settings and click **{{ ui-key.yacloud.mdb.forms.button_create }}**. For more information, see [Creating clusters](operations/cluster-create.md).
1. When the cluster is ready for operation, its status will change to **Alive**. This may take some time.

## Connect to the cluster {#connect}

To connect to your cluster:


1. If you are using security groups for a cloud network, [configure them](operations/connect.md#configuring-security-groups) to enable all required traffic between the cluster and the connecting host.


1. Copy the SSL key you specified during {{ dataproc-name }} cluster creation to the VM.

1. Connect to the cluster over SSH and check that Hadoop commands run properly. Depending on your image version, specify the username:

    * For version 2.0, use `ubuntu` as the username.
    * For version 1.4, use `root` as the username.

For a detailed description of the {{ dataproc-name }} cluster connection process, refer to the [Connecting to a cluster](operations/connect.md) section.

## Connect to the component interfaces {#connect-components}

To connect to the {{ dataproc-name }} component interfaces using the web UI:

1. [Enable the **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}**](operations/connect-interfaces.md#ui-proxy-enable) setting in the cluster.
1. Get a list of interface URLs.

To connect to the {{ dataproc-name }} component interfaces via SSH with port forwarding:

1. Create a jumpbox VM with a public IP address in the cluster’s network, using a security group that allows incoming and outgoing traffic on all component ports.
1. Connect to the new VM over SSH with port forwarding to the required {{ dataproc-name }} host ports. Depending on your image version, specify the username:

    * For version 2.0, use `ubuntu` as the username.
    * For version 1.4, use `root` as the username.

The detailed process for connecting to the {{ dataproc-name }} cluster’s component interfaces is described in [{#T}](operations/connect-interfaces.md).

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating clusters](operations/cluster-create.md) and [working with jobs](operations/jobs.md).
