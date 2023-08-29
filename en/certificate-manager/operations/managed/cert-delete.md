# Deleting a Let's Encrypt certificate

To delete a [Let's Encrypt certificate](../../concepts/managed-certificate.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the certificate was added to.
   1. In the list of services, select **{{ certificate-manager-name }}**.
   1. Find the certificate to be deleted in the list.
   1. Click ![image](../../../_assets/options.svg).
   1. In the menu that opens, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command:

      ```bash
      yc certificate-manager certificates delete --help
      ```

   1. View the list of certificates:

      ```bash
      yc certificate-manager certificate list
      ```

      Command result:

      ```bash
      +----------------------+----------------------+-------------+-----------+---------+------------+
      |          ID          |         NAME         |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
      +----------------------+----------------------+-------------+-----------+---------+------------+
      | fpq6gvvm6piuegbb2nol | myupdatedmanagedcert | example.com |           | MANAGED | VALIDATING |
      +----------------------+----------------------+-------------+-----------+---------+------------+
      ```

   1. Run this command:

      ```bash
      yc certificate-manager certificates delete \
        --id fpq6gvvm6piuegbb2nol
      ```

      Where `--id`: Certificate ID.

      Command result:

      ```bash
      id: fpq6gvvm6piuegbb2nol
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2020-09-15T08:49:11.533Z"
      ...
      - example.com
      status: VALIDATING
      updated_at: "2020-09-15T09:10:06.981Z"
      ```

- API

   To delete a certificate, use the [delete](../../api-ref/Certificate/delete.md) REST API method for the [Certificate](../../api-ref/Certificate/) resource or the [CertificateService/Delete](../../api-ref/grpc/certificate_service.md#Delete) gRPC API call.

{% endlist %}