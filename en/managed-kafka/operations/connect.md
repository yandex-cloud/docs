# Connecting to topics in an Apache Kafka® cluster

You can connect to {{ mkf-name }} cluster hosts:

* Over the internet if you configured public access for the cluster [when creating it](cluster-create.md). You can only connect to this type of cluster using an [SSL connection](#get-ssl-cert).


* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../vpc/concepts/network.md). If the cluster isn't publicly available, you don't need to use an SSL connection to connect to such VMs.



You can connect to the {{ KF }} cluster both with encryption (`SASL_SSL`, port 9091) and without it (`SASL_PLAINTEXT`, port 9092).


To connect to an {{ KF }} cluster:

1. [Create accounts](cluster-accounts.md#create-account) for clients (producers and consumers) with access to the required topics.
1. Connect the clients to the cluster:
   * Producers using the [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi).
   * Consumers using the [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

There are ready-made {{ KF }} API implementations for most popular programming languages. See [{#T}](#connection-string) for an example cluster connection code.

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the internet

   
   [Configure all security groups](../../vpc/operations/security-group-update.md#add-rule) in your cluster to allow incoming traffic on port 9091 from any IP. To do this, create the following rule for incoming traffic:

   * Port range: `9091`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   To allow connections to [{{ mkf-msr }}](../concepts/managed-schema-registry.md), add a rule for incoming traffic:

   * Port range: `443`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }}
   
   1. [Configure all security groups](../../vpc/operations/security-group-update.md#add-rule) in your cluster to allow incoming traffic on ports 9091 and 9092 from the security group where the VM is located. To do this, create the following rule for incoming traffic in these groups:


   * Port range: `9091-9092`.
   * Protocol: `TCP`.
   * Source: `Security group`.
   * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

   To allow connections to [{{ mkf-msr }}](../concepts/managed-schema-registry.md), add a rule for incoming traffic:

        * Port range: `443`.
        * Protocol: `TCP`.
        * Source: `CIDR`.
        * CIDR blocks: `0.0.0.0/0`.
   
   1. [Configure the security group](../../vpc/operations/security-group-update.md#add-rule) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

   Example of rules for a VM:

   * For incoming traffic:
      * Port range: `22`.
      * Protocol: `TCP`.
      * Source: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

      This rule lets you connect to the VM over SSH.

   * For outgoing traffic:
      * Protocol: ``Any``.
      * Port range: `{{ port-any }}`.
      * Source type: `CIDR`.
      * CIDR blocks: `0.0.0.0/0`.

      This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% list tabs %}

- Linux (Bash)

  {% include [install-certificate](../../_includes/mdb/mkf/install-certificate.md) %}


- Windows (PowerShell)

   ```powershell
   mkdir $HOME\.kafka; curl.exe -o $HOME\.kafka\{{ crt-local-file }} https://{{ s3-storage-host }}{{ pem-path }}
   ```


{% endlist %}

The resulting SSL certificate is also used when working with [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mkf-conn-strings-env.md) %}

Prior to connecting to cluster hosts over an SSL connection, [generate a certificate](#get-ssl-cert). The examples below assume that the `{{ crt-local-file }}` certificate is located in the directory:
* `{{ crt-local-dir }}` for Ubuntu;
* `$HOME\.kafka\` for Windows.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mkf-connection-strings](../../_includes/mdb/mkf-conn-strings.md) %}
