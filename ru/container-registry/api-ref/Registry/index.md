---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Registry
Набор методов для управления ресурсами Registry.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "status": "string",
  "createdAt": "string",
  "labels": "object"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор реестра.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит реестр.</p> 
name | **string**<br><p>Название реестра.</p> 
status | **string**<br><p>Только для вывода. Статус реестра.</p> <ul> <li>CREATING: Реестр создается.</li> <li>ACTIVE: Реестр готов к использованию.</li> <li>DELETING: Реестр удаляется.</li> </ul> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 метки на ресурс.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Создает реестр в указанном каталоге.
[delete](delete.md) | Удаляет указанный реестр.
[get](get.md) | Возвращает указанный ресурс Registry.
[list](list.md) | Возвращает список доступных ресурсов Registry в указанном каталоге.
[update](update.md) | Обновляет указанный реестр.