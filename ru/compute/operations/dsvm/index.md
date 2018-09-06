# Yandex Data Science Virtual Machine

Yandex Data Science Virtual Machine (далее — DSVM) — это виртуальная машина с предустановленными популярными платформами для машинного обучения. DSVM можно использовать как среду для обучения и экспериментов с современными моделями на данных.

Как создать DSVM читайте в разделе [Начало работы с DSVM](quickstart.md).

## Предустановленное программное обеспечение {#dsvm-specs}

Операционная система
:   Ubuntu 18.0.4

Установленные пакеты
:   - Система управления пакетами и окружениями [conda](https://conda.io/docs/index.html) с Python 2.7 и Python 3.6.
    - Веб-приложения [Jupyter Notebook/Lab](http://jupyter.org/index.html).
    - Пакеты Machine Learning:
        - [CatBoost](https://catboost.yandex/);
        - [LightGBM](https://github.com/Microsoft/LightGBM);
        - [XGBoost](https://xgboost.readthedocs.io/en/latest/);
        - [TensorFlow](https://www.tensorflow.org/);
        - [PyTorch](https://pytorch.org/);
        - [Keras](https://keras.io/).
    - Компиляторы: Clang, GCC, Node.js, Go.
    - Система управления контейнерами [Docker](https://www.docker.com).
    - Консольные клиенты систем контроля версий: [SVN](https://subversion.apache.org/), [Git](https://git-scm.com/), [Mercurial](https://www.mercurial-scm.org/).

