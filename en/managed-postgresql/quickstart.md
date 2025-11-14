---
title: Getting started with {{ mpg-full-name }}
description: Follow this guide to create a {{ PG }} cluster and connect to it.
---

# Getting started with {{ mpg-name }}

{{ mpg-name }} helps you create and maintain {{ PG }} clusters in the {{ yandex-cloud }} infrastructure.

To get started:

1. [Create a DB cluster](#cluster-create).
1. [Connect to the DB](#connect).
1. [Send your requests to the database](#query-db).


## Getting started {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) and [{{ roles.mpg.editor }}](security/index.md#managed-postgresql-editor) roles for the folder to your {{ yandex-cloud }} account. to be able to create a cluster.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md) VM in the same network as the DB cluster.

   * To connect to the cluster from the internet, request public access to hosts when [creating the cluster](#cluster-create).

   {% note info %}

   The next step implies connecting to the cluster from a VM. If your plan is to connect to the cluster from the internet, proceed to [creating a cluster](#cluster-create).

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over [SSH](https://en.wikipedia.org/wiki/Secure_Shell).


## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter a name for the cluster.
1. Select the `PRODUCTION` environment.
1. Select the {{ PG }} version.
1. Select the [host class](concepts/instance-types.md). Host class determines the technical specifications of the [VMs](../compute/concepts/vm.md) the cluster [hosts](concepts/index.md) will be deployed on.
1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

    1. Select the [disk type](concepts/storage.md#storage-type-selection).
    1. Set the [storage](concepts/storage.md) size.

1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**:

    1. Specify the DB name. It must be unique within the folder.
    1. Specify the user name of the DB owner.
    1. Enter your password or generate one using [{{ connection-manager-name }}](../metadata-hub/concepts/connection-manager.md).

1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:

    1. Select the cloud network you [created before you started out](#before-you-begin).
    1. Select the default security group or create a new one.

1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, specify the availability zones and subnets for the hosts that will be created together with the cluster.

   If you plan to connect to the cluster from the internet, enable **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** for the hosts.

1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Wait until the cluster is ready to work: its status will change to **Running**, and its state to **Alive**. To check its state, hover over the cluster status in the **{{ ui-key.yacloud.common.availability }}** column.

## Connect to the DB {#connect}


{% note warning %}

If you are using security groups for a cloud network, [configure them](operations/connect.md#configuring-security-groups) to enable all relevant traffic between the cluster and the connecting host.

{% endnote %}


To connect to the database:

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

    1. Get an SSL certificate:

        ```bash
        mkdir -p ~/.postgresql && \
        wget "{{ crt-web-path }}" \
                --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
        ```

        The certificate will be saved to the `~/.postgresql/root.crt` file.

    1. Install the required dependencies and the {{ PG }} client:

        ```bash
        sudo apt update && sudo apt install -y postgresql-client
        ```

    1. Connect to the database:

        {% include [default-connstring](../_includes/mdb/mpg/default-connstring.md) %}

        You can get the cluster ID with the [list of clusters in the folder](operations/cluster-list.md#list-clusters).

- Windows (PowerShell) {#windows}

    1. Install the same [{{ PG }} for Windows](https://www.postgresql.org/download/windows/) version that is used in the cluster. Select the _Command Line Tools_ install only.

    1. Get an SSL certificate:

        ```powershell
        mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
        ```

        The certificate will be saved to the `$HOME\.postgresql\root.crt` file.

    1. Set the environment variables for the connection:

        ```powershell
        $Env:PGSSLMODE="verify-full"; $Env:PGTARGETSESSIONATTRS="read-write"
        ```

    1. Connect to the database:

        ```powershell
        & "C:\Program Files\PostgreSQL\<{{ PG }}_major_version>\bin\psql.exe" `
            --host=c-<cluster_ID>.rw.{{ dns-zone }} `
            --port={{ port-mpg }} `
            --username=<username> `
            <DB_name>
        ```

        You can get the cluster ID with the [list of clusters in the folder](operations/cluster-list.md#list-clusters).

{% endlist %}

## Send your requests to the database {#query-db}

{% include [query-db](../_includes/mdb/pg-spqr-query-db.md) %}


## What's next {#whats-next}

* [Transfer data](../data-transfer/tutorials/managed-postgresql.md#quick-transfer) to the cluster database.
* Read about the [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a database](operations/connect.md).
* Check out our user [tutorials](tutorials/index.md).
* Check [questions and answers](qa/general.md).
