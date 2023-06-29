# Устранение ошибки timed out waiting for the condition при монтировании PVC

## Описание проблемы {#issue-description}
При монтировании Persistent Volume Claim (PVC) в кластере Managed Service for Kubernetes в выводе Kubelet и журналах сервиса возникает ошибка:
```
Unable to attach or mount volumes: unmounted volumes=[<НАИМЕНОВАНИЕ_PVC>],
unattached volumes=[conf kube-api-access-r9rql data]: timed out waiting for the condition
```

## Решение {#issue-resolution}
Выполните перезапуск ВМ с worker-нодой кластера, на которой находится под с проблемным хранилищем.
В этом случае важно выполнить «холодный» перезапуск с отключением ВМ, чтобы процес QEMU на гипервизоре был перезапущен с другим идентификатором.

Для «холодного» перезапуска ВМ воспользуйтесь кнопкой [«Остановить»](../../../compute/operations/vm-control/vm-stop-and-start.md#stop), затем дождитесь отображения статуса `Stopped` и повторно [запустите ВМ](../../../compute/operations/vm-control/vm-stop-and-start.md#start) из интерфейса консоли управления Compute Cloud или средствами YC CLI.
