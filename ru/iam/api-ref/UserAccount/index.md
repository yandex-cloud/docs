# UserAccount
Набор методов для управления ресурсом UserAccount.
## JSON-представление
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

## Методы
Метод | Описание
--- | ---
[get](get.md) | Возвращает указанный ресурс UserAccount.