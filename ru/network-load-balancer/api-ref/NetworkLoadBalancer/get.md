---
editable: false
---

# Метод get
Возвращает указанный ресурс NetworkLoadBalancer.
 
Чтобы получить список доступных ресурсов NetworkLoadBalancer, используйте запрос [list](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list).
 
## HTTP-запрос {#https-request}
```
GET https://load-balancer.api.cloud.yandex.net/network-load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
networkLoadBalancerId | Идентификатор возвращаемого ресурса NetworkLoadBalancer.  Чтобы получить идентификатор балансировщика, используйте запрос [list](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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

          // `attachedTargetGroups[].healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`
          "tcpOptions": {
            "port": "string"
          },
          "httpOptions": {
            "port": "string",
            "path": "string"
          },
          // конец списка возможных полей`attachedTargetGroups[].healthChecks[]`

        }
      ]
    }
  ]
}
```
Ресурс NetworkLoadBalancer. Подробнее см. в разделе [Сетевой балансировщик нагрузки](/docs/network-load-balancer/concepts).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор балансировщика.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит балансировщик.</p> 
createdAt | **string** (date-time)<br><p>Время создания ресурса в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя балансировщика. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> 
description | **string**<br><p>Описание балансировщика. Длина 0-256 символов.</p> 
labels | **object**<br><p>Метки ресурса в формате `` key:value ``. Максимум 64 метки на ресурс.</p> 
regionId | **string**<br><p>Идентификатор каталога, которому принадлежит балансировщик.</p> 
status | **string**<br><p>Состояние балансировщика.</p> <ul> <li>CREATING: Балансировщик создается.</li> <li>STARTING: Балансировщик запускается.</li> <li>ACTIVE: Балансировщик активен и передает трафик целевым ресурсам.</li> <li>STOPPING: Балансировщик остановлен.</li> <li>STOPPED: Балансировщик остановлен и не отправляет трафик целевым ресурсам.</li> <li>DELETING: Балансировщик удаляется.</li> <li>INACTIVE: У балансировщика нет обработчиков или целевых групп, или подключенные целевые группы пусты. Балансировщик не выполняет никаких проверок состояния и не передает трафик в этом состоянии.</li> </ul> 
type | **string**<br><p>Тип балансировщика. В настоящее время доступны только внешние балансировщики.</p> <p>Тип балансировщика нагрузки. В настоящее время доступны только внешние балансировщики.</p> <ul> <li>EXTERNAL: Внешний балансировщик.</li> </ul> 
sessionAffinity | **string**<br><p>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple.</p> <p>Тип адресации. В настоящее время доступна только адресация по принципу 5-tuple. Подробнее см. в разделе <a href="/docs/network-load-balancer/concepts/">Основные понятия</a>.</p> <ul> <li>CLIENT_IP_PORT_PROTO: Адресация 5-tuple.</li> </ul> 
listeners[] | **object**<br><p>Ресурс Listener. Дополнительные сведения см. в разделе <a href="/docs/network-load-balancer/concepts/listener">Обработчик</a></p> 
listeners[].<br>name | **string**<br><p>Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов.</p> 
listeners[].<br>address | **string**<br><p>IP-адрес для обработчика.</p> 
listeners[].<br>port | **string** (int64)<br><p>Порт.</p> 
listeners[].<br>protocol | **string**<br><p>Сетевой протокол для входящего трафика.</p> <p>Сетевой протокол для использования при проверке.</p> <ul> <li>TCP: Протокол TCP.</li> </ul> 
attachedTargetGroups[] | **object**<br><p>Ресурс AttachedTargetGroup. Дополнительные сведения см. в разделе <a href="/docs/network-load-balancer/concepts/target-resources">Целевые группы и ресурсы</a></p> 
attachedTargetGroups[].<br>targetGroupId | **string**<br><p>Обязательное поле. Идентификатор целевой группы.</p> <p>Максимальная длина строки в символах — 50.</p> 
attachedTargetGroups[].<br>healthChecks[] | **object**<br><p>Ресурс HealthCheck. Подробнее см. в разделе <a href="/docs/network-load-balancer/concepts/health-check">Проверка состояния</a>.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>name | **string**<br><p>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>interval | **string**<br><p>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>timeout | **string**<br><p>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>healthyThreshold | **string** (int64)<br><p>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions | **object**<br>Протокол TCP. <br>`attachedTargetGroups[].healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br><p>Конфигурация проверки состояния по протоколу TCP.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Настройки для проверок состояния по протоколу TCP.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions | **object**<br>Протокол HTTP. <br>`attachedTargetGroups[].healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br><p>Конфигурация проверки состояния по протоколу HTTP.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>port | **string** (int64)<br><p>Настройки для проверок состояния по протоколу HTTP.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
attachedTargetGroups[].<br>healthChecks[].<br>httpOptions.<br>path | **string**<br><p>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``.</p> 