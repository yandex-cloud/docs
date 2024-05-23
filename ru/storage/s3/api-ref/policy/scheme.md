# Схема данных

Схема данных в формате JSON:

```json
{
  "Version" : "string",
  "Id" : "string",
  "Statement" : [
    {
      "Sid" : "string",
      ("Principal" | "NotPrincipal") : ("*" | "CanonicalUser" : [
        "string",
        ...
      ]),
      "Effect" : ("Allow" | "Deny"),
      "Action" : ("*" | [
        "string",
        ...
      ]),
      "Resource" : ("*" | [
        "string",
        ...
      ]),
      "Condition" : {
        "condition_type_string" : {
          "condition_key_string" : [[("string" | "number" | "Boolean"),...]...]
        },
        ...
      }  
    },
    ...
  ]
}
```

Схема может включать до 10 240 символов.

Описание параметров схемы:

Параметр | Описание
----- | -----
`Version` | (Опционально) **string**<br/>Версия описания политик доступа.<br/>Примеры значений: `2012-10-17`.
`Id` | (Опционально) **string**<br/>Общая информация о политике. Некоторые сервисы {{ yandex-cloud }} требуют уникальности этого значения.<br/>Параметр задается пользователем.<br/>Примеры значений: `test-policy`, `Anonymous access policy`, `hrtk43sau2s8gqkaje06`.
`Statement[].` | **array**<br/>Правила политики доступа.<br/>Если к бакету применена политика доступа без правил, то доступ будет запрещен всем пользователям. Чтобы отключить проверки запросов по политике доступа, [удалите](delete.md) ее.
`Statement[].Sid` | **string**<br/>(Опционально) Идентификатор правила.<br/>Параметр задается пользователем.<br/>Примеры значений: `test-rule`, `Statement Allow`, `Statement Deny`.
`Statement[].Principal` | **string**<br/>(Опционально) Идентификатор субъекта запрошенного разрешения. Получателем может быть [пользователь](../../../../iam/operations/users/get.md), [сервисный аккаунт](../../../../iam/operations/sa/get-id.md) или [группа пользователей](../../../../organization/operations/manage-groups.md).<br/>Возможные значения: `*`, `<идентификатор_субъекта>`.<br/>[Задать](../../../operations/buckets/policy.md) группу пользователей в политике можно с помощью {{ yandex-cloud }} CLI, AWS CLI, {{ TF }} и API.
`Statement[].NotPrincipal` | **string**<br/>(Опционально) Идентификатор субъекта, который не получит запрошенного разрешения. В качестве субъекта может выступать [пользователь](../../../../iam/operations/users/get.md), [сервисный аккаунт](../../../../iam/operations/sa/get-id.md) или [группа пользователей](../../../../organization/operations/manage-groups.md).<br/>Возможные значения: `<идентификатор_субъекта>`.<br/>[Задать](../../../operations/buckets/policy.md) группу пользователей в политике можно с помощью {{ yandex-cloud }} CLI, AWS CLI, {{ TF }} и API.
`Statement[].Effect` | **string**<br/>Определяет запрет или разрешение запрошенного действия.<br/>Возможные значения: `Allow`, `Deny`.
`Statement[].Action` | **string**<br/>Определяет [действие](actions.md), которое выполнится при срабатывании политики.<br/>Возможные значения: `s3:GetObject`, `s3:PutObject`.
`Statement[].Resource` | **string**<br/>Определяет ресурс, в отношении которого будет произведено действие.<br/>Возможные значения: <ul><li>`arn:aws:s3:::<имя_бакета>` — бакет.</li><li>`arn:aws:s3:::<имя_бакета>/<ключ_объекта>` — объект в бакете.</li><li>`arn:aws:s3:::<имя_бакета>/<префикс_ключей_объектов>*` — все объекты в бакете, ключи которых начинаются с префикса, например `arn:aws:s3:::samplebucket/some/path/*`. Префикс может быть пустым: `arn:aws:s3:::samplebucket/*` — тогда правило будет относиться ко всем объектам в бакете.</li></ul> Ресурс бакета не включает в себя ресурсы всех его объектов. Чтобы правило в политике доступа относилось к бакету и всем объектам, их нужно указать как отдельные ресурсы, например `arn:aws:s3:::samplebucket` и `arn:aws:s3:::samplebucket/*`.
`Statement[].Condition{}.` | **string**<br/>(Опционально) [Условие](conditions.md), которое будет проверяться.
`Statement[].Condition{}.`<br/>`condition_type_string{}.` | **string**<br/>Тип условия.<br/>Возможные значения: `StringEquals`, `Bool`. Полный список значений смотрите в разделе [Операторы сравнения](conditions.md#condition-operators).
`Statement[].Condition{}.`<br/>`condition_type_string{}.`<br/>`condition_key_string` | **string**<br/>Определяет условие, значение которого будет проверяться.<br/>Возможные значения: `aws:PrincipalType`, `true`.
