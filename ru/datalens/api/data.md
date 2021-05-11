# API данных чартов


#### Endpoint {#endpoint}
`POST https://charts.yandex-team.ru/api/run`

Параметры передаются в body запроса как x-www-form-urlencoded, либо как json.

Обязательный параметр:

- `path` — путь до графика (все после слэша в урле, включая нужные вам параметры, например, `/editor/resure/metrics-example?scale=d`).

Вместо `path` можно передать хэш `params` (например, `{params: {name: 'resure/auxiliary-series', kind: 'Special'}}`).


#### Пример (cURL, используя строку path) {#example-curl-string-path}

```bash
curl -X "POST" "https://charts.yandex-team.ru/api/run" \
	-H "Authorization: OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX" \
	-H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
	--data-urlencode "path=/editor/resure/metrics-example"
```


#### Пример (cURL, используя хэш params) {#example-curl-hash-params}

```bash
curl -X "POST" "https://charts.yandex-team.ru/api/run" \
	-H "Authorization: OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX" \
	-H "Content-Type: application/json; charset=utf-8" \
	-d "{\"params\":{\"name\":\"resure/metrics-example\"}}"
```


#### Пример (Python, используя строку path) {#example-python-string-path}

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


#### Пример (Python, используя хэш params) {#example-python-hash-params}

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
