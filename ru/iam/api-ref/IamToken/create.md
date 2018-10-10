# Метод create
Создает IAM-токен для указанного субъекта.
 

 
## HTTP-запрос
`POST /iam/v1/tokens`
 
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
yandexPassportOauthToken | **string** <br> включает только одно из полей `yandexPassportOauthToken`<br><br>OAuth-токен для аккаунта в Яндекса.Паспорте. Дополнительные сведения см. в разделе [OAuth-токен](/docs/iam/concepts/authorization/oauth-token).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
iamToken | **string**<br>IAM-токен для указанного субъекта.  Передавайте токен в заголовке `Authorization` для дальнейших запросов к API. Например, `Authorization: Bearer [iam_token]`.