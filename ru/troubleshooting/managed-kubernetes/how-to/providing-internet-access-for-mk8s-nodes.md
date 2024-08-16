# Как выдать узлам {{ k8s }} доступ в интернет


## Описание проблемы {#case-description}

В процессе подключения к внешним адресам с узлов без доступа в интернет возникает ошибка:

```text
Failed to pull image "{{ registry }}/***": rpc error: code = Unknown desc
Error response from daemon: Gethttps://{{ registry }}/v2/: net/http: 
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

## Решение {#case-resolution}

Есть два способа предоставить доступ в интернет узлам кластера:

1. [Использовать NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway).
1. Добавить каждому узлу публичный IP-адрес через настройку группы.
