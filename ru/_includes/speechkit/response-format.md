# Формат ответа

Ответ может содержать:

- Результат выполнения запроса в случае успеха.
- Код и описание ошибки, если в результате запроса произошла ошибка:

  ```json
  {
    "code": "{string}",
    "message": "{string}"
  }
  ```

## Коды ответа {#response-codes}

gRPC | REST | Статус               | Причина                          | Решение
 --- | ---- | -------------------- | -------------------------------- |---
0    | 200  | `OK`                 | Операция выполнена               | —
3    | 400  | `INVALID_ARGUMENT`   | Некорректный запрос              | Проверьте формат запроса. Возможно, указан неправильный URI или параметры запроса
4    | 504  | `DEADLINE_EXCEEDED`  | Превышен срок выполнения запроса | Проблемы в сети между клиентом и сервером. Попробуйте отправить запрос повторно или обратитесь в [техническую поддержку](../../support/overview.md)
7    | 403  | `PERMISSION_DENIED`  | Недостаточно прав                | Проверьте наличие необходимых [ролей](../../speechkit/security/index.md) у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), от имени которого вы делаете запрос
8    | 429  | `RESOURCE_EXHAUSTED` | Превышена [квота](../../speechkit/concepts/limits.md) | В зависимости от квоты, подождите или обратитесь в техническую поддержку, чтобы увеличить квоту
12   | 501  | `UNIMPLEMENTED`      | Проблема на стороне сервиса      | Обратитесь в техническую поддержку
13   | 500  | `INTERNAL`           | Внутренняя ошибка сервиса        | Обратитесь в техническую поддержку
14   | 503  | `UNAVAILABLE`        | Сервис недоступен                | Попробуйте отправить запрос повторно или обратитесь в техническую поддержку
16   | 401  | `UNAUTHENTICATED`    | Ошибка авторизации               | Проверьте, от имени какого аккаунта вы отправляете запрос, правильно ли указан [API-ключ](../../iam/concepts/authorization/api-key.md) или [IAM-токен](../../iam/concepts/authorization/iam-token.md), и не истек ли срок действия токена

