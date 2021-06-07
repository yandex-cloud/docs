---
editable: false
---

# Метод create
Создает виртуальную машину в указанном каталоге. Метод запускает асинхронную
операцию, которую можно отменить перед тем, как она завершится.
 

 
## HTTP-запрос {#https-request}
```
POST https://compute.api.cloud.yandex.net/compute/v1/instances
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "platformId": "string",
  "resourcesSpec": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string",
    "gpus": "string"
  },
  "metadata": "object",
  "bootDiskSpec": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": true,

    // `bootDiskSpec` включает только одно из полей `diskSpec`, `diskId`
    "diskSpec": {
      "name": "string",
      "description": "string",
      "typeId": "string",
      "size": "string",

      // `bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`
      "imageId": "string",
      "snapshotId": "string",
      // конец списка возможных полей`bootDiskSpec.diskSpec`

    },
    "diskId": "string",
    // конец списка возможных полей`bootDiskSpec`

  },
  "secondaryDiskSpecs": [
    {
      "mode": "string",
      "deviceName": "string",
      "autoDelete": true,

      // `secondaryDiskSpecs[]` включает только одно из полей `diskSpec`, `diskId`
      "diskSpec": {
        "name": "string",
        "description": "string",
        "typeId": "string",
        "size": "string",

        // `secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // конец списка возможных полей`secondaryDiskSpecs[].diskSpec`

      },
      "diskId": "string",
      // конец списка возможных полей`secondaryDiskSpecs[]`

    }
  ],
  "networkInterfaceSpecs": [
    {
      "subnetId": "string",
      "primaryV4AddressSpec": {
        "address": "string",
        "oneToOneNatSpec": {
          "ipVersion": "string"
        }
      },
      "primaryV6AddressSpec": {
        "address": "string",
        "oneToOneNatSpec": {
          "ipVersion": "string"
        }
      }
    }
  ],
  "hostname": "string",
  "schedulingPolicy": {
    "preemptible": true
  },
  "serviceAccountId": "string",
  "networkSettings": {
    "type": "string"
  }
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога для создания виртуальной машины. Чтобы получить идентификатор каталога, используйте запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Имя виртуальной машины.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Описание виртуальной машины.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Метки ресурса в формате ``key:value``.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ``[a-z][-_0-9a-z]*``. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ``[-_0-9a-z]*``.</p> 
zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
platformId | **string**<br><p>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Это поле влияет на допустимые значения поля <a href="/docs/compute/api-ref/Instance/create#body_params">resourcesSpec</a>.</p> <p>Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-platforms">Платформы</a>.</p> 
resourcesSpec | **object**<br><p>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. Чтобы узнать список допустимых значений, см. раздел <a href="/docs/compute/concepts/performance-levels">Уровни производительности vCPU</a>.</p> 
resourcesSpec.<br>memory | **string** (int64)<br><p>Обязательное поле. Объем памяти в байтах, доступный виртуальной машине.</p> <p>Максимальное значение — 274877906944.</p> 
resourcesSpec.<br>cores | **string** (int64)<br><p>Обязательное поле. Количество ядер, доступное виртуальной машине.</p> <p>Значение должно быть равно 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 или 32.</p> 
resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> <p>Например, если требуется только 5% производительности CPU, можно задать значение ``core_fraction=5``. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/performance-levels">Уровни производительности vCPU</a>.</p> <p>Значение должно быть равно 0, 5, 20, 50 или 100.</p> 
resourcesSpec.<br>gpus | **string** (int64)<br><p>Количество GPU, доступное виртуальной машине.</p> <p>Значение должно быть равно 0, 1, 2 или 4.</p> 
metadata | **object**<br><p>Метаданные, назначаемые данной виртуальной машине, в формате пар ``ключ:значение``. Сюда входят пользовательские метаданные и предопределенные ключи. Общий размер всех ключей и значений не должен превышать 512 КБ.</p> <p>Значениями являются строки и используются только программами, которые настраивают виртуальную машину. Значения должны быть не более 256 КБ.</p> <p>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> 
bootDiskSpec | **object**<br><p>Обязательное поле. Загрузочный диск для подключения к виртуальной машине.</p> 
bootDiskSpec.<br>mode | **string**<br>Режим, в котором необходимо подключить этот диск.<br><ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись. Значение по умолчанию.</li> </ul> 
bootDiskSpec.<br>deviceName | **string**<br><p>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если значение не указано, будет сгенерировано случайное значение.</p> <p>Значение должно соответствовать регулярному выражению ``[a-z][a-z0-9-_]{,19}``.</p> 
bootDiskSpec.<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
bootDiskSpec.<br>diskSpec | **object**<br>Спецификация диска. <br>`bootDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br>
bootDiskSpec.<br>diskSpec.<br>name | **string**<br><p>Имя диска.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос <a href="/docs/compute/api-ref/DiskType/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Обязательное поле. Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа для создания диска.</p> <p>Максимальная длина строки в символах — 50.</p> 
bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка для восстановления диска.</p> <p>Максимальная длина строки в символах — 50.</p> 
bootDiskSpec.<br>diskId | **string** <br>`bootDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br><p>Идентификатор диска, который должен быть подключен.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs[] | **object**<br><p>Массив дополнительных дисков для подключения к виртуальной машине.</p> <p>Максимальное количество элементов — 3.</p> 
secondaryDiskSpecs[].<br>mode | **string**<br>Режим, в котором необходимо подключить этот диск.<br><ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись. Значение по умолчанию.</li> </ul> 
secondaryDiskSpecs[].<br>deviceName | **string**<br><p>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если значение не указано, будет сгенерировано случайное значение.</p> <p>Значение должно соответствовать регулярному выражению ``[a-z][a-z0-9-_]{,19}``.</p> 
secondaryDiskSpecs[].<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
secondaryDiskSpecs[].<br>diskSpec | **object**<br>Спецификация диска. <br>`secondaryDiskSpecs[]` включает только одно из полей `diskSpec`, `diskId`<br><br>
secondaryDiskSpecs[].<br>diskSpec.<br>name | **string**<br><p>Имя диска.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**<br><p>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос <a href="/docs/compute/api-ref/DiskType/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs[].<br>diskSpec.<br>size | **string** (int64)<br><p>Обязательное поле. Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа для создания диска.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`secondaryDiskSpecs[].diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка для восстановления диска.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs[].<br>diskId | **string** <br>`secondaryDiskSpecs[]` включает только одно из полей `diskSpec`, `diskId`<br><br><p>Идентификатор диска, который должен быть подключен.</p> <p>Максимальная длина строки в символах — 50.</p> 
networkInterfaceSpecs[] | **object**<br><p>Обязательное поле. Конфигурация сети для виртуальной машины. Указывает, как должен быть настроен сетевой интерфейс для взаимодействия с другими сервисами во внутренней сети и в интернете. В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс.</p> <p>Должен содержать ровно 1 элемент.</p> 
networkInterfaceSpecs[].<br>subnetId | **string**<br><p>Обязательное поле. Идентификатор подсети.</p> <p>Максимальная длина строки в символах — 50.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Основной IPv4-адрес, который будет назначен виртуальной машине для данного сетевого интерфейса.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. Если он не указан, системой будет назначен неиспользуемый внутренний IP-адрес.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация внешнего IP-адреса. Если она не указана, то у виртуальной машины не будет доступа в интернет.</p> 
networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Обязательное поле. Версия публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: Адрес IPv6. На данный момент не доступен.</li> </ul> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Основной IPv6-адрес, который будет назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. Если он не указан, системой будет назначен неиспользуемый внутренний IP-адрес.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация внешнего IP-адреса. Если она не указана, то у виртуальной машины не будет доступа в интернет.</p> 
networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Обязательное поле. Версия публичного IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: Адрес IPv6. На данный момент не доступен.</li> </ul> 
hostname | **string**<br><p>Имя хоста виртуальной машины. Это поле используется для генерации значения <a href="/docs/compute/api-ref/Instance#representation">Instance.fqdn</a>. Имя хоста должно быть уникальным в пределах сети и региона. Если не указано, то имя хоста будет равно <a href="/docs/compute/api-ref/Instance#representation">Instance.id</a> виртуальной машины и FQDN будет ``&lt;id&gt;.auto.internal``. В противном случае FQDN будет ``&lt;hostname&gt;.&lt;region_id&gt;.internal``.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
schedulingPolicy | **object**<br><p>Конфигурация политики планирования.</p> 
schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе <a href="/docs/compute/concepts/preemptible-vm">Прерываемые виртуальные машины</a>.</p> 
serviceAccountId | **string**<br><p>Идентификатор сервисного аккаунта для <a href="/docs/compute/operations/vm-connect/auth-inside-vm">аутентификации изнутри виртуальной машины</a>. Чтобы получить идентификатор сервисного аккаунта, используйте запрос <a href="/docs/iam/api-ref/ServiceAccount/list">list</a>.</p> 
networkSettings | **object**<br><p>Сетевые настройки.</p> 
networkSettings.<br>type | **string**<br><p>Не указывайте это поле, сетевые настройки пока не поддерживаются.</p> <ul> <li>STANDARD: Стандартная сеть.</li> <li>SOFTWARE_ACCELERATED: Сеть с программным ускорением.</li> <li>HARDWARE_ACCELERATED: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li> </ul> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  включает только одно из полей `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // конец списка возможных полей

}
```
Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Если значение равно ``false`` — операция еще выполняется. Если ``true`` — операция завершена, и задано значение одного из полей ``error`` или ``response``.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``metadata``.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля ``response``.</p> 