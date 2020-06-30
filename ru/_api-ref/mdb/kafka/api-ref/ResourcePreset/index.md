---
editable: false
---

# ResourcePreset
A set of methods for managing Apache Kafka resource presets.
## JSON-представление {#representation}
```json 
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "cores": "string",
  "memory": "string"
}
```
 
Поле | Описание
--- | ---
id | **string**<br><p>ID of the ResourcePreset resource.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Kafka broker created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a Kafka broker created with the preset, in bytes.</p> 

## Методы {#methods}
Метод | Описание
--- | ---
[get](get.md) | Returns the specified resource preset.
[list](list.md) | Retrieves the list of available resource presets.