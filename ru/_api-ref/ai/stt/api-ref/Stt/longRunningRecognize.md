---
editable: false
---

# Метод longRunningRecognize

 

 
## HTTP-запрос {#https-request}
```
POST https://stt.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize
```
 
## Параметры в теле запроса {#body_params}
 
```json 
{
  "config": {
    "specification": {
      "audioEncoding": "string",
      "sampleRateHertz": "string",
      "languageCode": "string",
      "profanityFilter": true,
      "model": "string",
      "partialResults": true,
      "singleUtterance": true,
      "audioChannelCount": "string",
      "rawResults": true
    },
    "folderId": "string"
  },
  "audio": {

    // `audio` включает только одно из полей `content`, `uri`
    "content": "string",
    "uri": "string",
    // конец списка возможных полей`audio`

  }
}
```

 
Поле | Описание
--- | ---
config | **object**<br>
config.<br>specification | **object**<br>
config.<br>specification.<br>audioEncoding | **string**<br><ul> <li>LINEAR16_PCM: 16-bit signed little-endian (Linear PCM)</li> </ul> 
config.<br>specification.<br>sampleRateHertz | **string** (int64)<br><p>8000, 16000, 48000 только для pcm</p> 
config.<br>specification.<br>languageCode | **string**<br><p>код в формате BCP-47</p> 
config.<br>specification.<br>profanityFilter | **boolean** (boolean)<br>
config.<br>specification.<br>model | **string**<br>
config.<br>specification.<br>partialResults | **boolean** (boolean)<br><p>Если установлено значение true, предварительные гипотезы могут быть возвращены по мере их появления (final=false flag). Если false или опущено, возвращаются только final=true result (s). Имеет смысл только для запросов StreamingRecognize.</p> 
config.<br>specification.<br>singleUtterance | **boolean** (boolean)<br>
config.<br>specification.<br>audioChannelCount | **string** (int64)<br><p>Используется только для распознавания длинных аудио.</p> 
config.<br>specification.<br>rawResults | **boolean** (boolean)<br><p>Эта отметка позволяет отключить нормализацию текста</p> 
config.<br>folderId | **string**<br>
audio | **object**<br>
audio.<br>content | **string** (byte) <br>`audio` включает только одно из полей `content`, `uri`<br><br>
audio.<br>uri | **string** <br>`audio` включает только одно из полей `content`, `uri`<br><br>
 
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