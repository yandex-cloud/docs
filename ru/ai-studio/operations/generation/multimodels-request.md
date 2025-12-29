---
title: Как отправлять запросы мультимодальным моделям
description: Следуя данной инструкции, вы научитесь отправлять запросы мультимодальным моделям на примере модели Gemma 3 27B it.
---

# Отправить запрос мультимодальной модели

В {{ ai-studio-name }} вы можете отправлять запросы [мультимодальным моделям](../../concepts/generation/batch-processing.md#multimodels-batch), которые могут анализировать изображения и возвращать ответ в виде текста. Изображения передаются в кодировке Base64.

{% note info %}

В {{ ai-playground }} работа с мультимодальными моделями пока недоступна.

{% endnote %}

Чтобы воспользоваться примером, [создайте](../get-api-key.md#run-client) сервисный аккаунт с [ролью](../../security/index.md#languageModels-user) `ai.languageModels.user` и получите для него API-ключ с областью действия `yc.ai.foundationModels.execute`.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  from openai import OpenAI
  import base64

  YC_API_KEY = "<API-ключ>"
  YC_FOLDER_ID = "<идентификатор_каталога>"
  
  client = OpenAI(
      api_key=YC_API_KEY,
      base_url="https://ai.api.cloud.yandex.net/v1",
  )
  
  
  # Вспомогательный метод для конвертации изображений в Base64
  def image_to_base64(image_path):
      with open(image_path, "rb") as image_file:
          return base64.b64encode(image_file.read()).decode('utf-8')
  
  
  # Изображения для сравнения
  image1_base64 = image_to_base64("image1.png")
  image2_base64 = image_to_base64("image2.png")
  
  # Для примера используется модель Gemma 3 27B it
  response = client.chat.completions.create(
      model=f"gpt://{YC_FOLDER_ID}/gemma-3-27b-it",
      messages=[
          {
              "role": "user",
              "content": [
                  {
                      "type": "text",
                      "text": "Сравни эти две картинки"
                  },
                  {
                      "type": "image_url",
                      "image_url": {
                          "url": f"data:image/jpeg;base64,{image1_base64}"
                      }
                  },
                  {
                      "type": "image_url",
                      "image_url": {
                          "url": f"data:image/jpeg;base64,{image2_base64}"
                      }
                  }
              ]
          }
      ]
  )
  
  print(response.choices[0].message.content)
  ```  
  
  Где:
  
  * `YC_API_KEY` — полученный [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта.
  * `YC_FOLDER_ID` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) сервисного аккаунта.

  {% cut "Пример ответа модели" %}
  
   ```text
  **Первое изображение:**
  
  *   **Объект:** Маленький пингвинёнок.
  *   **Характеристики:** Пингвинёнок покрыт пухом, у него милое выражение лица. У него перед собой ноутбук.
  *   **Фон:** Белый заснеженный пейзаж.
  
  **Второе изображение:**
  
  *   **Объект:** Енот, завернутый в белое махровое полотенце.
  *   **Характеристики:** Выражение лица енота задумчивое, немного грустное.
  *   **Фон:** Похоже на ванную комнату или другую бытовую комнату.
  
  **Основные различия:**
  
  *   **Виды животных:** Пингвин и енот - два совершенно разных животных, живущих в разных средах.
  *   **Обстановка:** Одно изображение сделано на природе (снег), а другое - в помещении.
  *   **Действия:** Пингвинёнок, похоже, "работает" или просто смотрит на ноутбук, а енот, похоже, отдыхает после купания.
  
  В целом, обе картинки очень милые и вызывают положительные эмоции, но показывают очень разные ситуации и животных.
  ``` 
  
  {% endcut %}


{% endlist %}