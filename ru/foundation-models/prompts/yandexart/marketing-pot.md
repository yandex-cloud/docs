# Идеи дизайна чайника

## Параметры запроса {#params}

### Пример 1 {#example-1}

* **Промт**: Электрический чайник в форме пингвина, стилизация, белый фон, трансформация, будущее, высокое качество, супер детализация.

* **Зерно**: `3`

* **Результат**:

![marketing-food](../../../_assets/yandexgpt/marketing-pot-22.jpeg)

### Пример 2 {#example-2}

* **Промт**: Электрический чайник в форме пингвина, стилизация, белый фон, трансформация, будущее, высокое качество, супер детализация.

* **Зерно**: `22`

* **Результат**:

![marketing-food](../../../_assets/yandexgpt/marketing-pot-3.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 3
  },
  "messages": [
    {
      "weight": 1,
      "text": "электрический чайник в форме пингвина, стилизация, белый фон, трансформация, будущее, высокое качество, супер детализация"
    }
  ]
}
```

Где `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.

{% include [prompt-structure](../../../_includes/yandexart/prompt-structure.md) %}

## Получение результата {#result}

{% include [prompt-result](../../../_includes/yandexart/prompt-result.md) %}
