# Connecting to topics in an Apache Kafka® cluster

You can connect to {{ mkf-name }} cluster hosts:

* Over the internet if you configured public access for the cluster [when creating it](cluster-create.md). You can only connect to such clusters over an [SSL connection](#get-ssl-cert).
* From {{ yandex-cloud }} virtual machines located in the same [cloud network](../../vpc/concepts/network.md). If the cluster isn't publicly available, you don't need to use an SSL connection to connect to such VMs.


You can connect to the {{ KF }} cluster both with encryption (`SASL_SSL`, port 9091) and without it (`SASL_PLAINTEXT`, port 9092).

To connect to an {{ KF }} cluster:

1. [Create accounts](cluster-accounts.md#create-account) for clients (producers and consumers) with access to the necessary topics.
1. Connect the clients to the cluster:
   * Producers using the [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi).
   * Consumers using the [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

There are ready-made {{ KF }} API implementations for most popular programming languages. See code examples for connecting to a cluster in [{#T}](#connection-string).

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% list tabs %}

- Over the Internet

  [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on port 9091 from any IP address. To do this, create the following rule for incoming traffic:
  * Protocol: `TCP`.
  * Port range: `9091`.
  * Source type: `CIDR`.
  * Source: `0.0.0.0/0`.

- With a VM in {{ yandex-cloud }}

  1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic on ports 9091, 9092 from the security group assigned to the VM. To do this, create the following rule for incoming traffic in these groups:
     * Protocol: `TCP`.
     * Port range: `9091`.
     * Source type: `Security group`.
     * Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

  1. [Set up the security group](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

     Example of rules for a VM:

     * For incoming traffic:
       * Protocol: `TCP`.
       * Port range: `22`.
       * Source type: `CIDR`.
       * Source: `0.0.0.0/0`.

       This rule lets you connect to the VM over SSH.

     * For outgoing traffic:
        * Protocol: `Any`.
        * Port range: `0-65535`.
        * Destination type: `CIDR`.
        * Destination: `0.0.0.0/0`.

       This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% endlist %}

{% note info %}

You can set more detailed rules for security groups, such as to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:


{% list tabs %}

- Linux (Bash)

  ```bash
  sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
  sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
  sudo chmod 655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
  ```

- Windows (PowerShell)

  ```powershell
  mkdir $HOME\.kafka; curl.exe -o $HOME\.kafka\YandexCA.crt https://{{ s3-storage-host }}{{ pem-path }}
  ```

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mkf-conn-strings-env.md) %}

Before connecting to cluster hosts over an SSL connection, [prepare a certificate](#get-ssl-cert). The examples below assume that the `YandexCA.crt` certificate is located in the directory:
* `/usr/local/share/ca-certificates/Yandex/` for Ubuntu.
* `$HOME\.kafka\` for Windows.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mkf-connection-strings](../../_includes/mdb/mkf-conn-strings.md) %}
