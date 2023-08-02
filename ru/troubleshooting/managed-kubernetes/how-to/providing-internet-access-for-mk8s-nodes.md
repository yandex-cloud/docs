# Выдача нодам Kubernetes доступа в Интернет


## Описание проблемы {#case-description}

В процессе подключения к внешним адресам с нод без доступа в интернет возникает ошибка:

```text
Failed to pull image "cr.yandex/***": rpc error: code = Unknown desc
Error response from daemon: Gethttps://cr.yandex/v2/: net/http: 
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

## Решение {#case-resolution}

Есть несколько способов предоставить доступ в Интернет нодам кластера:

1. [Включить NAT](https://cloud.yandex.ru/docs/vpc/operations/enable-nat) в Интернет для подсети нод;
2. [Использовать NAT-шлюз](https://cloud.yandex.ru/docs/vpc/concepts/gateways#nat-gateway);
3. Добавить каждой ноде публичный IP-адрес через настройку нод-группы.
