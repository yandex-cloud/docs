---
editable: false
---

# Метод Vision batchAnalyze

Анализирует набор изображений и возвращает результат поиска подобных изображений.

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
          "type": "IMAGE_COPY_SEARCH"
        }
      ],
      "mimeType": "string",
      "content": "string"
    }
  ]
}
```

Поле | Описание
---- | --------
analyzeSpecs[] | **object**<br><p>Список спецификаций. Каждая спецификация содержит изображение для анализа и тип анализа.</p>
analyzeSpecs[].<br>features[] | **object**<br><p>Список типов анализа.</p>
analyzeSpecs[].<br>features[].type | **string**<br><p>Тип анализа. Необходимо указать как `IMAGE_COPY_SEARCH`.</p>
analyzeSpecs[].<br>mimeType | **string**<br><p>[MIME-тип](https://en.wikipedia.org/wiki/Media_type) контента.</p> <p>Например, `application/pdf`.</p> <p>Максимальная длина — 255 символов.
analyzeSpecs[].<br>content | **string** (byte)<br><p>Содержимое изображения, представленное в виде потока байтов.</p> <p>Примечание: как и во всех полях с байтами, в protobuf используется чистое двоичное представление, тогда как в JSON-представлении используется base64.</p> <p>Максимальная длина — 10485760 символов.

## Ответ {#responses}

**HTTP Code: 200 - OK**

```json
{
 "results": [
  {
   "results": [
    {
     "imageCopySearch": {
      "topResults": [
       {
        "imageUrl": "string",
        "pageUrl": "string",
        "title": "string",
        "description": "string"
       },

       // Другие элементы списка `results[].results[].imageCopySearch.topResults[]`.

      ],
      "copyCount": "integer"
     }
    }
   ]
  }
 ]
}
```

Поле | Описание
---- | --------
results[] | **object**<br><p>Список результатов запроса.</p>
results[].results[] | **object**<br><p>Список результатов запроса для отдельной спецификации.</p>
results[].results[].<br>imageCopySearch | **object**<br><p>Результат запроса для анализа типа `IMAGE_COPY_SEARCH`.</p>
results[].results[].<br>imageCopySearch.<br>topResults[] | **object**<br><p>Список ссылок и сайтов, где встречается подобная картинка, упорядоченный по убыванию релеватности.</p>
results[].results[].<br>imageCopySearch.<br>topResults[].imageUrl | **string**<br><p>URL картинки.</p>
results[].results[].<br>imageCopySearch.<br>topResults[].pageUrl | **string**<br><p>URL страницы, где встречается картинка.</p>
results[].results[].<br>imageCopySearch.<br>topResults[].title | **string**<br><p>Заголовок страницы.</p>
results[].results[].<br>imageCopySearch.<br>topResults[].description | **string**<br><p>Описание страницы.</p>
results[].results[].<br>imageCopySearch.<br>copyCount | **integer**<br><p>Количество найденных копий.</p>

## Пример запроса {#sample}

```
curl -H "Authorization: Api-Key <Ваш Api-Key>" --data @data.json https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze 
```

Содержание файла `data.json` описано ниже. Используйте свои данные или [скачайте файл data.json](https://storage.yandexcloud.net/doc-files/data.json) с данными из примера.
```json
{
  "analyzeSpecs": [
    {
      "features": [
        {
          "type": "IMAGE_COPY_SEARCH"
        }
      ],
      "mimeType": "application/json",
      "content": "<Изображение>"
    }
  ]
}
```

**Ответ**

```json
{
 "results": [
  {
   "results": [
    {
     "imageCopySearch": {
      "topResults": [
       {
        "imageUrl": "https://i.mycdn.me/i?r=AzEPZsRbOZEKgBhR0XGMT1RkPP9W1BmgpMQhwHsyiKHQlqaKTM5SRkZCeTgDn6uOyic",
        "pageUrl": "www.wallpaperinhd.net/leonardo-dicaprio-wallpaper-22/",
        "title": "Leonardo DiCaprio Wallpaper 22 - Desktop Wallpapers HD Free Backgrounds",
        "description": "Leonardo DiCaprio Wallpaper 22"
       },
       {
        "imageUrl": "https://sun9-68.userapi.com/c635102/v635102124/51ccb/-wkH1Q727zI.jpg",
        "pageUrl": "vk.com/wall-22890129_219793",
        "title": "Стена ВКонтакте",
        "description": "Любовь с первого взгляда?"
       },

       // Другие элементы списка `results[].results[].imageCopySearch.topResults[]`.

      ],
      "copyCount": 13
     }
    }
   ]
  }
 ]
}
```
