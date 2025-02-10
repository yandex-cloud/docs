
Get a link to upload data into the dataset:
  
```bash
grpcurl \
  -H "Authorization: Bearer <IAM_token>" \
  -d '{"dataset_id": "<dataset_ID>", "size_bytes": <dataset_size>}' \
  {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/GetUploadDraftUrl | jq
  ```

Where:
* `<IAM_token>`: [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account you got [before you started](#before-begin).
* `<dataset_ID>`: Dataset ID you saved in the previous step.
* `<dataset_size>`: Size in bytes of the file with data for tuning. In the terminal, you can get the file size using the `ls -l <file_path>` command.

Result:

```text
{
  "datasetId": "fdso08c1u1cq********",
  "uploadUrl": "https://storage.yandexcloud.net/ai-fomo-drafts-prod/b1gt6g8ht345********/fdso08c1u1cq********?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20250120T105352Z&X-Amz-SignedHeaders=content-length%3Bhost&X-Amz-Expires=86400&X-Amz-Credential=YCAJE_WuJJ9D1r6huCoc8I3yO%2F20250120%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=611d7951994ae939acf4d32cc0c154c738d02adb2a04707a704f34ca********"
}
```

The `uploadUrl` field of the response contains a link you can use to upload your data into the dataset.

{% note tip %}
 
If you did not use jq, replace all `\u0026` occurrences with `&` in the link to use it to upload the dataset.

{% endnote %}