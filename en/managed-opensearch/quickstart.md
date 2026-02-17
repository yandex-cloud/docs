---
title: Getting started with {{ mos-full-name }}
description: Follow this guide to create an {{ OS }} cluster and connect to it.
---

# Getting started with {{ mos-name }}

To get started:
1. [Create a cluster](#create-cluster).
1. [Configure security groups](#configure-security-groups).
1. [Connect to the cluster](#connect).
1. [Connect to {{ OS }} Dashboards](#dashboards-connect).


## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up if you do not have an account yet.

1. If you do not have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the [{{ roles.mos.editor }} role or higher](security/index.md#roles-list) to your {{ yandex-cloud }} account to be able to create a cluster.

    To attach the service account to a cluster, e.g., to [use {{ objstorage-full-name }}](operations/s3-access.md), your account also needs the [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) role or higher.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. You can connect to an {{ OS }} cluster both from inside {{ yandex-cloud }} and from the internet:

    * To connect from inside {{ yandex-cloud }}, [create a Linux-based VM](../compute/quickstart/quick-create-linux.md) in the same network as the cluster.

    * To connect to a cluster from the internet, [request public access](operations/cluster-create.md) to hosts with the `DATA` [role](concepts/host-roles.md#data) when creating the cluster.

{% note info %}

This guide deals with connecting to the cluster from the internet.

{% endnote %}


## Create a cluster {#create-cluster}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
1. [Navigate to](../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**. For more information, see [Creating a cluster](operations/cluster-create.md).
1. Configure the cluster.

    
    To access the {{ OS }} Dashboards web interface, request public access. To do this, navigate to **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }}** with the **Dashboards** group type and select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

    {% include [mos-tip-public-dashboards](../_includes/mdb/mos/public-dashboards.md) %}


1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Wait until the cluster is ready: its status on the {{ mos-name }} dashboard will switch to **Creating** and then to **Alive**. This may take a while.


## Configure security groups {#configure-security-groups}

{% include notitle [Configuring security groups](../_includes/mdb/mos/configuring-security-groups.md) %}


## Connect to the cluster {#connect}

Follow all the steps below on your Linux-based machine.

To connect to your cluster:

1. Install an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mos/install-certificate.md) %}

1. Connect to the cluster using [cURL](https://curl.haxx.se/):

   {% include [default-connstring](../_includes/mdb/mos/default-connstring.md) %}

   To connect, enter `admin` for the username and the password you set when [creating the cluster](#create-cluster).

   If the connection is successful, you will see a message like this:

   ```bash
   {
     "name" : "....{{ dns-zone }}",
     "cluster_name" : "...",
     "cluster_uuid" : "...",
     "version" : {
     "distribution" : "opensearch",
     ...
     },
     "tagline" : "The OpenSearch Project: https://opensearch.org/"
   }
   ```

## Connect to {{ OS }} Dashboards {#dashboards-connect}

1. In your browser, connect to the [{{ OS }} Dashboards]({{ os.docs }}/dashboards/index/) web interface:

   
   1. Make sure hosts with the `DASHBOARDS` role are publicly accessible.


   1. Install the [SSL certificate]({{ crt-web-path }}) in your browser's store of trusted root certificates (see the instructions for Mozilla Firefox [here](https://wiki.mozilla.org/PSM:Changing_Trust_Settings#Trusting_an_Additional_Root_Certificate)).
   1. On the cluster page in the management console, click **OpenSearch Dashboards** or go to `https://c-<{{ OS }}_cluster_ID>.rw.{{ dns-zone }}>` in your browser.
   1. Enter `admin` for the username and the password you set when [creating the cluster](#create-cluster).

1. Explore a set of sample data:

   1. On the {{ OS }} Dashboards welcome screen, click **Add sample data**.
   1. Next, click **View data** for the dataset in question.

Learn more about using {{ OS }} Dashboards in [this {{ OS }} guide]({{ os.docs }}/dashboards/index/).

## What's next {#whats-next}

* Read about the [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/connect.md).
