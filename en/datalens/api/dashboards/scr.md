# Charts screenshot API

#### Endpoint {#endpoint}
`POST https://charts.yandex-team.ru/api/scr/v1/screenshots`

Screenshot parameters are passed to the request body as x-www-form-urlencoded.

Required parameter.

- `path` is a path to the chart (everything following a slash in the URL, for example, `/preview/wizard/resure/auxiliary-series`).

   **Be sure** to add to the path the **parameter** `_embedded=1` and (if needed) `_no_controls=1` (for example, `/preview/wizard/resure/auxiliary-series?_embedded=1&_no_controls=1`).

   When running cURL, make sure to **encode the path** first (for example, `%2Fpreview%2Fwizard%2Fresure%2Fauxiliary-series%3F_embedded%3D1%26_no_controls%3D1`).

Optional parameters.

- `width`: The width of the image in pixels
- `height`: The height of the image in pixels
- `base64`: if "1", the handle will return a base640-encoded image
- `type`: To create screenshots of tables, be sure to set this parameter in "table".


#### Example (cURL) {#example-curl}

`curl -X POST -H "Authorization: OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d 'path=%2Fpreview%2Fwizard%2Fresure%2Fauxiliary-series%3F_embedded%3D1%26_no_controls%3D1'
    "https://charts.yandex-team.ru/api/scr/v1/screenshots"`


#### Example (Python) {#example-python}

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
