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
`Version` | (Опционально) **string**<br/>Версия описания политик доступа.<br/>Возможные значения: `2012-10-17`.
`Id` | (Опционально) **string**<br/>Общая информация о политике. Некоторые сервисы {{ yandex-cloud }} требуют уникальности этого значения.<br/>Возможные значения: `Anonymous access policy`, `hrtk43sau2s8gqkaje06`.
`Statement[].` | **array**<br/>Правила политики доступа.
`Statement[].Sid` | **string**<br/>(Опционально) Идентификатор правила.<br/>Возможные значения: `Statement Allow`, `Statement Deny`.
`Statement[].Principal` | **string**<br/>(Опционально) ID получателя запрошенного разрешения.<br/>Возможные значения: `*`, `ajeexampleusername`.
`Statement[].NotPrincipal` | **string**<br/>(Опционально) Идентификатор сущности, которая не получит запрошенного разрешения.<br/>Возможные значения: `ajeexampleusername`.
`Statement[].Effect` | **string**<br/>Определяет запрет или разрешение запрошенного действия.<br/>Возможные значения: `Allow`, `Deny`.
`Statement[].Action` | **string**<br/>Определяет [действие](actions.md), которое выполнится при срабатывании политики.<br/>Возможные значения: `s3:GetObject`, `s3:PutObject`.
`Statement[].Resource` | **string**<br/>Определяет ресурс, в отношении которого будет произведено действие.<br/>Возможные значения: `arn:aws:s3:::sample_bucket/*`, `arn:aws:s3:::sample_bucket/object`.
`Statement[].Condition{}.` | **string**<br/>(Опционально) [Условие](conditions.md), которое будет проверяться.
`Statement[].Condition{}.`<br/>`condition_type_string{}.` | **string**<br/>Тип условия.<br/>Возможные значения: `StringEquals`, `Bool`. Полный список значений смотрите в разделе [Операторы сравнения](conditions.md#condition-operators).
`Statement[].Condition{}.`<br/>`condition_type_string{}.`<br/>`condition_key_string` | **string**<br/>Определяет условие, значение которого будет проверяться.<br/>Возможные значения: `aws:PrincipalType`, `true`.
