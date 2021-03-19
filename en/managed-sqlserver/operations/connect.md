# Connecting to a database in a cluster {{ MS }}

You can connect to {{ mms-short-name }} cluster hosts:

- Over the internet, if you configured public access for the appropriate host. You can only connect to such clusters over an [SSL connection](#get-ssl-cert).
- From {{ yandex-cloud }} VM instances hosted in the same [virtual network](../../vpc/concepts/network.md). If the cluster isn't publicly available, you don't need to use an SSL connection to connect to such VMs.

## Getting and installing an SSL certificate {#get-ssl-cert}

To use an encrypted SSL connection, get an SSL certificate and add it to the operating system's trusted certificate store:

{% list tabs %}

- Ubuntu 20.04
  
  ```bash
  $ sudo mkdir -p /usr/local/share/ca-certificates/Yandex && \
  sudo wget "https://{{ s3-storage-host }}{{ pem-path }}" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
  sudo update-ca-certificates
  ```

{% endlist %}

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mms-conn-strings-env.md) %}

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mms-connection-strings](../../_includes/mdb/mms-conn-strings.md) %}

