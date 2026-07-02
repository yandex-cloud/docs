[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for Kubernetes](../index.md) > Как изменить часовой пояс на узлах кластера Managed Service for Kubernetes

# Как изменить часовой пояс на узлах кластера Managed Service for Kubernetes


## Описание сценария {#case-description}

* Необходимо изменить заданный по умолчанию часовой пояс на узлах кластера Managed Service for Kubernetes;
* Необходимо задать часовой пояс для одного или нескольких узлов кластера Managed Service for Kubernetes.

## Решение {#case-resolution}

Все виртуальные машины, создаваемые в Yandex Cloud, включая узлы кластеров Managed Service for Kubernetes, получают время с физического гипервизора в часовом поясе `UTC+0`.

{% note tip %}

Рекомендуем обновить код вашего приложения для изменения времени на требуемое, например `UTC+3` (Московский регион).

{% endnote %}

Установка часового пояса также может быть важна при запуске событий CronJob, поскольку по умолчанию для таких событий в Managed Service for Kubernetes используется время, указанное на Controller Manager. Более подробная инструкция по указанию часового пояса для определенных событий CronJob приведена [в документации от разработчиков Kubernetes](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#time-zones).

## Если ничего не получилось {#if-nothing-worked}

Если вышеописанные действия не помогли решить задачу, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:

1. Идентификатор кластера Managed Service for Kubernetes.
1. Описание сценария использования, который предусматривает использование произвольных часовых поясов.