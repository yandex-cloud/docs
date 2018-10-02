# Быстрый старт

Чтобы распознать русскую речь с помощью SpeechKit API, отправьте небольшой аудиофрагмент, например [speech.ogg](https://download.cdn.yandex.net/from/yandex.ru/tech/ru/speechkit/cloud/doc/guide/files/speech.ogg), с помощью POST-запроса.

---

**[!TAB POST-запрос]**

```httpget
POST /speech/v1/stt:recognize/?topic=general&folderid=<folder id> HTTP/1.1
Host: stt.api.cloud.yandex.net
Authorization: Bearer <IAM-token>
  
... (двоичное содержимое аудиофайла)
```

**[!TAB cURL]**

```httpget
$ curl -LO https://download.cdn.yandex.net/from/yandex.ru/tech/ru/speechkit/cloud/doc/guide/files/speech.ogg
  
$ curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderid=<folder id>"
```

--- 

Подробнее о параметрах запроса читайте в разделе [[!TITLE]](request.md).

## Результат запроса

Тело ответа содержит результат в формате JSON. 

```
HTTP/1.1 200 OK
YaCloud-Request-Id: YYXXYYXXYY-YXXY-YXXY-YXXY-YYXXYYXXYY
YaCloud-Billing-Units: 15

{
  "result": "твой номер 212-85-06"
}
```
