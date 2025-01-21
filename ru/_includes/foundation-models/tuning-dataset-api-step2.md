
Получите ссылку, по которой вы сможете загрузить данные в датасет:
  
```bash
grpcurl \
  -H "Authorization: Bearer <IAM-токен>" \
  -d '{"dataset_id": "<идентификатор_датасета>", "size_bytes": <размер_датасета>}' \
  {{ api-host-llm }}:443 yandex.cloud.ai.dataset.v1.DatasetService/GetUploadDraftUrl | jq
  ```

Где:
* `<IAM-токен>` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
* `<идентификатор_датасета>` — идентификатор датасета, сохраненный на предыдущем шаге.
* `<размер_датасета>` — размер в байтах файла с данными для дообучения. В терминале получить размер файла можно с помощью команды `ls -l <путь_к_файлу>`.

Результат:

```text
{
  "datasetId": "fdso08c1u1cq********",
  "uploadUrl": "https://storage.yandexcloud.net/ai-fomo-drafts-prod/b1gt6g8ht345********/fdso08c1u1cq********?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20250120T105352Z&X-Amz-SignedHeaders=content-length%3Bhost&X-Amz-Expires=86400&X-Amz-Credential=YCAJE_WuJJ9D1r6huCoc8I3yO%2F20250120%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=611d7951994ae939acf4d32cc0c154c738d02adb2a04707a704f34ca********"
}
```

Поле `uploadUrl` ответа содержит ссылку, по которой вы сможете загрузить ваши данные в датасет.

{% note tip %}
 
Если вы не использовали утилиту jq, в полученной ссылке замените все последовательности символов `\u0026` на `&`, чтобы использовать ее для загрузки датасета.

{% endnote %}