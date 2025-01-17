---
editable: false
sourcePath: en/_api-ref-grpc/cloudapps/workload/v1/workload/api-ref/grpc/CloudApplication/get.md
---

# Cloud Apps Workload API, gRPC: CloudApplicationService.Get

Get Current Application

## gRPC request

**rpc Get ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)) returns ([CloudApplication](#yandex.cloud.cloudapps.workload.v1.CloudApplication))**

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#

## CloudApplication {#yandex.cloud.cloudapps.workload.v1.CloudApplication}

```json
{
  "id": "string",
  "status": "Status",
  "billing": {
    "type": "BillingType",
    "subscriptions": [
      {
        "instance_id": "string",
        "template_id": "string"
      }
    ]
  }
}
```

#|
||Field | Description ||
|| id | **string**

Required field. Application Identifier ||
|| status | enum **Status**

Required field. Application Status

- `STATUS_UNSPECIFIED`
- `PROCESSING`: Application under deploying / updating /deleting
- `DEPLOYED`: Application successfully deployed to YC
- `FAILED`: Application failed to deploy ||
|| billing | **[Billing](#yandex.cloud.cloudapps.workload.v1.CloudApplication.Billing)**

Required field. Application billing info ||
|#

## Billing {#yandex.cloud.cloudapps.workload.v1.CloudApplication.Billing}

#|
||Field | Description ||
|| type | enum **BillingType**

Required field. Type of application billing

- `BILLING_TYPE_UNSPECIFIED`
- `PAY_AS_YOU_GO`: User pays for application usage time
- `SUBSCRIPTION`: User bought a subscription ||
|| subscriptions[] | **[Subscription](#yandex.cloud.cloudapps.workload.v1.CloudApplication.Billing.Subscription)**

Subscriptions bounded to cloud application ||
|#

## Subscription {#yandex.cloud.cloudapps.workload.v1.CloudApplication.Billing.Subscription}

#|
||Field | Description ||
|| instance_id | **string**

Required field. Identifier of subscription instance ||
|| template_id | **string**

Required field. Subscription template identifier ||
|#