---
title: How to send requests to multimodal models
description: Follow this guide to learn how to send requests to multimodal models, e.g., Gemma 3 27B it.
---

# Sending a request to a multimodal model

In {{ ai-studio-name }}, you can send requests to multimodal models able to analyze images and respond in text form. Your images should be Base64-encoded.

{% note info %}

{{ ai-playground }} does not support multimodal models yet.

{% endnote %}

To complete the steps from this example, [create](../get-api-key.md#run-client) a service account with the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) and get an API key with the `yc.ai.foundationModels.execute` scope.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  from openai import OpenAI
  import base64

  YC_API_KEY = "<API_key>"
  YC_FOLDER_ID = "<folder_ID>"
  
  client = OpenAI(
      api_key=YC_API_KEY,
      base_url="https://ai.api.cloud.yandex.net/v1",
  )
  
  
  # Auxiliary method for converting images to Base64
  def image_to_base64(image_path):
      with open(image_path, "rb") as image_file:
          return base64.b64encode(image_file.read()).decode('utf-8')
  
  
  # Images for comparison
  image1_base64 = image_to_base64("image1.png")
  image2_base64 = image_to_base64("image2.png")
  
  # In this example, we use Gemma 3 27B it
  response = client.chat.completions.create(
      model=f"gpt://{YC_FOLDER_ID}/gemma-3-27b-it",
      messages=[
          {
              "role": "user",
              "content": [
                  {
                      "type": "text",
                      "text": "Compare these two images"
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
  
  Where:
  
  * `YC_API_KEY`: Service account [API key](../../../iam/concepts/authorization/api-key.md) you obtained.
  * `YC_FOLDER_ID`: Service account [folder ID](../../../resource-manager/operations/folder/get-id.md).

  {% cut "Model response example" %}
  
   ```text
  **First image:**
  
  *   **Object:** Little penguin.
  *   **Properties:** A fluffy little penguin with a cute face. It is holding a laptop.
  *   **Background:** A white snow-covered lanscape.
  
  **Second image:**
  
  *   **Object:** A raccoon wrapped in a white bath towel.
  *   **Properties:** The raccoon looks thoughtful, slightly saddened.
  *   **Background:** Resembles a bathroom or another utility room.
  
  **Main differences:**
  
  *   **Animal species:** Penguins and raccoons are completely different species living in different habitats.
  *   **Scenery:** One image is made outdoors (snow), the other one indoors.
  *   **Actions:** The little penguin seems to be working or just looking at its laptop, while the raccoon seems to be resting after a bath.
  
  On the whole, both the images are really cute and emotionally positive; however, they depict completely different scenes and animals.
  ``` 
  
  {% endcut %}


{% endlist %}