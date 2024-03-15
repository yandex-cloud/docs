# Устранение ошибки Multi-Attach error for volume


## Описание проблемы {#issue-description}

При попытке использовать `persistent volume` на нескольких подах одновременно возникют ошибки вида:
* `Multi-Attach error for volume "<volume-name>" Volume is already used by pod(s) <pod1>, <pod2>`;
* `Multi-Attach error for volume "<volume-name>" Volume is already exclusively attached to one node and can't be attached to another`.

## Решение {#issue-resolution}

По умолчанию с кластером поставляются классы хранилищ, которые основаны на сетевых дисках — а они не поддерживают режим множественного доступа. Подробнее об этом пишем в [документации](../../../managed-kubernetes/operations/volumes/manage-storage-class.md). Это ограничения нашего [драйвера](https://github.com/yandex-cloud/k8s-csi-s3), использовать его для множественного доступа невозможно, даже если создать собственный класс хранилища на его основе.

Также такие ошибки могут появляться, если поды, которые должны использовать `volume`, находятся [на разных нодах](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).

При необходимости использовать `ReadWriteMany`, рекомендуем воспользоваться CSI для нашего объектного хранилища, потому что тома на его основе поддерживают такой режим доступа:

Автоматическая установка через маркетплейс или `Helm`-чарт описана [здесь](../../../managed-kubernetes/operations/applications/csi-s3.md), а ручная интеграция — [здесь](../../../managed-kubernetes/operations/volumes/s3-csi-integration.md).


## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, то можно попробовать организовать хранилище самостоятельно. Некоторые из возможных решений также поддерживают множественный доступ (например, nfs или CEPH). Подробнее можно прочесть в [официальной документации k8s](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes).
