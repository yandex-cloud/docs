---
title: Getting started with {{ mrd-full-name }}
description: Follow this guide to create a {{ RD }} cluster and connect to it.
---

# Getting started with {{ mrd-name }}

To get started with the service:
1. [Create a cluster](#cluster-create).
1. [Connect to the cluster](#connect).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the [{{ roles.mrd.editor }} role or higher](security/index.md#roles-list) to your {{ yandex-cloud }} account. These roles allow you to create a cluster.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Create a Linux VM](../compute/operations/vm-create/create-linux-vm.md#console_1).

    Specify the following parameters:

    * **{{ ui-key.yacloud.compute.instances.create.section_image }}**: `Ubuntu 24.04` from {{ marketplace-short-name }}.
    * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
    * **{{ ui-key.yacloud.compute.instances.create.field_security-groups }}**: Leave the field empty.

        The VM will be assigned [the default security group](../vpc/concepts/security-groups.md) with the `default-sg` prefix. This security group enables SSH connections to the VM and allows any outgoing traffic.

    Set the other parameters as you need.

1. [Create a security group](../vpc/operations/security-group-create.md) in the same network as the VM. This security group will be assigned to the {{ RD }} cluster when creating it.

    In the security group, add a [rule](./operations/connect/index.md#configuring-security-groups) that allows connections to a [non-sharded {{ RD }} cluster](./concepts/sharding.md). Configuire the rule to allow incoming traffic from the default security group assigned to the VM.


## Create a cluster {#cluster-create}


Create a non-sharded {{ RD }} cluster [without public access](./concepts/network.md#public-access-to-host). You can only [connect](#connect) to such a cluster from a VM in the cluster network.


To create a cluster:

1. In the management console, select the folder where you want to create a {{ RD }} cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. Specify the following cluster parameters:

    * **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: Cluster name. It must be unique within the folder.
        * **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}**: Keep this option disabled.
        * Enable **{{ ui-key.yacloud.redis.field_tls-support }}**.
        * Enable **{{ ui-key.yacloud.redis.field_announce-hostnames }}**.

    * **{{ ui-key.yacloud.mdb.forms.section_network }}**:

        * **Network**: Specify the network with the [previously created](#before-you-begin) VM.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: Specify the [previously created](#before-you-begin) security group for the cluster.

    * **{{ ui-key.yacloud.mdb.forms.section_host }}** → **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}**: Make sure to disable this option, i.e., set its value to `No`, for all cluster hosts.

    * **{{ ui-key.yacloud.mdb.forms.section_settings }}** → **{{ ui-key.yacloud.mdb.forms.config_field_password }}**: User password.

        {% include [requirements-to-password](../_includes/mdb/mrd/requirements-to-password.md) %}

1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Wait until the cluster is ready: its status on the {{ mrd-name }} dashboard will change to **Running** and its state, to **Alive**. This may take some time.

For more information about creating a cluster, see [{#T}](./operations/cluster-create.md).

## Connect to the cluster {#connect}

1. [Use](../compute/operations/vm-connect/ssh.md) SSH to [connect to the previously created VM](#before-you-begin).

1. Install the `redis-cli` utility:

    ```bash
    sudo apt update && sudo apt install --yes redis-tools
    ```

1. Connect directly to the master host:

    {% list tabs group=connection %}

    - Connecting without SSL {#without-ssl}

        ```bash
        redis-cli -h c-<cluster_ID>.rw.{{ dns-zone }} \
          -p {{ port-mrd }} \
          -a <{{ RD }}_password>
        ```

    - Connecting via SSL {#with-ssl}

        1. Get an SSL certificate:

            {% include [unix-certificate](../_includes/mdb/mrd/unix-certificate.md) %}

        1. Run the following command:

            ```bash
            redis-cli -h c-<cluster_ID>.rw.{{ dns-zone }} \
              -p {{ port-mrd-tls }} \
              -a <{{ RD }}_password> \
              --tls \
              --cacert ~/.redis/{{ crt-local-file }}
            ```

    {% endlist %}

    You can get the cluster ID with a [list of clusters in the folder](./operations/cluster-list.md#list-clusters).

    {% include [see-fqdn-in-console](../_includes/mdb/see-fqdn-in-console.md) %}

1. Once connected, send the `PING` command. {{ RD }} should respond with `PONG`.

## What's next {#whats-next}

* Read about [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a cluster](operations/connect/index.md).
* Read [questions and answers](qa/general.md).
