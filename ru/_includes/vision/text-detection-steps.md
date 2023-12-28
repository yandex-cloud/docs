1. Кодируйте файл в формат Base64:

    {% include [base64-encode-command](base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`. В свойстве `content` укажите содержимое файла, полученное при [переводе](../../vision/operations/base64-encode.md) изображения в формат Base64.

    Чтобы сервис автоматически определил язык текста, укажите в конфигурации свойство `"language_codes": ["*"]`.

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "TEXT_DETECTION",
                "text_detection_config": {
                    "language_codes": ["*"]
                }
            }]
        }]
    }
    ```

1. {% include [send-request](send-request.md) %}

    Ответ будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на изображении:

    ```json
    {
      "results": [{
        "results": [{
          "textDetection": {
            "pages": [{
              "blocks": [{
                "boundingBox": { ... },
                "lines": [{
                    "boundingBox": { ... },
                    "words": [{
                      "boundingBox": {
                        "vertices": [{
                            "x": "504",
                            "y": "760"
                          },
                          {
                            "x": "504",
                            "y": "836"
                          },
                          {
                            "x": "826",
                            "y": "836"
                          },
                          {
                            "x": "826",
                            "y": "760"
                          }
                        ]
                      },
                      "languages": [{
                        "languageCode": "en",
                        "confidence": 0.9520227313
                      }],
                      "text": "PENGUINS",
                      "confidence": 0.9520227313
                    }],
                    "confidence": 0.9520227313
                  },
                  ...
                ]
              }],
              "width": "1920",
              "height": "1280"
            }]
          }
        }]
      }]
    }
    ```

1. Чтобы получить все распознанные на изображении слова, найдите все строки со свойством `text`, например с помощью [grep](https://www.gnu.org/software/grep/):

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      grep -o "\"text\":\s\".*\"" output.json
      ```

      Результат:

      ```text
      "text": "PENGUINS"
      "text": "CROSSING"
      "text": "SLOW"
      ```

    - CMD {#cmd}

      ```bash
      findstr text output.json
      ```

      Результат:

      ```text
      "text": "PENGUINS"
      "text": "CROSSING"
      "text": "SLOW"
      ```

    - PowerShell {#powershell}

      ```powershell
      Select-String -Pattern '\"text\":\s\".*\"' -Path .\output.json
      ```

      Результат:

      ```text
      output.json:1:      "text": "PENGUINS"
      output.json:2:      "text": "CROSSING"
      output.json:3:      "text": "SLOW"
      ```

    {% endlist %}