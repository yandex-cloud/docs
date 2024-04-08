# Изображение электроники

## Параметры запроса {#params}

* **Промт**: прицельная сетка, электронные схемы, текст, значки, киберпанк, макрофото, фотореализм, гипердетализация, Pixar

* **Зерно**: `2`

* **Результат**:

![social-network-electronics](../../../_assets/yandexgpt/social-network-electronics.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 2
  },
  "messages": [
    {
      "weight": 1,
      "text": "прицельная сетка, электронные схемы, текст, значки, киберпанк, макрофото, фотореализм, гипердетализация, Pixar"
    }
  ]
}
```

Где `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.

{% include [prompt-structure](../../../_includes/yandexart/prompt-structure.md) %}

## Получение результата {#result}

{% include [prompt-result](../../../_includes/yandexart/prompt-result.md) %}
