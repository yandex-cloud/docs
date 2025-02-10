After the data upload is complete, run the dataset validation:
  
 ```bash
 grpcurl \
   -H "Authorization: Bearer <IAM_token>" \
   -d '{"dataset_id": "<dataset_ID>"}' \
   {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/Validate
 ```

Where:
* `<IAM_token>`: [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
* `<dataset_ID>`: Dataset ID you saved in the previous step.

Result:

```text
{
  "id": "fdso01v2jdd4********",
  "createdAt": "2025-01-20T11:03:48Z",
  "modifiedAt": "2025-01-20T11:03:48Z"
}
```

Save the validation operation ID (`id` field). You will need it in the next step. 