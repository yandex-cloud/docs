В кластере {{ dataproc-name }} ваш код выполняется в [сессиях](https://livy.incubator.apache.org/docs/latest/rest-api.html#session). Сессия хранит промежуточное состояние до тех пор, пока вы не удалите ее или кластер. У каждого кластера есть сессия по умолчанию. Ее идентификатор равен идентификатору проекта.

Для управления сессиями используйте следующие команды:
* `%create_livy_session --cluster <имя кластера> --id <идентификатор сессии>` — создание сессии;
* `%delete_livy_session --cluster <имя кластера> --id <идентификатор сессии>` — удаление сессии.

Например, следующая команда создаст в кластере `my-new-cluster` сессию `ses1`, которая позволит каждому процессу использовать максимум 4 ядра CPU в кластере и 4 ГБ RAM (подробнее см. в [документации Spark](https://spark.apache.org/docs/latest/configuration.html)):

```python
%create_livy_session --cluster my-new-cluster --id ses1 --conf spark.cores.max=4 --conf spark.executor.memory=4g
```

Полный список параметров livy-сессии см. в [официальной документации](https://livy.incubator.apache.org/docs/latest/rest-api.html).
