# Как создать внутренний Ingress-контроллер


## Описание сценария {#case-description}

Необходимо создать внутренний Ingress-контроллер.

## Решение {#case-resolution}

{% note info %}

Возможность использования внутренних контроллеров находится в Preview — обратитесь в [службу поддержки](https://console.cloud.yandex.ru/support?section=contact), чтобы её включить.

{% endnote %}

Чтобы Ingress создавал внутренний контроллер, нужно настроить ряд параметров в файле `values.yaml` и использовать его при установке контроллера через Helm Chart:

1. [Выставьте в true](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L526) значение параметра `internal.enabled`;
2. [Добавьте](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L528) следующие аннотации в сервис:

```
yandex.cloud/load-balancer-type: internal
yandex.cloud/subnet-id: <id подсети из которой будет выдан внутренний IP>
```

3. [Отключите использование внешнего контроллера](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L521), выставив параметр `external.enabled` в false.

После создания балансировщика через Helm Chart, проверки Health Check будут добавлены автоматически.