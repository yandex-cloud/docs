---
editable: false
---

# Метод create
Создает IAM-токен для указанного субъекта.
 

 
## HTTP-запрос {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/tokens
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{

  //  включает только одно из полей `yandexPassportOauthToken`, `jwt`
  "yandexPassportOauthToken": "string",
  "jwt": "string",
  // конец списка возможных полей

}
```

 
Поле | Описание
--- | ---
yandexPassportOauthToken | **string** <br> включает только одно из полей `yandexPassportOauthToken`, `jwt`<br><br><p>OAuth-токен для аккаунта в Яндекса.Паспорте. Подробнее см. в разделе <a href="/docs/iam/concepts/authorization/oauth-token">OAuth-токен</a>.</p> 
jwt | **string** <br> включает только одно из полей `yandexPassportOauthToken`, `jwt`<br><br><p>JSON Web Token (JWT) для сервисного аккаунта. Подробнее см. в разделе <a href="/docs/iam/operations/iam-token/create-for-sa">Получить IAM-токен для сервисного аккаунта</a>.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "iamToken": "string",
  "expiresAt": "string"
}
```

 
Поле | Описание
--- | ---
iamToken | **string**<br><p>IAM-токен для указанного субъекта.</p> <p>Передавайте токен в заголовке ``Authorization`` для дальнейших запросов к API. Например, ``Authorization: Bearer [iam_token]``.</p> 
expiresAt | **string** (date-time)<br><p>Время окончания действия IAM-токена.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 