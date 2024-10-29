# Устранение проблем с монтированием томов к подам кластера {{ managed-k8s-name }} средствами Container Storage Interface для S3


## Описание проблемы {#issue-description}

При попытке монтирования тома к подам кластера {{ managed-k8s-name }} с использованием драйвера `csi-s3` отображается сообщение об ошибке:

```
Warning FailedAttachVolume attachdetach-controller AttachVolume.Attach failed for volume "<volume_name>" : Attach timeout for volume <volume_name>
Warning FailedMount kubelet Unable to attach or mount volumes: unmounted volumes=[<volume_name>], unattached volumes=[<volume_name>]: timed out waiting for the condition
```

## Решение {#issue-resolution}

Наиболее частая причина проблемы — использование устаревшей версии `csi-attacher` в кластере {{ managed-k8s-name }}. Воспользуйтесь [актуальной версией файла `attacher.yaml`](https://github.com/yandex-cloud/k8s-csi-s3/blob/master/deploy/kubernetes/attacher.yaml). Для этого выполните следующую команду:

```
kubectl apply -f attacher.yaml
```

Вам также может понадобиться обновить остальные `csi-s3`. Для обновления локально склонируйте [репозиторий с актуальной версией драйвера `csi-s3`](https://github.com/yandex-cloud/k8s-csi-s3), после чего обновите компоненты кластера {{ managed-k8s-name }} командами:

```
cd <каталог_со_склонированным_репозиторием>
cd deploy/kubernetes
kubectl apply -f provisioner.yaml
kubectl apply -f attacher.yaml
kubectl apply -f csi-s3.yaml
```

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Идентификатор кластера {{ managed-k8s-name }}.
1. Вывод команды `kubectl describe` для проблемных PV, PVC и подов.