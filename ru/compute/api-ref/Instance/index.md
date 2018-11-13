# Instance
Набор методов для управления ресурсами Instance.
## JSON-представление {#representation}
```json 
 {
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "platformId": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "status": "string",
  "metadata": "object",
  "bootDisk": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": true,
    "diskId": "string"
  },
  "secondaryDisks": [
    {
      "mode": "string",
      "deviceName": "string",
      "autoDelete": true,
      "diskId": "string"
    }
  ],
  "networkInterfaces": [
    {
      "index": "string",
      "macAddress": "string",
      "subnetId": "string",
      "primaryV4Address": {
        "address": "string",
        "oneToOneNat": {
          "address": "string",
          "ipVersion": "string"
        }
      },
      "primaryV6Address": {
        "address": "string",
        "oneToOneNat": {
          "address": "string",
          "ipVersion": "string"
        }
      }
    }
  ],
  "fqdn": "string"
}
```

## Методы {#methods}
Метод | Описание
--- | ---
[attachDisk](attachDisk.md) | Присоединяет диск к виртуальной машине.
[create](create.md) | Создает виртуальную машину в указанном каталоге. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.
[delete](delete.md) | Удаляет указанную виртуальную машину.
[detachDisk](detachDisk.md) | Отсоединяет диск от виртуальной машины.
[get](get.md) | Возвращает указанный ресурс Instance.
[getSerialPortOutput](getSerialPortOutput.md) | Возвращает вывод последовательного порта указанного ресурса Instance.
[list](list.md) | Возвращает список доступных ресурсов Instance в указанном каталоге.
[listOperations](listOperations.md) | Возвращает список операций для указанной виртуальной машины.
[restart](restart.md) | Перезапуск работающей виртуальной машины.
[start](start.md) | Запуск остановленной виртуальной машины.
[stop](stop.md) | Останавливает запущенную виртуальную машину.
[update](update.md) | Изменяет указанную виртуальную машину.