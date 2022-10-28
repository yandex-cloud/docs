# Yandex Data Science Virtual Machine

Yandex Data Science Virtual Machine (DSVM) is a virtual machine with pre-installed popular libraries for data analytics and machine learning. A DSVM can be used as an environment for training models and experimenting with data.

For information about how to create DSVMs, see the section [{#T}](quickstart.md).

## Pre-installed software {#dsvm-specs}

Operating system: Ubuntu 18.04

Installed packages:

- Package manager [conda](https://conda.io/docs/index.html) with Python 2.7 and Python 3.6.
   
- Tools for interactive and reproducible computations [{{ jlab }} Notebook](http://jupyter.org/index.html) and [{{ jlab }}Lab](https://jupyterlab.readthedocs.io/en/stable/).
   
- Machine Learning libraries:
   
   - [CatBoost](https://catboost.yandex/);
   - [LightGBM](https://github.com/Microsoft/LightGBM);
   - [XGBoost](https://xgboost.readthedocs.io/en/latest/);
   - [TensorFlow](https://www.tensorflow.org/);
   - [PyTorch](https://pytorch.org/).
- Container management system [Docker](https://www.docker.com).
   
- Console clients of version control systems: [SVN](https://subversion.apache.org/), [Git](https://git-scm.com/), and [Mercurial](https://www.mercurial-scm.org/).
- The [NumPy](https://anaconda.org/intel/numpy), [scikit-learn](https://anaconda.org/intel/scikit-learn), and [SciPy](https://anaconda.org/intel/scipy) libraries optimized with the Intel Math Kernel Library and Data Analytics Acceleration Library.
- Optimized libraries for working with images: [libjpeg-turbo](https://libjpeg-turbo.org) and [Pull-SIMD](https://github.com/uploadcare/pillow-simd#pillow-simd).

