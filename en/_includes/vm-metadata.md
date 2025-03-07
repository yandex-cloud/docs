You can directly access the VM metadata from within the VM. This method provides access to [all the metadata folders](../compute/concepts/metadata/directories.md) as well as all the keys inside them.

You can get direct access (without authentication) to metadata from inside the VM through a special metadata service. The metadata service inside the VM instance is available at `http://169.254.169.254`.

All authenticated VM users can access the metadata service without any restrictions. You cannot restrict an individual VM user's access to metadata.

You can test the metadata service using [cURL](https://curl.haxx.se) by first [connecting](../compute/operations/vm-connect/ssh.md) to the VM via the ssh protocol:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254
```

The metadata service will respond with a list of available metadata versions, for example:

```bash
1.0
2007-01-19
2007-03-01
...
2023-02-15
2023-05-10
latest
```

We recommend always using the `latest` metadata version.