# Портрет женщины

## Параметры запроса {#params}

* **Промт**: Анфас, красивая женщина, идеальный, яркий жизнерадостный макияж, губы покрыты красной помадой, на прозрачном фоне Kodak Portra 160.

* **Зерно**: `11`

* **Результат**:

![marketing-portrait](../../../_assets/yandexgpt/marketing-portrait.jpeg)

## Структура запроса {#structure}

```json
{
  "modelUri": "art://<идентификатор_каталога>/yandex-art/latest",
  "generationOptions": {
    "seed": 11
  },
  "messages": [
    {
      "weight": 1,
      "text": "анфас, красивая женщина, идеальный, яркий жизнерадостный макияж, губы покрыты красной помадой, на прозрачном фоне Kodak Portra 160"
    }
  ]
}
```

Где `<идентификатор_каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }}, у которого есть доступ к сервису {{ yagpt-name }}.

{% include [prompt-structure](../../../_includes/yandexart/prompt-structure.md) %}

## Получение результата {#result}

{% include [prompt-result](../../../_includes/yandexart/prompt-result.md) %}
