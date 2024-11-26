---
editable: false
sourcePath: en/_api-ref-grpc/iot/broker/v1/broker/api-ref/grpc/Broker/listCertificates.md
---

# IoT Core Broker Service, gRPC: BrokerService.ListCertificates

Retrieves the list of broker certificates for the specified broker.

## gRPC request

**rpc ListCertificates ([ListBrokerCertificatesRequest](#yandex.cloud.iot.broker.v1.ListBrokerCertificatesRequest)) returns ([ListBrokerCertificatesResponse](#yandex.cloud.iot.broker.v1.ListBrokerCertificatesResponse))**

## ListBrokerCertificatesRequest {#yandex.cloud.iot.broker.v1.ListBrokerCertificatesRequest}

```json
{
  "broker_id": "string"
}
```

#|
||Field | Description ||
|| broker_id | **string**

Required field. ID of the broker to list certificates for. ||
|#

## ListBrokerCertificatesResponse {#yandex.cloud.iot.broker.v1.ListBrokerCertificatesResponse}

```json
{
  "certificates": [
    {
      "broker_id": "string",
      "fingerprint": "string",
      "certificate_data": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| certificates[] | **[BrokerCertificate](#yandex.cloud.iot.broker.v1.BrokerCertificate)**

List of certificates for the specified broker. ||
|#

## BrokerCertificate {#yandex.cloud.iot.broker.v1.BrokerCertificate}

A broker certificate.

#|
||Field | Description ||
|| broker_id | **string**

ID of the broker that the certificate belongs to. ||
|| fingerprint | **string**

SHA256 hash of the certificates. ||
|| certificate_data | **string**

Public part of the certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#