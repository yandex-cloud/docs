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
id | **string**<br>Только для вывода. Идентификатор учетной записи пользователя.
yandexPassportUserAccount | **object** <br> включает только одно из полей `yandexPassportUserAccount`<br><br>Ресурс YandexPassportUserAccount. Дополнительные сведения см. в разделе [Обычный пользователь](/docs/iam/concepts/users/users#passport).
yandexPassportUserAccount.<br>login | **string**<br>Логин учетной записи Яндекс.Паспорта.
yandexPassportUserAccount.<br>defaultEmail | **string**<br>Электронная почта, которая задана по умолчанию для аккаунта в Яндекса.Паспорте.