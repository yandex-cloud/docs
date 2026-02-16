---
title: Как распознать рукописный текст в {{ vision-full-name }}. Пошаговая инструкция
description: Из руководства вы узнаете, как распознать комбинацию печатного и рукописного текста на русском и английском языке в {{ vision-full-name }}.
---


# Распознавание рукописного текста

Чтобы [распознать рукописный текст](../../concepts/ocr/index.md) на изображении, вы можете использовать [OCR API](../../ocr/api-ref/index.md) с моделью распознавания `handwritten`. Эта модель позволяет распознавать произвольное сочетание рукописного и печатного текста на русском и английском языках.


## Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}


## Распознать рукописный текст на изображении {#recognize-handwriting}

Распознавание текста на изображении реализовано в методе [recognize](../../ocr/api-ref/TextRecognition/recognize.md) OCR API.

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

1. Кодируйте файл с изображением в формат Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Создайте и отправьте запрос. 

    В свойстве `content` укажите содержимое файла, полученное при [переводе](../base64-encode.md) изображения в формат Base64.

    {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

    Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на изображении.

    {% cut "Результат запроса" %}

    ``` json
    {
      "result": {
        "textAnnotation": {
          "width": "241",
          "height": "162",
          "blocks": [
            {
              "boundingBox": {
                "vertices": [
                  {
                    "x": "28",
                    "y": "8"
                  },
                  {
                    "x": "28",
                    "y": "130"
                  },
                  {
                    "x": "240",
                    "y": "130"
                  },
                  {
                    "x": "240",
                    "y": "8"
                  }
                ]
              },
              "lines": [
                {
                  "boundingBox": {
                    "vertices": [
                      {
                        "x": "28",
                        "y": "8"
                      },
                      {
                        "x": "28",
                        "y": "77"
                      },
                      {
                        "x": "240",
                        "y": "77"
                      },
                      {
                        "x": "240",
                        "y": "8"
                      }
                    ]
                  },
                  "text": "Привет,",
                  "words": [
                    {
                      "boundingBox": {
                        "vertices": [
                          {
                            "x": "28",
                            "y": "9"
                          },
                          {
                            "x": "28",
                            "y": "81"
                          },
                          {
                            "x": "240",
                            "y": "81"
                          },
                          {
                            "x": "240",
                            "y": "9"
                          }
                        ]
                      },
                      "text": "Привет,",
                      "entityIndex": "-1",
                      "textSegments": [
                        {
                          "startIndex": "0",
                          "length": "7"
                        }
                      ]
                    }
                  ],
                  "textSegments": [
                    {
                      "startIndex": "0",
                      "length": "7"
                    }
                  ]
                },
                {
                  "boundingBox": {
                    "vertices": [
                      {
                        "x": "112",
                        "y": "94"
                      },
                      {
                        "x": "112",
                        "y": "130"
                      },
                      {
                        "x": "240",
                        "y": "130"
                      },
                      {
                        "x": "240",
                        "y": "94"
                      }
                    ]
                  },
                  "text": "Мир!",
                  "words": [
                    {
                      "boundingBox": {
                        "vertices": [
                          {
                            "x": "112",
                            "y": "89"
                          },
                          {
                            "x": "112",
                            "y": "137"
                          },
                          {
                            "x": "240",
                            "y": "137"
                          },
                          {
                            "x": "240",
                            "y": "89"
                          }
                        ]
                      },
                      "text": "Мир!",
                      "entityIndex": "-1",
                      "textSegments": [
                        {
                          "startIndex": "8",
                          "length": "4"
                        }
                      ]
                    }
                  ],
                  "textSegments": [
                    {
                      "startIndex": "8",
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
                  "startIndex": "0",
                  "length": "12"
                }
              ]
            }
          ],
          "entities": [],
          "tables": [],
          "fullText": "Привет,\nМир!\n"
        },
        "page": "0"
      }
    }
    ```
    {% endcut %}

1. Чтобы получить все распознанные на изображении слова, найдите все значения со свойством `text`.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}