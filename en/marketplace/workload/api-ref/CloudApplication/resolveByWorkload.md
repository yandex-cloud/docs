---
editable: false
apiPlayground:
  - url: https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications:resolve-by-workload
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        workloadType:
          description: |-
            **enum** (WorkloadType)
            Required field. Type of workload. See WorkloadType.
            - `WORKLOAD_TYPE_UNSPECIFIED`
            - `COMPUTE_INSTANCE`: Compute Instance
          type: string
          enum:
            - WORKLOAD_TYPE_UNSPECIFIED
            - COMPUTE_INSTANCE
        workloadId:
          description: |-
            **string**
            Required field. Identifier of workload
          type: string
      required:
        - workloadType
        - workloadId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/cloudapps/workload/v1/workload/api-ref/CloudApplication/resolveByWorkload.md
---

# Cloud Apps Workload API, REST: CloudApplication.ResolveByWorkload

Resolve Cloud Application by workload

## HTTP request

```
POST https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications:resolve-by-workload
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

- `WORKLOAD_TYPE_UNSPECIFIED`
- `COMPUTE_INSTANCE`: Compute Instance ||
|| workloadId | **string**

Required field. Identifier of workload ||
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

Required field. Application Identifier ||
|| status | **enum** (Status)

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
|| type | **enum** (BillingType)

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
|| instanceId | **string**

Required field. Identifier of subscription instance ||
|| templateId | **string**

Required field. Subscription template identifier ||
|#