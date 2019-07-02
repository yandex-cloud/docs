## Как включить
### Создание таблицы через gRPC API

При создании таблицы запросом `TModifyScheme` в атрибуте `CreateTable` заполняется атрибут `PartitionConfig` например, вот так
```    
PartitionConfig {
      PartitioningPolicy {
        SizeToSplit: 1000000000
      }
```
где `SizeToSplit` - размер в байтах, при достижении которого даташард запускает процедуру разделения на два

### Создание таблицы через HTTP API

Чтобы создать таблицу с таким же поведением через [HTTP API](../api/rest.md) нужно отправить вот такой запрос
``` bash
curl -v --data @create-table.json -w'\n' http://my-kikimr-endpoint:8765/CLI_MB/DbSchema
```
<details markdown="1"><summary>содержимое файла create-table.json</summary>
``` json
{
    "Path": "/Root/Tmp/",
    "CreateTable": {
        "autosplit_and_ssd_via_http": {
            "Columns": {
                "id": "Uint32",
                "FirstName": "String",
                "LastName": "String"
            },
            "PartitionConfig": {
                "PartitioningPolicy": {
                    "SizeToSplit": 1000000000
                }
            },
            "Key": ["id"]
        }
    }
}
```
</details>

### Изменение таблицы через gRPC API
При создании таблицы запросом `TModifyScheme` в атрибуте `AlterTable` заполняется атрибут `PartitionConfig` например, вот так
```    
PartitionConfig {
      PartitioningPolicy {
        SizeToSplit: 1000000000
      }
```
где `SizeToSplit` - размер в байтах, при достижении которого даташард запускает процедуру разделения на два
### Изменение таблицы через HTTP API
Чтобы включить опцию автоматического шардирования для уже существующей таблицы используя [HTTP API](../api/rest.md), нужно отправить вот такой запрос
``` bash
curl -v --data @alter-table.json -w'\n' http://my-kikimr-endpoint:8765/CLI_MB/DbSchema
```
<details markdown="1"><summary>содержимое файла alter-table.json</summary>
``` json
{
    "Path": "/Root/Tmp/",
    "AlterTable": {
        "autosplit_and_ssd_via_http": {
            "PartitionConfig": {
                "PartitioningPolicy": {
                    "SizeToSplit": 1000000000
                }
            }
        }
    }
}
```
</details>