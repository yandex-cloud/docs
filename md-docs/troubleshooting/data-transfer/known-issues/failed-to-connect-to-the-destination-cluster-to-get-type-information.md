[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Data Transfer](../index.md) > Устранение ошибки `failed to connect to the destination cluster to get type information`

# Устранение ошибки `failed to connect to the destination cluster to get type information`


### Ошибка hostname resolving error {#hostname-resolving-error}

Текст ошибки:

```text
Cannot retrieve table information from the source database: failed to resolve storage: failed to connect to the destination cluster to get type information: unable to get master host: unable to create имя-сервиса service client: All hosts are unavailable
hostname resolving error (lookup имя-хоста.mdb.yandexcloud.net on 127.0.0.1:53) failed to connect to `host=имя-хоста.mdb.yandexcloud.net user= database=`: hostname resolving error
```

Ошибка возникает, если в параметрах облачной подсети кластера-приемника или источника в трансфере указаны адреса сторонних DNS-серверов. В этом случае во время выполнения трансфера может возникнуть ошибка `hostname resolving error`.

Подробнее о сетевых настройках сервиса в разделе [Сеть в Yandex Data Transfer](../../../data-transfer/concepts/network.md).

**Решение:**

* Настройте сторонние DNS-серверы так, чтобы они разрешали имена хостов кластера.
* Если это невозможно, добавьте эндпоинт кластера по IP-адресу как внешнюю инсталляцию.