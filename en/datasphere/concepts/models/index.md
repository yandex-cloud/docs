# Models

While using {{ ml-platform-full-name }}, a VM's memory stores the interpreter state, as well as computing and training results. You can save these computations to a separate resource named _model_.

In {{ ml-platform-name }}, there are two types of models available:
* Models trained in projects.
* [Foundation models](foundation-models.md) tuned based on the *Fine-tuning* method.

Once created, the model is available for the project. Like any other resource, you can publish the model in the community to use it in other projects. To do this, you need at least the `Editor` role in the project and the `Developer` role in the community in which you want to publish it. You can open the access on the **{{ ui-key.yc-ui-datasphere.common.access }}** tab on the model view page. The resource available to the community will appear on the community page under **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

## Supported variable types {#supported-types}

You can create a model based on different library types supported by [serialzy](https://github.com/lambdazy/serialzy#list-of-supported-libraries-for-stable-serialization). The table below provides a list of supported data and variable types.

| Libraries | Types | Data format |
|---|---|---|
| [CatBoost](https://catboost.ai) | [CatBoostRegressor](https://catboost.ai/en/docs/concepts/python-reference_catboostregressor), [CatBoostClassifier](https://catboost.ai/en/docs/concepts/python-reference_catboostclassifier), [CatBoostRanker](https://catboost.ai/en/docs/concepts/python-reference_catboostranker) | [cbm](https://catboost.ai/en/docs/concepts/python-reference_catboost_save_model) |
| [CatBoost](https://catboost.ai) | [Pool](https://catboost.ai/en/docs/concepts/python-reference_pool) | [quantized pool](https://catboost.ai/en/docs/concepts/python-reference_pool_save) |
| [Tensorflow.Keras](https://keras.io) | [Sequential](https://keras.io/guides/sequential_model/), [Model](https://keras.io/api/models/model/) with subclasses | [tf_keras](https://keras.io/api/models/model_saving_apis/) |
| [TensorFlow](https://www.tensorflow.org) | [Checkpoint](https://www.tensorflow.org/api_docs/python/tf/train/Checkpoint), [Module](https://www.tensorflow.org/api_docs/python/tf/Module) with subclasses | [tf_pure](https://www.tensorflow.org/api_docs/python/tf/saved_model) |
| [LightGBM](https://lightgbm.readthedocs.io) | [LGBMClassifier](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.LGBMClassifier.html), [LGBMRegressor](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.LGBMRegressor.html), [LGBMRanker](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.LGBMRanker.html) | [lgbm](https://lightgbm.readthedocs.io/en/v3.3.2/pythonapi/lightgbm.Booster.html#lightgbm.Booster.save_model) |
| [XGBoost](https://lightgbm.readthedocs.io) | [XGBClassifier](https://xgboost.readthedocs.io/en/latest/python/python_api.html#module-xgboost.sklearn), [XGBRegressor](https://xgboost.readthedocs.io/en/latest/python/python_api.html#module-xgboost.sklearn), [XGBRanker](https://xgboost.readthedocs.io/en/latest/python/python_api.html#module-xgboost.sklearn) | [xgb](https://xgboost.readthedocs.io/en/latest/python/python_intro.html#training) |
| [Torch](https://pytorch.org) | [Module](https://pytorch.org/docs/stable/notes/modules.html) with subclasses | [pt](https://pytorch.org/docs/stable/generated/torch.jit.save.html#torch.jit.save) |
| [ONNX](https://onnx.ai/) | [ModelProto](https://onnx.ai/onnx/api/classes.html#onnx.ModelProto) | [onnx](https://github.com/onnx/onnx/blob/main/docs/PythonAPIOverview.md) |

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
