После того как CDN-ресурс был создан, [узнайте](../../cdn/operations/resources/get-resources-info.md#get-cname) доменное имя CDN-провайдера и создайте для указанного имени [ресурсную запись CNAME](../../dns/concepts/resource-record.md#cname) в настройках вашего DNS-хостинга, например в [{{ dns-full-name }}](../../dns/operations/resource-record-create.md). Подробнее см. в разделе [{#T}](../../cdn/concepts/resource.md#hostnames).

Пример ресурсной записи:

```text
cdn.example.com. CNAME {{ cname-example-yc }}
```