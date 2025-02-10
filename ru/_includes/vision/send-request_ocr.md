{% list tabs group=programming_language %}

Отправьте запрос с помощью метода [recognize](../../vision/ocr/api-ref/TextRecognition/recognize.md) и сохраните ответ в файл, например `output.json`:

- UNIX {#unix}

  ```bash
  export IAM_TOKEN=<IAM-токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --header "x-folder-id: <идентификатор_каталога>" \
    --header "x-data-logging-enabled: true" \
    --data '{
      "mimeType": "JPEG",
      "languageCodes": ["ru","en"],
      "model": "handwritten",
      "content": "<изображение_в_кодировке_base64>"
    }' \
    https://ocr.{{ api-host }}/ocr/v1/recognizeText \
    --output output.json
  ```

  Где:

  * `<IAM-токен>` — полученный ранее IAM-токен.
  * `<идентификатор_каталога>` — полученный ранее идентификатор каталога.

- Python {#python}

  ```python
  data = {"mimeType": <mime_type>,
          "languageCodes": ["ru","en"],
          "content": content}

  url = "https://ocr.api.cloud.yandex.net/ocr/v1/recognizeText"

  headers= {"Content-Type": "application/json",
            "Authorization": "Bearer {:s}".format(<IAM-токен>),
            "x-folder-id": "<идентификатор_каталога>",
            "x-data-logging-enabled": "true"}
    
    w = requests.post(url=url, headers=headers, data=json.dumps(data))
  ```

{% endlist %}
