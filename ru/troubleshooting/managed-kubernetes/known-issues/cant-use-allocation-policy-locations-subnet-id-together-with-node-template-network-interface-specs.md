# Устранение ошибки `Can't use allocation_policy.locations.subnet_id together with node_template.network_interface_specs`


## Описание проблемы {#issue-description}

Попытка создания новой группы узлов кластера {{ managed-k8s-name }} средствами {{ TF }}-провайдера, утилиты YC CLI или через API завершается ошибкой:

```
can't use "allocation_policy.locations[0].subnet_id" together with "node_template.network_interface_specs"
```

## Решение {#issue-resolution}

Ошибка указывает на наличие в команде или манифесте взаимоисключающих параметров. Попробуйте создать группу узлов средствами [Консоли управления]({{ link-console-main }}) или явным образом указать имя или идентификатор облачной подсети перед запуском операции выполнения.

{% cut "Пример для YC CLI" %}

```bash
yc managed-kubernetes node-group create  \
--name my-sample-k8s-cluster-nodegroup-1 \   
--cluster-name my-sample-k8s-cluster     \
--platform standard-v3                   \
--cores 2                                \
--memory 4                               \
--core-fraction 100                      \
--disk-type network-hdd                  \
--disk-size 30                           \
--fixed-size 1                           \
--network-interface subnets=$SUBNET_ID   \
--async
```

где `$SUBNET_ID` – идентификатор облачной подсети, внутри которой следует создать группу узлов.

{% endcut %}

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Идентификатор кластера {{ managed-k8s-name }}
1. Дату и время запуска проблемной операции создания группы узлов.
1. Скриншот или текстовый вывод сообщения об ошибке, получаемой при попытке создания группы узлов.