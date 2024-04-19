# Устранение ошибки `Failed authentication with /`


## Описание проблемы {#issue-description}

В журналах работы кластера {{ mkf-full-name }} появляются ошибки:

```
{
 hostname: "[rc1c-sjgXXXXXXXXXXXXXX.mdb.yandexcloud.net](http://rc1c-sjgXXXXXXXXXXXXXX.mdb.yandexcloud.net/)",
 message: "\[SocketServer listenerType=ZK_BROKER, nodeId=1\] 
 Failed authentication with /10.X.X.X (channelId=10.X.X.X:9091-10.X.X.Y:43598-3694) 
 (SSL handshake failed) (org.apache.kafka.common.network.Selector)",
 origin: "kafka_server",
 severity: "INFO"
 }
```

## Решение {#issue-resolution}

Наблюдаемые ошибки указывают на проблемы подключения со стороны приложения. Проверьте параметры и логи приложения, запущенного на хосте `10.X.X.X`  на наличие ошибок.

Наиболее популярные причины проблемы могут быть в неправильно указанном протоколе, сертификате или секретах для авторизации в кластере Kafka. Например, ошибка `SSL handshake failed`  указывает на проблемы с сертификатами SSL/TLS.