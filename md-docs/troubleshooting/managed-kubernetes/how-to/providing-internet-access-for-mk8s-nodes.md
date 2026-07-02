[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for Kubernetes](../index.md) > Как выдать узлам Kubernetes доступа в интернет

# Как выдать узлам Kubernetes доступ в интернет


## Описание проблемы {#case-description}

В процессе подключения к внешним адресам с узлов без доступа в интернет возникает ошибка:

```text
Failed to pull image "cr.yandex/***": rpc error: code = Unknown desc
Error response from daemon: Gethttps://cr.yandex/v2/: net/http: 
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

## Решение {#case-resolution}

Есть два способа предоставить доступ в интернет узлам кластера:

1. [Использовать NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway).
1. Добавить каждому узлу публичный IP-адрес через настройку группы.