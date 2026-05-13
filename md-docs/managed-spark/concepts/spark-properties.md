# Свойства Apache Spark™

Свойства Apache Spark™ определяют конфигурацию заданий, например ресурсы запуска, параметры динамической аллокации и параллелизма, SQL-параметры и т. д. Чтобы переопределить конфигурацию, вы можете изменить свойства Apache Spark™ на уровне отдельного задания при его создании.

Свойства Apache Spark™ задаются и хранятся в формате «ключ-значение». Вы можете задать любые свойства, указанные в [официальной документации Apache Spark™](https://spark.apache.org/docs/latest/configuration.html), кроме:

* `spark.kubernetes.*` — свойства Kubernetes нельзя переопределить, так как это может привести к некорректной работе кластера Yandex Managed Service for Apache Spark™.
* `spark.yarn.*` — Yandex Managed Service for Apache Spark™ не использует YARN.