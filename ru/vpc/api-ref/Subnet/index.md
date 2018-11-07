# Subnet
Набор методов для управления подсетями.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "zoneId": "string",
  "v4CidrBlocks": [
    "string"
  ],
  "v6CidrBlocks": [
    "string"
  ]
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает подсеть в указанных каталоге и сети.  Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.
[delete](delete.md) | Удаляет указанную подсеть.
[get](get.md) | Возвращает указанный ресурс Subnet.
[list](list.md) | Возвращает список доступных подсетей в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанной подсети.
[update](update.md) | Обновляет параметры указанной подсети.  Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.