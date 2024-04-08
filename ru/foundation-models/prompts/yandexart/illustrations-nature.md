# Изображение природы

## Параметры запроса {#params}

* **Промт**: гиперреалистичная фотография, солнце сквозь деревья, лиственный лес, лето, широкий кадр, 32к, фото Nikon d800, объектив 30 мм, hd full wallpaper

* **Зерно**: `9`

* **Результат**:

![illustrations-nature](../../../_assets/yandexgpt/illustrations-nature.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 9
  },
  "messages": [
    {
      "weight": 1,
      "text": "гиперреалистичная фотография, солнце сквозь деревья, лиственный лес, лето, широкий кадр, 32к, фото Nikon d800, объектив 30 мм, hd full wallpaper"
    }
  ]
}
```

Где `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.

{% include [prompt-structure](../../../_includes/yandexart/prompt-structure.md) %}

## Получение результата {#result}

{% include [prompt-result](../../../_includes/yandexart/prompt-result.md) %}
