[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > Вопросы и ответы > Настройка и обновление

# Настройка и обновление

* [Что делать, если часть моих данных потеряется при обновлении версии Kubernetes?](#backups-update)

* [Можно ли настроить резервное копирование для кластера Kubernetes?](#cluster-backups)

* [Будут ли ресурсы простаивать при обновлении версии Kubernetes?](#downtime-update)

* [Можно ли обновить кластер Managed Service for Kubernetes в один этап?](#upgrade-in-one-step)

* [Обновляется ли плагин Container Network Interface вместе с кластером Managed Service for Kubernetes?](#upgrade-cni)

* [Можно ли прислать вам YAML-файл с конфигурацией, чтобы вы применили его к моему кластеру?](#configs)

* [Можете ли вы установить Web UI Dashboard, Rook и другие инструменты?](#install-tools)

* [Что делать, если после обновления Kubernetes не подключаются тома?](#pvc)

* [Как использовать сертификаты из Certificate Manager в приложениях в Managed Service for Kubernetes?](#application-certificate)

* [Как задать часовой пояс для приложения или CronJob?](#timezone)

#### Что делать, если часть моих данных потеряется при обновлении версии Kubernetes? {#backups-update}

Данные не потеряются: перед [обновлением версии Kubernetes](../concepts/release-channels-and-updates.md) Managed Service for Kubernetes подготавливаем для них резервные копии. Вы можете самостоятельно настроить [резервное копирование кластера в Yandex Object Storage](../tutorials/kubernetes-backup.md). Также мы рекомендуем выполнять резервное копирование баз данных средствами самого приложения.

#### Можно ли настроить резервное копирование для кластера Kubernetes? {#cluster-backups}

Данные в [кластерах Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../concepts/index.md#node-group) кластеров Managed Service for Kubernetes и хранить их в [Object Storage](../../storage/index.md) или другом хранилище.

Подробнее читайте в разделе [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](../tutorials/kubernetes-backup.md).

#### Будут ли ресурсы простаивать при обновлении версии Kubernetes? {#downtime-update}

При обновлении [мастера](../concepts/index.md#master) будут простаивать ресурсы Control Plane. Поэтому такие операции, как [создание](../operations/node-group/node-group-create.md) или [удаление](../operations/node-group/node-group-delete.md) [группы узлов Managed Service for Kubernetes](../concepts/index.md#node-group), будут недоступны. Пользовательская нагрузка на приложение продолжит обрабатываться.

Если значение `max_expansion` больше нуля, при обновлении групп узлов Managed Service for Kubernetes создаются новые узлы. На них переводится вся нагрузка, а старые группы узлов удаляются. Простой при этом будет равен времени рестарта [пода](../concepts/index.md#pod) при перемещении в новую группу узлов Managed Service for Kubernetes.

#### Можно ли обновить кластер Managed Service for Kubernetes в один этап? {#upgrade-in-one-step}

Зависит от того, с какой на какую версию вы хотите перевести кластер Managed Service for Kubernetes. За один этап кластер Managed Service for Kubernetes можно обновить только до следующей минорной версии относительно текущей. Обновление до более новых версий производится в несколько этапов, например: 1.19 → 1.20 → 1.21. Подробнее в разделе [Обновление кластера](../operations/update-kubernetes.md#cluster-upgrade).

Если при обновлении вы хотите пропустить промежуточные версии, [создайте кластер Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-create.md) с нужной версией и перенесите нагрузку на него со старого кластера.

#### Обновляется ли плагин Container Network Interface вместе с кластером Managed Service for Kubernetes? {#upgrade-cni}

Да. Если вы используете контроллеры [Calico](../concepts/network-policy.md#calico) и [Cilium](../concepts/network-policy.md#cilium), они обновляются вместе с кластером Managed Service for Kubernetes. Чтобы обновить кластер Managed Service for Kubernetes, выполните одно из действий:
* [Создайте кластер Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-create.md) с нужной версией и перенесите нагрузку на него со старого кластера.
* [Обновите кластер Managed Service for Kubernetes вручную](../operations/update-kubernetes.md#cluster-manual-upgrade).

Чтобы вовремя получать обновления для текущей версии кластера Managed Service for Kubernetes, [настройте автоматическое обновление](../operations/update-kubernetes.md#cluster-auto-upgrade).

#### Можно ли прислать вам YAML-файл с конфигурацией, чтобы вы применили его к моему кластеру? {#configs}

Нет. Вы можете использовать kubeconfig-файл, чтобы применить YAML-файл с конфигурацией кластера самостоятельно.

#### Можете ли вы установить Web UI Dashboard, Rook и другие инструменты? {#install-tools}

Нет. Вы можете установить все необходимые инструменты самостоятельно.

#### Что делать, если после обновления Kubernetes не подключаются тома? {#pvc}

Если после обновления Kubernetes вы получаете ошибку:

```text
AttachVolume.Attach failed for volume "pvc":
Attach timeout for volume yadp-k8s-volumes/pvc
```

Проверьте установленную версию и настройки [CSI для Object Storage](../operations/volumes/s3-csi-integration.md). Используйте [поддерживаемый драйвер](https://github.com/yandex-cloud/k8s-csi-s3) и инструкции по его установке. Обновление отдельного компонента `csi-attacher` не является универсальным решением ошибки.

Если проблема сохраняется, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). Укажите идентификатор кластера, время возникновения ошибки и результаты диагностики.

#### Как использовать сертификаты из Certificate Manager в приложениях в Managed Service for Kubernetes? {#application-certificate}

Способ подключения зависит от приложения и контроллера, который завершает TLS-соединение. Для [Ingress-контроллера Application Load Balancer](../alb-ref/ingress.md) можно указать сертификат из Certificate Manager в конфигурации Ingress.

Если приложению нужен сертификат в виде файла, [выгрузите сертификат](../../certificate-manager/operations/managed/cert-get-content.md) из Certificate Manager и настройте его использование в приложении. Однократная выгрузка не обеспечивает обновление файла в приложении при перевыпуске сертификата: обновление нужно настроить отдельно.

#### Как задать часовой пояс для приложения или CronJob? {#timezone}

Для приложения настройте преобразование времени в нужный часовой пояс средствами самого приложения.

Для CronJob укажите часовой пояс в поле `.spec.timeZone`, например `Europe/Moscow`. Если поле не задано, расписание интерпретируется в часовом поясе kube-controller-manager. Подробнее о [часовых поясах CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#time-zones).

Если для вашего сценария требуется изменить часовой пояс самого узла, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). Укажите идентификатор кластера и опишите сценарий.