# Хосты группы узлов Managed Service for Kubernetes долго находятся в статусе Reconciling

## Описание проблемы {#issue-description}
Некоторые (или все) виртуальные машины группы узлов Managed Service for Kubernetes находятся в статусе Reconciling более 20 минут.

## Диагностика и воспроизведение {#diagnosis-and-reproduction}

* Проверьте уровень потребления квот по Managed Service for Kubernetes. Если уровень потребления близок к текущему значению квот, [сформируйте запрос на увеличение квот]({{ link-console-quotas }}). У вас должна быть роль `quota-manager.requestOperator` или выше (`editor` или `admin`);
* Если квоты не превышены, проверьте состояние виртуальных машин, принадлежащих группе узлов, командой:
```
yc managed-kubernetes node-group list-nodes <node_group_id> --format yaml
```

Наличие в выводе этой команды сообщения `Kubelet stopped posting node status` означает, что внутри виртуальной машины, принадлежащей группе узлов, произошел сбой операционной системы или прикладных сервисов, отвечающих за работоспособность этого хоста в составе группы узлов.

## Решение {#issue-resolution}

1. Подключитесь по SSH к проблемной виртуальной машине. 
О том, как подключиться к узлу по SSH, пишем в [документации](../../../managed-kubernetes/operations/node-connect-ssh.md).

2. Выполните следующие команды в интерактивном сеансе проблемной виртуальной машины:
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
Сервисы должны быть в статусе `Active` и в логах не должно быть ошибок.

{% endnote %}

Альтернативно вы можете перезагрузить виртуальную машину средствами консоли управления или YC CLI.