# Описание метода API

Преобразует речь из переданного аудиофайла в текст.

> [!WARNING]
>
> 1. Технология распознавания речи работает с аудиофайлами размером не более 1Мб и длительностью не более 1 минуты.
> 1. Для аудиофайлов следует использовать аудиокодек OPUS и контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).
>

## Запрос

```
POST https://stt.api.cloud.yandex.net/speech/v1/stt:recognize
```

### Query параметры

Параметр | Описание
----- | -----
`topic` | [Языковая модель](../stt/index.md#model), которую следует использовать при распознавании.<br/>Чем точнее выбрана модель, тем лучше результат распознавания. В одном запросе можно указать только одну модель.<br/>Значение параметра по умолчанию: `general`.
`lang` | Язык, для которого будет выполнено распознавание.<br/>Допустимые значения:<ul><li>`ru-RU` — русский язык,</li><li>`en-US` — английский язык.</li></ul>Значение параметра по умолчанию: `ru-RU`.<br/>Допустимые значения параметра `topic` для различных значений `lang` приведены в разделе [[!TITLE]](../stt/index.md#model).
`disableAntimat` | Параметр, указывающий, что нужно отключить антимат — фильтр ненормативной лексики в распознанной речи.<br>Допустимые значения:<ul><li>`true` — ненормативная лексика не будет исключена из результатов распознавания;</li><li>`false` — ненормативная лексика будет исключена из результатов распознавания.</li></ul>Значение параметра по умолчанию: `false`.
`folderid` | Обязательный параметр.<br/>Идентификатор вашего каталога.<br/>Для этого метода API `folderid` передается в Query параметрах, а не в теле запроса.<br/>Подробнее о том, как узнать идентификатор каталога читайте в разделе [Авторизация в API](../concepts/auth.md).

### Параметры в теле запроса

В теле необходимо передать двоичное содержимое аудиофайла.

## Ответ

Ответ содержит гипотезу распознавания.

Гипотеза распознавания — это предположение системы распознавания о том, что было произнесено.

Распознанный текст обрабатывается перед отправкой — числительные преобразуются в цифры, расставляются некоторые знаки препинания (например, дефисы) и т. д. Этот преобразованный текст и является финальным результатом распознавания, который отправляется в теле ответа.

Ответ возвращается в формате JSON.

```json
{
  "result": <гипотеза распознавания>
}  
```


## Примеры {#request-example}

### Пример запроса

---

**[!TAB POST-запрос]**

```httpget
POST /speech/v1/stt:recognize/?topic=general&lang=ru-RU&folderid=<folder id> HTTP/1.1
Host: stt.api.cloud.yandex.net
Authorization: Bearer <IAM-token>
  
... (двоичное содержимое аудиофайла)
```

**[!TAB cURL]**

```httpget
curl -X POST \
     -H "Authorization: Bearer <IAM-token>" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderid=<folder id>"
```

**[!TAB Python]**

```python
import urllib.request
import json
with open("speech.ogg", "rb") as f:
    data = f.read()
url = urllib.request.Request("https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderid=<folder id>", data=data)
url.add_header("Authorization", "Bearer <IAM-token>")
responseData = urllib.request.urlopen(url).read().decode('UTF-8')
decodedData = json.loads(responseData)
if decodedData.get("error_code") is None:
    print(decodedData.get("result"))
```

---

### Пример ответа

```
HTTP/1.1 200 OK
YaCloud-Request-Id: YYXXYYXXYY-YXXY-YXXY-YXXY-YYXXYYXXYY
YaCloud-Billing-Units: 15
{
  "result": "твой номер 212-85-06"
}        
```

[!INCLUDE [request-id-note](../_includes/request-id-note.md)]
