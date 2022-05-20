# Connection

#### Is cluster access possible from within {{ yandex-cloud }}? {#conn-from-yc}

You can connect to {{ mpg-short-name }} cluster hosts:
* Over the internet, if you configured public access for the appropriate host. You can only connect to these hosts over an SSL connection.
* From {{ yandex-cloud }} virtual machines located on the same cloud network. If there is no public access to a host, connections from this type of virtual machine don't need to be over SSL.

For more information, please see the [service documentation](../operations/connect.md).

#### How do I get an SSL certificate for a {{ mpg-name }} connection on Windows? {#get-ssl}

You can get an SSL certificate using PowerShell:

```powershell
mkdir $HOME\AppData\Roaming\postgresql; `
curl.exe -o $HOME\AppData\Roaming\postgresql\root.crt https://{{ s3-storage-host }}{{ pem-path }}
```

The certificate will be available at `$HOME\AppData\Roaming\postgresql\root.crt`.

For more information about getting a certificate and connecting to the database, see the [service documentation](../operations/connect.md).
