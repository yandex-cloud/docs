---
title: Getting started with {{ mmg-full-name }}
description: In this tutorial, you will learn how to set up and configure a {{ SD }} cluster.
---

# Getting started with {{ mmg-name }}

To get started:


* [Create a cluster](#cluster-create).
* [Connect to the database](#connect).



## Getting started {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if you do not have an account yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the [{{ roles.mmg.editor }} role (or higher)](security/index.md#roles-list) to your {{ yandex-cloud }} account. These roles provide the permissions needed to create a cluster.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. You can connect to database clusters both from within and outside {{ yandex-cloud }}:

   * To connect from within {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md)-based VM in the same cloud network as your database cluster.

   * To connect to your cluster from the internet, request public access to its hosts when creating it.

   {% note info %}

   The next step requires connecting to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to your VM over SSH.

1. Install {{ MG }} Shell:

   ```bash
   cd ~/ && \
   wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-shell_4.4.1_amd64.deb && \
   sudo dpkg -i mongodb-org-shell_4.4.1_amd64.deb
   ```
   

## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create your database cluster.
1. [Navigate to](../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}** service.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Specify the cluster settings and click **{{ ui-key.yacloud.mdb.clusters.button_create }}**. For more information, see [Creating a cluster](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mmg-short-name }} dashboard will change to **Running**, and its state to **Alive**. This may take a while.


## Connect to the database {#connect}

1. If using security groups for the cloud network, [configure them](operations/connect/index.md#configuring-security-groups) to allow all required traffic between the cluster and your connection host.

1. Obtain an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mmg/install-certificate.md) %}

1. Connect to the cluster using the {{ MG }} CLI:

   {% include [default-connstring-old](../_includes/mdb/mmg/default-connstring-old.md) %}

    To learn how to get a host’s FQDN, see [this guide](operations/connect/index.md#get-fqdn).


## What's next {#whats-next}

* Read about the [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a database](operations/connect/index.md).
* Check out the [questions and answers](qa/general.md).
