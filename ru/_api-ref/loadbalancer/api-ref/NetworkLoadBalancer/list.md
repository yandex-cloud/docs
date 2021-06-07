---
editable: false
---

# Метод list
Возвращает список доступных ресурсов NetworkLoadBalancer в указанном каталоге.
 

 
## HTTP-запрос {#https-request}
```
GET https://load-balancer.api.cloud.yandex.net/load-balancer/v1/networkLoadBalancers
```
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
folderId | Обязательное поле. Идентификатор каталога, которому принадлежит балансировщик. Чтобы получить идентификатор каталога, используйте запрос [list](/docs/load-balancer/api-ref/NetworkLoadBalancer/list).  Максимальная длина строки в символах — 50.
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/load-balancer/api-ref/NetworkLoadBalancer/list#query_params), сервис вернет значение [nextPageToken](/docs/load-balancer/api-ref/NetworkLoadBalancer/list#responses), которое можно использовать для получения следующей страницы.  Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/load-balancer/api-ref/NetworkLoadBalancer/list#query_params) равным значению поля [nextPageToken](/docs/load-balancer/api-ref/NetworkLoadBalancer/list#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации ресурсов в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [NetworkLoadBalancer.name](/docs/load-balancer/api-ref/NetworkLoadBalancer#representation). 2. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9].`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "networkLoadBalancers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "regionId": "string",
      "status": "string",
      "type": "string",
      "sessionAffinity": "string",
      "listeners": [
        {
          "name": "string",
          "address": "string",
          "port": "string",
          "protocol": "string"
        }
      ],
      "attachedTargetGroups": [
        {
          "targetGroupId": "string",
          "healthChecks": [
            {
              "name": "string",
              "interval": "string",
              "timeout": "string",
              "unhealthyThreshold": "string",
              "healthyThreshold": "string",

              // `networkLoadBalancers[].attachedTargetGroups[].healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`
              "tcpOptions": {
                "port": "string"
              },
              "httpOptions": {
                "port": "string",
                "path": "string"
              },
              // конец списка возможных полей`networkLoadBalancers[].attachedTargetGroups[].healthChecks[]`

            }
          ]
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
networkLoadBalancers[] | **object**<br><p>Ресурс NetworkLoadBalancer. Подробнее см. в разделе <a href="/docs/load-balancer/concepts">Сетевой балансировщик нагрузки</a>.</p> 
networkLoadBalancers[].<br>id | **string**<br><p>Идентификатор балансировщика.</p> 
networkLoadBalancers[].<br>folderId | **string**<br><p>Идентификатор каталога, которому принадлежит балансировщик.</p> 
networkLoadBalancers[].<br>createdAt | **string** (date-time)<br><p>Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
networkLoadBalancers[].<br>name | **string**<br><p>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
networkLoadBalancers[].<br>description | **string**<br><p>Описание балансировщика. Длина 0-256 символов.</p> 
networkLoadBalancers[].<br>labels | **object**<br><p>Метки ресурса в формате ``key:value``. Максимум 64 метки на ресурс.</p> 
networkLoadBalancers[].<br>regionId | **string**<br><p>Идентификатор каталога, которому принадлежит балансировщик.</p> 
networkLoadBalancers[].<br>status | **string**<br><p>Состояние балансировщика.</p> <ul> <li>CREATING: Балансировщик создается.</li> <li>STARTING: Балансировщик запускается.</li> <li>ACTIVE: Балансировщик активен и передает трафик целевым ресурсам.</li> <li>STOPPING: Балансировщик остановлен.</li> <li>STOPPED: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li> <li>DELETING: Балансировщик удаляется.</li> <li>INACTIVE: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li> </ul> 
networkLoadBalancers[].<br>type | **string**<br><p>Тип балансировщика. В настоящее время доступны только внешние балансировщики.</p> <p>Тип балансировщика нагрузки. В настоящее время доступны только внешние балансировщики.</p> <ul> <li>EXTERNAL: Внешний балансировщик.</li> </ul> 
networkLoadBalancers[].<br>sessionAffinity | **string**<br><p>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple.</p> <p>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. Подробнее см. в разделе <a href="/docs/load-balancer/concepts/">Основные понятия</a>.</p> <ul> <li>CLIENT_IP_PORT_PROTO: Адресация 5-tuple.</li> </ul> 
networkLoadBalancers[].<br>listeners[] | **object**<br><p>Ресурс Listener. Дополнительные сведения см. в разделе <a href="/docs/load-balancer/concepts/listener">Обработчик</a></p> 
networkLoadBalancers[].<br>listeners[].<br>name | **string**<br><p>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов.</p> 
networkLoadBalancers[].<br>listeners[].<br>address | **string**<br><p>IP-адрес для обработчика.</p> 
networkLoadBalancers[].<br>listeners[].<br>port | **string** (int64)<br><p>Порт.</p> 
networkLoadBalancers[].<br>listeners[].<br>protocol | **string**<br><p>Сетевой протокол для входящего трафика.</p> <p>Сетевой протокол для использования при проверке.</p> <ul> <li>TCP: Протокол TCP.</li> </ul> 
networkLoadBalancers[].<br>attachedTargetGroups[] | **object**<br><p>Ресурс AttachedTargetGroup. Дополнительные сведения см. в разделе <a href="/docs/load-balancer/concepts/target-resources">Целевые группы и ресурсы</a></p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>targetGroupId | **string**<br><p>Обязательное поле. Идентификатор целевой группы.</p> <p>Максимальная длина строки в символах — 50.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[] | **object**<br><p>Ресурс HealthCheck. Подробнее см. в разделе <a href="/docs/load-balancer/concepts/health-check">Проверка состояния</a>.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>name | **string**<br><p>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>interval | **string**<br><p>Интервал между проверками работоспособности. Формат значения: ``Ns``, где N — количество секунд. Значение по умолчанию — 2 секунды.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>timeout | **string**<br><p>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: ``Ns``, где N — количество секунд Значение по умолчанию — 1 секунда.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на ``UNHEALTHY``. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>healthyThreshold | **string** (int64)<br><p>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса ``HEALTHY``. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions | **object**<br>Протокол TCP. <br>`networkLoadBalancers[].attachedTargetGroups[].healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br><p>Конфигурация проверки состояния по протоколу TCP.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Настройки для проверок состояния по протоколу TCP.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>httpOptions | **object**<br>Протокол HTTP. <br>`networkLoadBalancers[].attachedTargetGroups[].healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br><p>Конфигурация проверки состояния по протоколу HTTP.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>port | **string** (int64)<br><p>Настройки для проверок состояния по протоколу HTTP.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
networkLoadBalancers[].<br>attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>path | **string**<br><p>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например ``/ping``. Путь по умолчанию — ``/``.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/load-balancer/api-ref/NetworkLoadBalancer/list#query_params">pageSize</a>, используйте <a href="/docs/load-balancer/api-ref/NetworkLoadBalancer/list#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/load-balancer/api-ref/NetworkLoadBalancer/list#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/load-balancer/api-ref/NetworkLoadBalancer/list#responses">nextPageToken</a>, для перебора страниц результатов.</p> 