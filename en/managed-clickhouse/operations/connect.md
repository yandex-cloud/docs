# Connecting to a database in a {{ CH }} cluster

You can connect to {{ mch-short-name }} cluster hosts:

{% include [cluster-connect-note](../../_includes/mdb/cluster-connect-note.md) %}

You can connect to a cluster both with encryption, via ports `9440` for [clickhouse-client]({{ ch.docs }}/interfaces/cli/) and `8443` for the [HTTP interface]({{ ch.docs }}/interfaces/http/), and without encryption, via ports `9000` and `8123`, respectively.

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

{% if audience != "internal" %}

{% list tabs %}

- Over the internet

   [Configure all security groups](../../vpc/operations/security-group-add-rule.md) in a cluster to allow incoming traffic on ports 8443 and 9440 from any IP address. To do this, create the following rules for incoming traffic:

   * Port range: `8443`, `9440`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   A separate rule is created for each port.

- From a VM in {{ yandex-cloud }}

   1. [Configure all the security groups](../../vpc/operations/security-group-add-rule.md) of your cluster to allow incoming traffic on ports 8123, 8443, 9000, and 9440 from the security group where your VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * Port range: `8123` (or any of the other ports listed).
      * Protocol: `TCP`.
      * Source: `Security group`.
      * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. [Configure the security group](../../vpc/operations/security-group-add-rule.md) where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:
         * Port range: `22`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule lets you connect to the VM over SSH.

      * For outgoing traffic:
         * Port range: `{{ port-any }}`.
         * Protocol: ``Any``.
         * Source type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% else %}

{% list tabs %}

- Over the internet

   Configure all security groups in a cluster to allow incoming traffic on ports 8443 and 9440 from any IP address. To do this, create the following rules for incoming traffic:

   * Port range: `8443`, `9440`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   A separate rule is created for each port.

- From a VM in {{ yandex-cloud }}

   1. Configure all the security groups of your cluster to allow incoming traffic on ports 8123, 8443, 9000, and 9440 from the security group where your VM is located. To do this, create the following rules for incoming traffic in these security groups:

      * Port range: `8123` (or any of the other ports listed).
      * Protocol: `TCP`.
      * Source: `Security group`.
      * Security group: If a cluster and a VM are in the same security group, select `Self` (`Self`) as the value. Otherwise, specify the VM security group.

      A separate rule is created for each port.

   1. Configure the security group where the VM is located to allow connections to the VM and traffic between the VM and the cluster hosts.

      Example of rules for a VM:

      * For incoming traffic:
         * Port range: `22`.
         * Protocol: `TCP`.
         * Source: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule lets you connect to the VM over SSH.

      * For outgoing traffic:
         * Port range: `{{ port-any }}`.
         * Protocol: ``Any``.
         * Source type: `CIDR`.
         * CIDR blocks: `0.0.0.0/0`.

         This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.

{% endlist %}

{% endif %}

{% note info %}

You can set more detailed rules for security groups, such as allowing traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If the security group settings are incomplete or incorrect, you might lose access the cluster.

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate.

{% list tabs %}

- Linux (Bash)

   Run the following commands:

  {% include [install-certificate](../../_includes/mdb/mch/install-certificate.md) %}

{% if audience != "internal" %}

- Windows (PowerShell)

   1. Download and import the certificate:
      ```powershell
      mkdir -Force $HOME\.clickhouse; `
      (Invoke-WebRequest https://{{ s3-storage-host }}{{ pem-path }}).RawContent.Split([Environment]::NewLine)[-31..-1] `
        | Out-File -Encoding ASCII $HOME\.clickhouse\{{ crt-local-file }}; `
      Import-Certificate `
        -FilePath $HOME\.clickhouse\{{ crt-local-file }} `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

   1. Confirm that that you agree to install the certificate in the "Trusted Root Certification Authorities" store.

{% endif %}

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip

   1. Create a data source:
      1. Select **File** → **New** → **Data Source** → **{{ CH }}**.
      1. On the **General** tab:
         1. Specify the connection parameters:
            * **Host**: Any {{ CH }} host FQDN or a [special FQDN](#auto).
            * **Port**: `{{ port-mch-http }}`.
            * **User**, **Password**: DB user's name and password.
            * **Database**: Name of the DB to connect to.
         1. Click **Download** to download the connection driver.
      1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. Specify the path to the file with the [SSL certificate to use for your connection](#get-ssl-cert).
   1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **OK** to save the data source.

- DBeaver

   1. Create a new DB connection:
      1. In the **Database** menu, select **New connection**.
      1. Select **{{ CH }}** from the DB list.
      1. Click **Next**.
      1. Specify the connection parameters on the **Main** tab:
         * **Host**: FQDN of any {{ CH }} host or a [special FQDN](#auto).
         * **Port**: `{{ port-mch-http }}`.
         * **DB/Schema**: Name of the DB to connect to.
         * Under **Authentication**, specify the DB user's name and password.
      1. On the **Driver properties** tab:
         1. Click **Download** in a new window with an invitation to download the driver files.
         1. Specify the [SSL connection](#get-ssl-cert) parameters in the driver property list:
            * `ssl:true`;
            * `sslrootcert:<path to the file with an SSL certificate for the connection>`.
   1. Click **Test connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
   1. Click **Ready** to save the database connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

You can connect to public {{ CH }} cluster hosts only if you use an SSL certificate. Before connecting [prepare a certificate](#get-ssl-cert).

In the examples below, it is assumed that the `{{ crt-local-file }}` certificate:
* Is located in the `{{ crt-local-dir }}` folder (for Ubuntu).
* Is imported to the Trusted Root Certificate store (for Windows).

Connecting without an SSL certificate is only supported for hosts that are not publicly accessible. For connections to the database, traffic inside the virtual network isn't encrypted in this case.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mch-connection-strings](../../_includes/mdb/mch-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the {{ CH }} version is output.

## Selecting an available host automatically {#auto}

If you don't want to manually connect to another host in case the current one becomes unavailable, use an address like this:

* `c-<cluster ID>.rw.{{ dns-zone }}` to connect to an available host in a cluster.

* `<shard name>.c-<cluster ID>.rw.{{ dns-zone }}` to connect to an available host in a [shard](../concepts/sharding.md).

If the host that this address points to becomes unavailable, there may be a slight delay before the address starts pointing to another available host.
