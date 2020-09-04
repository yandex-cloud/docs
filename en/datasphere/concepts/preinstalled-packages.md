# List of pre-installed software and available commands

{{ ml-platform-short-name }} already has pre-installed packages for data analysis and machine learning. If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook cell.

## List of pre-installed packages {#preinstalled-packages}

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

## Package versions {#versions}

To view the version of the installed package, in the notebook cell run the command:
```js
%pip show <Package name>
```

To view the list of installed packages and their versions, in the notebook cell run the command:
```js
%pip list
```

#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)

