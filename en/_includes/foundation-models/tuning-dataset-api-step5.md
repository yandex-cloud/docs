Dataset validation may take some time. To find out validation status and get an error report (if any), send this request:
  
```bash
grpcurl \
  -H "Authorization: Bearer <IAM_token>" \
  -d '{"operation_id": "<validation_operation_ID>"}' \
  {{ api-host-llm }}:443 yandex.cloud.operation.OperationService/Get
```

Where:
* `<IAM_token>`: [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
* `<validation_operation_ID>`: ID of the validation operation you saved in the previous step.

Result:

```text
{
  "id": "fdso01v2jdd4********",
  "createdAt": "2025-01-20T11:03:48Z",
  "modifiedAt": "2025-01-20T11:04:46Z",
  "done": true,
  "response": {
    "@type": "type.googleapis.com/yandex.cloud.ai.dataset.v1.ValidateDatasetResponse",
    "datasetId": "fdso08c1u1cq********",
    "isValid": true
  }
}
```

The `isValid` field is set to `true`. This means the loaded dataset was validated successfully.