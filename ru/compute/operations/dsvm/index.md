# Yandex Data Science Virtual Machine

Yandex Data Science Virtual Machine (DSVM) — это виртуальная машина с предустановленными популярными библиотеками для анализа данных и машинного обучения. DSVM можно использовать как среду для обучения моделей и экспериментов с данными.

Как создать DSVM читайте в разделе [[!TITLE]](quickstart.md).

## Предустановленное программное обеспечение {#dsvm-specs}

Операционная система
:   Ubuntu 18.04

Установленные пакеты
:   - Менеджер пакетов [conda](https://conda.io/docs/index.html) с Python 2.7 и Python 3.6.
    - Инструменты для интерактивных и воспроизводимых вычислений [Jupyter Notebook](http://jupyter.org/index.html) и [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/).
    - Библиотеки Machine Learning:
        - [CatBoost](https://catboost.yandex/);
        - [LightGBM](https://github.com/Microsoft/LightGBM);
        - [XGBoost](https://xgboost.readthedocs.io/en/latest/);
        - [TensorFlow](https://www.tensorflow.org/);
        - [PyTorch](https://pytorch.org/);
        - [Keras](https://keras.io/).
    - Компиляторы: Clang, GCC, Node.js, Go.
    - Система управления контейнерами [Docker](https://www.docker.com).
    - Консольные клиенты систем контроля версий: [SVN](https://subversion.apache.org/), [Git](https://git-scm.com/), [Mercurial](https://www.mercurial-scm.org/).

