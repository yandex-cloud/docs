# Runtime environment

When creating a {{ dataproc-name }} cluster, you can choose the image version (versions of components).

Below is a list of  [current](#current-images) and [deprecated](#deprecated-images) {{ dataproc-name }} images. Each image version includes [conda](https://docs.conda.io/en/latest/), [pip](https://pip.pypa.io/en/stable/installation/) (Python environment managers), and a collection of pre-installed libraries.

{% note info %}

{{ dataproc-name }} does not support automatic OS or software updates. For stable and reliable cluster performance, check for and install updates manually on a regular basis. This requires [connecting to your cluster hosts over SSH](../operations/connect.md).

{% endnote %}

## Current images {#current-images}


{% note info %}

Access to image 2.1 is provided upon request. Contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}



| Components | Image 1.4 | Image 2.0 | Image 2.1 (beta) |
| ------------ | --------- | --------- | ---------------- |
| **Component versions** |
| Hadoop | 2.10.0 | 3.2.2 | 3.3.2 |
| Tez | 0.9.2 | 0.10.0 | 0.10.1 |
| Hive | 2.3.6 | 3.1.2 | — |
| Zookeeper | 3.4.14 | 3.4.14 | 3.5.9 |
| HBase | 1.3.5 | 2.2.7 | 2.4.9 |
| Sqoop | 1.4.7 | — | — |
| Oozie | 5.2.0 | 5.2.1 | — |
| Spark | 2.4.6 | 3.0.3 | 3.2.1 |
| Flume | 1.9.0 | — | — |
| Zeppelin | 0.8.2 | 0.9.0 | 0.10.0 |
| Livy | 0.7.0 | 0.8.0 | 0.8.0 |
| **Versions of Python and machine learning libraries** |
| Python | 3.7.9 | 3.8.10 | 3.8.13 |
| PyArrow | 0.13.0 | 1.0.1 | 4.0.0 |
| ipykernel | 5.1.3 | 5.3.4 | 5.3.4 |
| TensorFlow | 1.15.0 | — | — |
| CatBoost | 0.20.2 | — | — |
| PyHive | 0.6.1 | 0.6.1 | 0.6.5 |
| LightGBM | 2.3.0 | — | — |
| XGBoost | 0.90 | — | — |
| scikit-learn | 0.21.3 | 0.23.2 | 0.24.1 |
| pandas | 0.25.3 | 1.1.3 | 1.2.4 |
| koalas | — | 1.7.0 | 1.8.2 |
| numpy | — | 1.19.2 | 1.20.1 |
| boto3 | — | 1.16.7 | 1.16.7 |
| IPython | 7.9.0 | 7.19.0 | 7.22.0 |
| Matplotlib | 3.1.1 | 3.2.2 | 3.4.2 |




## Deprecated images {#deprecated-images}

{% note info %}

These images are deprecated. We recommend using [the latest image versions](#current-images). Existing clusters will continue to run, but you won't be able to create new clusters with deprecated versions.

{% endnote %}

| Components | Image 1.0 | Image 1.1 | Image 1.2 | Image 1.3 |
| ------------ | --------- | --------- | --------- | --------- |
| **Component versions** |
| Hadoop | 2.8.5 | 2.10.0 | 2.10.0 | 2.10.0 |
| Tez | 0.9.1 | 0.9.2 | 0.9.2 | 0.9.2 |
| Hive | 2.3.4 | 2.3.6 | 2.3.6 | 2.3.6 |
| Zookeeper | 3.4.6 | 3.4.14 | 3.4.14 | 3.4.14 |
| HBase | 1.3.3 | 1.3.5 | 1.3.5 | 1.3.5 |
| Sqoop | 1.4.6 | 1.4.7 | 1.4.7 | 1.4.7 |
| Oozie | 4.3.0 | 4.3.1 | 5.2.0 | 5.2.0 |
| Spark | 2.2.1 | 2.4.4 | 2.4.6 | 2.4.6 |
| Flume | 1.8.0 | 1.8.0 | 1.9.0 | 1.9.0 |
| Zeppelin | 0.7.3 | 0.8.2 | 0.8.2 | 0.8.2 |
| Livy | — | — | — | 0.7.0 |
| **Versions of Python and machine learning libraries** |
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

