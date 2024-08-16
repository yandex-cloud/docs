# Устранение ошибки `Timed out waiting for the condition` при монтировании PVC


## Описание проблемы {#issue-description}

При монтировании Persistent Volume Claim (*PVC*) в кластере {{ managed-k8s-name }} в выводе kubelet и журналах сервиса возникает ошибка:
```
Unable to attach or mount volumes: unmounted volumes=[<наименование_PVC>],
unattached volumes=[conf kube-api-access-r9rql data]: timed out waiting for the condition
```

## Решение {#issue-resolution}

Выполните перезапуск ВМ с рабочим узлом кластера, на котором находится под с проблемным хранилищем. В этом случае важно выполнить «холодный» перезапуск с отключением ВМ, чтобы процес QEMU на гипервизоре был перезапущен с другим идентификатором.

Для «холодного» перезапуска ВМ нажмите кнопку [**{{ ui-key.yacloud.common.stop }}**](../../../compute/operations/vm-control/vm-stop-and-start.md#stop), затем дождитесь отображения статуса `STOPPED` и повторно [запустите ВМ](../../../compute/operations/vm-control/vm-stop-and-start.md#start) из интерфейса консоли управления {{ compute-name }} или средствами YC CLI.
