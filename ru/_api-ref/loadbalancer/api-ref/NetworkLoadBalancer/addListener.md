---
editable: false
---

# Метод addListener
Добавляет обработчик в указанный балансировщик.
 

 
## HTTP-запрос {#https-request}
```
POST https://load-balancer.api.cloud.yandex.net/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:addListener
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
networkLoadBalancerId | Обязательное поле. Идентификатор балансировщика, к которому будет добавлен обработчик.  Чтобы получить идентификатор балансировщика, используйте запрос [list](/docs/load-balancer/api-ref/NetworkLoadBalancer/list).  Максимальная длина строки в символах — 50.
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "listenerSpec": {
    "name": "string",
    "port": "string",
    "protocol": "string",
    "targetPort": "string",
    "externalAddressSpec": {
      "address": "string",
      "ipVersion": "string"
    }
  }
}
```

 
Поле | Описание
--- | ---
listenerSpec | **object**<br><p>Обязательное поле. Спецификация обработчика.</p> <p>Спецификация обработчика, которая будет использоваться балансировщиком.</p> 
listenerSpec.<br>name | **string**<br><p>Обязательное поле. Имя обработчика. У обработчиков одного балансировщика должны быть уникальные имена. Длина 3-63 символов.</p> <p>Значение должно соответствовать регулярному выражению ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
listenerSpec.<br>port | **string** (int64)<br><p>Порт для входящего трафика.</p> <p>Допустимые значения — от 1 до 32767 включительно.</p> 
listenerSpec.<br>protocol | **string**<br>Обязательное поле. Сетевой протокол для входящего трафика.<br><p>Сетевой протокол для использования при проверке.</p> <ul> <li>TCP: Протокол TCP.</li> </ul> 
listenerSpec.<br>targetPort | **string** (int64)<br><p>Порты целевых ресурсов для входящего трафика. Допустимые значения — от 1 до 32767 включительно.</p> 
listenerSpec.<br>externalAddressSpec | **object**<br>Спецификация внешнего IP-адреса.<br><p>Спецификация внешнего адреса для ``ListenerSpec``.</p> 
listenerSpec.<br>externalAddressSpec.<br>address | **string**<br><p>Публичный IP-адрес для обработчика. Если адрес передается в методе <a href="/docs/load-balancer/api-ref/NetworkLoadBalancer/update">update</a>, он заменит существующий адрес обработчика.</p> 
listenerSpec.<br>externalAddressSpec.<br>ipVersion | **string**<br><p>Версия IP-адреса.</p> <p>Версия IP-адресов, с которыми работает балансировщик нагрузки. В настоящее время доступны только адреса IPv4.</p> <ul> <li>IPV4: Протокол IPv4.</li> <li>IPV6: Протокол IPv6.</li> </ul> 
 
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