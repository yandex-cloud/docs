---
title: Pre-configuring a {{ SD }} cluster connection in {{ mmg-full-name }}
description: In this tutorial, you will learn how to pre-configure a database connection in a {{ SD }} cluster.
---

# Pre-configuring a {{ SD }} cluster connection

You can connect to {{ mmg-short-name }} cluster hosts:

{% include [cluster-connect-note](../../../_includes/mdb/mmg/cluster-connect-note.md) %}

To connect to cluster hosts, use the following ports:

* `{{ port-mmg }}`: For a non-sharded cluster.
* `{{ port-mmg-sharded }}`: For a [sharded](../../concepts/sharding.md) cluster.

The system will automatically route write requests to the cluster’s primary replica.

{% note info %}

To enable internet connectivity to the cluster, configure public access on its primary replica.

[Automatic failover](../../concepts/replication.md) may break internet connectivity to the cluster if public access is limited to specific hosts.

{% endnote %}



## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Rule settings depend on the chosen connection method:

{% list tabs group=connection_method %}

- Over the internet {#internet}

    [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow inbound traffic from any IP address on port `{{ port-mmg }}` for an unsharded cluster, or on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) cluster. To do this, create the following ingress rule:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
        * `{{ port-mmg }}` for a non-sharded cluster.
        * `{{ port-mmg-sharded }}` for a sharded cluster.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

- From a {{ yandex-cloud }} VM {#cloud}

    1. [Configure all cluster security groups](../../../vpc/operations/security-group-add-rule.md) to allow inbound traffic from your VM’s security group on port `{{ port-mmg }}` for an unsharded cluster, or on port `{{ port-mmg-sharded }}` for a [sharded](../shards.md) cluster. To do this, create the following ingress rule in these groups:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
            * `{{ port-mmg }}` for a non-sharded cluster.
            * `{{ port-mmg-sharded }}` for a sharded cluster.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: VM security group. If this is the same group you are currently configuring, specify `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).
        
    1. [Configure the VM’s security group](../../../vpc/operations/security-group-add-rule.md) to enable connections to the VM and traffic between the VM and the cluster hosts.

        VM rule examples:

        * For inbound traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}.`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule allows inbound connections to the VM over SSH.

        * For outbound traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

            This rule permits all outbound traffic, allowing you to install any necessary certificates and tools on your VM.

{% endlist %}

{% note info %}

You can specify more granular security group rules, such as allowing traffic only in specific subnets.

Make sure to properly configure security groups for all subnets where the cluster hosts will reside. Incomplete or incorrect security group configuration can lead to a loss of access to the cluster in the event of [automatic primary replica failover](../../concepts/replication.md).

{% endnote %}

For more information, see [{#T}](../../concepts/network.md#security-groups).


## Obtaining an SSL certificate {#get-ssl-cert}

To connect to public {{ SD }} hosts, obtain an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mmg/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Getting FQDNs for {{ SD }} hosts {#get-fqdn}

To connect to a host, you need its [FQDN](../../concepts/network.md#hostname) (fully qualified domain name). Here is an example of a {{ SD }} host FQDN:

```text
{{ host-name }}.{{ dns-zone }}
```

You can get the FQDN using one of the following methods:

* Check the FQDN in the management console:

    1. Navigate to the cluster page.
    1. Navigate to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Copy the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column value.

* In the [management console]({{ link-console-main }}), copy the cluster connection command (it contains the host’s FQDN). To get this command, navigate to the cluster page and click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Get the list of cluster hosts](../hosts.md#list-hosts) via the CLI or API.

## Connection limits {#connection-limits}

{% include [mmg-conn-limits](../../../_includes/mdb/mmg/conn-limits.md) %}

A host's RAM size depends on its class. All available options are listed under [Host classes](../../concepts/instance-types.md).

## Installing MongoDB Shell {#mongosh-install}

To connect to a {{ mmg-name }} cluster from either Linux (using Bash) or Windows (using PowerShell), install MongoDB Shell:

{% list tabs group=connection %}

- Linux {#linux}

  1. If you do not have Homebrew yet, install it:

      ```bash
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ```

  1. Add `brew` to `PATH`:

      ```bash
      echo >> /home/<username>/.bashrc && \
      echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/<user>/.bashrc && \
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ```

  1. Install the dependencies:

      ```bash
      sudo apt-get install build-essential
      ```

  1. Install the `mongodb-atlas-cli` package:

      ```bash
      brew install mongodb-atlas-cli
      ```

- Windows 10/11 {#windows}

  You can use one of the following methods:

  * Download and install the MongoDB Shell `*.msi` package from the [official GitHub repository](https://github.com/mongodb-js/mongosh/releases).
  * Install MongoDB Shell via [Chocolatey](https://chocolatey.org/install) by running this command:

    ```bash
    choco install mongodb-shell
    ```

{% endlist %}

## What's next {#whats-next}

* [Connect](clients.md) to the cluster using either command-line tools, a graphical IDE, or a Docker container.
* [Integrate](code-examples.md) the cluster connection into your application code.
