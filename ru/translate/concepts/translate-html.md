# Перевод специальных символов и HTML-разметки

API {{ translate-name }} возвращает тело ответа в формате JSON. Поэтому при переводе текста, который содержит HTML-разметку и другие специальные символы, некоторые из этих символов могут быть конвертированы в [юникод](https://datatracker.ietf.org/doc/html/rfc7159#section-7). Например, чтобы кавычка (`"`) не означала конец текста, она заменяется на последовательность из шести символов — `\u0022`.

Если отправить модели следующий запрос:

```json
{
    "targetLanguageCode": "en",
    "format": "HTML",
    "texts": ["<b>Дорогие коллеги!</b> Поздравляю вас с праздником!"]
}
```

В ответе вернется результат с конвертированными символами:

```json
{
  "translations": [
    {
      "text": "\u003cb\u003eDear colleagues!\u003c/b\u003e I wish you a happy holiday!",
      "detectedLanguageCode": "ru"
    }
  ]
}
```

Чтобы получить текст с нужной разметкой, файл JSON необходимо преобразовать с помощью функции нужного языка или любого другого специализированного инструмента. Пример такого преобразования на языке Python с помощью библиотеки `requests`:

```python
import requests

IAM_TOKEN = '<IAM-токен>'
folder_id = '<идентификатор_каталога>'
target_language = 'en'
texts = ["<b>Дорогие коллеги!</b> Поздравляю вас с праздником!"]

body = {
    "targetLanguageCode": target_language,
    "texts": texts,
    "folderId": folder_id,
}

headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer {0}".format(IAM_TOKEN)
}

response = requests.post('https://translate.api.cloud.yandex.net/translate/v2/translate',
    json = body,
    headers = headers
)

body_dict = response.json()
print(body_dict['translations'])
```

Результат:

```txt
[{'text': '<b>Dear colleagues!</b> I wish you a happy holiday!', 'detectedLanguageCode': 'ru'}]
```
