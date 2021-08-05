---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Image
Набор методов для управления ресурсами Image.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "name": "string",
  "digest": "string",
  "compressedSize": "string",
  "config": {
    "id": "string",
    "digest": "string",
    "size": "string"
  },
  "layers": [
    {
      "id": "string",
      "digest": "string",
      "size": "string"
    }
  ],
  "tags": [
    "string"
  ],
  "createdAt": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор Docker-образа.</p> 
name | **string**<br><p>Имя Docker-образа. Уникально в рамках реестра.</p> 
digest | **string**<br><p>Контентный адрес Docker-образа.</p> 
compressedSize | **string** (int64)<br><p>Размер сжатого Docker-образа, в байтах.</p> 
config | **object**<br><p>Конфигурация Docker-образа.</p> <p>Ресурс Blob.</p> 
config.<br>id | **string**<br><p>Только для вывода. Идентификатор блоба.</p> 
config.<br>digest | **string**<br><p>Контентный адрес блоба.</p> 
config.<br>size | **string** (int64)<br><p>Размер блоба, указанный в байтах.</p> 
layers[] | **object**<br><p>Ресурс Blob.</p> 
layers[].<br>id | **string**<br><p>Только для вывода. Идентификатор блоба.</p> 
layers[].<br>digest | **string**<br><p>Контентный адрес блоба.</p> 
layers[].<br>size | **string** (int64)<br><p>Размер блоба, указанный в байтах.</p> 
tags[] | **string**<br><p>Теги Docker-образа.</p> <p>Каждый тег уникален в пределах репозитория.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[delete](delete.md) | Удаляет указанный Docker-образ.
[get](get.md) | Возвращает указанный ресурс Image.
[list](list.md) | Получает список ресурсов Image в указанном реестре или репозитории.