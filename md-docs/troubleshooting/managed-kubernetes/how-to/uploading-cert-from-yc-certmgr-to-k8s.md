# Как использовать сертификаты из Certificate Manager в балансировщиках нагрузки или в Managed Service for Kubernetes


## Описание сценария {#case-description}

* Необходимо использовать сертификат, выпущенный в Certificate Manager для приложения, запущенного в кластере Managed Service for Kubernetes;
* Необходимо получить сертификат, выпущенный в Certificate Manager для его загрузки в Managed Service for Kubernetes.

## Решение {#case-resolution}

Сертификаты, выпущенные в Certificate Manager, не подгружаются автоматически в приложения, запущенные в кластерах Managed Service for Kubernetes, а также внутри Application Load Balancer и Network Load Balancer.

Однократно получить файл с цепочкой сертификатов в формате PEM вы можете с помощью команды:

```
yc certificate-manager certificate content --id <CERTIFICATE_ID> --chain CERT_FILE_NAME_HERE.PEM
```

Этот вариант не предусматривает автоматического обновления сертификата в веб-приложении при перевыпуске сертификата.

## Если ничего не получилось {#if-issue-still-persists}

Если вышеописанные действия не помогли решить задачу, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:

1. Идентификатор сертификата в Certificate Manager.
1. Идентификатор кластера Managed Service for Kubernetes, Application Load Balancer или Network Load Balancer.
1. Описание желаемого результата.