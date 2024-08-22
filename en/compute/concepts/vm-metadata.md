# VM metadata

[VM](vm.md) instance details are available in the metadata service. You can use metadata to provide any keys and values, and then request the metadata from [inside](../operations/vm-info/get-info.md#inside-instance) or [outside](../operations/vm-info/get-info.md#outside-instance) a VM instance. For more information about setting up a metadata service, see [{#T}](../operations/vm-info/get-info.md#metadata-options).

Metadata is also used by apps that launch at VM startup.

## Metadata formats supported inside VM {#metadata-formats}

From inside a VM instance, metadata is available in the following formats:
* [Google Compute Engine](../operations/vm-info/get-info.md#gce-metadata) (not all fields are supported).
* [Amazon EC2](../operations/vm-info/get-info.md#ec2-metadata) (not all fields are supported).

## How to send metadata {#how-to-send-metadata}

You can provide metadata when creating or [updating](../operations/vm-control/vm-update.md#change-metadata) VMs. Data for connection to a VM can only be provided when creating the VM; moreover, in a [VM running Linux](../operations/vm-create/create-linux-vm.md), a public SSH key must be provided for each user.

{% list tabs group=instructions %}

- Management console {#console}

  Metadata is provided under **{{ ui-key.yacloud.common.metadata }}** in `Key:Value` format.

  For example, to create multiple users in the virtual machine OS, add the `user-data` key and specify the following configuration in it:

  {% include [users-from-metadata-example](../../_includes/compute/users-from-metadata-example.md) %}

  When creating users via metadata, specify the data of all users in the `user-data` key, including the data of the user specified under **{{ ui-key.yacloud.compute.instances.create.section_access }}**.

- CLI {#cli}

  In the CLI, you can provide metadata in any of the three parameters:

  * `--metadata-from-file`: As a configuration file in the `--metadata-from-file key=<file_path>` format. Use this method to conveniently deliver a value consisting of several lines.

      For example, to add several users to a VM at the same time, describe the configuration in a `YAML` file:

      {% include [users-from-metadata-example](../../_includes/compute/users-from-metadata-example.md) %}

  * `--metadata`: As a comma-separated list of `key=value` pairs, e.g., `--metadata foo1=bar,foo2=baz`.

      For a multiline value, use `\n` to split lines, e.g., `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`.
  * `--ssh-key`: Provide an SSH key. Only for Linux VMs.

    {{ compute-name }} creates the `yc-user` user and adds the specified SSH key to the list of authorized keys. After the VM is created, you can use this key to connect to it over SSH.

  You can combine these parameters, for example:

  ```bash
  yc compute instance create \
    --name my-instance \
    --metadata-from-file user-data=metadata.yaml \
    --metadata serial-port-enable=1
  ...
  ```

- {{ TF }} {#tf}

   In {{ TF }}, you can specify metadata in three ways:
   * As a separate file with user metadata to process by the `cloud-init` agent. Under `metadata`, specify the path to the file with user metadata, such as `cloud-init.yaml`:

      ```hcl
      ...
      metadata = {
        user-data = "${file("cloud-init.yaml")}"
      }
      ...
      ```

      {% cut "Sample contents of the `cloud-init.yaml` file" %}

      {% include [users-from-metadata-example](../../_includes/compute/users-from-metadata-example.md) %}

      {% endcut %}

   * Under `metadata`, as a line with user metadata. For a multiline value, use `\n` to split lines. For example:

      ```hcl
      ...
      metadata = {
        user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - <SSH_key _contents>"
      }
      ...
      ```

  * Only for Linux VMs. Under `ssh-keys`, specify the username and the SSH key to access Linux VMs. Enter your username and the contents of your SSH key as follows:

      ```hcl
      ...
      metadata = {
        ssh-keys = "<username>:<SSH_key_contents>"
      }
      ...
      ```

      If you are using an out-of-the-box public [image](../concepts/image.md) from {{ marketplace-full-name }}, the specified username does not matter. The key will be assigned to the user specified in the `cloud-init` configuration by default. Such users vary depending on an image.

      If you do not know the default user, find the string containing `Authorized keys from` in the [serial port output](../operations/vm-info/get-serial-port-output.md). It contains the name of the user assigned the authorized keys.

      If no such string is found, but you see the `no authorized ssh keys fingerprints found for user` string, it means that you did not provide your SSH key correctly. In this case, check the format or try providing the SSH keys in the `user-data` field.

- API {#api}

  In the API, specify the metadata in the `metadata` property as a JSON object, e.g.:

  ```json
  "metadata": {
    "ssh-keys": "ssh-ed25519 AAAAB3Nza... user@example.com",
    "serial-port-enable": "1"
  }
  ```

  For a line break, use `\n`.

{% endlist %}

{% note warning %}

The metadata, including the user-defined one, is available in unencrypted format. If the metadata contains sensitive information, make sure to protect it, e.g., through encryption.

{% endnote %}

## Keys processed in public images {#keys-processed-in-public-images}

The list of keys that are processed in {{ yandex-cloud }} public images depends on the operating system.

{% list tabs group=operating_system %}

- Linux {#linux}

  * `serial-port-enable`: Flag enabling access to the [serial console](../operations/serial-console/index.md). `1`: access enabled; `0`: (default) access disabled.
  * `enable-oslogin`: Flag that enables access via [OS Login](../operations/vm-connect/os-login.md). `True` means access is enabled; `false` (default) means access is disabled.
  * `user-data`: String with the user metadata to be processed by the [cloud-init](https://cloud-init.io) agent running on a VM instance.

    Cloud-init supports different metadata transmission [formats](https://cloudinit.readthedocs.io/en/latest/topics/format.html), e.g., [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html). In this format, you can provide SSH keys and indicate which user each key is associated with. To do this, specify them in the `users/ssh-authorized-keys` section:

    {% include [user-data](../../_includes/compute/user-data.md) %}

    To provide this data in the request, replace line breaks with `\n`:

    ```json
    "metadata": {
      "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3Nza......OjbSMRX user@example.com\n      - ssh-ed25519 AAAAB3Nza...Pu00jRN user@desktop"
    }
    ```

    For example, in the `user-data` key, you can describe the [software installation scripts](../operations/vm-create/create-with-cloud-init-scripts.md#examples) to be run when creating a new VM.

  * `ssh-keys`: Key for delivering the SSH key to Linux VMs through {{ TF }}. Specify it in `<username>:<SSH_key_content>` format, e.g., `user:ssh-ed25519 AAC4NzaC1... user@example.com`. If you specify multiple keys, only the first one will be used.

- Windows {#windows}

  `user-data`: String with user metadata to be processed by the [Cloudbase-Init](https://cloudbase.it/cloudbase-init/) agent. This agent supports various [data formats](https://cloudbase-init.readthedocs.io/en/latest/userdata.html), such as PowerShell scripts that set the administrator password:

   ```json
   "metadata": {
     "user-data": "#ps1\nnet user Administrator Passw0rd"
   }
   ```

{% endlist %}

## Identity document {#identity-document}

When creating a VM, an identity document that stores information about the VM is generated. It contains IDs of the VM, Marketplace product, disk image, etc. VMs can request information about themselves from the metadata service.

To request an identity document:

1. Connect to the VM:

   ```bash
   ssh <VM's_IP>
   ```

1. You can get an identity document in [Google Compute Engine](../operations/vm-info/get-info.md#gce-metadata) and [Amazon EC2](../operations/vm-info/get-info.md#ec2-metadata) formats. Run this command:

   {% list tabs %}

   - GCE

      ```bash
      curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
      ```

   - EC2

      ```bash
      curl http://169.254.169.254/latest/vendor/instance-identity/document
      ```

   {% endlist %}

   Response example:

   ```
   {"instanceId":"fhmm5252k8vl********","productCodes":null,"imageId":"fd8evlqsgg4e********","productIds":["f2e3ia802lab********"],"createdAt":"2023-05-29T09:46:59Z","version":"2023-03-01"}
   ```

{% note info %}

If you created your VM before June 9, 2023, and you cannot get its identity document, stop and restart the VM.

{% endnote %}

### Signed identity documents {#signed-identity-documents}

If you are going to use the contents of an identity document for critical tasks, check the contents and validate the document before using it.

Apart from identity documents, the VM metadata service provides their cryptographic signatures. You can use these signatures to verify a document's origin, validity, and integrity.

{% list tabs %}

- RSA

   1. Connect to the VM:

      ```bash
      ssh <VM's_IP>
      ```

   1. Get an RSA signature from the VM metadata and save it to a file named `rsa2048`:

      * **GCE**:

         ```bash
         curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/rsa > rsa2048
         ```

      * **EC2**:

         ```bash
         curl http://169.254.169.254/latest/vendor/instance-identity/rsa > rsa2048
         ```

   1. Create a `certificate` file and add a public certificate to it:

      
      ```
      -----BEGIN CERTIFICATE-----
      MIIC4TCCAcmgAwIBAgIUP0zcGO1MeRwze8VdSMEt/OdBXoIwDQYJKoZIhvcNAQEL
      BQAwADAeFw0yMzA2MDcwNjU4MTBaFw0zMzA2MDQwNjU4MTBaMAAwggEiMA0GCSqG
      SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDw6TvAvrbJvY4tzIIuDnLEVfRUW4BZJD3y
      K8fyyxXrYDvC69RKCKk9+TQhnUOLhZNlDST4HFfSPlakOjXUduyJE5M1EmoLAstN
      81aP3TejseDavxmaNijXRsa9E731T5H+zo44PgAHfQJmiD7rtcr+QOIosKUB2dwp
      F2acp9hLKd389BfNctziG0Oxq7hlISTDBnhzBg7eKuqWtShjVW5RqQvp3bARfUPa
      RWdYjmZvR+AnmozV1SGnpAnatzhnF6tNAb5XSEw49tumsX1D4A11J6mtrafO6bsP
      wdIPwy9W15iCszUNlFcdBaZhESc34VbyCyLMvA5T0Uj1FJHz1RFlAgMBAAGjUzBR
      MB0GA1UdDgQWBBQq0z6Vcmjcn8wnRTwKGSm5YGas9TAfBgNVHSMEGDAWgBQq0z6V
      cmjcn8wnRTwKGSm5YGas9TAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
      A4IBAQBplippQ/Pxn7AkuwOTSwSTeJ7S+rMSb6iSL9chNHetanft0Ikr5BDsSrd6
      TeHV0sEMilDIjX0EjSNHwYtYrDPk6cGjkzDTYb6/U10c5Xhwi0g7/lMH/RPihPz5
      co80VEqXWlgfgHuE7/cAiTJ61PiFD9oI494bQcIISQNDfbUUiYfn32+8nK20rn8C
      w7PbGoIv6zz6A0c6DJT7yXJF5sAHgX4M03Oi9edzQ077ZOboXSuUKe4VfHIpjTjZ
      0sM/NbG5BFstyetVc3FZOGWGukTRb0C0GSASOm6hCyh5ctmpwlS4menc/OAx9BYO
      r9ZBjEa0oLFVV0pP5Tj4Gf1DDpuJ
      -----END CERTIFICATE-----
      ```




   1. Verify the signature and save the contents of the document to a file named `document`:

      ```bash
      openssl smime -verify -in rsa2048 -inform PEM -certfile certificate -noverify | tee document
      ```

      If the signature is valid, you will see a message saying `Verification successful`.

- DSA

   1. Connect to the VM:

      ```bash
      ssh <VM's_IP>
      ```

   1. Get a dsa2048 signature from the VM metadata and save it to a file named `dsa2048`:

      * **GCE**:

         ```bash
         curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/dsa > dsa2048
         ```

      * **EC2**:

         ```bash
         curl http://169.254.169.254/latest/vendor/instance-identity/dsa > dsa2048
         ```

   1. Create a `certificate` file and save a public certificate to it:

      
      ```
      -----BEGIN CERTIFICATE-----
      MIIERjCCA+ugAwIBAgIULIUmuptqf9Pz7nMGMHeW+BPNneYwCwYJYIZIAWUDBAMC
      MAAwHhcNMjMwNjA3MDY1NjI0WhcNMzMwNjA0MDY1NjI0WjAAMIIDRjCCAjkGByqG
      SM44BAEwggIsAoIBAQDFyteKPnUOauqiHzsLCw2Z//c1IjSqVVPpIbETQ1NUCsUI
      o6+at1VkxJ76K/HqvFlhC87nSGWuQMgflQXcVIEQ8c0wnQGRj4lwkkjm8WClo4xv
      t/FsNyv4uEcPgcz45A2YxE4+5odjicKMCz4pPW+kc9t4BiKw4I9uGySBhA1p21e+
      fmR4AzDSHdHGRlvlYOfYANZlVeWm+qLsb+VfyeETTOD+ooMA9Y4ue3dw2l8Clib8
      WummF2PNRnnOeEFGbwZErtdObla2TjdNzFWc6QWo1EcqqkBXG1TutY/FgNcTj+Ps
      nFoUu4ZIy7o8p8YgzyffSCQbP5ppRGpfh4DuIS+vAiEA8tkwKyKmcCxTWnpRNWlY
      O6kUanHgEQczpLtP3mDvcdUCggEAMhbW4syX5p7X1qs0OnFCLcd4tYA2DnR1dLu3
      ZPusUh6c9+cH3ICEnK22KB1nplMAHDyXjtV2rCvIGlNUcT6OkSulnkvNE185cfM0
      UKofG4t6VJNpa8bngF7Ccyf6QBPcUzigHv+QDQDZuA4k3IcQp0hC9ppOaN6J9rKp
      5cSPyLzJ2vyY6mG650omxgnwG4OGZSRX8c1JN/MvIj79m3LqM7civ8l6ljnC+LNm
      1T7mcgZcf9iYc5+OWICoeDtFUdr+qsNIXonIMku6FpJu0pBgVgE6GI+nD4oaXSQS
      bckxB24DEYvTlVALuXqPS8MZyQZz5ltoI8xnbEOMqtU3IPox1AOCAQUAAoIBADcS
      Pt2SC+cGUCKNhrPquESB2/dZKUDuyEtYIYMidfoyoBGhz2QuqOqf5tEcLY9gCeMP
      NxmaXW1AQtcAX/+tyCZrVxEc31btW3alLmu/NtKxmb6PRshsASI/LIE1wH82TV8C
      4ymFDyKUGCb5AWN+Ziv5AP5/6Q08awQ7YAuz/sw0xOMqDuUfYkLerPEuQg5Sozs0
      DWucS/ex7l+VqNAZUBZykta961bhplIDTRG05YD3Lz0w/WIBMdZzzolA7F3jgFJg
      rCfZwQeDbf1iorfxRS5DqR0Vt7XE6/yqRUzDjOMctKY68jLZGFfOfTQ9iX2R9K/f
      7kJPxaHnA+WWo13ExwGjUzBRMB0GA1UdDgQWBBTj+x+t2VJhAWI57o9xRwMOeTFj
      mzAfBgNVHSMEGDAWgBTj+x+t2VJhAWI57o9xRwMOeTFjmzAPBgNVHRMBAf8EBTAD
      AQH/MAsGCWCGSAFlAwQDAgNIADBFAiAX2ABj/9ea1Q4ssAgIGkA4vJywoUoT4Sbg
      LFFIJGlNWgIhAO0b749SY5+6UMEOLsxgvNzKKcv58BKADfBdJAXE6fRk
      ```



   1. Verify the signature and save the contents of the document to a file named `document`:

      ```bash
      openssl smime -verify -in dsa2048 -inform PEM -certfile certificate -noverify | tee document
      ```

      If the signature is valid, you will see a message saying `Verification successful`.

- BASE64

   1. Connect to the VM:

      ```bash
      ssh <VM's_IP>
      ```

   1. Get a base64 signature from the VM metadata and save it to a file named `signature`:

      * **GCE**:

         ```bash
         curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/base64 | base64 -d >> signature
         ```

      * **EC2**:

         ```bash
         curl http://169.254.169.254/latest/vendor/instance-identity/base64 | base64 -d >> signature
         ```

   1. Get an identity document and save it to a file named `document`:

      * **GCE**:

         ```bash
         curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document > document
         ```

      * **EC2**:

         ```bash
         curl http://169.254.169.254/latest/vendor/instance-identity/document > document
         ```

   1. Create a `certificate` file and save a public certificate to it:

      ```
      -----BEGIN CERTIFICATE-----
      MIIC4TCCAcmgAwIBAgIUP0zcGO1MeRwze8VdSMEt/OdBXoIwDQYJKoZIhvcNAQEL
      BQAwADAeFw0yMzA2MDcwNjU4MTBaFw0zMzA2MDQwNjU4MTBaMAAwggEiMA0GCSqG
      SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDw6TvAvrbJvY4tzIIuDnLEVfRUW4BZJD3y
      K8fyyxXrYDvC69RKCKk9+TQhnUOLhZNlDST4HFfSPlakOjXUduyJE5M1EmoLAstN
      81aP3TejseDavxmaNijXRsa9E731T5H+zo44PgAHfQJmiD7rtcr+QOIosKUB2dwp
      F2acp9hLKd389BfNctziG0Oxq7hlISTDBnhzBg7eKuqWtShjVW5RqQvp3bARfUPa
      RWdYjmZvR+AnmozV1SGnpAnatzhnF6tNAb5XSEw49tumsX1D4A11J6mtrafO6bsP
      wdIPwy9W15iCszUNlFcdBaZhESc34VbyCyLMvA5T0Uj1FJHz1RFlAgMBAAGjUzBR
      MB0GA1UdDgQWBBQq0z6Vcmjcn8wnRTwKGSm5YGas9TAfBgNVHSMEGDAWgBQq0z6V
      cmjcn8wnRTwKGSm5YGas9TAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
      A4IBAQBplippQ/Pxn7AkuwOTSwSTeJ7S+rMSb6iSL9chNHetanft0Ikr5BDsSrd6
      TeHV0sEMilDIjX0EjSNHwYtYrDPk6cGjkzDTYb6/U10c5Xhwi0g7/lMH/RPihPz5
      co80VEqXWlgfgHuE7/cAiTJ61PiFD9oI494bQcIISQNDfbUUiYfn32+8nK20rn8C
      w7PbGoIv6zz6A0c6DJT7yXJF5sAHgX4M03Oi9edzQ077ZOboXSuUKe4VfHIpjTjZ
      0sM/NbG5BFstyetVc3FZOGWGukTRb0C0GSASOm6hCyh5ctmpwlS4menc/OAx9BYO
      r9ZBjEa0oLFVV0pP5Tj4Gf1DDpuJ
      -----END CERTIFICATE-----
      ```

   1. Extract a public key from the certificate and save it to a file named `key`:

      ```bash
      openssl x509 -pubkey -noout -in certificate >> key
      ```

   1. Verify the signature and save the contents of the document to a file named `document`:

      ```bash
      openssl dgst -sha256 -verify key -signature signature document
      ```

      If the signature is valid, you will see a message saying `Verified OK`.

{% endlist %}

Map the identity document from the VM metadata to the document saved to the file:

```
curl http://169.254.169.254/latest/vendor/instance-identity/document | openssl dgst -sha256
```

```
openssl dgst -sha256 < document
```

If they have the same hash, the identity document saved to the file matches the document from the VM metadata.

#### See also {#see-also}

* [{#T}](instance-groups/instance-template.md)
* [Creating a VM with a custom configuration script](../operations/vm-create/create-with-cloud-init-scripts.md)