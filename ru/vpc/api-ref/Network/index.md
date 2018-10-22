# Network
Набор методов для управления облачными сетями.
## JSON-представление
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object"
}
```

## Методы
Метод | Описание
--- | ---
[create](create.md) | Создает облачную сеть в указанном каталоге.
[delete](delete.md) | Удаляет указанную облачную сеть.
[get](get.md) | Возвращает указанный ресурс Network.
[list](list.md) | Возвращает список доступных ресурсов Network в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанной облачной сети.
[listSubnets](listSubnets.md) | Возвращает список доступных подсетей в указанной облачной сети.
[update](update.md) | Обновляет параметры указанной облачной сети.