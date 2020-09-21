# List of pre-installed software and available commands

{{ ml-platform-short-name }} already has pre-installed packages for data analysis and machine learning. If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook cell.

## List of pre-installed packages {#preinstalled-packages}

* [NumPy](https://numpy.org/)
* [Pandas](https://pandas.pydata.org/)
* [scikit-learn](https://scikit-learn.org/stable/)
* [TensorFlow](https://www.tensorflow.org/)
* [TensorFlow Datasets](https://www.tensorflow.org/datasets)
* [Keras](https://keras.io/)
* [Matplotlib](https://matplotlib.org/)
* [CatBoost](https://catboost.ai/docs/concepts/about.html)
* [XGBoost](https://xgboost.ai/)
* [LightGBM](https://lightgbm.readthedocs.io/en/latest/)
* [Pytorch](https://pytorch.org/)
* [Scipy](https://www.scipy.org/)
* [NLTK](https://www.nltk.org/)
* [DVC](https://dvc.org/)
* [PyArrow](https://arrow.apache.org/docs/python/)
* [Requests](https://requests.readthedocs.io/en/master/)
* [packaging](https://packaging.pypa.io/en/latest/)
* [cloudpickle](https://github.com/cloudpipe/cloudpickle)
* [pybase64](https://pybase64.readthedocs.io/en/stable/)
* [Moto](https://github.com/spulec/moto)
* [cfn-lint](https://www.npmjs.com/package/cfn-lint)
* [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)
* [botocore](https://botocore.amazonaws.com/v1/documentation/api/latest/index.html)
* [S3Fs](https://s3fs.readthedocs.io/en/latest/)
* [YaDisk](https://yadisk.readthedocs.io/en/latest/)
* [Google API Python Client](https://github.com/googleapis/google-api-python-client)
* [oauth2client](https://oauth2client.readthedocs.io/en/latest/)
* [tqdm](https://tqdm.github.io/)
* [PycURL](http://pycurl.io/docs/latest/index.html)
* [scp](https://github.com/jbardin/scp.py)
* [autograd](https://github.com/HIPS/autograd)
* [torchvision](https://pytorch.org/docs/stable/torchvision/index.html)
* [Neural Tangents](https://neural-tangents.readthedocs.io/en/latest/)
* [Dask](https://dask.org/)
* [Gensim](https://radimrehurek.com/gensim/)
* [Transformers](https://huggingface.co/transformers/index.html)
* [fastai](https://docs.fast.ai/)
* [SoundFile](https://pysoundfile.readthedocs.io/en/latest/)
* [librosa](https://librosa.org/doc/latest/index.html)
* [wget](https://pypi.org/project/wget/)
* [sounddevice](https://python-sounddevice.readthedocs.io/en/0.4.0/)
* [psutil](https://psutil.readthedocs.io/en/latest/)
* [plotly](https://plotly.com/python/)

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

