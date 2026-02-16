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
