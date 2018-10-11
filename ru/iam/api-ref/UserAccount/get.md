# Метод get
Возвращает указанный ресурс UserAccount.
 

 
## HTTP-запрос
`GET /iam/v1/userAccounts/{userAccountId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
userAccountId | Обязательное поле. Идентификатор запрашиваемого ресурса UserAccount.  Максимальная длина — 50 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс UserAccount. Дополнительные сведения см. в разделе
[Пользователи Яндекс.Облака](/docs/iam/concepts/users/users).
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор учетной записи пользователя.</p> 
yandexPassportUserAccount | **object** <br> включает только одно из полей `yandexPassportUserAccount`<br><br><p>Ресурс YandexPassportUserAccount. Дополнительные сведения см. в разделе <a href="/docs/iam/concepts/users/users#passport">Обычный пользователь</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Логин учетной записи Яндекс.Паспорта.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Электронная почта, которая задана по умолчанию для аккаунта в Яндекса.Паспорте.</p> 