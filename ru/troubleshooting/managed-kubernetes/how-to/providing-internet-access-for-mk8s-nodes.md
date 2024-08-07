# Выдача нодам Kubernetes доступа в Интернет


## Описание проблемы {#case-description}

В процессе подключения к внешним адресам с нод без доступа в интернет возникает ошибка:

```text
Failed to pull image "{{ registry }}/***": rpc error: code = Unknown desc
Error response from daemon: Gethttps://{{ registry }}/v2/: net/http: 
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```

## Решение {#case-resolution}

Есть несколько способов предоставить доступ в Интернет нодам кластера:

1. [Использовать NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway);
2. Добавить каждой ноде публичный IP-адрес через настройку нод-группы.
