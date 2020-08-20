# Список предустановленного ПО и доступные команды

В разделе описаны предустановленное ПО и команды, доступные для выполнения в ноутбуке.

## Список предустановленных пакетов {#preinstalled-packages}

Пакеты для анализа данных и машинного обучения уже предустановлены. Если какого-то пакета вам не хватает, вы можете [установить его](../operations/projects/install-dependencies.md) прямо из ячейки ноутбука.

* [NumPy](https://numpy.org/)
* [Pandas](https://pandas.pydata.org/)
* [scikit-learn](https://scikit-learn.org/stable/)
* [TensorFlow](https://www.tensorflow.org/)
* [Keras](https://keras.io/)
* [Matplotlib](https://matplotlib.org/)
* [CatBoost](https://catboost.ai/docs/concepts/about.html)
* [XGBoost](https://xgboost.ai/)
* [LightGBM](https://lightgbm.readthedocs.io/en/latest/)
* [Pytorch](https://pytorch.org/)
* [Scipy](https://www.scipy.org/)
* [NLTK](https://www.nltk.org/)

### Версии пакетов {#versions}

Чтобы посмотреть версию установленного пакета, выполните в ячейке ноутбука команду `%pip show <Имя пакета>`.

Чтобы посмотреть список установленных пакетов и их версии, выполните в ячейке ноутбука команду `%pip list`.

## Список доступных команд {#magic}

Список команд, доступных в ноутбуке, составлен из списка стандартных команд с некоторыми ограничениями и дополнениями. Ознакомьтесь со списком стандартных команд в [документации IPython](https://ipython.readthedocs.io/en/stable/interactive/magics.html). Ограничения и дополнения представлены ниже.

### Заблокированные стандартные команды {#block}

Стандартные команды, недоступные для выполнения в ноутбуке: 
* `%%bash`
* `%%perl`
* `%%python`
* `%%python2`
* `%%python3`
* `%%ruby`
* `%%script`
* `%%sh`

### Дополнительные команды {#extension}

Дополнительные команды, доступные для выполнения в ноутбуке: 
* `%%state_exclude [имена переменных]` — исключает указанные переменные из сохранения состояния.
* `%%state_include [имена переменных]` — добавляет указанные переменные в сохранение состояния.
* `%%state_include_all` — возвращает все переменные в сохранение состояния.
* `%%state_exclude_ls` — возвращает список всех переменных, которые были исключены из сохранения состояния.

#### См. также {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)