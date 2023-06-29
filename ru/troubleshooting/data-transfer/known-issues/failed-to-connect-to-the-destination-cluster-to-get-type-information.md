# Устранение ошибки failed to connect to the destination cluster to get type information

## Описание проблемы {#issue-description}

При запуске трансфера отображается текст сообщения об ошибке: 
```
Cannot retrieve table information from the source database: failed to resolve storage: failed to connect to the destination cluster to get type information: unable to get master host: unable to create имя-сервиса service client: All hosts are unavailable
hostname resolving error (lookup имя-хоста.mdb.yandexcloud.net on 127.0.0.1:53) failed to connect to `host=имя-хоста.mdb.yandexcloud.net user= database=`: hostname resolving error
```

## Решение {#issue-resolution}

Вероятно, в параметрах облачной подсети кластера-приёмника или источника в данном трансфере указаны адреса сторонних DNS-серверов. В этом случае во время выполнения трансфера возникнет ошибка `hostname resolving error`.

Подробнее об этом пишем в разделе [Сеть в Yandex Data Transfer](../../../data-transfer/concepts/network) нашей документации.

В качестве решения проблемы вы можете либо настроить сторонние DNS-сервера таким образом, чтобы они разрешали имена хостов кластера, либо добавить эндпоинт кластера по IP (как внешнюю инсталляцию).
