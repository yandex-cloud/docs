You can upload a certificate chain and a private key to use on your own, for example, when configuring a web server on a VM.

To get the contents of a certificate:

{% list tabs %}

- CLI

    The command displays a certificate chain and private key and saves their contents to the `--chain` and `--key` files, respectively.
    * `--id`: Certificate ID, make sure you set either the `--id` or `--name` flag.
    * `--name`: Name of the certificate, make sure you set either the `--id` or `--name` flag.
    * `--chain`: (Optional) File to save the certificate chain to in PEM format.
    * `--key`: (Optional) File to save the private key to in PEM format.

    ```
    yc certificate-manager certificate content \
      --id fpqcsmn76v82fi446ri7 \
      --chain certificate_full_chain.pem \
      --key private_key.pem
    ```

- API

  To get the certificate contents, use the [getContent](../../certificate-manager/api-ref/CertificateContent/get.md) method for the [Certificate](../../certificate-manager/api-ref/Certificate/) resource.


{% endlist %}

{% note info %}

To view the certificate contents, assign the `certificate-manager.certificates.downloader` role to the service account.

{% endnote %}