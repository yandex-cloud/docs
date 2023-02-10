# Getting started with {{ mmg-name }}

To get started with the service:
1. [Create a cluster](#cluster-create).
1. [Connect to the DB](#connect) .

{% if audience == "internal" %}

For the internal MDB service, the [web interface]({{ console-link }}) is deployed where you can manually create a database cluster. For more information about [quotas]({{ link-console-quotas }}) and the correlation between ABC services and clouds and folders, see [{#T}](../mdb/access.md).

{% include [Internal access](../_includes/mdb/internal-access.md) %}

## CLI setup {#cli-setup}

If you plan to use the CLI, install and configure it by following the [instructions](../cli/quickstart.md).

If you did everything correctly, the list clusters query should now work:

```bash
{{ yc-mdb-mg }} cluster list
```

{% else %}

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.

1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect to a DB cluster from inside {{ yandex-cloud }}, create a VM in the same cloud network as the DB cluster (with [Linux](../compute/quickstart/quick-create-linux.md){% if product == "cloud-il" %} or [Windows](../compute/quickstart/quick-create-windows.md){% endif %}).

   * To be able to connect to the cluster from the internet, request public access to hosts when creating the cluster.

   {% note info %}

   The next step assumes that you connect to the cluster from a [Linux](../compute/quickstart/quick-create-linux.md)-based VM.

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM via {% if lang == "ru" and audience != "internal" %}[SSH](../glossary/ssh-keygen.md){% else %}SSH{% endif %}.

1. Install {{ MG }} Shell:

   ```bash
   cd ~/ && \
   wget https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/4.4/multiverse/binary-amd64/mongodb-org-shell_4.4.1_amd64.deb && \
   sudo dpkg -i mongodb-org-shell_4.4.1_amd64.deb
   ```

{% endif %}

## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
1. Select **{{ mmg-name }}**.
1. Click **Create cluster**.
1. Set the cluster parameters and click **Create cluster**. This process is described in detail in [{#T}](operations/cluster-create.md).
1. Wait until the cluster is ready: its status on the {{ mmg-short-name }} dashboard changes to **Running** and its state to **Alive**. This may take some time.

## Connect to the DB {#connect}

{% if audience != "internal" %}

1. [Configure security groups](operations/connect/index.md#configuring-security-groups) for the cloud network to enable all the relevant traffic between the cluster and the connecting host.

{% endif %}

1. Get an SSL certificate:

   {% include [install-certificate](../_includes/mdb/mmg/install-certificate.md) %}

1. Connect to the cluster using the {{ MG }} CLI:

   {% include [default-connstring-old](../_includes/mdb/mmg/default-connstring-old.md) %}

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to the database](operations/connect/index.md).
* Read [questions and answers](qa/general.md).
