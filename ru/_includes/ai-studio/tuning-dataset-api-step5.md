Валидация датасета может занять некоторое время. Чтобы узнать статус операции и, при наличии, получить отчет о возникших ошибках, отправьте запрос:
  
```bash
grpcurl \
  -H "Authorization: Bearer <IAM-токен>" \
  -d '{"operation_id": "<идентификатор_операции_валидации>"}' \
  {{ api-host-llm }}:443 yandex.cloud.operation.OperationService/Get
```

Где:
* `<IAM-токен>` — [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, полученный [перед началом работы](#before-begin).
* `<идентификатор_операции_валидации>` — идентификатор операции валидации, сохраненный на предыдущем шаге.

Результат:

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

Значение поля `isValid` — `true`. Значит, валидация загруженного датасета прошла успешно.