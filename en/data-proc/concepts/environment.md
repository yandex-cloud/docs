# Runtime environment

When creating a {{ dataproc-name }} cluster, you can choose the image version that determines component versions.

Below is a list of [current](#current-images) and [deprecated](#deprecated-images) {{ dataproc-name }} images. Each image version includes [conda](https://docs.conda.io/en/latest/), [pip](https://pip.pypa.io/en/stable/installation/) (Python environment managers), and a collection of pre-installed libraries.

{{ dataproc-name }} has no native mechanism for image version upgrades. To upgrade your image version, create a new cluster. To make sure the version you use is always up-to-date, automate the creation and removal of temporary {{ dataproc-name }} clusters using [{{ maf-full-name }}](../tutorials/airflow-automation.md). To run jobs automatically, apart from {{ maf-name }} you can also use [{{ ml-platform-full-name }}](../tutorials/datasphere-integration.md).

## Current images {#current-images}


{% note info %}

Access to image 2.2 is provided on request. Contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}



| Components   | Image 2.0 | Image 2.1^1^ | Image 2.2 (beta) |
| ------------ | --------- |--------------|------------------|
| **Component versions**                                     |
| Hadoop       | 3.2.2     | 3.3.2        | 3.3.2            |
| Tez          | 0.10.0    | 0.10.1       | —                |
| Hive         | 3.1.2     | —            | —                |
| Zookeeper    | 3.4.14    | —            | —                |
| HBase        | 2.2.7     | —            | —                |
| Oozie        | 5.2.1     | —            | —                |
| Spark        | 3.0.3     | 3.3.2^2^     | 3.5.0            |
| Zeppelin     | 0.9.0     | 0.10.0       | —                |
| Livy         | 0.8.0     | 0.8.0        | 0.8.0            |
| **Versions of Python and machine learning libraries**           |
| Python       | 3.8.10    | 3.8.13       | 3.11.10          |
| PyArrow      | 1.0.1     | 4.0.0        | 14.0.2           |
| ipykernel    | 5.3.4     | 5.3.4        | 6.29.5           |
| PyHive       | 0.6.1     | 0.6.1        | 0.7.0            |
| scikit-learn | 0.23.2    | 0.24.1       | 1.5.1            |
| pandas       | 1.1.3     | 1.2.4        | 2.2.2            |
| koalas       | 1.7.0     | 1.8.2        | —                |
| numpy        | 1.19.2    | 1.20.1       | 1.26.4           |
| boto3        | 1.16.7    | 1.16.7       | 1.34.154         |
| IPython      | 7.19.0    | 7.22.0       | 8.27.0           |
| Matplotlib   | 3.2.2     | 3.4.2        | 3.9.2            |

^1^ Stable since 2.1.15.

^2^ Spark 3.3.2 is supported in {{ dataproc-name }} images starting from version 2.1.4. Images versions 2.1.1-2.1.3 contain Spark 3.2.1.

## Deprecated images {#deprecated-images}

{% note info %}

These images are deprecated. We recommend using [the latest image versions](#current-images). Existing clusters will continue running, but you will not be able to create new clusters with deprecated versions.

{% endnote %}

| Components                           | Image 1.4 |
|--------------------------------------| --------- |
| **Component versions**                           |
| Hadoop                               | 2.10.0    |
| Tez                                  | 0.9.2     |
| Hive                                 | 2.3.6     |
| Zookeeper                            | 3.4.14    |
| HBase                                | 1.3.5     |
| Sqoop                                | 1.4.7     |
| Oozie                                | 5.2.0     |
| Spark                                | 2.4.6     |
| Flume                                | 1.9.0     |
| Zeppelin                             | 0.8.2     |
| Livy                                 | 0.7.0     |
| **Versions of Python and machine learning libraries** |
| Python                               | 3.7.9     |
| PyArrow                              | 0.13.0    |
| ipykernel                            | 5.1.3     |
| TensorFlow                           | 1.15.0    |
| CatBoost                             | 0.20.2    |
| PyHive                               | 0.6.1     |
| LightGBM                             | 2.3.0     |
| XGBoost                              | 0.90      |
| scikit-learn                         | 0.21.3    |
| pandas                               | 0.25.3    |
| IPython                              | 7.9.0     |
| Matplotlib                           | 3.1.1     |