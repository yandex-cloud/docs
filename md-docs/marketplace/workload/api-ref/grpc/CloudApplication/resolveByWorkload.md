[Документация Yandex Cloud](../../../../../index.md) > [Yandex Cloud Marketplace](../../../../index.md) > Партнерам > Справочник Cloud Apps Workload API > [gRPC (англ.)](../index.md) > [CloudApplication](index.md) > ResolveByWorkload

# Cloud Apps Workload API, gRPC: CloudApplicationService.ResolveByWorkload

Resolve Cloud Application by workload

## gRPC request

**rpc ResolveByWorkload ([ResolveByWorkloadRequest](#yandex.cloud.cloudapps.workload.v1.ResolveByWorkloadRequest)) returns ([ResolveByWorkloadResponse](#yandex.cloud.cloudapps.workload.v1.ResolveByWorkloadResponse))**

## ResolveByWorkloadRequest {#yandex.cloud.cloudapps.workload.v1.ResolveByWorkloadRequest}

```json
{
  "workload_type": "WorkloadType",
  "workload_id": "string"
}
```

#|
||Field | Description ||
|| workload_type | enum **WorkloadType**

Required field. Type of workload. See WorkloadType.

- `COMPUTE_INSTANCE`: Compute Instance ||
|| workload_id | **string**

Required field. Identifier of workload

The maximum string length in characters is 50. ||
|#

## ResolveByWorkloadResponse {#yandex.cloud.cloudapps.workload.v1.ResolveByWorkloadResponse}

```json
{
  "cloud_application": {
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
}
```

#|
||Field | Description ||
|| cloud_application | **[CloudApplication](#yandex.cloud.cloudapps.workload.v1.CloudApplication)**

Details of cloud application ||
|#

## CloudApplication {#yandex.cloud.cloudapps.workload.v1.CloudApplication}

#|
||Field | Description ||
|| id | **string**

Required field. Application Identifier

The maximum string length in characters is 50. ||
|| status | enum **Status**

Required field. Application Status

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