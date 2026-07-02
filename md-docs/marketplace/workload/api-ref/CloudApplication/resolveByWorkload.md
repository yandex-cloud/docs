[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Marketplace](../../../index.md) > Партнерам > Справочник Cloud Apps Workload API > [REST (англ.)](../index.md) > [CloudApplication](index.md) > ResolveByWorkload

# Cloud Apps Workload API, REST: CloudApplication.ResolveByWorkload

Resolve Cloud Application by workload

## HTTP request

```
POST https://cloudapps.api.cloud.yandex.net/cloudapps/workload/v1/cloud-applications:resolve-by-workload
```

## Body parameters {#yandex.cloud.cloudapps.workload.v1.ResolveByWorkloadRequest}

```json
{
  "workloadType": "string",
  "workloadId": "string"
}
```

#|
||Field | Description ||
|| workloadType | **enum** (WorkloadType)

Required field. Type of workload. See WorkloadType.

- `COMPUTE_INSTANCE`: Compute Instance ||
|| workloadId | **string**

Required field. Identifier of workload

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.cloudapps.workload.v1.ResolveByWorkloadResponse}

**HTTP Code: 200 - OK**

```json
{
  "cloudApplication": {
    "id": "string",
    "status": "string",
    "billing": {
      "type": "string",
      "subscriptions": [
        {
          "instanceId": "string",
          "templateId": "string"
        }
      ]
    }
  }
}
```

#|
||Field | Description ||
|| cloudApplication | **[CloudApplication](#yandex.cloud.cloudapps.workload.v1.CloudApplication)**

Details of cloud application ||
|#

## CloudApplication {#yandex.cloud.cloudapps.workload.v1.CloudApplication}

#|
||Field | Description ||
|| id | **string**

Required field. Application Identifier

The maximum string length in characters is 50. ||
|| status | **enum** (Status)

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
|| type | **enum** (BillingType)

Required field. Type of application billing

- `PAY_AS_YOU_GO`: User pays for application usage time
- `SUBSCRIPTION`: User bought a subscription ||
|| subscriptions[] | **[Subscription](#yandex.cloud.cloudapps.workload.v1.CloudApplication.Billing.Subscription)**

Subscriptions bounded to cloud application ||
|#

## Subscription {#yandex.cloud.cloudapps.workload.v1.CloudApplication.Billing.Subscription}

#|
||Field | Description ||
|| instanceId | **string**

Required field. Identifier of subscription instance ||
|| templateId | **string**

Required field. Subscription template identifier ||
|#