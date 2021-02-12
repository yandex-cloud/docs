---
editable: false
---

# Метод getTargetStates
Возвращает состояния целевых ресурсов в подключенной целевой группе.
 

 
## HTTP-запрос {#https-request}
```
GET https://load-balancer.api.cloud.yandex.net/network-load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:getTargetStates
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
networkLoadBalancerId | Идентификатор ресурса NetworkLoadBalancer с присоединенной целевой группой.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
targetGroupId | Идентификатор целевой группы для получения состояний ресурсов.  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "targetStates": [
    {
      "subnetId": "string",
      "address": "string",
      "status": "string"
    }
  ]
}
```

 
Поле | Описание
--- | ---
targetStates[] | **object**<br><p>Состояние целевого ресурса по результатам последней проверки.</p> 
targetStates[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой подключен целевой ресурс.</p> 
targetStates[].<br>address | **string**<br><p>IP-адрес целевого ресурса.</p> 
targetStates[].<br>status | **string**<br><p>Состояние целевого ресурса.</p> <p>Состояние целевого ресурса.</p> <ul> <li>INITIAL: Балансировщик настраивает проверку состояния для этого целевого ресурса.</li> <li>HEALTHY: Проверка состояния пройдена и целевой ресурс готов принимать трафик.</li> <li>UNHEALTHY: Проверка состояния не пройдена и целевой ресурс не принимает трафик.</li> <li>DRAINING: Целевой ресурс удаляется и балансировщик больше не передает трафик этому ресурсу.</li> <li>INACTIVE: Балансировщик остановлен и не выполняет проверки состояния для этого целевого ресурса или ресурс подключен к балансировщику без обработчика.</li> </ul> 