# Yandex Data Science Virtual Machine

Yandex Data Science Virtual Machine (DSVM) — это виртуальная машина с предустановленными популярными библиотеками для [анализа данных](../../../glossary/data-analytics.md) и машинного обучения. DSVM можно использовать как среду для обучения моделей и экспериментов с данными.

Как создать DSVM читайте в разделе [{#T}](quickstart.md).

## Предустановленное программное обеспечение {#dsvm-specs}

Операционная система: Ubuntu 18.04

Установленные пакеты:
* Менеджер пакетов [conda](https://conda.io/docs/index.html) с Python 2.7 и Python 3.6.
* Инструменты для интерактивных и воспроизводимых вычислений [{{ jlab }} Notebook](http://jupyter.org/index.html) и [{{ jlab }}Lab](https://jupyterlab.readthedocs.io/en/stable/).
* Библиотеки Machine Learning:
  * [CatBoost](https://catboost.yandex/).
  * [LightGBM](https://github.com/Microsoft/LightGBM).
  * [PyTorch](https://pytorch.org/).
  * [TensorFlow](https://www.tensorflow.org/).
  * [XGBoost](https://xgboost.readthedocs.io/en/latest/).
* Система управления контейнерами [Docker](https://www.docker.com).
* Консольные клиенты [систем контроля версий](../../../glossary/vcs.md): [Git](https://git-scm.com/), [Mercurial](https://www.mercurial-scm.org/) и [SVN](https://subversion.apache.org/).
* Библиотеки [NumPy](https://anaconda.org/intel/numpy), [scikit-learn](https://anaconda.org/intel/scikit-learn) и [SciPy](https://anaconda.org/intel/scipy), оптимизированные с помощью Intel Math Kernel Library и Data Analytics Acceleration Library.
* Оптимизированные библиотеки для работы с изображениями: [libjpeg-turbo](https://libjpeg-turbo.org), [Pillow-SIMD](https://github.com/uploadcare/pillow-simd#pillow-simd).