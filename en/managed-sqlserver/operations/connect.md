# Connecting to a database in a {{ MS }} cluster

You can connect to {{ mms-short-name }} cluster hosts:

* Over the internet, if you configured public access for the appropriate host. You can only connect to such clusters over an [SSL connection](#get-ssl-cert).
* From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md). If the cluster isn't publicly available, you don't need to use an SSL connection to connect to such VMs.

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% list tabs %}

- Ubuntu 20.04
  
  ```bash
  $ sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
  sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
  sudo update-ca-certificates
  ```

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Connecting to cluster hosts from graphical IDEs {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

You can only use graphical IDEs to connect to public cluster hosts using SSL certificates. Before connecting, [prepare a certificate](#get-ssl-cert).

{% list tabs %}

- DataGrip

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **Microsoft SQL Server**.
     1. On the **General** tab:
        1. Specify the connection parameters:
           * **Host**: FQDN of any {{ MS }} host.
           * **Port**: `{{ port-mms }}`.
           * **User**, **Password**: DB user's name and password.
           * **Database**: Name of the DB to connect to.
        1. Click **Download** to download the connection driver.
     1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate for the connection](#get-ssl-cert).
  1. Click **Test Connection** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver

  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select the **{{ MS }}** database from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        * **Host**: FQDN of any {{ MS }} host.
        * **Port**: `{{ port-mms }}`.
        * **DB/Schema**: Name of the DB to connect to.
        * **User**, **Password**: DB user's name and password.
     1. On the **SSL** tab, enable the **Use SSL** and **Always trust the server certificate** settings.
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you'll see the connection status and information about the DBMS and driver.
  1. Click **Done** to save the connection settings.

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mms-conn-strings-env.md) %}

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mms-connection-strings](../../_includes/mdb/mms-conn-strings.md) %}

