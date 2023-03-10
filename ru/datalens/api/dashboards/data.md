# API данных чартов


#### Endpoint {#endpoint}
`POST https://charts.yandex-team.ru/api/run`

Параметры передаются в body запроса как x-www-form-urlencoded, либо как json.

Обязательный параметр:

- `id` — идентификатор чарта.

Параметры самого чарта можно передать с помощью хэша `params` (например, `"params": {"kind": "Special"}`).


#### Пример (cURL) {#example-curl-hash-params}

```bash
curl -X "POST" "https://charts.yandex-team.ru/api/run" \
    -H "Authorization: OAuth QAD-qJSJyANAAAKs7tk1fuH1kIdr1H5k_ccXXX" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d '{"id": "or8itzcgkclce", "params": {}}'
```


#### Пример (Python) {#example-python-hash-params}

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
                "id": "or8itzcgkclce",
                "params": {}
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
