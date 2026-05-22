# Как узнать внешний IP-адрес узла Managed Service for Kubernetes


## Описание сценария {#case-description}

Необходимо узнать внешний IP-адрес узла, на котором запущен под.

## Решение {#case-resolution}

IP адрес узла может вернуть запрос в сервис метаданных:

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true
```

Подробнее об этом способе мы рассказываем в разделе документации Compute Cloud [о получении метаданных](../../../compute/operations/vm-info/get-info.md).

Если у узла Managed Service for Kubernetes есть доступ в интернет, вы также можете послать запрос к стороннему  ресурсу, возвращающему внешний IP-адрес, например:

```
curl http://ifconfig.co
```

## Если ничего не получилось {#if-nothing-worked}

Если вышеописанные действия не помогли решить задачу, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:

1. Идентификатор кластера Managed Service for Kubernetes.
1. Описание сценария использования, который вы хотите реализовать.