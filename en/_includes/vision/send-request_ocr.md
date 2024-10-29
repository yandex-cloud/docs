{% list tabs group=programming_language %}

Send a request using the [recognize](../../vision/ocr/api-ref/TextRecognition/recognize.md) method and save the response to a file, e.g., `output.json`:

- UNIX {#unix}

  ```bash
  export IAM_TOKEN=<IAM_token>
  curl -X POST \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -H "x-folder-id: <folder_ID>" \
      -H "x-data-logging-enabled: true" \
      -d "@body.json" \
      https://ocr.{{ api-host }}/ocr/v1/recognizeText \
      -o output.json
  ```

  Where:

  * `<IAM_token>`: Previously obtained IAM token.
  * `<folder_ID>`: Previously obtained folder ID.

- Python {#python}

  ```python
  data = {"mimeType": <mime_type>,
          "languageCodes": ["*"],
          "content": content}

  url = "https://ocr.api.cloud.yandex.net/ocr/v1/recognizeText"

  headers= {"Content-Type": "application/json",
            "Authorization": "Bearer {:s}".format(<IAM_token>),
            "x-folder-id": "<folder_ID>",
            "x-data-logging-enabled": "true"}

    w = requests.post(url=url, headers=headers, data=json.dumps(data))
  ```

{% endlist %}
