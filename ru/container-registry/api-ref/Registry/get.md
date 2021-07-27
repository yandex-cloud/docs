---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Метод get
Возвращает указанный ресурс Registry.
 
Чтобы получить список доступных ресурсов Registry, используйте запрос [list](/docs/container-registry/api-ref/Registry/list).
 
## HTTP-запрос {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/registries/{registryId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
registryId | Обязательное поле. Идентификатор возвращаемого ресурса Registry.  Чтобы получить идентификатор реестра, используйте запрос [list](/docs/container-registry/api-ref/Registry/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

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
Ресурс Registry. Подробнее смотрите в разделе [Реестр](/docs/container-registry/concepts/registry).
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор реестра.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит реестр.</p> 
name | **string**<br><p>Название реестра.</p> 
status | **string**<br><p>Только для вывода. Статус реестра.</p> <ul> <li>CREATING: Реестр создается.</li> <li>ACTIVE: Реестр готов к использованию.</li> <li>DELETING: Реестр удаляется.</li> </ul> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 метки на ресурс.</p> 