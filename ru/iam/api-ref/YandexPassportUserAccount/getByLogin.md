# Метод getByLogin
Возвращает указанный ресурс YandexPassportUserAccount.
 

 
## HTTP-запрос {#https-request}
`GET https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin`
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
login | Обязательное поле. Логин возвращаемого ресурса YandexPassportUserAccount.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс UserAccount. Подробнее см. [Users](/docs/iam/concepts/users/users).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор учетной записи пользователя.</p> 
yandexPassportUserAccount | **object** <br> включает только одно из полей `yandexPassportUserAccount`<br><br><p>Ресурс YandexPassportUserAccount. Подробнее см. <a href="/docs/iam/concepts/users/users#passport">Обычные пользователи</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Логин учетной записи Яндекс.Паспорта.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Электронная почта, которая задана по умолчанию для аккаунта в Яндекса.Паспорте.</p> 