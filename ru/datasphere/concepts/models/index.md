# Модели

Во время работы в {{ ml-platform-full-name }} в памяти ВМ сохраняется состояние интерпретатора и результаты вычислений или обучения. Вы можете сохранить эти вычисления в отдельный ресурс _модель_. 

В {{ ml-platform-name }} доступно два типа моделей:
* модели, обученные в проектах;
* дообученные по методу Fine-tuning [фундаментальные модели](foundation-models.md).

{% note info %}

Модели доступны только в проектах [в режиме {{ dd }}](../project.md#dedicated).

{% endnote %}

## Поддерживаемые типы переменных {#supported-types}

Вы можете создать модель на основе разных типов библиотек, поддерживаемых библиотекой [serialzy](https://github.com/lambdazy/serialzy#list-of-supported-libraries-for-stable-serialization). Список поддерживаемых типов данных и переменных представлен в таблице ниже.

| Библиотека | Типы | Формат данных | 
|---|---|---|
| [CatBoost](https://catboost.ai) | [CatBoostRegressor](https://catboost.ai/en/docs/concepts/python-reference_catboostregressor), [CatBoostClassifier](https://catboost.ai/en/docs/concepts/python-reference_catboostclassifier), [CatBoostRanker](https://catboost.ai/en/docs/concepts/python-reference_catboostranker) | [cbm](https://catboost.ai/en/docs/concepts/python-reference_catboost_save_model) |
| [CatBoost](https://catboost.ai) | [Pool](https://catboost.ai/en/docs/concepts/python-reference_pool) | [quantized pool](https://catboost.ai/en/docs/concepts/python-reference_pool_save) |
| [Tensorflow.Keras](https://keras.io) | [Sequential](https://keras.io/guides/sequential_model/), [Model](https://keras.io/api/models/model/) with subclasses | [tf_keras](https://keras.io/api/models/model_saving_apis/) |
| [Tensorflow](https://www.tensorflow.org)    | [Checkpoint](https://www.tensorflow.org/api_docs/python/tf/train/Checkpoint), [Module](https://www.tensorflow.org/api_docs/python/tf/Module) with subclasses | [tf_pure](https://www.tensorflow.org/api_docs/python/tf/saved_model) |
| [LightGBM](https://lightgbm.readthedocs.io) | [LGBMClassifier](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.LGBMClassifier.html), [LGBMRegressor](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.LGBMRegressor.html), [LGBMRanker](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.LGBMRanker.html) | [lgbm](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.Booster.html#lightgbm.Booster.save_model) |
| [XGBoost](https://lightgbm.readthedocs.io) | [XGBClassifier](https://xgboost.readthedocs.io/en/latest/python/python_api.html#module-xgboost.sklearn), [XGBRegressor](https://xgboost.readthedocs.io/en/latest/python/python_api.html#module-xgboost.sklearn), [XGBRanker](https://xgboost.readthedocs.io/en/latest/python/python_api.html#module-xgboost.sklearn) | [xgb](https://xgboost.readthedocs.io/en/latest/python/python_intro.html#training) |
| [Torch](https://pytorch.org)  | [Module](https://pytorch.org/docs/stable/notes/modules.html) with subclasses | [pt](https://pytorch.org/docs/stable/generated/torch.jit.save.html#torch.jit.save) |

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
