# Subcluster runtime environment

When creating a {{ dataproc-name }} cluster, you can choose the image version (versions of Hadoop and additional components). 

The components for both [current](#current-images) and [deprecated](#deprecated-images) image versions are listed below. Each image version includes [Conda](https://docs.conda.io/en/latest/) (a Python environment management system) and a set of machine learning tools.


## Current images {#current-images}

| Components | Image 1.4 | Image 2.0 |
| ---------  | --------- | --------- |
| **Hadoop and component versions** |
| Hadoop | 2.10.0 | 3.2.2 |
| Tez | 0.9.2 | 0.10.0 |
| Hive |  2.3.6 | 3.1.2 |
| Zookeeper | 3.4.14 | 3.4.14 |
| HBase | 1.3.5 | 2.2.7 |
| Sqoop | 1.4.7 | — |
| Oozie | 5.2.0 | 5.2.1 |
| Spark | 2.4.6 | 3.0.2 |
| Flume | 1.9.0 | — |
| Zeppelin | 0.8.2 | 0.9.0 |
| Livy | 0.7.0 | 0.8.0 |
| **Python and machine learning library versions** |
| Python | 3.7.9 | 3.8.10 |
| PyArrow | 0.13.0 | 1.0.1 |
| ipykernel | 5.1.3 | 5.3.4 |
| TensorFlow | 1.15.0 | — |
| CatBoost | 0.20.2 | — |
| PyHive | 0.6.1 | 0.6.1 |
| LightGBM | 2.3.0 | — |
| XGBoost | 0.90 | — |
| scikit-learn | 0.21.3 | 0.23.2 |
| pandas | 0.25.3 | 1.1.3 |
| IPython | 7.9.0 | 7.19.0 |
| Matplotlib | 3.1.1 | 3.2.2 |


## Deprecated images {#deprecated-images}

{% note info %}

These image versions are deprecated. Consider using the [recent image versions](#current-images).

{% endnote %}

| Components | Image 1.0 | Image 1.1 | Image 1.2 | Image 1.3 |
| ---------  | --------- | --------- | --------- | --------- |
| **Hadoop and component versions** |
| Hadoop | 2.8.5 | 2.10.0 | 2.10.0 | 2.10.0 |
| Tez | 0.9.1 | 0.9.2 | 0.9.2 | 0.9.2 |
| Hive | 2.3.4 | 2.3.6 | 2.3.6 |2.3.6 |
| Zookeeper | 3.4.6 | 3.4.14 | 3.4.14 | 3.4.14 |
| HBase | 1.3.3 | 1.3.5 | 1.3.5 | 1.3.5 |
| Sqoop | 1.4.6 | 1.4.7 | 1.4.7 | 1.4.7 |
| Oozie | 4.3.0 | 4.3.1 | 5.2.0 | 5.2.0 |
| Spark | 2.2.1 | 2.4.4 | 2.4.6 | 2.4.6 |
| Flume | 1.8.0 | 1.8.0 | 1.9.0 | 1.9.0 |
| Zeppelin | 0.7.3 | 0.8.2 | 0.8.2 | 0.8.2 |
| Livy | — | — | — | 0.7.0 |
| **Python and machine learning library versions** |
| Python | 3.7 | 3.7.5 | 3.7.7 | 3.7.9 |
| PyArrow | 0.11.1 | 0.13.0 | 0.13.0 | 0.13.0 |
| ipykernel | 5.1.0 | 5.1.3 | 5.1.3 | 5.1.3 |
| TensorFlow | 1.13.1 | 1.15.0 | 1.15.0 | 1.15.0 |
| CatBoost | 0.14.2 | 0.20 | 0.20 | 0.20.2 |
| PyHive | — | 0.6.1 | 0.6.1 | 0.6.1 |
| LightGBM | 2.2.3 | 2.3.0 | 2.3.0 | 2.3.0 |
| XGBoost | 0.82 | 0.90 | 0.90 | 0.90 |
| scikit-learn | 0.21.1 | 0.21.3 | 0.21.3 | 0.21.3 |
| pandas | 0.24.2 | 0.25.3 | 0.25.3 | 0.25.3 |
| IPython | 7.5.0 | 7.9.0 | 7.9.0 | 7.9.0 |
| Matplotlib | 3.0.3 | 3.1.1 | 3.1.1 | 3.1.1 |
