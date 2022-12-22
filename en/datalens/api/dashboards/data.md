# Chart data API 


#### Endpoint {#endpoint}
`POST https://charts.yandex-team.ru/api/run`

The parameters are passed to the request body as x-www-form-urlencoded or json.

Required parameter.

- `path`: A path to the chart (everything after a trailing slash in the URL, including the parameters that you need: `/editor/resure/metrics-example?scale=d`).

Instead of the `path`, you can pass the `params` hash (for example, `{params: {name: 'resure/auxiliary-series', kind: 'Special'}}`).


#### Example (cURL, using the path string) {#example-curl-string-path}

```bash
curl -X "POST" "https://charts.yandex-team.ru/api/run" \
	-H "Authorization: OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX" \
	-H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
	--data-urlencode "path=/editor/resure/metrics-example"
```


#### Example (cURL, using the params hash) {#example-curl-hash-params}

```bash
curl -X "POST" "https://charts.yandex-team.ru/api/run" \
	-H "Authorization: OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX" \
	-H "Content-Type: application/json; charset=utf-8" \
	-d "{\"params\":{\"name\":\"resure/metrics-example\"}}"
```


#### Example (Python, using the path string) {#example-python-string-path}

```python
import requests

def fetch_editor_data():
    try:
        response = requests.post(
            url="https://charts.yandex-team.ru/api/run",
            headers={
                "Authorization": "OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX",
                "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
            },
            data={
                "path": "/editor/resure/metrics-example",
            },
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')


fetch_editor_data()
```


#### Example (Python, using the params hash) {#example-python-hash-params}

```python
import requests
import json

def fetch_editor_data():
    try:
        response = requests.post(
            url="https://charts.yandex-team.ru/api/run",
            headers={
                "Authorization": "OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX",
                "Content-Type": "application/json; charset=utf-8",
            },
            data=json.dumps({
                "params": {
                    "name": "resure/metrics-example"
                }
            })
        )
        print('Response HTTP Status Code: {status_code}'.format(
            status_code=response.status_code))
        print('Response HTTP Response Body: {content}'.format(
            content=response.content))
    except requests.exceptions.RequestException:
        print('HTTP Request failed')


fetch_editor_data()
```
