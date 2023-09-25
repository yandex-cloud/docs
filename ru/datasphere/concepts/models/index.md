# Модели

Во время работы в {{ ml-platform-full-name }} в памяти ВМ сохраняется состояние интерпретатора и результаты вычислений или обучения. Вы можете сохранить эти вычисления в отдельный ресурс _модель_. 

В {{ ml-platform-name }} доступно два типа моделей:
* модели, обученные в проектах;
* дообученные по методу P-tuning [фундаментальные модели](foundation-models.md).

{% note info %}

Модели доступны только в проектах [в режиме {{ dd }}](../project.md#dedicated).

{% endnote %}

## Поддерживаемые типы переменных {#supported-types}

Вы можете создать модель на основе разных типов библиотек [CatBoost](https://catboost.ai) и Tensorflow.Keras](https://keras.io). Список поддерживаемых типов данных и переменных представлен в таблице ниже.

| Библиотека | Типы | Формат данных | 
|---|---|---|
| [CatBoost](https://catboost.ai) | [CatBoostRegressor](https://catboost.ai/en/docs/concepts/python-reference_catboostregressor), [CatBoostClassifier](https://catboost.ai/en/docs/concepts/python-reference_catboostclassifier), [CatBoostRanker](https://catboost.ai/en/docs/concepts/python-reference_catboostranker) | [cbm](https://catboost.ai/en/docs/concepts/python-reference_catboost_save_model) |
| [CatBoost](https://catboost.ai) | [Pool](https://catboost.ai/en/docs/concepts/python-reference_pool) | [quantized pool](https://catboost.ai/en/docs/concepts/python-reference_pool_save) |
| [Tensorflow.Keras](https://keras.io) | [Sequential](https://keras.io/guides/sequential_model/), [Model](https://keras.io/api/models/model/) with subclasses | [tf_keras](https://keras.io/api/models/model_saving_apis/) |

## Информация о модели как ресурсе {#info}

Вся информация о созданных в проекте моделях доступна в разделе **Ресурсы** и в правом боковом меню {{ jlab }}Lab на вкладке **Модели**.

О каждой модели хранится следующая информация:

* имя;
* имя ноутбука, в котором модель была создана;
* имя переменной, из которой модель была создана;
* размер модели в байтах;
* имя пользователя, создавшего модель;
* дата создания датасета в формате в [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время), например `18 июля 2023 г., 14:23`.

Чтобы посмотреть подробную информацию о модели, нажмите на ее название в списке моделей проекта. 

#### См. также {#see-also}

* [Как создать, загрузить и удалить модель](../../operations/data/models.md).
* [Фундаментальные модели](foundation-models.md).
