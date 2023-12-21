---
title: "Как распознать таблицу в {{ vision-full-name }}. Пошаговая инструкция"
description: "Из руководства вы узнаете, как распознать текст в таблицах на русском и английском языке в {{ vision-full-name }}."
---

# Распознавание таблицы

Чтобы [распознать текст](../../concepts/ocr/index.md) внутри таблицы, вы можете использовать [OCR API](../../ocr/api-ref/index.md) с моделью распознавания `table`. Эта модель позволяет распознавать таблицы на русском и английском языках.

## Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Распознать таблицу {#recognize-table-text}

Распознавание текста на изображении реализовано в методе [recognize](../../ocr/api-ref/TextRecognition/recognize.md) OCR API.

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

1. Кодируйте файл с изображением в формат Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["ru","en"],
      "model": "table",
      "content": "<изображение_в_кодировке_base64>"
    }
    ```

    В свойстве `content` укажите содержимое файла, полученное при [переводе](../base64-encode.md) изображения в формат Base64.

1. {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

    Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на изображении:

    ``` json
    {
      "result": {
        "textAnnotation": {
          "width": "97",
          "height": "81",
          "blocks": [
            {
              "boundingBox": {
                "vertices": [
                  {
                    "x": "11",
                    "y": "12"
                  },
                  {
                    "x": "11",
                    "y": "27"
                  },
                  {
                    "x": "60",
                    "y": "27"
                  },
                  {
                    "x": "60",
                    "y": "12"
                  }
                ]
              },
              "lines": [
                {
                  "boundingBox": {
                    "vertices": [
                      {
                        "x": "11",
                        "y": "12"
                      },
                      {
                        "x": "11",
                        "y": "27"
                      },
                      {
                        "x": "60",
                        "y": "27"
                      },
                      {
                        "x": "60",
                        "y": "12"
                      }
                    ]
                  },
                  "text": "Имя",
                  "words": [
                    {
                      "boundingBox": {
                        "vertices": [
                          {
                            "x": "11",
                            "y": "10"
                          },
                          {
                            "x": "11",
                            "y": "30"
                          },
                          {
                            "x": "60",
                            "y": "30"
                          },
                          {
                            "x": "60",
                            "y": "10"
                          }
                        ]
                      },
                      "text": "Имя",
                      "entityIndex": "-1",
                      "textSegments": [
                        {
                          "startIndex": "0",
                          "length": "3"
                        }
                      ]
                    }
                  ],
                  "textSegments": [
                    {
                      "startIndex": "0",
                      "length": "3"
                    }
                  ]
                }
              ],
              "languages": [
                {
                  "languageCode": "ru"
                }
              ],
              "textSegments": [
                {
                  "startIndex": "0",
                  "length": "3"
                }
              ]
            },
            {
              "boundingBox": {
                "vertices": [
                  {
                    "x": "8",
                    "y": "47"
                  },
                  {
                    "x": "8",
                    "y": "66"
                  },
                  {
                    "x": "68",
                    "y": "66"
                  },
                  {
                    "x": "68",
                    "y": "47"
                  }
                ]
              },
              "lines": [
                {
                  "boundingBox": {
                    "vertices": [
                      {
                        "x": "8",
                        "y": "47"
                      },
                      {
                        "x": "8",
                        "y": "66"
                      },
                      {
                        "x": "68",
                        "y": "66"
                      },
                      {
                        "x": "68",
                        "y": "47"
                      }
                    ]
                  },
                  "text": "Иван",
                  "words": [
                    {
                      "boundingBox": {
                        "vertices": [
                          {
                            "x": "8",
                            "y": "46"
                          },
                          {
                            "x": "8",
                            "y": "67"
                          },
                          {
                            "x": "68",
                            "y": "67"
                          },
                          {
                            "x": "68",
                            "y": "46"
                          }
                        ]
                      },
                      "text": "Иван",
                      "entityIndex": "-1",
                      "textSegments": [
                        {
                          "startIndex": "4",
                          "length": "4"
                        }
                      ]
                    }
                  ],
                  "textSegments": [
                    {
                      "startIndex": "4",
                      "length": "4"
                    }
                  ]
                }
              ],
              "languages": [
                {
                  "languageCode": "ru"
                }
              ],
              "textSegments": [
                {
                  "startIndex": "4",
                  "length": "4"
                }
              ]
            }
          ],
          "entities": [],
          "tables": [],
          "fullText": "Имя\nИван\n"
        },
        "page": "0"
      }
    }
    ```

1. Чтобы получить все распознанные на изображении слова, найдите все значения со свойством `text`.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}