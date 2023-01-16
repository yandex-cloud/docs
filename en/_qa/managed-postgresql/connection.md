# Connection to a {{ PG }} cluster

#### Is the cluster accessible from inside {{ yandex-cloud }}? {#conn-from-yc}

You can connect to {{ mpg-short-name }} cluster hosts:
* Over the internet, if you configured public access for the appropriate host. You can only connect to these hosts over an SSL connection.
* From {{ yandex-cloud }} virtual machines located in the same cloud network. If there is no public access to a host, connections from this type of virtual machine don't need to be over SSL.

For more information, please see the [service documentation](../../managed-postgresql/operations/connect.md).

#### How do I obtain an SSL certificate to connect to {{ mpg-name }} on Windows? {#get-ssl}

You can obtain an SSL certificate using PowerShell:

```powershell
mkdir $HOME\AppData\Roaming\postgresql; `
curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt {{ crt-web-path }}
```

The certificate will be available at `$HOME\AppData\Roaming\postgresql\root.crt`.

For more detail on obtaining a certificate and on connecting to a database, please see the [service documentation](../../managed-postgresql/operations/connect.md).

#### How do I install an SSL certificate to connect Power BI to {{ mpg-name }} via psql? {#power-bi}

1. Install [Windows Subsystem for Linux]({{ ms.docs }}/windows/wsl/) (WSL) and run the command below in the terminal window:

   ```bash
   mkdir /mnt/c/temp && \
   curl "{{ crt-web-path }}" -o /mnt/c/temp/CA.pem && \
   openssl pkcs12 -export -out /mnt/c/temp/CA.pfx -nokeys -in /mnt/c/temp/CA.pem
   ```

   The certificate will be available at `C:\temp\CA.pfx`.

2. [Place the certificate you received in the Windows certificate store](https://docs.microsoft.com/en-us/skype-sdk/sdn/articles/installing-the-trusted-root-certificate).
