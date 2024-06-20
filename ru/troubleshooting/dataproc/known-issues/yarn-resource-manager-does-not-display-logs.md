# Нет логов в YARN Resource Manager Web UI после выполнения заданий


## Описание проблемы {#issue-description}

Не получается посмотреть логи выполненного задания в интерфейсе YARN Resource Manager Web UI кластера {{ dataproc-name }}, при этом во время выполнения задания логи видны. При попытке посмотреть логи отображается сообщение:

```
Failed redirect for container_....

Failed while trying to construct the redirect url to the log server. Log Server url may not be configured
Local Logs:
java.lang.Exception: Unknown container. Container either has not started or has already completed or doesn't belong to this node at all.
```

## Решение {#issue-resolution}

На кластерах по умолчанию включена агрегация логов - после завершения работы контейнера его логи переносятся в HDFS. YARN UI отображает логи только тогда, когда они лежат непосредственно в файловой системе узла. Вот что мы можем порекомендовать:

* Получить логи из HDFS командой:

```
sudo -u hdfs hadoop fs -ls /var/log/yarn/
```

* Получить логи через CLI самого YARN:

```
yarn logs --applciation appId
```

* Настроить выгрузку логов в S3:

```
yc dataproc cluster update your_cluster \
--property yarn:yarn.nodemanager.remote-app-log-dir = s3a://<bucket_name>/yarn-logs/
--property yarn:yarn.log-aggregation.retain-seconds = -1
```

{% note tip %}

Чтобы в UI можно было смотреть логи завершенного приложения, необходимо выключить агрегацию логов. Через CLI это можно сделать следующей командой:

```
yc dataproc cluster update your_cluster --property yarn:yarn.log-aggregation-enable=false
```

{% endnote %}
