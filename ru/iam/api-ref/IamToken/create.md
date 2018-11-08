# Метод create
Создает IAM-токен для указанного субъекта.
 

 
## HTTP-запрос {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/tokens
```
 
## Параметры в теле запроса {#body_params}
 
```json 
 {

  // включает только одно из полей `yandexPassportOauthToken`
  "yandexPassportOauthToken": "string",
  // конец списка возможных полей

}
```

 
Поле | Описание
--- | ---
yandexPassportOauthToken | **string** <br> включает только одно из полей `yandexPassportOauthToken`<br><br><p>OAuth-токен для аккаунта в Яндекса.Паспорте. Подробнее см. <a href="/docs/iam/concepts/authorization/oauth-token">OAuth-токен</a>.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
iamToken | **string**<br><p>IAM-токен для указанного субъекта.</p> <p>Передавайте токен в заголовке <code>Authorization</code> для дальнейших запросов к API. Например, <code>Authorization: Bearer [iam_token]</code>.</p> 