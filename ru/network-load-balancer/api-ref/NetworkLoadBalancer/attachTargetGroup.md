---
editable: false
---

# Метод attachTargetGroup
Подключает целевую группу к указанному балансировщику.
 

 
## HTTP-запрос {#https-request}
```
POST https://load-balancer.api.cloud.yandex.net/network-load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:attachTargetGroup
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
networkLoadBalancerId | Обязательное поле. Идентификатор балансировщика, к которому будет подключена целевая группа.  Чтобы получить идентификатор балансировщика, используйте запрос [list](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "attachedTargetGroup": {
    "targetGroupId": "string",
    "healthChecks": [
      {
        "name": "string",
        "interval": "string",
        "timeout": "string",
        "unhealthyThreshold": "string",
        "healthyThreshold": "string",

        // `attachedTargetGroup.healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`
        "tcpOptions": {
          "port": "string"
        },
        "httpOptions": {
          "port": "string",
          "path": "string"
        },
        // конец списка возможных полей`attachedTargetGroup.healthChecks[]`

      }
    ]
  }
}
```

 
Поле | Описание
--- | ---
attachedTargetGroup | **object**<br><p>Обязательное поле. Идентификатор целевой группы для подключения к балансировщику. Чтобы получить идентификатор балансировщика, используйте запрос <a href="/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list">list</a>.</p> <p>Ресурс AttachedTargetGroup. Дополнительные сведения см. в разделе <a href="/docs/network-load-balancer/concepts/target-resources">Целевые группы и ресурсы</a></p> 
attachedTargetGroup.<br>targetGroupId | **string**<br><p>Обязательное поле. Идентификатор целевой группы.</p> <p>Максимальная длина строки в символах — 50.</p> 
attachedTargetGroup.<br>healthChecks[] | **object**<br><p>Ресурс HealthCheck. Подробнее см. в разделе <a href="/docs/network-load-balancer/concepts/health-check">Проверка состояния</a>.</p> 
attachedTargetGroup.<br>healthChecks[].<br>name | **string**<br><p>Обязательное поле. Название проверки состояния. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов.</p> <p>Значение должно соответствовать регулярному выражению `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
attachedTargetGroup.<br>healthChecks[].<br>interval | **string**<br><p>Интервал между проверками работоспособности. Формат значения: `` Ns ``, где N — количество секунд. Значение по умолчанию — 2 секунды.</p> 
attachedTargetGroup.<br>healthChecks[].<br>timeout | **string**<br><p>Время, за которое целевой ресурс должен ответить на проверку. Формат значения: `` Ns ``, где N — количество секунд Значение по умолчанию — 1 секунда.</p> 
attachedTargetGroup.<br>healthChecks[].<br>unhealthyThreshold | **string** (int64)<br><p>Количество неудачных проверок работоспособности перед изменением состояния целевого ресурса на `` UNHEALTHY ``. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
attachedTargetGroup.<br>healthChecks[].<br>healthyThreshold | **string** (int64)<br><p>Количество успешных проверок состояния, необходимых для установки целевому ресурсу статуса `` HEALTHY ``. Значение по умолчанию — 2.</p> <p>Допустимые значения — от 2 до 10 включительно.</p> 
attachedTargetGroup.<br>healthChecks[].<br>tcpOptions | **object**<br>Протокол TCP. <br>`attachedTargetGroup.healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br><p>Конфигурация проверки состояния по протоколу TCP.</p> 
attachedTargetGroup.<br>healthChecks[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Настройки для проверок состояния по протоколу TCP.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
attachedTargetGroup.<br>healthChecks[].<br>httpOptions | **object**<br>Протокол HTTP. <br>`attachedTargetGroup.healthChecks[]` включает только одно из полей `tcpOptions`, `httpOptions`<br><br><p>Конфигурация проверки состояния по протоколу HTTP.</p> 
attachedTargetGroup.<br>healthChecks[].<br>httpOptions.<br>port | **string** (int64)<br><p>Настройки для проверок состояния по протоколу HTTP.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
attachedTargetGroup.<br>healthChecks[].<br>httpOptions.<br>path | **string**<br><p>URL для отправки запросов проверки состояния, который будет установлен всем ресурсам целевой группы. Например `` /ping ``. Путь по умолчанию — `` / ``.</p> 
 
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
done | **boolean** (boolean)<br><p>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`.</p> 
metadata | **object**<br><p>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`.</p> 
error | **object**<br>Описание ошибки в случае сбоя или отмены операции. <br> включает только одно из полей `error`, `response`<br><br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>Текст ошибки.</p> 
error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
response | **object** <br> включает только одно из полей `error`, `response`<br><br><p>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`.</p> 