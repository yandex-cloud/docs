# Получение реального IP-адреса источника в заголовках запросов


## Описание задачи {#case-description}

* Необходимо журналировать внешние IP-адреса клиентов, устанавливающих соединения с балансировщиком.

## Решение

Когда трафик перехватывается между клиентами и серверами, журналы доступа к серверу содержат только IP-адрес прокси-сервера или балансировки нагрузки.

В Network Load Balancer IP-адрес удаленного хоста, инициирующего запрос, виден по умолчанию без дополнительных настроек, если не используется Ingress Controller для Kubernetes. При его использовании для сохранения реальных адресов запросов необходимо вручную настроить политику `TrafficPolicy: local` по [инструкции](../../../managed-kubernetes/operations/create-load-balancer.md#lb-create).

При использовании Application Load Balancer IP-адрес источника запроса фигурирует в заголовке `X-forwarded-for`.
Заголовок `X-Forwarded-For` необходим для идентификации происхождения IP-адреса пользователя, подключающегося к веб-серверу через HTTP-прокси или балансировщик нагрузки.

Если необходимо журналировать внешние адреса в журнал веб-сервера, потребуется изменить его конфигурацию.

{% list tabs %}

- Nginx

    Если в качестве бэкенда используется веб-сервер Nginx, то в конфигурации службы Nginx внутри блока `log_format` должна содержаться переменная `http_x_forwarded_for`:
    ```
    log_format main '$remote_addr - $http_x_forwarded_for - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" $request_time';
    ```

- Apache 

    Если в качестве бэкенда используется веб-сервер Apache, в конфигурации службы Apache должна содержаться переменная `%{X-Forwarded-For}`:

    ```text
    Log format config

    LogFormat "%{X-Forwarded-For}i %l %u %t "%r" %>s %b "%{Referer}i" "%{User-Agent}i"" common
    SetEnvIf X-Forwarded-For "^......." forwarded
    CustomLog "logs/access_log" common env=forwarded
    ```

{% endlist %}

После изменения конфигурации веб-сервера и его перезапуска вы увидите в журналах внешние IP-адреса клиентов.
Например, если на Ingress приходит запрос с IP 123.34.56.67:

```text
kubectl logs nginx-ingress-nginx-ingress-xxxxx
123.34.56.67 - - [28/Jun/2022:09:11:32 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/7.68.0" "-"
```

В логах пода с бэкендом этот адрес будет фигурировтаь внутри заголовка `X-Forwarded-For`:

```text
kubectl logs -n demo-ns pod/nginx
10.20.129.8 - - [28/Jun/2022:09:11:32 +0000] "GET / HTTP/1.1" 200 615 "-" "curl/7.68.0" "123.34.56.67"
```
