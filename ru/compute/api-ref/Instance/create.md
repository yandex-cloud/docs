# Метод create
Создает виртуальную машину в указанном каталоге.
 

 
## HTTP-запрос
`POST /compute/v1/instances`
 
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
    "coreFraction": "string"
  },
  "metadata": "object",
  "bootDiskSpec": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": true,

    // `bootDiskSpec`включает только одно из полей `diskSpec`, `diskId`
    "diskSpec": {
      "name": "string",
      "description": "string",
      "typeId": "string",
      "size": "string",

      // `bootDiskSpec.diskSpec`включает только одно из полей `imageId`, `snapshotId`
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

      // `secondaryDiskSpecs`включает только одно из полей `diskSpec`, `diskId`
      "diskSpec": {
        "name": "string",
        "description": "string",
        "typeId": "string",
        "size": "string",

        // `secondaryDiskSpecs.diskSpec`включает только одно из полей `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // конец списка возможных полей`secondaryDiskSpecs.diskSpec`

      },
      "diskId": "string",
      // конец списка возможных полей`secondaryDiskSpecs`

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
      }
    }
  ],
  "hostname": "string"
}
```

 
Поле | Описание
--- | ---
folderId | **string**<br>Обязательное поле. Идентификатор каталога для создания виртуальной машины. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/resource-manager/api-ref/Folder/list).  Максимальная длина — 50 символов.
name | **string**<br>Имя виртуальной машины.  Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению `` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ ``.
description | **string**<br>Описание виртуальной машины.  Максимальная длина — 256 символов.
labels | **object**<br>Метки ресурса в формате ключ-значение.  Не более 64 на ресурс.  Каждый ключ должен быть длиной от 1 до 63 символов и соответствовать регулярному выражению `` [a-z][-_0-9a-z]* ``. Максимальная длина каждого значения — не более 63 символов. Каждое значение должно соответствовать регулярному выражению `` [-_0-9a-z]* ``.
zoneId | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. Чтобы получить список доступных зон, используйте запрос [list](/docs/compute/api-ref/Zone/list).  Максимальная длина — 50 символов.
platformId | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Это поле влияет на допустимые значения в поле [resourcesSpec](/docs/compute/api-ref/Instance/create#body_params).  В настоящее время доступна только одна платформа - `standard-v1`. Эта платформа подходит для большинства задач. Эта платформа позволяет создавать машины различных типов: с большим объемом памяти, с большим количеством ядер, с высокой производительностью.  Значение должно соответствовать регулярному выражению `` standard-v1 ``.
resourcesSpec | **object**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. Чтобы узнать список допустимых значений, см. раздел [Вычислительные ресурсы виртуальной машины](/docs/compute/concepts/vm-types).
resourcesSpec.<br>memory | **string** (int64)<br>Обязательное поле. Объем памяти в байтах, доступный виртуальной машине.  Максимальное значение — 34359738368.
resourcesSpec.<br>cores | **string** (int64)<br>Обязательное поле. Количество ядер, доступных виртуальной машине.  Максимальное значение — 32.
resourcesSpec.<br>coreFraction | **string** (int64)<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.  Например, если требуется только 5% производительности CPU, можно задать core_fraction=5. Дополнительные сведения см. в разделе [Виртуальные машины с частичным использованием ядра](/docs/compute/concepts/vm-types#burstable-cores).  Значение должно быть равно 5.
metadata | **object**<br>Метаданные, назначаемые этой виртуальной машине, в формате пар ключ/значение. Это включает произвольные пользовательские метаданные и предзаданные ключи. Общий размер всех ключей и значений не должен превышать 512 КБ.  Значения - произвольные строки и имеют смысл только, когда интерпретируются программами, которые выполняют настройку виртуальной машины. Единственное ограничение на значения заключается в том, что их размер должен быть не более 256 КБ.  Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Подробнее см. [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata).
bootDiskSpec | **object**<br>Обязательное поле. Загрузочный диск для подключения к виртуальной машине.
bootDiskSpec.<br>mode | **string**<br> - READ_ONLY: Доступ на чтение.  - READ_WRITE: Доступ на чтение и запись.<br>`READ_ONLY`<br>`READ_WRITE`<br>
bootDiskSpec.<br>deviceName | **string**<br>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.  Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если не указано, будет сгенерировано случайное значение.  Значение должно соответствовать регулярному выражению `` [a-z][a-z0-9-_]{,19} ``.
bootDiskSpec.<br>autoDelete | **boolean** (boolean)<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.
bootDiskSpec.<br>diskSpec | **object** <br>`bootDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br>
bootDiskSpec.<br>diskSpec.<br>name | **string**<br>Имя диска.  Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению `` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ ``.
bootDiskSpec.<br>diskSpec.<br>description | **string**<br>Описание диска.  Максимальная длина — 256 символов.
bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос [list](/docs/compute/api-ref/DiskType/list).  Максимальная длина — 50 символов.
bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br>Обязательное поле. Размер диска в байтах.  Допустимые значения — от 4194304 до 4398046511104 включительно.
bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br>Идентификатор образа для создания диска из него.  Максимальная длина — 50 символов.
bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br>Идентификатор снимка для восстановления диска из него.  Максимальная длина — 50 символов.
bootDiskSpec.<br>diskId | **string** <br>`bootDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br>ID диска, который должен быть подключен.  Максимальная длина — 50 символов.
secondaryDiskSpecs | **object**<br>Массив дополнительных дисков для подключения к виртуальной машине.  Максимальное количество элементов — 3.
secondaryDiskSpecs.<br>mode | **string**<br> - READ_ONLY: Доступ на чтение.  - READ_WRITE: Доступ на чтение и запись.<br>`READ_ONLY`<br>`READ_WRITE`<br>
secondaryDiskSpecs.<br>deviceName | **string**<br>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.  Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если не указано, будет сгенерировано случайное значение.  Значение должно соответствовать регулярному выражению `` [a-z][a-z0-9-_]{,19} ``.
secondaryDiskSpecs.<br>autoDelete | **boolean** (boolean)<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.
secondaryDiskSpecs.<br>diskSpec | **object** <br>`secondaryDiskSpecs` включает только одно из полей `diskSpec`, `diskId`<br><br>
secondaryDiskSpecs.<br>diskSpec.<br>name | **string**<br>Имя диска.  Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению `` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ ``.
secondaryDiskSpecs.<br>diskSpec.<br>description | **string**<br>Описание диска.  Максимальная длина — 256 символов.
secondaryDiskSpecs.<br>diskSpec.<br>typeId | **string**<br>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос [list](/docs/compute/api-ref/DiskType/list).  Максимальная длина — 50 символов.
secondaryDiskSpecs.<br>diskSpec.<br>size | **string** (int64)<br>Обязательное поле. Размер диска в байтах.  Допустимые значения — от 4194304 до 4398046511104 включительно.
secondaryDiskSpecs.<br>diskSpec.<br>imageId | **string** <br>`secondaryDiskSpecs.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br>Идентификатор образа для создания диска из него.  Максимальная длина — 50 символов.
secondaryDiskSpecs.<br>diskSpec.<br>snapshotId | **string** <br>`secondaryDiskSpecs.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br>Идентификатор снимка для восстановления диска из него.  Максимальная длина — 50 символов.
secondaryDiskSpecs.<br>diskId | **string** <br>`secondaryDiskSpecs` включает только одно из полей `diskSpec`, `diskId`<br><br>ID диска, который должен быть подключен.  Максимальная длина — 50 символов.
networkInterfaceSpecs | **object**<br>Обязательное поле. Конфигурация сети для виртуальной машины. Указывает, как должен быть настроен сетевой интерфейс для взаимодействия с другими сервисами во внутренней сети и в интернете. В настоящее время поддерживается только один сетевой интерфейс для виртуальной машины.  Должен содержать ровно 1 элемент.
networkInterfaceSpecs.<br>subnetId | **string**<br>Обязательное поле. Идентификатор подсети.  Максимальная длина — 50 символов.
networkInterfaceSpecs.<br>primaryV4AddressSpec | **object**<br>Обязательное поле. Primary IPv4-адрес, который будет назначен виртуальной машине для данного сетевого интерфейса.
networkInterfaceSpecs.<br>primaryV4AddressSpec.<br>address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для этого сетевого интерфейса. Если не указано, системой будет назначен неиспользуемый внутренний IP-адрес.
networkInterfaceSpecs.<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br>Конфигурация внешнего IP-адреса. Если не указано, то к виртуальной машине не будет доступа из интернета.
networkInterfaceSpecs.<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br>Обязательное поле. Версия внешнего IP-адреса.   - IPV4: IPv4-адрес, например 192.0.2.235.  - IPV6: IPv6-адрес, например, 2001:0db8:85a3:0000:0000:8a2e:0370:7334.<br>`IPV4`<br>`IPV6`<br>
hostname | **string**<br>Имя хоста виртуальной машины. Это поле используется для генерации значения [Instance.fqdn](/docs/compute/api-ref/Instance#representation). Имя хоста должно быть уникальным в сети и регионе. Если не указано, то имя хоста будет равно [Instance.id](/docs/compute/api-ref/Instance#representation) виртуальной машины, а FQDN будет `<id>.auto.internal`. В противном случае FQDN будет `<hostname>.<region_id>.internal`.  Значение должно быть длиной от 3 до 63 символов и соответствовать регулярному выражению `` ^[a-z][-a-z0-9]{1,61}[a-z0-9]$ ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор операции.
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов.
createdAt | **string** (date-time)<br>Только для вывода. Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
createdBy | **string**<br>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.
modifiedAt | **string** (date-time)<br>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt).
done | **boolean** (boolean)<br>Только для вывода. Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.
metadata | **object**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.
error | **object** <br> включает только одно из полей `error`, `response`<br><br>Описание ошибки в случае сбоя или отмены операции.
error.<br>code | **integer** (int32)<br>Код ошибки. Значение из списка [google.rpc.Code](https://cloud.google.com/appengine/docs/admin-api/reference/rpc/google.rpc#google.rpc.Code).
error.<br>message | **string**<br>Текст ошибки.
error.<br>details | **object**<br>Список сообщений с подробными сведениями об ошибке.
response | **object** <br> включает только одно из полей `error`, `response`<br><br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.