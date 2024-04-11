# Viewing operations with a certificate

All actions with {{ certificate-manager-name }} resources are logged as a list of operations. Each operation is assigned a unique ID.

## Get a list of operations {#get-operations}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the folder with the certificate.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud.certificate-manager.label_certificates }}**.
   1. Select the certificate you need.
   1. Go to the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** panel for the selected certificate.

      You will see a list of operations with the selected certificate.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations for a certificate, run this command:

   ```bash
   yc certificate-manager certificates list-operations <certificate_name_or_ID>
   ```

   Result:

   ```text
   +----------------------+---------------------+----------------------+---------------------+--------+--------------------+
   |          ID          |     CREATED AT      |      CREATED BY      |     MODIFIED AT     | STATUS |    DESCRIPTION     |
   +----------------------+---------------------+----------------------+---------------------+--------+--------------------+
   | fpq207m67dkq******** | 2024-03-26 16:32:07 | aje9k8luj4qf******** | 2024-03-26 16:32:07 | DONE   | Update certificate |
   | fpqolhv1gtl5******** | 2024-03-21 12:32:27 | aje9k8luj4qf******** | 2024-03-21 12:32:27 | DONE   | Create certificate |
   +----------------------+---------------------+----------------------+---------------------+--------+--------------------+
   ```

   By default, information about operations is provided as text. To get more detailed information, specify the `yaml` or `json` output data format using the `--format` flag:

   ```bash
   yc certificate-manager certificates list-operations <certificate_name_or_ID> --format yaml
   ```

   Result:

   ```yaml
   - id: fpq207m67dkq********
     description: Update certificate
     created_at: "2024-03-26T16:32:07.034Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-03-26T16:32:07.047Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.UpdateCertificateMetadata
       certificate_id: fpqf446dhkgi********
     response:
       '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.Certificate
       id: fpqf446dhkgi********
       folder_id: b1g681qpemb4********
       created_at: "2024-03-21T12:32:27.008Z"
       name: cert-alb
       labels:
         key: value
       type: IMPORTED
       domains:
         - cdn.yandexcloud.example
       status: ISSUED
       issuer: CN=cdn.yandexcloud.example
       subject: CN=cdn.yandexcloud.example
       serial: 6e71e5c50a038f96a144397315bd8e93********
       updated_at: "2024-03-26T16:32:07.022219309Z"
       issued_at: "2024-03-21T12:32:27.008Z"
       not_after: "2025-03-21T12:30:49Z"
       not_before: "2024-03-21T12:30:49Z"
       incomplete_chain: true
   - id: fpqolhv1gtl5********
     description: Create certificate
     created_at: "2024-03-21T12:32:27.062Z"
     created_by: aje9k8luj4qf********
     modified_at: "2024-03-21T12:32:27.082Z"
     ...
       not_before: "2024-03-21T12:30:49Z"
       incomplete_chain: true
   ```

- API {#api}

   Use the [listOperations](../api-ref/Certificate/listOperations.md) REST API method for the [Certificate](../api-ref/Certificate/index.md) resource or the [CertificateService/ListOperations](../api-ref/grpc/certificate_service.md#ListOperations) gRPC API call.

{% endlist %}

## Get detailed information about an operation {#get-operations-info}

1. [Get a list of operations](#get-operations) for the resource.
1. Copy the ID of the operation.
1. Get detailed information about the operation:

   {% list tabs group=instructions %}

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc operation get <operation_ID>
      ```

      Result:

      ```yaml
      id: fpq207m67dkq********
      description: Update certificate
      created_at: "2024-03-26T16:32:07.034Z"
      created_by: aje9k8luj4qf********
      modified_at: "2024-03-26T16:32:07.047Z"
      done: true
      metadata:
        '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.UpdateCertificateMetadata
        certificate_id: fpqf446dhkgi********
      response:
        '@type': type.googleapis.com/yandex.cloud.certificatemanager.v1.Certificate
        id: fpqf446dhkgi********
        folder_id: b1g681qpemb4********
        created_at: "2024-03-21T12:32:27.008Z"
        name: cert-alb
        labels:
          key: value
        type: IMPORTED
        domains:
          - cdn.yandexcloud.example
        status: ISSUED
        issuer: CN=cdn.yandexcloud.example
        subject: CN=cdn.yandexcloud.example
        serial: 6e71e5c50a038f96a144397315bd8e93********
        updated_at: "2024-03-26T16:32:07.022219309Z"
        issued_at: "2024-03-21T12:32:27.008Z"
        not_after: "2025-03-21T12:30:49Z"
        not_before: "2024-03-21T12:30:49Z"
        incomplete_chain: true
      ```

   - API {#api}

      Use the [OperationService/Get](../api-ref/grpc/operation_service.md#Get) gRPC API call.

   {% endlist %}

#### See also {#see-also}

* [{#T}](../../api-design-guide/concepts/about-async.md)
