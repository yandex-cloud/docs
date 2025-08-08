---
editable: false
apiPlayground:
  - url: https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications
    method: get
    path: null
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/cloudapps/workload/v1/workload/api-ref/CloudApplication/get.md
---

# Cloud Apps Workload API, REST: CloudApplication.Get

Get Current Application

## HTTP request

```
GET https://cloudapps.{{ api-host }}/cloudapps/workload/v1/cloud-applications
```

## Response {#yandex.cloud.cloudapps.workload.v1.CloudApplication}

**HTTP Code: 200 - OK**

```json
{
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
```

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