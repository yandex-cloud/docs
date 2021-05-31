---
editable: false
---

# InstanceService

Набор методов для управления ресурсами Instance.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Instance. |
| [List](#List) | Возвращает список доступных ресурсов Instance в указанном каталоге. |
| [Create](#Create) | Создает виртуальную машину в указанном каталоге. |
| [Update](#Update) | Изменяет указанную виртуальную машину. |
| [Delete](#Delete) | Удаляет указанную виртуальную машину. |
| [UpdateMetadata](#UpdateMetadata) | Обновляет метаданные указанной виртуальной машины. |
| [GetSerialPortOutput](#GetSerialPortOutput) | Возвращает вывод последовательного порта указанного ресурса Instance. |
| [Stop](#Stop) | Останавливает запущенную виртуальную машину. |
| [Start](#Start) | Запускает остановленную виртуальную машину. |
| [Restart](#Restart) | Перезапускает работающую виртуальную машину. |
| [AttachDisk](#AttachDisk) | Присоединяет диск к виртуальной машине. |
| [DetachDisk](#DetachDisk) | Отсоединяет диск от виртуальной машины. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной виртуальной машины. |

## Вызовы InstanceService {#calls}

## Get {#Get}

Возвращает указанный ресурс Instance. <br>Чтобы получить список доступных ресурсов Instance, используйте запрос [List](#List).

**rpc Get ([GetInstanceRequest](#GetInstanceRequest)) returns ([Instance](#Instance))**

### GetInstanceRequest {#GetInstanceRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Instance. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.
view | enum **InstanceView**<br>Определяет, какая информация о ресурсе Instance должна быть возвращена в ответе сервера. <ul><li>`BASIC`: Не включать метаданные виртуальной машины в ответ сервера.</li><li>`FULL`: Возвращать метаданные виртуальной машины в ответе сервера.</li><ul/>


### Instance {#Instance}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## List {#List}

Возвращает список доступных ресурсов Instance в указанном каталоге.

**rpc List ([ListInstancesRequest](#ListInstancesRequest)) returns ([ListInstancesResponse](#ListInstancesResponse))**

### ListInstancesRequest {#ListInstancesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка виртуальных машин. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstancesResponse.next_page_token](#ListInstancesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstancesResponse.next_page_token](#ListInstancesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Instance.name](#Instance1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListInstancesResponse {#ListInstancesResponse}

Поле | Описание
--- | ---
instances[] | **[Instance](#Instance1)**<br>Список ресурсов Instance. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstancesRequest.page_size](#ListInstancesRequest), используйте `next_page_token` в качестве значения параметра [ListInstancesRequest.page_token](#ListInstancesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Instance {#Instance1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources1)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk1)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk1)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface1)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy1)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings1)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources1}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk1}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface1}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress1)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress1)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress1}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat1)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat1}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy1}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings1}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## Create {#Create}

Создает виртуальную машину в указанном каталоге. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Create ([CreateInstanceRequest](#CreateInstanceRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateInstanceMetadata](#CreateInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance2)<br>

### CreateInstanceRequest {#CreateInstanceRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для создания виртуальной машины. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя виртуальной машины. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, где находится виртуальная машина. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
platform_id | **string**<br>Обязательное поле. Идентификатор аппаратной платформы виртуальной машины. Это поле влияет на допустимые значения поля `resources_spec`. <br>Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Обязательное поле. Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. Чтобы узнать список допустимых значений, см. раздел [Уровни производительности vCPU](/docs/compute/concepts/performance-levels). 
metadata | **map<string,string>**<br>Метаданные, назначаемые данной виртуальной машине, в формате пар `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. Общий размер всех ключей и значений не должен превышать 512 КБ. <br>Значениями являются строки и используются только программами, которые настраивают виртуальную машину. Значения должны быть не более 256 КБ. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Обязательное поле. Загрузочный диск для подключения к виртуальной машине. 
secondary_disk_specs[] | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Массив дополнительных дисков для подключения к виртуальной машине. Максимальное количество элементов — 3.
network_interface_specs[] | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>Конфигурация сети для виртуальной машины. Указывает, как должен быть настроен сетевой интерфейс для взаимодействия с другими сервисами во внутренней сети и в интернете. В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. Количество элементов должно быть ровно 1.
hostname | **string**<br>Имя хоста виртуальной машины. Это поле используется для генерации значения [yandex.cloud.compute.v1.Instance.fqdn](#Instance). Имя хоста должно быть уникальным в пределах сети и региона. Если не указано, то имя хоста будет равно [yandex.cloud.compute.v1.Instance.id](#Instance) виртуальной машины и FQDN будет `<id>.auto.internal`. В противном случае FQDN будет `<hostname>.<region_id>.internal`. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy2)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings2)**<br>Сетевые настройки. 


### ResourcesSpec {#ResourcesSpec}

Поле | Описание
--- | ---
memory | **int64**<br>Обязательное поле. Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Обязательное поле. Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. <br>Например, если требуется только 5% производительности CPU, можно задать значение `core_fraction=5`. Дополнительные сведения см. в разделе [Уровни производительности vCPU](/docs/compute/concepts/performance-levels). Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### AttachedDiskSpec {#AttachedDiskSpec}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим, в котором необходимо подключить этот диск. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись. Значение по умолчанию.</li><ul/>
device_name | **string**<br>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если значение не указано, будет сгенерировано случайное значение. Значение должно соответствовать регулярному выражению ` [a-z][a-z0-9-_]{,19} `.
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk | **oneof:** `disk_spec` или `disk_id`<br>
&nbsp;&nbsp;disk_spec | **[DiskSpec](#DiskSpec)**<br>Спецификация диска. 
&nbsp;&nbsp;disk_id | **string**<br>Идентификатор диска, который должен быть подключен. Максимальная длина строки в символах — 50.


### DiskSpec {#DiskSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя диска. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List). Максимальная длина строки в символах — 50.
size | **int64**<br>Обязательное поле. Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа для создания диска. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка для восстановления диска. Максимальная длина строки в символах — 50.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Поле | Описание
--- | ---
subnet_id | **string**<br>Обязательное поле. Идентификатор подсети. Максимальная длина строки в символах — 50.
primary_v4_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Основной IPv4-адрес, который будет назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address_spec | **[PrimaryAddressSpec](#PrimaryAddressSpec)**<br>Основной IPv6-адрес, который будет назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddressSpec {#PrimaryAddressSpec}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. Если он не указан, системой будет назначен неиспользуемый внутренний IP-адрес. 
one_to_one_nat_spec | **[OneToOneNatSpec](#OneToOneNatSpec)**<br>Конфигурация внешнего IP-адреса. Если она не указана, то у виртуальной машины не будет доступа в интернет. 


### OneToOneNatSpec {#OneToOneNatSpec}

Поле | Описание
--- | ---
ip_version | enum **IpVersion**<br>Обязательное поле. Версия публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy2}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings2}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateInstanceMetadata](#CreateInstanceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance2)>**<br>в случае успешного выполнения операции. 


### CreateInstanceMetadata {#CreateInstanceMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор создаваемой виртуальной машины. Максимальная длина строки в символах — 50.


### Instance {#Instance2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources2)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk2)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk2)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface2)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy3)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings3)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources2}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk2}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface2}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress2)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress2)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress2}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat2)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat2}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy3}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings3}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## Update {#Update}

Изменяет указанную виртуальную машину.

**rpc Update ([UpdateInstanceRequest](#UpdateInstanceRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceMetadata](#UpdateInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance3)<br>

### UpdateInstanceRequest {#UpdateInstanceRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса Instance. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса Disk будут обновлены. 
name | **string**<br>Имя виртуальной машины. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание виртуальной машины. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. Это поле влияет на допустимые значения поля `resources_spec`. <br>Платформы позволяют создавать виртуальные машины разных типов: с большим объемом памяти, с большим количеством ядер или с высокой производительностью. Дополнительные сведения см. в разделе [Платформы](/docs/compute/concepts/vm-platforms). 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. Чтобы узнать список допустимых значений, см. раздел [Уровни производительности vCPU](/docs/compute/concepts/performance-levels). 
metadata | **map<string,string>**<br>Метаданные, назначаемые данной виртуальной машине, в формате пар `ключ:значение`. Сюда входят пользовательские метаданные и предопределенные ключи. Общий размер всех ключей и значений не должен превышать 512 КБ. <br>Существующий набор `metadata` полностью перезаписывается набором, переданным в запросе. <br>Значениями являются строки и используются только программами, которые настраивают виртуальную машину. Значения должны быть не более 256 КБ. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings4)**<br>Сетевые настройки. 


### ResourcesSpec {#ResourcesSpec1}

Поле | Описание
--- | ---
memory | **int64**<br>Обязательное поле. Объем памяти в байтах, доступный виртуальной машине. Максимальное значение — 274877906944.
cores | **int64**<br>Обязательное поле. Количество ядер, доступное виртуальной машине. Значение должно быть равно 1,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32.
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. <br>Например, если требуется только 5% производительности CPU, можно задать значение `core_fraction=5`. Дополнительные сведения см. в разделе [Уровни производительности vCPU](/docs/compute/concepts/performance-levels). Значение должно быть равно 0,5,20,50,100.
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. Значение должно быть равно 0,1,2,4.


### NetworkSettings {#NetworkSettings4}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceMetadata](#UpdateInstanceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance3)>**<br>в случае успешного выполнения операции. 


### UpdateInstanceMetadata {#UpdateInstanceMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор изменяемого ресурса Instance. 


### Instance {#Instance3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources3)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk3)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk3)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface3)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy4)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings5)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources3}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk3}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface3}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress3)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress3)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress3}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat3)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat3}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy4}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings5}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## Delete {#Delete}

Удаляет указанную виртуальную машину.

**rpc Delete ([DeleteInstanceRequest](#DeleteInstanceRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteInstanceMetadata](#DeleteInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteInstanceRequest {#DeleteInstanceRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор удаляемой виртуальной машины. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteInstanceMetadata](#DeleteInstanceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteInstanceMetadata {#DeleteInstanceMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор удаляемой виртуальной машины. 


## UpdateMetadata {#UpdateMetadata}

Обновляет метаданные указанной виртуальной машины.

**rpc UpdateMetadata ([UpdateInstanceMetadataRequest](#UpdateInstanceMetadataRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateInstanceMetadataMetadata](#UpdateInstanceMetadataMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance4)<br>

### UpdateInstanceMetadataRequest {#UpdateInstanceMetadataRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор изменяемой виртуальной машины. 
delete[] | **string**<br>Список ключей для удаления. 
upsert | **map<string,string>**<br>Метаданные в формате пар `ключ:значение`, которые будут добавлены или обновлены для данной виртуальной машины. 


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateInstanceMetadataMetadata](#UpdateInstanceMetadataMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance4)>**<br>в случае успешного выполнения операции. 


### UpdateInstanceMetadataMetadata {#UpdateInstanceMetadataMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор изменяемой виртуальной машины. 


### Instance {#Instance4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources4)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk4)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk4)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface4)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy5)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings6)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources4}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk4}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface4}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress4)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress4)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress4}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat4)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat4}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy5}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings6}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## GetSerialPortOutput {#GetSerialPortOutput}

Возвращает вывод последовательного порта указанного ресурса Instance.

**rpc GetSerialPortOutput ([GetInstanceSerialPortOutputRequest](#GetInstanceSerialPortOutputRequest)) returns ([GetInstanceSerialPortOutputResponse](#GetInstanceSerialPortOutputResponse))**

### GetInstanceSerialPortOutputRequest {#GetInstanceSerialPortOutputRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор виртуальной машины для получения вывода последовательного порта. Максимальная длина строки в символах — 50.
port | **int64**<br>Последовательный порт из которого извлекаются данные. Значение по умолчанию — 1. Значение должно быть равно 1,2,3,4.


### GetInstanceSerialPortOutputResponse {#GetInstanceSerialPortOutputResponse}

Поле | Описание
--- | ---
contents | **string**<br>Содержимое вывода последовательного порта, начиная с момента начала загрузки виртуальной машины. 


## Stop {#Stop}

Останавливает запущенную виртуальную машину. <br>Вы можете запустить виртуальную машину позже, используя метод [InstanceService.Start](#Start).

**rpc Stop ([StopInstanceRequest](#StopInstanceRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopInstanceMetadata](#StopInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StopInstanceRequest {#StopInstanceRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор останавливаемой виртуальной машины. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopInstanceMetadata](#StopInstanceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### StopInstanceMetadata {#StopInstanceMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор удаляемой виртуальной машины. 


## Start {#Start}

Запускает остановленную виртуальную машину.

**rpc Start ([StartInstanceRequest](#StartInstanceRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartInstanceMetadata](#StartInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance5)<br>

### StartInstanceRequest {#StartInstanceRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор запускаемой виртуальной машины. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartInstanceMetadata](#StartInstanceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance5)>**<br>в случае успешного выполнения операции. 


### StartInstanceMetadata {#StartInstanceMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор виртуальной машины. 


### Instance {#Instance5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources5)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk5)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk5)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface5)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy6)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings7)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources5}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk5}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface5}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress5)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress5)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress5}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat5)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat5}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy6}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings7}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## Restart {#Restart}

Перезапускает работающую виртуальную машину.

**rpc Restart ([RestartInstanceRequest](#RestartInstanceRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestartInstanceMetadata](#RestartInstanceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RestartInstanceRequest {#RestartInstanceRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор виртуальной машины, которую необходимо перезапустить. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestartInstanceMetadata](#RestartInstanceMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### RestartInstanceMetadata {#RestartInstanceMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор виртуальной машины. 


## AttachDisk {#AttachDisk}

Присоединяет диск к виртуальной машине.

**rpc AttachDisk ([AttachInstanceDiskRequest](#AttachInstanceDiskRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AttachInstanceDiskMetadata](#AttachInstanceDiskMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance6)<br>

### AttachInstanceDiskRequest {#AttachInstanceDiskRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор виртуальной машины для подключения диска. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.
attached_disk_spec | **[AttachedDiskSpec](#AttachedDiskSpec)**<br>Обязательное поле. Диск для подключения. 


### AttachedDiskSpec {#AttachedDiskSpec1}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим, в котором необходимо подключить этот диск. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись. Значение по умолчанию.</li><ul/>
device_name | **string**<br>Задает уникальный серийный номер, который на виртуальной машине с операционной системой Linux отображается в директории /dev/disk/by-id/. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. Если значение не указано, будет сгенерировано случайное значение. Значение должно соответствовать регулярному выражению ` [a-z][a-z0-9-_]{,19} `.
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk | **oneof:** `disk_spec` или `disk_id`<br>
&nbsp;&nbsp;disk_spec | **[DiskSpec](#DiskSpec1)**<br>Спецификация диска. 
&nbsp;&nbsp;disk_id | **string**<br>Идентификатор диска, который должен быть подключен. Максимальная длина строки в символах — 50.


### DiskSpec {#DiskSpec1}

Поле | Описание
--- | ---
name | **string**<br>Имя диска. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
type_id | **string**<br>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List). Максимальная длина строки в символах — 50.
size | **int64**<br>Обязательное поле. Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.
source | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа для создания диска. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка для восстановления диска. Максимальная длина строки в символах — 50.


### Operation {#Operation7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AttachInstanceDiskMetadata](#AttachInstanceDiskMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance6)>**<br>в случае успешного выполнения операции. 


### AttachInstanceDiskMetadata {#AttachInstanceDiskMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор виртуальной машины. 
disk_id | **string**<br>Идентификатор типа диска. 


### Instance {#Instance6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources6)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk6)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk6)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface6)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy7)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings8)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources6}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk6}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface6}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress6)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress6)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress6}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat6)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat6}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy7}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings8}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## DetachDisk {#DetachDisk}

Отсоединяет диск от виртуальной машины.

**rpc DetachDisk ([DetachInstanceDiskRequest](#DetachInstanceDiskRequest)) returns ([operation.Operation](#Operation8))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DetachInstanceDiskMetadata](#DetachInstanceDiskMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Instance](#Instance7)<br>

### DetachInstanceDiskRequest {#DetachInstanceDiskRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор виртуальной машины, от которой надо отсоединить диск. Чтобы получить идентификатор виртуальной машины, используйте запрос [InstanceService.List](#List). Максимальная длина строки в символах — 50.
disk | **oneof:** `disk_id` или `device_name`<br>
&nbsp;&nbsp;disk_id | **string**<br>Идентификатор диска, который необходимо отсоединить. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;device_name | **string**<br>Серийный номер диска, который необходимо отсоединить. На виртуальной машине с операционной системой Linux поиск этого значения будет осуществлен в директории /dev/disk/by-id/. Значение должно соответствовать регулярному выражению ` [a-z][a-z0-9-_]{,19} `.


### Operation {#Operation8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DetachInstanceDiskMetadata](#DetachInstanceDiskMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Instance](#Instance7)>**<br>в случае успешного выполнения операции. 


### DetachInstanceDiskMetadata {#DetachInstanceDiskMetadata}

Поле | Описание
--- | ---
instance_id | **string**<br>Идентификатор виртуальной машины. 
disk_id | **string**<br>Идентификатор типа диска. 


### Instance {#Instance7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор виртуальной машины. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит виртуальная машина. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя виртуальной машины. Длина 1-63 символов. 
description | **string**<br>Описание виртуальной машины. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится виртуальная машина. 
platform_id | **string**<br>Идентификатор аппаратной платформы виртуальной машины. 
resources | **[Resources](#Resources7)**<br>Вычислительные ресурсы виртуальной машины, такие как объем памяти и количество ядер. 
status | enum **Status**<br>Статус виртуальной машины. <ul><li>`PROVISIONING`: Виртуальная машина ожидает выделения ресурсов.</li><li>`RUNNING`: Виртуальная машина работает нормально.</li><li>`STOPPING`: Виртуальная машина останавливается.</li><li>`STOPPED`: Виртуальная машина остановлена.</li><li>`STARTING`: Виртуальная машина запускается.</li><li>`RESTARTING`: Виртуальная машина перезапускается.</li><li>`UPDATING`: Виртуальная машина обновляется.</li><li>`ERROR`: С виртуальной машиной произошла ошибка, блокирующая работу.</li><li>`CRASHED`: Виртуальная машина аварийно завершила работу и будет перезапущена автоматически.</li><li>`DELETING`: Виртуальная машина удаляется.</li><ul/>
metadata | **map<string,string>**<br>Метаданные в формате пар `key:value`, назначаемые данной виртуальной машине. Сюда входят пользовательские метаданные и предопределенные ключи. <br>Например, можно использовать метаданные для доставки открытого ключа SSH на виртуальную машину. Дополнительные сведения см. в разделе [Метаданные виртуальной машины](/docs/compute/concepts/vm-metadata). 
boot_disk | **[AttachedDisk](#AttachedDisk7)**<br>Загрузочный диск, подключенный к виртуальной машине. 
secondary_disks[] | **[AttachedDisk](#AttachedDisk7)**<br>Массив дополнительных дисков, подключенных к виртуальной машине. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface7)**<br>Массив сетевых интерфейсов, присоединенных к виртуальной машине. 
fqdn | **string**<br>Доменное имя виртуальной машины. FQDN определяется сервером в формате `<hostname>.<region_id>.internal` при создании виртуальной машины. Если имя хоста не было указано при создании виртуальной машины, FQDN будет `<id>.auto.internal`. 
scheduling_policy | **[SchedulingPolicy](#SchedulingPolicy8)**<br>Конфигурация политики планирования. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта для [аутентификации изнутри виртуальной машины](/docs/compute/operations/vm-connect/auth-inside-vm). Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). 
network_settings | **[NetworkSettings](#NetworkSettings9)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. 


### Resources {#Resources7}

Поле | Описание
--- | ---
memory | **int64**<br>Объем памяти в байтах, доступный виртуальной машине. 
cores | **int64**<br>Количество ядер, доступное виртуальной машине. 
core_fraction | **int64**<br>Базовый уровень производительности CPU с возможностью повышения производительности выше этого уровня. Это поле устанавливает базовую производительность для каждого ядра. 
gpus | **int64**<br>Количество GPU, доступное виртуальной машине. 


### AttachedDisk {#AttachedDisk7}

Поле | Описание
--- | ---
mode | enum **Mode**<br>Режим доступа к ресурсу Disk. <ul><li>`READ_ONLY`: Доступ на чтение.</li><li>`READ_WRITE`: Доступ на чтение и запись.</li><ul/>
device_name | **string**<br>Cерийный номер, который отображается в директории /dev/disk/by-id/ на виртуальной машине с операционной системой Linux. <br>Это значение может использоваться для ссылки на устройство внутри виртуальной машины при монтировании, изменении размера и т. д. 
auto_delete | **bool**<br>Указывает, должен ли диск автоматически удалиться при удалении виртуальной машины. 
disk_id | **string**<br>Идентификатор диска, подключенного к виртуальной машине. 


### NetworkInterface {#NetworkInterface7}

Поле | Описание
--- | ---
index | **string**<br>Индекс сетевого интерфейса, генерируемого сервером, 0,1,2... В настоящее время для каждой виртуальной машины поддерживается только один сетевой интерфейс. 
mac_address | **string**<br>MAC-адрес, назначенный сетевому интерфейсу. 
subnet_id | **string**<br>Идентификатор подсети. 
primary_v4_address | **[PrimaryAddress](#PrimaryAddress7)**<br>Основной IPv4-адрес, который назначен виртуальной машине для данного сетевого интерфейса. 
primary_v6_address | **[PrimaryAddress](#PrimaryAddress7)**<br>Основной IPv6-адрес, который назначен виртуальной машине для данного сетевого интерфейса. IPv6 еще не доступен. 


### PrimaryAddress {#PrimaryAddress7}

Поле | Описание
--- | ---
address | **string**<br>Внутренний IPv4-адрес, назначенный виртуальной машине для данного сетевого интерфейса. 
one_to_one_nat | **[OneToOneNat](#OneToOneNat7)**<br>Конфигурация one-to-one NAT. Если она отсутствует, NAT не был настроен. 


### OneToOneNat {#OneToOneNat7}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес, связанный с данной виртуальной машиной. 
ip_version | enum **IpVersion**<br>Версия IP для публичного IP-адреса. <ul><li>`IPV4`: IPv4-адрес, например 192.0.2.235.</li><li>`IPV6`: <ol><li>На данный момент не доступен.</li></ol></li><ul/>


### SchedulingPolicy {#SchedulingPolicy8}

Поле | Описание
--- | ---
preemptible | **bool**<br>Если значение равно true — будет создана прерываемая виртуальная машина. Дополнительные сведения см. в разделе [Прерываемые виртуальные машины](/docs/compute/concepts/preemptible-vm). 


### NetworkSettings {#NetworkSettings9}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Не указывайте это поле, сетевые настройки пока не поддерживаются. <ul><li>`STANDARD`: Стандартная сеть.</li><li>`SOFTWARE_ACCELERATED`: Сеть с программным ускорением.</li><li>`HARDWARE_ACCELERATED`: Сеть с аппаратным ускорением (этот тип пока недоступен, значение зарезервировано для использования в будущем).</li><ul/>


## ListOperations {#ListOperations}

Возвращает список операций для указанной виртуальной машины.

**rpc ListOperations ([ListInstanceOperationsRequest](#ListInstanceOperationsRequest)) returns ([ListInstanceOperationsResponse](#ListInstanceOperationsResponse))**

### ListInstanceOperationsRequest {#ListInstanceOperationsRequest}

Поле | Описание
--- | ---
instance_id | **string**<br>Обязательное поле. Идентификатор ресурса Instance, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListInstanceOperationsResponse.next_page_token](#ListInstanceOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListInstanceOperationsResponse.next_page_token](#ListInstanceOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListInstanceOperationsResponse {#ListInstanceOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>Список операций для указанной виртуальной машины. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListInstanceOperationsRequest.page_size](#ListInstanceOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListInstanceOperationsRequest.page_token](#ListInstanceOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation9}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`. 


