# Как начать работать с {{ vision-short-name }}

Этот раздел описывает, как распознать текст на изображении или в файле с помощью {{ vision-short-name }} [OCR API](../vision/ocr/api-ref/index.md).

## Перед началом работы {#before-you-begin}

{% include [curl](../_includes/curl.md) %}


{% list tabs %}

- Аккаунт пользователя на Яндексе

  1. На странице [**Биллинг**]({{ link-console-billing }}) убедитесь, что [платежный аккаунт](../billing/concepts/billing-account.md) находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
  1. [Получите IAM-токен](../iam/operations/iam-token/create.md), необходимый для аутентификации.
  1. [Получите идентификатор любого каталога](../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
  1. Полученный идентификатор передавайте в заголовке `x-folder-id`.

{% endlist %}

## Распознайте текст {#analyze-image}

Вы можете использовать любые возможности для анализа из [списка](concepts/index.md#features). Для примера, воспользуемся возможностью [Распознавание текста](concepts/ocr/index.md):

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../_includes/vision/ocr-file-restrictions.md) %}

    {% note info %}

    Нужен пример изображения? Скачайте изображение дорожного знака, [предупреждающего о пингвинах](https://{{ s3-storage-host }}/vision/penguins_sample.jpg).

    {% endnote %}

1. Кодируйте файл с изображением в формат Base64:

    {% include [base64-encode-command](../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<изображение_в_кодировке_base64>"
    }
    ```

    В свойстве `content` укажите изображение, [кодированное в Base64](./operations/base64-encode.md).
    
    Чтобы сервис автоматически определил язык текста, укажите в конфигурации свойство `"language_codes": ["*"]`.


1. {% include [send-request](../_includes/vision/send-request_ocr.md) %}

    Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на изображении:

    ``` json
    {
      "result": {
        "text_annotation": {
          "width": "1920",
          "height": "1280",
          "blocks": [{
            "bounding_box": {
              "vertices": [{
                "x": "460",
                "y": "777"
              }, {
                "x": "460",
                "y": "906"
              }, {
                "x": "810",
                "y": "906"
              }, {
                "x": "810",
                "y": "777"
              }]
            },
            "lines": [{
              "bounding_box": {
                "vertices": [{
                  "x": "460",
                  "y": "777"
                }, {
                  "x": "460",
                  "y": "820"
                }, {
                  "x": "802",
                  "y": "820"
                }, {
                  "x": "802",
                  "y": "777"
                }]
              },
              "alternatives": [{
                "text": "PENGUINS",
                "words": [{
                  "bounding_box": {
                    "vertices": [{
                      "x": "460",
                      "y": "768"
                    }, {
                      "x": "460",
                      "y": "830"
                    }, {
                      "x": "802",
                      "y": "830"
                    }, {
                      "x": "802",
                      "y": "768"
                    }]
                  },
                  "text": "PENGUINS",
                  "entity_index": "-1"
                }]
              }]
            }, {
              "bounding_box": {
                "vertices": [{
                  "x": "489",
                  "y": "861"
                }, {
                  "x": "489",
                  "y": "906"
                }, {
                  "x": "810",
                  "y": "906"
                }, {
                  "x": "810",
                  "y": "861"
                }]
              },
              "alternatives": [{
                "text": "CROSSING",
                "words": [{
                  "bounding_box": {
                    "vertices": [{
                      "x": "489",
                      "y": "852"
                    }, {
                      "x": "489",
                      "y": "916"
                    }, {
                      "x": "810",
                      "y": "916"
                    }, {
                      "x": "810",
                      "y": "852"
                    }]
                  },
                  "text": "CROSSING",
                  "entity_index": "-1"
                }]
              }]
            }],
            "languages": [{
              "language_code": "en"
            }]
          }, {
            "bounding_box": {
              "vertices": [{
                "x": "547",
                "y": "989"
              }, {
                "x": "547",
                "y": "1046"
              }, {
                "x": "748",
                "y": "1046"
              }, {
                "x": "748",
                "y": "989"
              }]
            },
            "lines": [{
              "bounding_box": {
                "vertices": [{
                  "x": "547",
                  "y": "989"
                }, {
                  "x": "547",
                  "y": "1046"
                }, {
                  "x": "748",
                  "y": "1046"
                }, {
                  "x": "748",
                  "y": "989"
                }]
              },
              "alternatives": [{
                "text": "SLOW",
                "words": [{
                  "bounding_box": {
                    "vertices": [{
                      "x": "547",
                      "y": "983"
                    }, {
                      "x": "547",
                      "y": "1054"
                    }, {
                      "x": "748",
                      "y": "1054"
                    }, {
                      "x": "748",
                      "y": "983"
                    }]
                  },
                  "text": "SLOW",
                  "entity_index": "-1"
                }]
              }]
            }],
            "languages": [{
              "language_code": "en"
            }]
          }],
          "entities": []
        },
        "page": "0"
      }
    }
    ```

1. Чтобы получить распознанные слова с изображения, найдите все значения со свойством `text`.

{% include [coordinate-definition-issue-note](../_includes/vision/coordinate-definition-issue-note.md) %}

#### Что дальше {#what-is-next}

* [Узнайте обо всех возможностях сервиса](concepts/index.md)
* [Узнайте про способы аутентификации в API](api-ref/authentication.md)
* [Найдите лица на фото](operations/face-detection/index.md)
* [Оцените качество изображения](operations/classification/quality.md)
* [Модерируйте изображения](operations/classification/moderation.md)
