# Quick start

To use the SpeechKit API for speech recognition in Russian, send a small audio fragment (for example, [speech.ogg](https://download.cdn.yandex.net/from/yandex.ru/tech/ru/speechkit/cloud/doc/guide/files/speech.ogg)) via a POST request.

---

**[!TAB POST request]**

```httpget
POST /speech/v1/stt:recognize/?topic=general&folderId=<folder id> HTTP/1.1
Host: stt.api.cloud.yandex.net
Authorization: Bearer <IAM-token>
  
... (binary content of an audio file)
```

**[!TAB cURL]**

```httpget
$ curl -LO https://download.cdn.yandex.net/from/yandex.ru/tech/ru/speechkit/cloud/doc/guide/files/speech.ogg
  
$ curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderId=<folder id>"
```

--- 

For more information about request parameters, see [[!TITLE]](request.md).

## Request result {#response}

The response body contains the result in JSON format.

```
HTTP/1.1 200 OK
YaCloud-Request-Id: YYXXYYXXYY-YXXY-YXXY-YXXY-YYXXYYXXYY
YaCloud-Billing-Units: 1

{
  "result": "твой номер 212-85-06"
}
```

