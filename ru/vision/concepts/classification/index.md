# Классификация изображений

_Классификация изображений сейчас находится на [стадии Preview](/docs/overview/concepts/launch-stages)._

В этом разделе описано, как работает возможность _классификация изображений_ в сервисе.

Эта возможность позволяет оценить, насколько изображение соответствует какому-то признаку, например, есть ли на изображении контент для взрослых. Это сократит затраты на ручную модерацию: вы сможете блокировать такие изображения автоматически.

Список признаков, для которых возвращается результат, зависит от выбранной модели. Например, модель `quality`, оценивающая качество изображения, возвращает вероятности для признаков `low`, `medium` и `high`. [Подробнее о доступных моделях](supported-models.md).

## Формат запроса {#request-format}

Чтобы использовать эту возможность, укажите `CLASSIFICATION` в типе возможности и передайте название [модели](supported-models.md):

```json
{
    "folderId": "b1gvmob95yysaplct532",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        "features": [{
            "type": "CLASSIFICATION",
            "classificationConfig": {
                "model": "quality"
            }
        }]
    }]
}
```

В рамках одной возможности для анализа может быть использована только одна модель. Если надо применить больше моделей к изображению, передайте еще один объект в `features`:

```json
{
    "folderId": "b1gvmob95yysaplct532",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        "features": [{
            "type": "CLASSIFICATION",
            "classificationConfig": {
                "model": "quality"
            }
        },
        {
            "type": "CLASSIFICATION",
            "classificationConfig": {
                "model": "moderation"
            }
        }]
    }]
}
```


## Ответ сервиса {#service-response}

Сервис возвращает список признаков в формате:

```json
{
    "name": "low", // имя признака
    "probability": 0,71257284 // вероятность соответствия признаку
}
```

Сервис возвращает все признаки для выбранной модели, даже если вероятность для признака равна нулю.

**Пример ответа:**

{% include [classification-quality-response](../../../_includes/vision/classification-quality-response.md) %}

#### Что дальше {#what-is-next}

* [Посмотрите список поддерживаемых моделей](supported-models.md)
* [Посмотрите, как обрабатывать ошибки](../../api-ref/errors-handling.md)