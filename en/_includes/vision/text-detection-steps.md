1. Encode the file as Base64:

    {% include [base64-encode-command](base64-encode-command.md) %}

1. Create a file with the request body, e.g., `body.json`. In the `content` property, specify the image file contents [encoded](../../vision/operations/base64-encode.md) as Base64.

    For the service to automatically detect the text language, specify the `"language_codes": ["*"]` property in the configuration.

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

    The response will consist of recognized blocks of text, lines, and words with their position on the image indicated:

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

1. To get all the recognized words from the image, find all the lines with the `text` property, e.g., using the [grep](https://www.gnu.org/software/grep/) utility:

   {% list tabs group=programming_language %}

   - Bash {#bash}

      ```bash
      grep -o "\"text\":\s\".*\"" output.json
      ```

      Result:

      ```text
      "text": "PENGUINS"
      "text": "CROSSING"
      "text": "SLOW"
      ```

   - CMD {#cmd}

      ```bash
      findstr text output.json
      ```

      Result:

      ```text
      "text": "PENGUINS"
      "text": "CROSSING"
      "text": "SLOW"
      ```

   - PowerShell {#powershell}

      ```powershell
      Select-String -Pattern '\"text\":\s\".*\"' -Path .\output.json
      ```

      Result:

      ```text
      output.json:1:      "text": "PENGUINS"
      output.json:2:      "text": "CROSSING"
      output.json:3:      "text": "SLOW"
      ```

   {% endlist %}