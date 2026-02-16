{{ ml-platform-name }} использует системные переменные для работы с кластером {{ dataproc-name }}. Не переопределяйте значения следующих переменных:
* `sc`
* `spark`
* `HiveContext`
* `StreamingContext`
* `SqlContext`

Следующие глобальные конфигурации Spark переопределяются параметрами, необходимыми для выполнения заданий Livy:
* `spark.jars`
* `spark.submit.deployMode`
* `spark.yarn.dist.archives`
* `spark.submit.pyFiles`
* `spark.yarn.maxAppAttempts`
* `spark.yarn.submit.waitAppCompletion`

Чтобы задать дополнительные библиотеки для сессии Spark, используйте параметры `spark.driver.extraClassPath` и `spark.executor.extraClassPath`, а сами библиотеки разместите на всех узлах во время создания кластера {{ dataproc-name }} с помощью скриптов инициализации. Пути к используемым библиотекам должны совпадать на всех узлах кластера.