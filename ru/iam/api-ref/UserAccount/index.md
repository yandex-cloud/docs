# UserAccount
Набор методов для управления ресурсом UserAccount.
## JSON-представление {#representation}
```json 
 {
  "id": "string",

  // включает только одно из полей `yandexPassportUserAccount`
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  },
  // конец списка возможных полей

}
```

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс UserAccount.