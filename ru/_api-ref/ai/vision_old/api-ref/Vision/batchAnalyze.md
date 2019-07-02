---
editable: false
---

# Метод batchAnalyze
Анализирует набор изображений и возвращает результаты с аннотациями.
 

 
## HTTP-запрос {#https-request}
```
POST https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze
```
 
## Параметры в теле запроса {#body_params}
 
```json 
 {
  "analyzeSpecs": [
    {
      "features": [
        {
          "type": "string",
          "textDetectionConfig": {
            "languageCodes": [
              "string"
            ]
          }
        }
      ],
      "content": "string"
    }
  ],
  "folderId": "string"
}
```

 
Поле | Описание
--- | ---
analyzeSpecs[] | **object**<br><p>Обязательное поле. Список спецификаций. Каждая спецификация содержит файл для анализа и возможности для анализа.</p> <p>Ограничения</p> <ul> <li>Поддерживаемые форматы файлов: JPEG, PNG.</li> <li>Максимальный размер файла: 1 МБ.</li> <li>Размер изображения не должен превышать 20 мегапикселей (длина x ширина).</li> </ul> <p>Количество элементов должно находиться в диапазоне от 1 до 8.</p> 
analyzeSpecs[].<br>features[] | **object**<br><p>Обязательное поле. Запрошенные возможности для анализа. В настоящее время поддерживается только распознавание текста (OCR).</p> <p>Максимальное количество запрошенных возможностей для одного файла - 8.</p> <p>Количество элементов должно находиться в диапазоне от 1 до 8.</p> 
analyzeSpecs[].<br>features[].<br>type | **string**<br><ul> <li>TEXT_DETECTION: Распознавание текста (OCR).</li> </ul> 
analyzeSpecs[].<br>features[].<br>textDetectionConfig | **object**<br>
analyzeSpecs[].<br>features[].<br>textDetectionConfig.<br>languageCodes[] | **string**<br><p>Обязательное поле. Список языков для распознавания текста. Указывается в формате <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> (например, <code>ru</code>).</p> <p>Количество элементов должно находиться в диапазоне от 1 до 8. Максимальная длина строки в символах для каждого значения — 3.</p> 
analyzeSpecs[].<br>content | **string** (byte)<br><p>Содержимое изображения, представленное в виде потока байтов. Примечание: как и во всех полях с байтами, в protobuf используется чистое двоичное представление, тогда как в JSON-представлении используется base64.</p> <p>Максимальная длина строки в символах — 1048576.</p> 
folderId | **string**<br><p>Идентификатор папки, к которой у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p> 
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
 {
  "results": [
    {
      "results": [
        {
          "error": {
            "code": "integer",
            "message": "string",
            "details": [
              "object"
            ]
          },
          "textDetection": {
            "pages": [
              {
                "width": "string",
                "height": "string",
                "blocks": [
                  {
                    "boundingBox": {
                      "vertices": [
                        {
                          "x": "string",
                          "y": "string"
                        }
                      ]
                    },
                    "lines": [
                      {
                        "boundingBox": {
                          "vertices": [
                            {
                              "x": "string",
                              "y": "string"
                            }
                          ]
                        },
                        "words": [
                          {
                            "boundingBox": {
                              "vertices": [
                                {
                                  "x": "string",
                                  "y": "string"
                                }
                              ]
                            },
                            "text": "string",
                            "confidence": "number",
                            "languages": [
                              {
                                "languageCode": "string",
                                "confidence": "number"
                              }
                            ]
                          }
                        ],
                        "confidence": "number"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        }
      ],
      "error": {
        "code": "integer",
        "message": "string",
        "details": [
          "object"
        ]
      }
    }
  ]
}
```

 
Поле | Описание
--- | ---
results[] | **object**<br><p>Результаты запроса. Результаты имеют тот же порядок, что и спецификации в запросе.</p> 
results[].<br>results[] | **object**<br><p>Результаты для каждой запрошенной возможности для анализа. Результаты имеют тот же порядок, что и указанные возможности в запросе.</p> 
results[].<br>results[].<br>error | **object**<br><p>Описание ошибки в случае сбоя или отмены операции.</p> 
results[].<br>results[].<br>error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
results[].<br>results[].<br>error.<br>message | **string**<br><p>Текст ошибки.</p> 
results[].<br>results[].<br>error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 
results[].<br>results[].<br>textDetection | **object**<br>
results[].<br>results[].<br>textDetection.<br>pages[] | **object**<br><p>Страницы распознанного файла.</p> <p>Для JPEG и PNG файлов содержит только 1 страницу.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>width | **string** (int64)<br><p>Ширина страницы в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>height | **string** (int64)<br><p>Высота страницы в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[] | **object**<br><p>Распознанные блоки текста на этой странице.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox | **object**<br><p>Область на странице, где находится блок текста.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox.<br>vertices[] | **object**<br><p>Вершины обрамляющей фигуры.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>Координата по оси X в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Координата по оси Y в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[] | **object**<br><p>Распознанные строки в этом блоке.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox | **object**<br><p>Область на странице, где расположена строка.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[] | **object**<br><p>Вершины обрамляющей фигуры.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>Координата по оси X в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Координата по оси Y в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[] | **object**<br><p>Распознанные слова в этой строке.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox | **object**<br><p>Область на странице, где расположена строка.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[] | **object**<br><p>Вершины обрамляющей фигуры.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>Координата по оси X в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Координата по оси Y в пикселях.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>text | **string**<br><p>Распознанное слово.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>confidence | **number** (double)<br><p>Достоверность результатов OCR для слова. Диапазон [0, 1].</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>languages[] | **object**<br><p>Список распознанных языков и достоверность распознавания.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>languages[].<br>languageCode | **string**<br><p>Код распознанного языка.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>languages[].<br>confidence | **number** (double)<br><p>Достоверность распознанного языка. Диапазон [0, 1].</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>confidence | **number** (double)<br><p>Достоверность результатов OCR для строки. Диапазон [0, 1].</p> 
results[].<br>error | **object**<br><p>Возвращает информацию об ошибке, если ошибка произошла при обработке файла.</p> <p>Описание ошибки в случае сбоя или отмены операции.</p> 
results[].<br>error.<br>code | **integer** (int32)<br><p>Код ошибки. Значение из списка <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
results[].<br>error.<br>message | **string**<br><p>Текст ошибки.</p> 
results[].<br>error.<br>details[] | **object**<br><p>Список сообщений с подробными сведениями об ошибке.</p> 