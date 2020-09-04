# Список предустановленного ПО

В {{ ml-platform-short-name }} уже предустановлены пакеты для анализа данных и машинного обучения. Если какого-то пакета вам не хватает, вы можете [установить его](../operations/projects/install-dependencies.md) прямо из ячейки ноутбука.

## Список предустановленных пакетов {#preinstalled-packages}

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

## Версии пакетов {#versions}

Чтобы посмотреть версию установленного пакета, выполните в ячейке ноутбука команду: 
```js
%pip show <Имя пакета>
```

Чтобы посмотреть список установленных пакетов и их версии, выполните в ячейке ноутбука команду:
```js
%pip list
```

#### См. также {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)