# Models

While using {{ ml-platform-full-name }}, a VM's memory stores the interpreter state, as well as computing and training results. You can save these computations to a separate resource named _model_.

Two types of models are available in {{ ml-platform-name }}:
* Models trained in projects.
* [Foundation models](foundation-models.md) retrained based on the Fine-tuning method.

{% note info %}

Models are only available in projects in [{{ dd }} mode](../project.md#dedicated).

{% endnote %}

## Supported variable types {#supported-types}

You can create a model based on different types of [CatBoost](https://catboost.ai) and [Tensorflow.Keras](https://keras.io) libraries. The table below provides a list of supported data and variable types.

| Library | Types | Data format |
|---|---|---|
| [CatBoost](https://catboost.ai) | [CatBoostRegressor](https://catboost.ai/en/docs/concepts/python-reference_catboostregressor), [CatBoostClassifier](https://catboost.ai/en/docs/concepts/python-reference_catboostclassifier), [CatBoostRanker](https://catboost.ai/en/docs/concepts/python-reference_catboostranker) | [cbm](https://catboost.ai/en/docs/concepts/python-reference_catboost_save_model) |
| [CatBoost](https://catboost.ai) | [Pool](https://catboost.ai/en/docs/concepts/python-reference_pool) | [quantized pool](https://catboost.ai/en/docs/concepts/python-reference_pool_save) |
| [Tensorflow.Keras](https://keras.io) | [Sequential](https://keras.io/guides/sequential_model/), [Model](https://keras.io/api/models/model/) with subclasses | [tf_keras](https://keras.io/api/models/model_saving_apis/) |

## Information about models as a resource {#info}

All information about models created in a project is available under **Resources** and in the {{ jlab }}Lab right-hand menu in the **Models** tab.

The following information is stored about each model:

* Name.
* Name of the notebook the model was created in.
* Name of the variable the model was created from.
* Model size in bytes.
* Name of the user who created the model.
* Dataset creation date in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, e.g., `July 18, 2023, 14:23`.

To view model details, click its name in the project's model list.

#### See also {#see-also}

* [How to create, upload, and delete a model](../../operations/data/models.md)
* [Foundation models](foundation-models.md)
