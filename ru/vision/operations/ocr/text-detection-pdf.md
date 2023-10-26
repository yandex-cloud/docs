# Распознавание текста из PDF-файла

Чтобы [распознать текст](../../concepts/ocr/index.md) из PDF-файла, вы можете использовать [OCR API](../../ocr/api-ref/index.md) или [Vision API](../../vision/api-ref/index.md). OCR API — это обновленный и переработанный интерфейс, который предоставляет больше [возможностей](../../concepts/limits.md#vision-limits), в т.ч. распознавание многоколоночного текста.

## Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Распознать текст из PDF-файла с помощью OCR API {#ocr-api-recognition}

Распознавание текста из PDF-файла реализовано в методах OCR API [TextRecognition.recognize](../../ocr/api-ref/TextRecognition/recognize.md) для одностраничных PDF-файлов и [TextRecognitionAsync.recognize](../../ocr/api-ref/TextRecognitionAsync/recognize.md) — для многостраничных. 

1. Подготовьте PDF-файл для распознавания. Размер файла не должен превышать {{ ocr-max-filesize }}, в одном файле должно быть не более 200 страниц.

1. Кодируйте PDF-файл в формат Base64.

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command-pdf.md) %}

1. Создайте файл с телом запроса, например `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "application/pdf",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<PDF-файл_в_кодировке_base64>"
    }
    ```

    В свойстве `content` укажите содержимое файла, полученное при [переводе](../base64-encode.md) PDF-файла в формат Base64.
    
    Чтобы сервис автоматически определил язык текста, укажите в конфигурации свойство `"languageCodes": ["*"]`.

1. Отправьте запрос:

    {% list tabs %}

    - Одностраничный PDF

      {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

      Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на странице PDF-файла.

      {% cut "Результат" %}

      ```json
      {
        "result": {
          "text_annotation": {
            "width": "3312",
            "height": "4683",
            "blocks": [
              {
                "bounding_box": {
                  "vertices": [
                    {
                      "x": "373",
                      "y": "371"
                    },
                    {
                      "x": "373",
                      "y": "580"
                    },
                    {
                      "x": "1836",
                      "y": "580"
                    },
                    {
                      "x": "1836",
                      "y": "371"
                    }
                  ]
                },
                "lines": [
                  {
                    "bounding_box": {
                      "vertices": [
                        {
                          "x": "373",
                          "y": "371"
                        },
                        {
                          "x": "373",
                          "y": "430"
                        },
                        {
                          "x": "1836",
                          "y": "430"
                        },
                        {
                          "x": "1836",
                          "y": "371"
                        }
                      ]
                    },
                    "alternatives": [
                      {
                        "text": "Страница №1, строка 1",
                        "words": [
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "373",
                                  "y": "358"
                                },
                                {
                                  "x": "373",
                                  "y": "444"
                                },
                                {
                                  "x": "967",
                                  "y": "444"
                                },
                                {
                                  "x": "967",
                                  "y": "358"
                                }
                              ]
                            },
                            "text": "Страница",
                            "entity_index": "-1"
                          },
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "1014",
                                  "y": "358"
                                },
                                {
                                  "x": "1014",
                                  "y": "444"
                                },
                                {
                                  "x": "1278",
                                  "y": "444"
                                },
                                {
                                  "x": "1278",
                                  "y": "358"
                                }
                              ]
                            },
                            "text": "№1,",
                            "entity_index": "-1"
                          },
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "1303",
                                  "y": "358"
                                },
                                {
                                  "x": "1303",
                                  "y": "444"
                                },
                                {
                                  "x": "1718",
                                  "y": "444"
                                },
                                {
                                  "x": "1718",
                                  "y": "358"
                                }
                              ]
                            },
                            "text": "строка",
                            "entity_index": "-1"
                          },
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "1765",
                                  "y": "358"
                                },
                                {
                                  "x": "1765",
                                  "y": "444"
                                },
                                {
                                  "x": "1836",
                                  "y": "444"
                                },
                                {
                                  "x": "1836",
                                  "y": "358"
                                }
                              ]
                            },
                            "text": "1",
                            "entity_index": "-1"
                          }
                        ]
                      }
                    ]
                  },
                  {
                    "bounding_box": {
                      "vertices": [
                        {
                          "x": "373",
                          "y": "520"
                        },
                        {
                          "x": "373",
                          "y": "580"
                        },
                        {
                          "x": "1836",
                          "y": "580"
                        },
                        {
                          "x": "1836",
                          "y": "520"
                        }
                      ]
                    },
                    "alternatives": [
                      {
                        "text": "Страница №1, строка 2",
                        "words": [
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "373",
                                  "y": "508"
                                },
                                {
                                  "x": "373",
                                  "y": "594"
                                },
                                {
                                  "x": "967",
                                  "y": "594"
                                },
                                {
                                  "x": "967",
                                  "y": "508"
                                }
                              ]
                            },
                            "text": "Страница",
                            "entity_index": "-1"
                          },
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "1014",
                                  "y": "507"
                                },
                                {
                                  "x": "1014",
                                  "y": "593"
                                },
                                {
                                  "x": "1277",
                                  "y": "593"
                                },
                                {
                                  "x": "1277",
                                  "y": "507"
                                }
                              ]
                            },
                            "text": "№1,",
                            "entity_index": "-1"
                          },
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "1302",
                                  "y": "507"
                                },
                                {
                                  "x": "1302",
                                  "y": "593"
                                },
                                {
                                  "x": "1718",
                                  "y": "593"
                                },
                                {
                                  "x": "1718",
                                  "y": "507"
                                }
                              ]
                            },
                            "text": "строка",
                            "entity_index": "-1"
                          },
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "1765",
                                  "y": "507"
                                },
                                {
                                  "x": "1765",
                                  "y": "593"
                                },
                                {
                                  "x": "1836",
                                  "y": "593"
                                },
                                {
                                  "x": "1836",
                                  "y": "507"
                                }
                              ]
                            },
                            "text": "2",
                            "entity_index": "-1"
                          }
                        ]
                      }
                    ]
                  }
                ],
                "languages": [
                  {
                    "language_code": "ru"
                  }
                ]
              }
            ],
            "entities": []
          },
          "page": "0"
        }
      }
      ```

      {% endcut %}

    - Многостраничный PDF

      * {% include [send-request](../../../_includes/vision/send-request_ocr-async.md) %}  

          Результат:

          ```json
          {
            "id": "cfrtr5q0hdhl********",
            "description": "OCR async recognition",
            "created_at": "2023-10-24T09:12:48Z",
            "created_by": "ajeol2afu1js********",
            "modified_at": "2023-10-24T09:12:48Z",
            "done": false,
            "metadata": null
          }
          ```

          Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

      * Отправьте запрос на получение результата распознавания с помощью метода [getRecognition](../../ocr/api-ref/TextRecognitionAsync/getRecognition.md):

          ```bash
          export IAM_TOKEN=<IAM_токен>
          curl -X GET \
              -H "Content-Type: application/json" \
              -H "Authorization: Bearer ${IAM_TOKEN}" \
              -H "x-folder-id: <идентификатор_каталога>" \
              -H "x-data-logging-enabled: true" \
              https://ocr.{{ api-host }}/ocr/v1/getRecognition?operationId=<идентификатор_операции> \
              -o output.json
          ```

          Где:
          * `<IAM_токен>` — полученный ранее IAM-токен.
          * `<идентификатор_каталога>` — полученный ранее идентификатор каталога.
          * `<идентификатор_операции>` — полученный ранее идентификатор операции распознавания.

          Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на странице PDF-файла. Результат распознавания каждой страницы приводится в отдельной секции `result`.


          {% cut "Результат" %}

          ```json
          {
            "result": {
              "text_annotation": {
                "width": "3312",
                "height": "4683",
                "blocks": [
                  {
                    "bounding_box": {
                      "vertices": [
                        {
                          "x": "373",
                          "y": "371"
                        },
                        {
                          "x": "373",
                          "y": "580"
                        },
                        {
                          "x": "1836",
                          "y": "580"
                        },
                        {
                          "x": "1836",
                          "y": "371"
                        }
                      ]
                    },
                    "lines": [
                      {
                        "bounding_box": {
                          "vertices": [
                            {
                              "x": "373",
                              "y": "371"
                            },
                            {
                              "x": "373",
                              "y": "430"
                            },
                            {
                              "x": "1836",
                              "y": "430"
                            },
                            {
                              "x": "1836",
                              "y": "371"
                            }
                          ]
                        },
                        "alternatives": [
                          {
                            "text": "Страница №1, строка 1",
                            "words": [
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "373",
                                      "y": "358"
                                    },
                                    {
                                      "x": "373",
                                      "y": "444"
                                    },
                                    {
                                      "x": "967",
                                      "y": "444"
                                    },
                                    {
                                      "x": "967",
                                      "y": "358"
                                    }
                                  ]
                                },
                                "text": "Страница",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1014",
                                      "y": "358"
                                    },
                                    {
                                      "x": "1014",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1278",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1278",
                                      "y": "358"
                                    }
                                  ]
                                },
                                "text": "№1,",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1303",
                                      "y": "358"
                                    },
                                    {
                                      "x": "1303",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1718",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1718",
                                      "y": "358"
                                    }
                                  ]
                                },
                                "text": "строка",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1765",
                                      "y": "358"
                                    },
                                    {
                                      "x": "1765",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1836",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1836",
                                      "y": "358"
                                    }
                                  ]
                                },
                                "text": "1",
                                "entity_index": "-1"
                              }
                            ]
                          }
                        ]
                      },
                      {
                        "bounding_box": {
                          "vertices": [
                            {
                              "x": "373",
                              "y": "520"
                            },
                            {
                              "x": "373",
                              "y": "580"
                            },
                            {
                              "x": "1836",
                              "y": "580"
                            },
                            {
                              "x": "1836",
                              "y": "520"
                            }
                          ]
                        },
                        "alternatives": [
                          {
                            "text": "Страница №1, строка 2",
                            "words": [
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "373",
                                      "y": "508"
                                    },
                                    {
                                      "x": "373",
                                      "y": "594"
                                    },
                                    {
                                      "x": "967",
                                      "y": "594"
                                    },
                                    {
                                      "x": "967",
                                      "y": "508"
                                    }
                                  ]
                                },
                                "text": "Страница",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1014",
                                      "y": "507"
                                    },
                                    {
                                      "x": "1014",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1277",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1277",
                                      "y": "507"
                                    }
                                  ]
                                },
                                "text": "№1,",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1302",
                                      "y": "507"
                                    },
                                    {
                                      "x": "1302",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1718",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1718",
                                      "y": "507"
                                    }
                                  ]
                                },
                                "text": "строка",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1765",
                                      "y": "507"
                                    },
                                    {
                                      "x": "1765",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1836",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1836",
                                      "y": "507"
                                    }
                                  ]
                                },
                                "text": "2",
                                "entity_index": "-1"
                              }
                            ]
                          }
                        ]
                      }
                    ],
                    "languages": [
                      {
                        "language_code": "ru"
                      }
                    ]
                  }
                ],
                "entities": []
              },
              "page": "0"
            }
          }
          {
            "result": {
              "text_annotation": {
                "width": "3312",
                "height": "4683",
                "blocks": [
                  {
                    "bounding_box": {
                      "vertices": [
                        {
                          "x": "371",
                          "y": "371"
                        },
                        {
                          "x": "371",
                          "y": "580"
                        },
                        {
                          "x": "1836",
                          "y": "580"
                        },
                        {
                          "x": "1836",
                          "y": "371"
                        }
                      ]
                    },
                    "lines": [
                      {
                        "bounding_box": {
                          "vertices": [
                            {
                              "x": "371",
                              "y": "371"
                            },
                            {
                              "x": "371",
                              "y": "430"
                            },
                            {
                              "x": "1820",
                              "y": "430"
                            },
                            {
                              "x": "1820",
                              "y": "371"
                            }
                          ]
                        },
                        "alternatives": [
                          {
                            "text": "Страница №2, строка 1",
                            "words": [
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "371",
                                      "y": "357"
                                    },
                                    {
                                      "x": "371",
                                      "y": "444"
                                    },
                                    {
                                      "x": "964",
                                      "y": "444"
                                    },
                                    {
                                      "x": "964",
                                      "y": "357"
                                    }
                                  ]
                                },
                                "text": "Страница",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "993",
                                      "y": "357"
                                    },
                                    {
                                      "x": "993",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1292",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1292",
                                      "y": "357"
                                    }
                                  ]
                                },
                                "text": "№2,",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1317",
                                      "y": "357"
                                    },
                                    {
                                      "x": "1317",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1701",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1701",
                                      "y": "357"
                                    }
                                  ]
                                },
                                "text": "строка",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1748",
                                      "y": "357"
                                    },
                                    {
                                      "x": "1748",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1820",
                                      "y": "444"
                                    },
                                    {
                                      "x": "1820",
                                      "y": "357"
                                    }
                                  ]
                                },
                                "text": "1",
                                "entity_index": "-1"
                              }
                            ]
                          }
                        ]
                      },
                      {
                        "bounding_box": {
                          "vertices": [
                            {
                              "x": "373",
                              "y": "520"
                            },
                            {
                              "x": "373",
                              "y": "580"
                            },
                            {
                              "x": "1836",
                              "y": "580"
                            },
                            {
                              "x": "1836",
                              "y": "520"
                            }
                          ]
                        },
                        "alternatives": [
                          {
                            "text": "Страница №2, строка 2",
                            "words": [
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "373",
                                      "y": "507"
                                    },
                                    {
                                      "x": "373",
                                      "y": "594"
                                    },
                                    {
                                      "x": "967",
                                      "y": "594"
                                    },
                                    {
                                      "x": "967",
                                      "y": "507"
                                    }
                                  ]
                                },
                                "text": "Страница",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1014",
                                      "y": "507"
                                    },
                                    {
                                      "x": "1014",
                                      "y": "594"
                                    },
                                    {
                                      "x": "1277",
                                      "y": "594"
                                    },
                                    {
                                      "x": "1277",
                                      "y": "507"
                                    }
                                  ]
                                },
                                "text": "№2,",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1302",
                                      "y": "507"
                                    },
                                    {
                                      "x": "1302",
                                      "y": "594"
                                    },
                                    {
                                      "x": "1718",
                                      "y": "594"
                                    },
                                    {
                                      "x": "1718",
                                      "y": "507"
                                    }
                                  ]
                                },
                                "text": "строка",
                                "entity_index": "-1"
                              },
                              {
                                "bounding_box": {
                                  "vertices": [
                                    {
                                      "x": "1765",
                                      "y": "506"
                                    },
                                    {
                                      "x": "1765",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1836",
                                      "y": "593"
                                    },
                                    {
                                      "x": "1836",
                                      "y": "506"
                                    }
                                  ]
                                },
                                "text": "2",
                                "entity_index": "-1"
                              }
                            ]
                          }
                        ]
                      }
                    ],
                    "languages": [
                      {
                        "language_code": "ru"
                      }
                    ]
                  }
                ],
                "entities": []
              },
              "page": "1"
            }
          }
          ```

          {% endcut %}

    {% endlist %}

1. Чтобы получить распознанные слова из PDF-файла, найдите все значения со свойством `text`.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}


## Распознать текст из PDF-файла с помощью Vision API {#vision-api-recognition}

Распознавание текста из PDF-файла реализовано в методе [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) Vision API.

1. В PDF-файле должно быть не больше 8 страниц. Если страниц больше, разбейте его на файлы по 8 страниц.
1. Кодируйте PDF-файл в формат Base64.

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command-pdf.md) %}

1. Создайте файл с телом запроса, например `body.json`.

    **body.json:**
    ```json
    {
        "folderId": "<идентификатор_каталога>",
        "analyze_specs": [{
            "content": "<PDF-файл_в_кодировке_base64>",
            "mime_type": "application/pdf",
            "features": [{
                "type": "TEXT_DETECTION",
                "text_detection_config": {
                    "language_codes": ["*"]
                }
            }]
        }]
    }
    ```

    Где:
    * `folderId` – [идентификатор любого каталога](../../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
    * `content` – содержимое файла, полученное при [переводе](../base64-encode.md) PDF-файла в формат Base64.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

1. Чтобы получить все распознанные на изображении слова, найдите все строки со свойством `text`, например с помощью [grep](https://www.gnu.org/software/grep/):

    {% list tabs %}

    - Bash

      ```bash
      grep -o "\"text\":\s\".*\"" output.json
      ```

      Результат:

      ```text
      "text": "PENGUINS"
      "text": "CROSSING"
      "text": "SLOW"
      ```

    - CMD

      ```bash
      findstr text output.json
      ```

      Результат:

      ```text
      "text": "PENGUINS"
      "text": "CROSSING"
      "text": "SLOW"
      ```

    - PowerShell

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