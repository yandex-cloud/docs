# Getting started with {{ mmg-name }}

To get started with the service:
1. [Create a cluster](#cluster-create).
1. [Connect to the DB](#connect).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect to a DB cluster from inside {{ yandex-cloud }}, create a VM in the same cloud network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md)).

   * To connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via SSH.

1. Install {{ MG }} Shell:

   ```bash
   cd ~/ && \
   wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-shell_4.4.1_amd64.deb && \
   sudo dpkg -i mongodb-org-shell_4.4.1_amd64.deb
   ```


## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Set the cluster parameters and click **{{ ui-key.yacloud.mdb.clusters.button_create }}**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mmg-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}


1. If you are using security groups for a cloud network, [configure them](operations/connect/index.md#configuring-security-groups) to enable all relevant traffic between the cluster and the connecting host.


1. Get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mmg/install-certificate.md) %}

1. Connect to the cluster using the {{ MG }} CLI:

   {% include [default-connstring-old](../_includes/mdb/mmg/default-connstring-old.md) %}

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect/index.md).
* Read [questions and answers](qa/general.md).
