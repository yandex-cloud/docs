[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [Managed Service for Kubernetes](../index.md) > Хосты группы узлов Managed Service for Kubernetes долго находятся в статусе `RECONCILING`

# Хосты группы узлов Managed Service for Kubernetes долго находятся в статусе `RECONCILING`


## Описание проблемы {#issue-description}

Некоторые или все виртуальные машины группы узлов Managed Service for Kubernetes находятся в статусе `RECONCILING` более 20 минут.

## Диагностика и воспроизведение {#issue-diagnostics-and-reproduction}

* Проверьте уровень потребления квот по Managed Service for Kubernetes. Если уровень потребления близок к текущему значению квот, [сформируйте запрос на увеличение квот](https://console.yandex.cloud/cloud?section=quotas). У вас должна быть роль `quota-manager.requestOperator` или выше: `editor` или `admin`;
* Если квоты не превышены, проверьте состояние виртуальных машин, принадлежащих группе узлов, командой:

```
yc managed-kubernetes node-group list-nodes <node_group_id> --format yaml
```

Наличие в выводе этой команды сообщения `Kubelet stopped posting node status` означает, что внутри виртуальной машины, принадлежащей группе узлов, произошел сбой операционной системы или прикладных сервисов, отвечающих за работоспособность этого хоста в составе группы.

## Решение {#issue-resolution}

Для решение проблемы выполните следующие действия:

1. Подключитесь по SSH к проблемной виртуальной машине. Как подключиться к узлу по SSH, пишем в [документации Managed Service for Kubernetes](../../../managed-kubernetes/operations/node-connect-ssh.md).
1. Выполните следующие команды в интерактивном сеансе проблемной виртуальной машины:
```
sudo service containerd restart
sudo service kubelet restart
```

{% note info %}

Для проверки состояния сервисов рекомендуем использовать следующие команды:
```
service containerd status
service kubelet status
```
Сервисы должны быть в статусе `ACTIVE`, и в логах не должно быть ошибок.

{% endnote %}

Вы также можете перезагрузить виртуальную машину средствами [Консоли управления](https://console.yandex.cloud) или YC CLI.