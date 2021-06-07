---
editable: false
---

# Метод list
Возвращает список версий в указанном релизном канале.
 

 
## HTTP-запрос {#https-request}
```
GET https://mks.api.cloud.yandex.net/managed-kubernetes/v1/versions
```
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "availableVersions": [
    {
      "releaseChannel": "string",
      "versions": [
        "string"
      ]
    }
  ]
}
```

 
Поле | Описание
--- | ---
availableVersions[] | **object**<br><p>Версии, доступные в указанном релизном канале.</p> 
availableVersions[].<br>releaseChannel | **string**<br><p>Релизный канал: ``RAPID``, ``REGULAR`` или ``STABLE``. Дополнительные сведения см. в <a href="https://cloud.yandex.ru/docs/managed-kubernetes/concepts/release-channels-and-updates">документации</a>.</p> <ul> <li>RAPID: На канале часто появляются минорные обновления, содержащие новую функциональность и улучшения. Вы не можете отключить автоматическое обновление на этом канале, но вы можете указать период времени для автоматического обновления.</li> <li>REGULAR: Новая функциональность и улучшения порциями попадают на канал через некоторое время после того, как были предоставлены на канале ``RAPID``.</li> <li>STABLE: На канале происходят только обновления, касающиеся исправление ошибок или улучшения безопасности.</li> </ul> 
availableVersions[].<br>versions[] | **string**<br><p>Версия компонентов Kubernetes.</p> 