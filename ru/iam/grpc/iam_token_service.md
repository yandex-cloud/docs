---
editable: false
---

# IamTokenService

Набор методов для управления IAM-токенами.

| Вызов | Описание |
| --- | --- |
| [Create](#Create) | Создает IAM-токен для указанного субъекта. |

## Вызовы IamTokenService {#calls}

## Create {#Create}

Создает IAM-токен для указанного субъекта.

**rpc Create ([CreateIamTokenRequest](#CreateIamTokenRequest)) returns ([CreateIamTokenResponse](#CreateIamTokenResponse))**

### CreateIamTokenRequest {#CreateIamTokenRequest}

Поле | Описание
--- | ---
identity | **oneof:** `yandex_passport_oauth_token` или `jwt`<br>
&nbsp;&nbsp;yandex_passport_oauth_token | **string**<br>OAuth-токен для аккаунта в Яндекса.Паспорте. Подробнее см. в разделе [OAuth-токен](/docs/iam/concepts/authorization/oauth-token). 
&nbsp;&nbsp;jwt | **string**<br>JSON Web Token (JWT) для сервисного аккаунта. Подробнее см. в разделе [Получить IAM-токен для сервисного аккаунта](/docs/iam/operations/iam-token/create-for-sa). 


### CreateIamTokenResponse {#CreateIamTokenResponse}

Поле | Описание
--- | ---
iam_token | **string**<br>IAM-токен для указанного субъекта. <br>Передавайте токен в заголовке `Authorization` для дальнейших запросов к API. Например, `Authorization: Bearer `iam_token``. 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время окончания действия IAM-токена. 


