You can upload a certificate chain and a private key to use on your own,
for example, when configuring a web server on a VM.

To get the contents of a certificate:

{% list tabs %}

- CLI

   The command will display a certificate chain and a private key and save their contents to the `--chain` and `--key` files, respectively.

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

   To get the certificate contents, use the [get](../../certificate-manager/api-ref/CertificateContent/get.md) REST API method for the [CertificateContent](../../certificate-manager/api-ref/CertificateContent/) resource or the [CertificateContentService/Get](../../certificate-manager/api-ref/grpc/certificate_content_service.md#Get) gRPC API call.

{% endlist %}

{% note info %}

To view the certificate contents, assign the `certificate-manager.certificates.downloader` role to the service account.

{% endnote %}