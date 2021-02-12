---
editable: false
---

# NetworkLoadBalancerService

Набор методов для управления ресурсами NetworkLoadBalancer.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс NetworkLoadBalancer. |
| [List](#List) | Возвращает список доступных ресурсов NetworkLoadBalancer в указанном каталоге. |
| [Create](#Create) | Создает балансировщик в указанном каталоге, используя данные, указанные в запросе. |
| [Update](#Update) | Обновляет указанный балансировщик. |
| [Delete](#Delete) | Удаляет указанный балансировщик. |
| [Start](#Start) | Запускает балансировку нагрузки и проверки состояния с заданными параметрами с помощью указанного балансировщика. |
| [Stop](#Stop) | Указанный балансировщик останавливает балансировку нагрузки и проверки состояния. |
| [AttachTargetGroup](#AttachTargetGroup) | Подключает целевую группу к указанному балансировщику. |
| [DetachTargetGroup](#DetachTargetGroup) | Отключает целевую группу от указанного балансировщика. |
| [GetTargetStates](#GetTargetStates) | Возвращает состояния целевых ресурсов в подключенной целевой группе. |
| [AddListener](#AddListener) | Добавляет обработчик в указанный балансировщик. |
| [RemoveListener](#RemoveListener) | Удаляет обработчик из указанного балансировщика сетевой нагрузки. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного балансировщика. |

## Вызовы NetworkLoadBalancerService {#calls}

## Get {#Get}

Возвращает указанный ресурс NetworkLoadBalancer. <br>Чтобы получить список доступных ресурсов NetworkLoadBalancer, используйте запрос [List](#List).

**rpc Get ([GetNetworkLoadBalancerRequest](#GetNetworkLoadBalancerRequest)) returns ([NetworkLoadBalancer](#NetworkLoadBalancer))**

### GetNetworkLoadBalancerRequest {#GetNetworkLoadBalancerRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор возвращаемого ресурса NetworkLoadBalancer. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.


### NetworkLoadBalancer {#NetworkLoadBalancer}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## List {#List}

Возвращает список доступных ресурсов NetworkLoadBalancer в указанном каталоге.

**rpc List ([ListNetworkLoadBalancersRequest](#ListNetworkLoadBalancersRequest)) returns ([ListNetworkLoadBalancersResponse](#ListNetworkLoadBalancersResponse))**

### ListNetworkLoadBalancersRequest {#ListNetworkLoadBalancersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, которому принадлежит балансировщик. Чтобы получить идентификатор каталога, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListNetworkLoadBalancersResponse.next_page_token](#ListNetworkLoadBalancersResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNetworkLoadBalancersResponse.next_page_token](#ListNetworkLoadBalancersResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [NetworkLoadBalancer.name](#NetworkLoadBalancer1). </li><li>Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9].`.</li></ol> Максимальная длина строки в символах — 1000.


### ListNetworkLoadBalancersResponse {#ListNetworkLoadBalancersResponse}

Поле | Описание
--- | ---
network_load_balancers[] | **[NetworkLoadBalancer](#NetworkLoadBalancer1)**<br>Список ресурсов NetworkLoadBalancer. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNetworkLoadBalancersRequest.page_size](#ListNetworkLoadBalancersRequest), используйте `next_page_token` в качестве значения параметра [ListNetworkLoadBalancersRequest.page_token](#ListNetworkLoadBalancersRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### NetworkLoadBalancer {#NetworkLoadBalancer1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener1)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup1)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener1}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup1}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck1)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck1}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions1)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions1)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions1}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions1}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## Create {#Create}

Создает балансировщик в указанном каталоге, используя данные, указанные в запросе.

**rpc Create ([CreateNetworkLoadBalancerRequest](#CreateNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateNetworkLoadBalancerMetadata](#CreateNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer2)<br>

### CreateNetworkLoadBalancerRequest {#CreateNetworkLoadBalancerRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается балансировщик. Чтобы получить идентификатор каталога, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя балансировщика. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание балансировщика. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
region_id | **string**<br>Обязательное поле. Идентификатор региона, в котором находится балансировщик. Максимальная длина строки в символах — 50.
type | **[NetworkLoadBalancer.Type](#NetworkLoadBalancer2)**<br>Обязательное поле. Тип балансировщика. В настоящее время доступны только внешние балансировщики. 
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br>Список обработчиков и их спецификации для балансировщика. Максимальное количество элементов — 10.
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup2)**<br>Список подключенных к балансировщику целевых групп. Сейчас к балансировщику можно подключить только одну целевую группу. Максимальное количество элементов — 1.


### ListenerSpec {#ListenerSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
port | **int64**<br>Порт для входящего трафика. Допустимые значения — от 1 до 32767 включительно.
protocol | **[Listener.Protocol](#Listener2)**<br>Обязательное поле. Сетевой протокол для входящего трафика. 
address | **oneof:** `external_address_spec`<br>IP-адрес для входящего трафика. Идентификатор ранее созданного адреса или спецификация адреса.
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Спецификация внешнего IP-адреса. 
target_port | **int64**<br>Порты целевых ресурсов для входящего трафика. Допустимые значения — от 1 до 32767 включительно. 


### ExternalAddressSpec {#ExternalAddressSpec}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес для обработчика. Если адрес передается в методе [NetworkLoadBalancerService.Update](#Update), он заменит существующий адрес обработчика. 
ip_version | enum **IpVersion**<br>Версия IP-адреса. <ul><li>`IPV4`: Протокол IPv4.</li><li>`IPV6`: Протокол IPv6.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup2}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck2)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck2}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions2)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions2)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions2}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions2}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateNetworkLoadBalancerMetadata](#CreateNetworkLoadBalancerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer2)>**<br>в случае успешного выполнения операции. 


### CreateNetworkLoadBalancerMetadata {#CreateNetworkLoadBalancerMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор создаваемого балансировщика. 


### NetworkLoadBalancer {#NetworkLoadBalancer2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener2)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup3)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener2}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup3}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck3)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck3}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions3)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions3)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions3}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions3}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## Update {#Update}

Обновляет указанный балансировщик.

**rpc Update ([UpdateNetworkLoadBalancerRequest](#UpdateNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNetworkLoadBalancerMetadata](#UpdateNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer3)<br>

### UpdateNetworkLoadBalancerRequest {#UpdateNetworkLoadBalancerRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор обновляемого балансировщика. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса NetworkLoadBalancer будут обновлены. 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` [a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание балансировщика. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. <br>Имеющийся набор меток полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
listener_specs[] | **[ListenerSpec](#ListenerSpec)**<br>Список обработчиков балансировщика и их спецификации. Максимальное количество элементов — 10.
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup4)**<br>Список подключенных к балансировщику целевых групп. Сейчас к балансировщику можно подключить только одну целевую группу. Максимальное количество элементов — 1.


### ListenerSpec {#ListenerSpec1}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
port | **int64**<br>Порт для входящего трафика. Допустимые значения — от 1 до 32767 включительно.
protocol | **[Listener.Protocol](#Listener3)**<br>Обязательное поле. Сетевой протокол для входящего трафика. 
address | **oneof:** `external_address_spec`<br>IP-адрес для входящего трафика. Идентификатор ранее созданного адреса или спецификация адреса.
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Спецификация внешнего IP-адреса. 
target_port | **int64**<br>Порты целевых ресурсов для входящего трафика. Допустимые значения — от 1 до 32767 включительно. 


### ExternalAddressSpec {#ExternalAddressSpec1}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес для обработчика. Если адрес передается в методе [NetworkLoadBalancerService.Update](#Update), он заменит существующий адрес обработчика. 
ip_version | enum **IpVersion**<br>Версия IP-адреса. <ul><li>`IPV4`: Протокол IPv4.</li><li>`IPV6`: Протокол IPv6.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup4}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck4)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck4}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions4)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions4)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions4}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions4}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNetworkLoadBalancerMetadata](#UpdateNetworkLoadBalancerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer3)>**<br>в случае успешного выполнения операции. 


### UpdateNetworkLoadBalancerMetadata {#UpdateNetworkLoadBalancerMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор обновляемого ресурса NetworkLoadBalancer. 


### NetworkLoadBalancer {#NetworkLoadBalancer3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener3)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup5)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener3}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup5}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck5)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck5}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions5)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions5)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions5}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions5}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## Delete {#Delete}

Удаляет указанный балансировщик.

**rpc Delete ([DeleteNetworkLoadBalancerRequest](#DeleteNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNetworkLoadBalancerMetadata](#DeleteNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteNetworkLoadBalancerRequest {#DeleteNetworkLoadBalancerRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор удаляемого балансировщика. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteNetworkLoadBalancerMetadata](#DeleteNetworkLoadBalancerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteNetworkLoadBalancerMetadata {#DeleteNetworkLoadBalancerMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор удаляемого ресурса NetworkLoadBalancer. 


## Start {#Start}

Запускает балансировку нагрузки и проверки состояния с заданными параметрами с помощью указанного балансировщика. Изменяет состояние балансировщика на `` ACTIVE ``.

**rpc Start ([StartNetworkLoadBalancerRequest](#StartNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartNetworkLoadBalancerMetadata](#StartNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StartNetworkLoadBalancerRequest {#StartNetworkLoadBalancerRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор балансировщика, который будет запущен. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartNetworkLoadBalancerMetadata](#StartNetworkLoadBalancerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### StartNetworkLoadBalancerMetadata {#StartNetworkLoadBalancerMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор запускаемого ресурса NetworkLoadBalancer. 


## Stop {#Stop}

Указанный балансировщик останавливает балансировку нагрузки и проверки состояния. Изменяет состояние балансировщика на `` STOPPED ``.

**rpc Stop ([StopNetworkLoadBalancerRequest](#StopNetworkLoadBalancerRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopNetworkLoadBalancerMetadata](#StopNetworkLoadBalancerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StopNetworkLoadBalancerRequest {#StopNetworkLoadBalancerRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор балансировщика, который будет остановлен. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopNetworkLoadBalancerMetadata](#StopNetworkLoadBalancerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### StopNetworkLoadBalancerMetadata {#StopNetworkLoadBalancerMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор останавливаемого ресурса NetworkLoadBalancer. 


## AttachTargetGroup {#AttachTargetGroup}

Подключает целевую группу к указанному балансировщику.

**rpc AttachTargetGroup ([AttachNetworkLoadBalancerTargetGroupRequest](#AttachNetworkLoadBalancerTargetGroupRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AttachNetworkLoadBalancerTargetGroupMetadata](#AttachNetworkLoadBalancerTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer4)<br>

### AttachNetworkLoadBalancerTargetGroupRequest {#AttachNetworkLoadBalancerTargetGroupRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор балансировщика, к которому будет подключена целевая группа. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.
attached_target_group | **[AttachedTargetGroup](#AttachedTargetGroup6)**<br>Обязательное поле. Идентификатор целевой группы для подключения к балансировщику. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). 


### AttachedTargetGroup {#AttachedTargetGroup6}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck6)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck6}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions6)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions6)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions6}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions6}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AttachNetworkLoadBalancerTargetGroupMetadata](#AttachNetworkLoadBalancerTargetGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer4)>**<br>в случае успешного выполнения операции. 


### AttachNetworkLoadBalancerTargetGroupMetadata {#AttachNetworkLoadBalancerTargetGroupMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор балансировщика, к которому подключается целевая группа. 
target_group_id | **string**<br>Идентификатор целевой группы. 


### NetworkLoadBalancer {#NetworkLoadBalancer4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener4)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup7)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener4}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup7}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck7)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck7}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions7)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions7)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions7}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions7}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## DetachTargetGroup {#DetachTargetGroup}

Отключает целевую группу от указанного балансировщика.

**rpc DetachTargetGroup ([DetachNetworkLoadBalancerTargetGroupRequest](#DetachNetworkLoadBalancerTargetGroupRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DetachNetworkLoadBalancerTargetGroupMetadata](#DetachNetworkLoadBalancerTargetGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer5)<br>

### DetachNetworkLoadBalancerTargetGroupRequest {#DetachNetworkLoadBalancerTargetGroupRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор балансировщика, от которого будет отключена целевая группа. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DetachNetworkLoadBalancerTargetGroupMetadata](#DetachNetworkLoadBalancerTargetGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer5)>**<br>в случае успешного выполнения операции. 


### DetachNetworkLoadBalancerTargetGroupMetadata {#DetachNetworkLoadBalancerTargetGroupMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор балансировщика, от которого отключается целевая группа. 
target_group_id | **string**<br>Идентификатор целевой группы. 


### NetworkLoadBalancer {#NetworkLoadBalancer5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener5)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup8)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener5}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup8}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck8)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck8}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions8)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions8)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions8}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions8}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## GetTargetStates {#GetTargetStates}

Возвращает состояния целевых ресурсов в подключенной целевой группе.

**rpc GetTargetStates ([GetTargetStatesRequest](#GetTargetStatesRequest)) returns ([GetTargetStatesResponse](#GetTargetStatesResponse))**

### GetTargetStatesRequest {#GetTargetStatesRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор ресурса NetworkLoadBalancer с присоединенной целевой группой. Максимальная длина строки в символах — 50.
target_group_id | **string**<br>Идентификатор целевой группы для получения состояний ресурсов. Максимальная длина строки в символах — 50.


### GetTargetStatesResponse {#GetTargetStatesResponse}

Поле | Описание
--- | ---
target_states[] | **[TargetState](#TargetState)**<br>Список состояний ресурсов в целевой группе, указанных в сообщении [GetTargetStatesRequest](#GetTargetStatesRequest) . 


### TargetState {#TargetState}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор подсети, к которой подключен целевой ресурс. 
address | **string**<br>IP-адрес целевого ресурса. 
status | enum **Status**<br>Состояние целевого ресурса. <ul><li>`INITIAL`: Балансировщик настраивает проверку состояния для этого целевого ресурса.</li><li>`HEALTHY`: Проверка состояния пройдена и целевой ресурс готов принимать трафик.</li><li>`UNHEALTHY`: Проверка состояния не пройдена и целевой ресурс не принимает трафик.</li><li>`DRAINING`: Целевой ресурс удаляется и балансировщик больше не передает трафик этому ресурсу.</li><li>`INACTIVE`: Балансировщик остановлен и не выполняет проверки состояния для этого целевого ресурса или ресурс подключен к балансировщику без обработчика.</li><ul/>


## AddListener {#AddListener}

Добавляет обработчик в указанный балансировщик.

**rpc AddListener ([AddNetworkLoadBalancerListenerRequest](#AddNetworkLoadBalancerListenerRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddNetworkLoadBalancerListenerMetadata](#AddNetworkLoadBalancerListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer6)<br>

### AddNetworkLoadBalancerListenerRequest {#AddNetworkLoadBalancerListenerRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор балансировщика, к которому будет добавлен обработчик. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.
listener_spec | **[ListenerSpec](#ListenerSpec)**<br>Обязательное поле. Спецификация обработчика. 


### ListenerSpec {#ListenerSpec2}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
port | **int64**<br>Порт для входящего трафика. Допустимые значения — от 1 до 32767 включительно.
protocol | **[Listener.Protocol](#Listener6)**<br>Обязательное поле. Сетевой протокол для входящего трафика. 
address | **oneof:** `external_address_spec`<br>IP-адрес для входящего трафика. Идентификатор ранее созданного адреса или спецификация адреса.
&nbsp;&nbsp;external_address_spec | **[ExternalAddressSpec](#ExternalAddressSpec)**<br>Спецификация внешнего IP-адреса. 
target_port | **int64**<br>Порты целевых ресурсов для входящего трафика. Допустимые значения — от 1 до 32767 включительно. 


### ExternalAddressSpec {#ExternalAddressSpec2}

Поле | Описание
--- | ---
address | **string**<br>Публичный IP-адрес для обработчика. Если адрес передается в методе [NetworkLoadBalancerService.Update](#Update), он заменит существующий адрес обработчика. 
ip_version | enum **IpVersion**<br>Версия IP-адреса. <ul><li>`IPV4`: Протокол IPv4.</li><li>`IPV6`: Протокол IPv6.</li><ul/>


### Operation {#Operation7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddNetworkLoadBalancerListenerMetadata](#AddNetworkLoadBalancerListenerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer6)>**<br>в случае успешного выполнения операции. 


### AddNetworkLoadBalancerListenerMetadata {#AddNetworkLoadBalancerListenerMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор обработчика, к которому будет добавлен обработчик. 


### NetworkLoadBalancer {#NetworkLoadBalancer6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener6)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup9)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener6}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup9}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck9)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck9}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions9)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions9)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions9}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions9}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## RemoveListener {#RemoveListener}

Удаляет обработчик из указанного балансировщика сетевой нагрузки.

**rpc RemoveListener ([RemoveNetworkLoadBalancerListenerRequest](#RemoveNetworkLoadBalancerListenerRequest)) returns ([operation.Operation](#Operation8))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveNetworkLoadBalancerListenerMetadata](#RemoveNetworkLoadBalancerListenerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[NetworkLoadBalancer](#NetworkLoadBalancer7)<br>

### RemoveNetworkLoadBalancerListenerRequest {#RemoveNetworkLoadBalancerListenerRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор балансировщика, у которого будет удален обработчик. Чтобы получить идентификатор балансировщика, используйте запрос [NetworkLoadBalancerService.List](#List). Максимальная длина строки в символах — 50.
listener_name | **string**<br>Обязательное поле. Имя удаляемого обработчика. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.


### Operation {#Operation8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveNetworkLoadBalancerListenerMetadata](#RemoveNetworkLoadBalancerListenerMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[NetworkLoadBalancer](#NetworkLoadBalancer7)>**<br>в случае успешного выполнения операции. 


### RemoveNetworkLoadBalancerListenerMetadata {#RemoveNetworkLoadBalancerListenerMetadata}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Идентификатор балансировщика, у которого удаляется обработчик. 


### NetworkLoadBalancer {#NetworkLoadBalancer7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор балансировщика. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание балансировщика. Длина 0-256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс. 
region_id | **string**<br>Идентификатор каталога, которому принадлежит балансировщик. 
status | enum **Status**<br>Состояние балансировщика. <ul><li>`CREATING`: Балансировщик создается.</li><li>`STARTING`: Балансировщик запускается.</li><li>`ACTIVE`: Балансировщик активен и передает трафик целевым ресурсам.</li><li>`STOPPING`: Балансировщик остановлен.</li><li>`STOPPED`: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li><li>`DELETING`: Балансировщик удаляется.</li><li>`INACTIVE`: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li><ul/>
type | enum **Type**<br>Тип балансировщика. В настоящее время доступны только внешние балансировщики. <ul><li>`EXTERNAL`: Внешний балансировщик.</li><ul/>
session_affinity | enum **SessionAffinity**<br>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. <ul><li>`CLIENT_IP_PORT_PROTO`: Адресация 5-tuple.</li><ul/>
listeners[] | **[Listener](#Listener7)**<br>Список обработчиков балансировщика. 
attached_target_groups[] | **[AttachedTargetGroup](#AttachedTargetGroup10)**<br>Список целевых групп, подключенных к балансировщику. 


### Listener {#Listener7}

Поле | Описание
--- | ---
name | **string**<br>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов. 
address | **string**<br>IP-адрес для обработчика. 
port | **int64**<br>Порт. 
protocol | enum **Protocol**<br>Сетевой протокол для входящего трафика. <ul><li>`TCP`: Протокол TCP.</li><ul/>


### AttachedTargetGroup {#AttachedTargetGroup10}

Поле | Описание
--- | ---
target_group_id | **string**<br>Обязательное поле. Идентификатор целевой группы. Максимальная длина строки в символах — 50.
health_checks[] | **[HealthCheck](#HealthCheck10)**<br>Проверка состояния целевой группы. Сейчас можно установить только одну проверку состояния для одной целевой группы. Количество элементов должно быть ровно 1.


### HealthCheck {#HealthCheck10}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды. 
timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда. 
unhealthy_threshold | **int64**<br>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
healthy_threshold | **int64**<br>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2. Допустимые значения — от 2 до 10 включительно.
options | **oneof:** `tcp_options` или `http_options`<br>Протокол для проверки состояния. TCP или HTTP.
&nbsp;&nbsp;tcp_options | **[TcpOptions](#TcpOptions10)**<br>Протокол TCP. 
&nbsp;&nbsp;http_options | **[HttpOptions](#HttpOptions10)**<br>Протокол HTTP. 


### TcpOptions {#TcpOptions10}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу TCP. Допустимые значения — от 1 до 32767 включительно.


### HttpOptions {#HttpOptions10}

Поле | Описание
--- | ---
port | **int64**<br>Настройки для проверок состояния по протоколу HTTP. Допустимые значения — от 1 до 32767 включительно.
path | **string**<br>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного балансировщика.

**rpc ListOperations ([ListNetworkLoadBalancerOperationsRequest](#ListNetworkLoadBalancerOperationsRequest)) returns ([ListNetworkLoadBalancerOperationsResponse](#ListNetworkLoadBalancerOperationsResponse))**

### ListNetworkLoadBalancerOperationsRequest {#ListNetworkLoadBalancerOperationsRequest}

Поле | Описание
--- | ---
network_load_balancer_id | **string**<br>Обязательное поле. Идентификатор ресурса NetworkLoadBalancer, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис в ответе вернет значение [ListNetworkLoadBalancerOperationsResponse.next_page_token](#ListNetworkLoadBalancerOperationsResponse), которое можно использовать для получения остальных результатов. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNetworkLoadBalancerOperationsResponse.next_page_token](#ListNetworkLoadBalancerOperationsResponse), прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListNetworkLoadBalancerOperationsResponse {#ListNetworkLoadBalancerOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>Список операций для указанного балансировщика. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNetworkLoadBalancerOperationsRequest.page_size](#ListNetworkLoadBalancerOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListNetworkLoadBalancerOperationsRequest.page_token](#ListNetworkLoadBalancerOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


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


