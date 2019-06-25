# Среда исполнения на подкластерах

При создании кластера {{ dataproc-name }} вы можете выбрать версию образа (набор версий Hadoop и дополнительных компонентов). В каждую версию образа также входит Conda (менеджер Python-окружений) и набор инструментов машинного обучения.

На стадии Preview доступна только версия образа 1.0.

## Версия 1.0 {#1.0}

Версии Hadoop и компонентов:

* Hadoop 2.8.5
* Tez 0.9.1
* Hive 2.3.4
* ZooKeeper 3.4.6
* HBase 1.3.3
* Sqoop 1.4.6
* Oozie 4.3.0
* Spark 2.2.1
* Flume 1.8.0
* Zeppelin 0.7.3

Версии Python и библиотек машинного обучения:

* Python 3.7
* PyArrow 0.11.1
* ipykernel 5.1.0
* TensorFlow 1.13.1
* CatBoost 0.14.2
* LightGBM 2.2.3
* XGBoost 0.82
* scikit-learn 0.21.1
* pandas 0.24.2
* IPython 7.5.0
* Matplotlib 3.0.3