# Yandex Data Science Virtual Machine

Yandex Data Science Virtual Machine (DSVM) is a VM with pre-installed popular libraries for data analysis and machine learning. A DSVM can be used as an environment for training models and experimenting with data.

For information on how to create DSVMs, see [{#T}](quickstart.md).

## Pre-installed software {#dsvm-specs}

Operating system: Ubuntu 18.04.

Installed packages:
* [Conda](https://conda.io/docs/index.html) with Python 2.7 and Python 3.6.
* [{{ jlab }} Notebook](http://jupyter.org/index.html) and [{{ jlab }}Lab](https://jupyterlab.readthedocs.io/en/stable/) for interactive and reproducible computations.
* ML libraries:
  * [CatBoost](https://catboost.yandex/).
  * [LightGBM](https://github.com/Microsoft/LightGBM).
  * [PyTorch](https://pytorch.org/).
  * [TensorFlow](https://www.tensorflow.org/).
  * [XGBoost](https://xgboost.readthedocs.io/en/latest/).
* [Docker](https://www.docker.com).
* Console clients of version control systems: [Git](https://git-scm.com/), [Mercurial](https://www.mercurial-scm.org/), and [SVN](https://subversion.apache.org/).
* [NumPy](https://anaconda.org/intel/numpy), [scikit-learn](https://anaconda.org/intel/scikit-learn), and [SciPy](https://anaconda.org/intel/scipy) libraries optimized with Intel Math Kernel Library and Data Analytics Acceleration Library.
* Optimized libraries for working with images: [libjpeg-turbo](https://libjpeg-turbo.org) and [Pull-SIMD](https://github.com/uploadcare/pillow-simd#pillow-simd).