# Translation of special characters and HTML markup

The {{ translate-name }} API returns the response body in JSON format. Therefore, when translating text that contains HTML markup and other special characters, some of these characters may be converted to [Unicode](https://datatracker.ietf.org/doc/html/rfc7159#section-7). For example, to prevent the double quote (`"`) from marking the end of the text, it is replaced with the six-character sequence: `\u0022`.

If you send the following request to the model:

```json
{
    "targetLanguageCode": "en",
    "format": "HTML",
    "texts": ["<b>Дорогие коллеги!</b> Поздравляю вас с праздником!"]
}
```

The response will return with the converted characters:

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

To get the text with the markup you need, convert the JSON file using a function in the relevant language or any other specialized tool. Here is an example of such a conversion in Python using the `requests` library:

```python
import requests

IAM_TOKEN = '<IAM_token>'
folder_id = '<folder_ID>'
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

Result:

```txt
[{'text': '<b>Dear colleagues!</b> I wish you a happy holiday!', 'detectedLanguageCode': 'ru'}]
```
