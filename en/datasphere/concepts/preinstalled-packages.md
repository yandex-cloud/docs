# List of pre-installed software and available commands

This section describes preinstalled software and commands that you can run in a notebook.

## List of pre-installed packages {#preinstalled-packages}

Packages for data analysis and machine learning are pre-installed. If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook cell.

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

### Package versions {#versions}

To view the version of the installed package, run the command `%pip show <Package name>` in the notebook cell.

To view the list of installed packages and their versions, run the `%pip list` command in the notebook cell.

## List of available commands {#magic}

The list of commands available in the notebook is made up of standard commands with some restrictions and additions. View the list of standard commands in the [IPython documentation](https://ipython.readthedocs.io/en/stable/interactive/magics.html). Restrictions and additions are given below.

### Disabled standard commands {#block}

Standard commands that aren't available in the notebook:

* `%%bash`
* `%%perl`
* `%%python`
* `%%python2`
* `%%python3`
* `%%ruby`
* `%%script`
* `%%sh`

### Additional commands {#extension}

Additional commands available in the notebook:

* `%%state_exclude [variable names]`: Excludes the specified variables when saving a state.
* `%%state_include [variable names]`: Adds the specified variables when saving a state.
* `%%state_include_all`: Returns all variables when saving a state.
* `%%state_exclude_ls`: Returns a list of all variables that were excluded when saving a state.

#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)

