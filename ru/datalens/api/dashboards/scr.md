# API скриншотов чартов

#### Endpoint {#endpoint}
`POST https://charts.yandex-team.ru/api/scr/v1/screenshots`

Параметры скриншотов передаются в body запроса как x-www-form-urlencoded.

Обязательный параметр:

- `path` — путь до графика (все после слэша в урле, например, `/preview/wizard/resure/auxiliary-series`).

  **Обязательно** добавляйте к пути **параметр** `_embedded=1` и по желанию `_no_controls=1` (например, `/preview/wizard/resure/auxiliary-series?_embedded=1&_no_controls=1`).

  При использовании cURL, не забывайте предварительно **заэкодить путь** (например, `%2Fpreview%2Fwizard%2Fresure%2Fauxiliary-series%3F_embedded%3D1%26_no_controls%3D1`).

Опциональные параметры:

- `width` — ширина изображения в пикселях
- `height` — высота изображения в пикселях
- `base64` — если "1", то ручка вернет изображение, закодированное в base64
- `type` — если вам нужно делать скриншоты таблиц, этот параметр нужно задать в "table"


#### Пример (cURL) {#example-curl}

`curl -X POST -H "Authorization: OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d 'path=%2Fpreview%2Fwizard%2Fresure%2Fauxiliary-series%3F_embedded%3D1%26_no_controls%3D1'
    "https://charts.yandex-team.ru/api/scr/v1/screenshots"`


#### Пример (Python) {#example-python}

```python
import requests
import shutil
from urllib import urlencode

url = "https://charts.yandex-team.ru/api/scr/v1/screenshots"
params = {
    'path': '/preview/wizard/resure/auxiliary-series?_embedded=1&_no_controls=1',
    'width': 647,
    'height': 640,
}
payload = urlencode(params)
headers = {
    'authorization': "OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX",
    'content-type': "application/x-www-form-urlencoded"
}

response = requests.request("POST", url, data=payload, headers=headers, stream=True)
with open('scr.png', 'wb') as out_file:
	shutil.copyfileobj(response.raw, out_file)
```
