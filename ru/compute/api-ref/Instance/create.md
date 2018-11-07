# Метод create
Создает виртуальную машину в указанном каталоге. Метод
запускает асинхронную операцию, которую можно отменить перед
тем, как она завершится.
 

 
## HTTP-запрос {#https-request}
`POST https://compute.api.cloud.yandex.net/compute/v1/instances`
 
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
      },
      "primaryV6AddressSpec": {
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
folderId | **string**<br><p>Обязательное поле. Идентификатор каталога для создания виртуальной машины. Чтобы получить идентификатор каталога, используйте запрос <a href="/docs/resource-manager/api-ref/Folder/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
name | **string**<br><p>Имя виртуальной машины.</p> <p>Значение должно соответствовать регулярному выражению <code>|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
description | **string**<br><p>Описание виртуальной машины.</p> <p>Максимальная длина строки в символах — 256.</p> 
labels | **object**<br><p>Метки ресурса в формате <code>ключ:значение</code>.</p> <p>Не более 64 на ресурс. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению <code>[a-z][-_0-9a-z]*</code>. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению <code>[-_0-9a-z]*</code>.</p> 
zoneId | **string**<br><p>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. Чтобы получить список доступных зон, используйте запрос <a href="/docs/compute/api-ref/Zone/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
platformId | **string**<br><p>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Это поле влияет на допустимые значения в поле <a href="/docs/compute/api-ref/Instance/create#body_params">resourcesSpec</a>.</p> <p>В настоящее время доступна только одна платформа - &quot;standard-v1`. Эта платформа подходит для большинства задач. Эта платформа позволяет создавать машины различных типов: с большим объемом памяти, с большим количеством ядер, с высокой производительностью.</p> <p>Значение должно соответствовать регулярному выражению <code>standard-v1</code>.</p> 
resourcesSpec | **object**<br><p>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. Чтобы узнать список допустимых значений, см. <a href="/docs/compute/concepts/vm-types">Вычислительные ресурсы виртуальной машины</a>.</p> 
resourcesSpec.<br>memory | **string** (int64)<br><p>Обязательное поле. Объем памяти в байтах, доступный виртуальной машине.</p> <p>Максимальное значение — 34359738368.</p> 
resourcesSpec.<br>cores | **string** (int64)<br><p>Обязательное поле. Количество ядер, доступных виртуальной машине.</p> <p>Максимальное значение — 32.</p> 
resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра.</p> <p>Например, если требуется только 5% производительности CPU, можно задать core_fraction=5. Подробнее см. <a href="/docs/compute/concepts/vm-types#burstable-cores">Виртуальные машины с частичным использованием ядра</a>.</p> <p>Значение должно быть равно 5.</p> 
metadata | **object**<br><p>Метаданные, назначаемые этой виртуальной машине, в формате <code>ключ:значение</code>. Это включает произвольные пользовательские метаданные и предзаданные ключи. Общий размер всех ключей и значений не должен превышать 512 КБ.</p> <p>Значения - произвольные строки и имеют смысл только, когда интерпретируются программами, которые выполняют настройку виртуальной машины. Единственное ограничение на значения заключается в том, что их размер должен быть не более 256 КБ.</p> <p>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Подробнее см. <a href="/docs/compute/concepts/vm-metadata">Метаданные виртуальной машины</a>.</p> 
bootDiskSpec | **object**<br><p>Обязательное поле. Загрузочный диск для подключения к виртуальной машине.</p> 
bootDiskSpec.<br>mode | **string**<br><ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись. Значение по умолчанию.</li> </ul> 
bootDiskSpec.<br>deviceName | **string**<br><p>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если не указано, будет сгенерировано случайное значение.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-z][a-z0-9-_]{,19}</code>.</p> 
bootDiskSpec.<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
bootDiskSpec.<br>diskSpec | **object** <br>`bootDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br>
bootDiskSpec.<br>diskSpec.<br>name | **string**<br><p>Имя диска.</p> <p>Значение должно соответствовать регулярному выражению <code>|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос <a href="/docs/compute/api-ref/DiskType/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Обязательное поле. Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа для создания диска из него.</p> <p>Максимальная длина строки в символах — 50.</p> 
bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`bootDiskSpec.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка для восстановления диска из него.</p> <p>Максимальная длина строки в символах — 50.</p> 
bootDiskSpec.<br>diskId | **string** <br>`bootDiskSpec` включает только одно из полей `diskSpec`, `diskId`<br><br><p>ID диска, который должен быть подключен.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs | **object**<br><p>Массив дополнительных дисков для подключения к виртуальной машине.</p> <p>Максимальное количество элементов — 3.</p> 
secondaryDiskSpecs.<br>mode | **string**<br><ul> <li>READ_ONLY: Доступ на чтение.</li> <li>READ_WRITE: Доступ на чтение и запись. Значение по умолчанию.</li> </ul> 
secondaryDiskSpecs.<br>deviceName | **string**<br><p>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/.</p> <p>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если не указано, будет сгенерировано случайное значение.</p> <p>Значение должно соответствовать регулярному выражению <code>[a-z][a-z0-9-_]{,19}</code>.</p> 
secondaryDiskSpecs.<br>autoDelete | **boolean** (boolean)<br><p>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины.</p> 
secondaryDiskSpecs.<br>diskSpec | **object** <br>`secondaryDiskSpecs` включает только одно из полей `diskSpec`, `diskId`<br><br>
secondaryDiskSpecs.<br>diskSpec.<br>name | **string**<br><p>Имя диска.</p> <p>Значение должно соответствовать регулярному выражению <code>|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
secondaryDiskSpecs.<br>diskSpec.<br>description | **string**<br><p>Описание диска.</p> <p>Максимальная длина строки в символах — 256.</p> 
secondaryDiskSpecs.<br>diskSpec.<br>typeId | **string**<br><p>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос <a href="/docs/compute/api-ref/DiskType/list">list</a>.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs.<br>diskSpec.<br>size | **string** (int64)<br><p>Обязательное поле. Размер диска в байтах.</p> <p>Допустимые значения — от 4194304 до 4398046511104 включительно.</p> 
secondaryDiskSpecs.<br>diskSpec.<br>imageId | **string** <br>`secondaryDiskSpecs.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор образа для создания диска из него.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs.<br>diskSpec.<br>snapshotId | **string** <br>`secondaryDiskSpecs.diskSpec` включает только одно из полей `imageId`, `snapshotId`<br><br><p>Идентификатор снимка для восстановления диска из него.</p> <p>Максимальная длина строки в символах — 50.</p> 
secondaryDiskSpecs.<br>diskId | **string** <br>`secondaryDiskSpecs` включает только одно из полей `diskSpec`, `diskId`<br><br><p>ID диска, который должен быть подключен.</p> <p>Максимальная длина строки в символах — 50.</p> 
networkInterfaceSpecs | **object**<br><p>Обязательное поле. Конфигурация сети для виртуальной машины. Указывает, как должен быть настроен сетевой интерфейс для взаимодействия с другими сервисами во внутренней сети и в интернете. В настоящее время поддерживается только один сетевой интерфейс для виртуальной машины.</p> <p>Должен содержать ровно 1 элемент.</p> 
networkInterfaceSpecs.<br>subnetId | **string**<br><p>Обязательное поле. Идентификатор подсети.</p> <p>Максимальная длина строки в символах — 50.</p> 
networkInterfaceSpecs.<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4-адрес, который будет назначен виртуальной машине для данного сетевого интерфейса.</p> 
networkInterfaceSpecs.<br>primaryV4AddressSpec.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для этого сетевого интерфейса. Если не указано, системой будет назначен неиспользуемый внутренний IP-адрес.</p> 
networkInterfaceSpecs.<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация внешнего IP-адреса. Если не указано, то к виртуальной машине не будет доступа из интернета.</p> 
networkInterfaceSpecs.<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Обязательное поле. Версия внешнего IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: IPv6-адрес, например, 2001:0db8:85a3:0000:0000:8a2e:0370:7334.</li> </ul> 
networkInterfaceSpecs.<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6-адрес, который будет назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен.</p> 
networkInterfaceSpecs.<br>primaryV6AddressSpec.<br>address | **string**<br><p>Внутренний IPv4-адрес, назначенный виртуальной машине для этого сетевого интерфейса. Если не указано, системой будет назначен неиспользуемый внутренний IP-адрес.</p> 
networkInterfaceSpecs.<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>Конфигурация внешнего IP-адреса. Если не указано, то к виртуальной машине не будет доступа из интернета.</p> 
networkInterfaceSpecs.<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>Обязательное поле. Версия внешнего IP-адреса.</p> <ul> <li>IPV4: IPv4-адрес, например 192.0.2.235.</li> <li>IPV6: IPv6-адрес, например, 2001:0db8:85a3:0000:0000:8a2e:0370:7334.</li> </ul> 
hostname | **string**<br><p>Имя хоста виртуальной машины. Это поле используется для генерации значения <a href="/docs/compute/api-ref/Instance#representation">Instance.fqdn</a>. Имя хоста должно быть уникальным в сети и регионе. Если не указано, то имя хоста будет равно <a href="/docs/compute/api-ref/Instance#representation">Instance.id</a> виртуальной машины, а FQDN будет &quot;<id>.auto.internal<code>. Otherwise FQDN will be</code><hostname>.&lt;region_id&gt;.internal`.</p> <p>Значение должно соответствовать регулярному выражению <code>|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Operation. Дополнительные сведения см. в разделе
[Объект Operation](/docs/api-design-guide/concepts/operation).
 
Поле | Описание
--- | ---
id | **string**<br><p>Только для вывода. Идентификатор операции.</p> 
description | **string**<br><p>Описание операции. Длина описания должна быть от 0 до 256 символов.</p> 
createdAt | **string** (date-time)<br><p>Только для вывода. Время создания ресурса в формате в <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
createdBy | **string**<br><p>Только для вывода. Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию.</p> 
modifiedAt | **string** (date-time)<br><p>Только для вывода. Время, когда ресурс Operation последний раз обновлялся. Значение в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
done | **boolean** (boolean)<br><p>Только для вывода. Если значение равно <code>false</code> — операция еще выполняется. Если <code>true</code> — операция завершена, и задано значение одного из полей <code>error</code> или <code>response</code>.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>metadata</code>.</p> 
error | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля <code>response</code>.</p> 