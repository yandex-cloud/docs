#### Что делать, если часть моих данных потеряется при обновлении версии {{ k8s }}? {#backups-update}

Данные не потеряются: перед [обновлением версии {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) {{ managed-k8s-name }} подготавливаем для них резервные копии. Вы можете самостоятельно настроить [резервное копирование кластера в {{ objstorage-full-name }}](../../managed-kubernetes/tutorials/kubernetes-backup.md). Также мы рекомендуем выполнять резервное копирование баз данных средствами самого приложения.

#### Можно ли настроить резервное копирование для кластера {{ k8s }}? {#cluster-backups}

Данные в [кластерах {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров {{ managed-k8s-name }} и хранить их в [{{ objstorage-name }}](../../storage/) или другом хранилище.

Подробнее читайте в разделе [{#T}](../../managed-kubernetes/tutorials/kubernetes-backup.md).

#### Будут ли ресурсы простаивать при обновлении версии {{ k8s }}? {#downtime-update}

При обновлении [мастера](../../managed-kubernetes/concepts/index.md#master) будут простаивать ресурсы Control Plane. Поэтому такие операции, как [создание](../../managed-kubernetes/operations/node-group/node-group-create.md) или [удаление](../../managed-kubernetes/operations/node-group/node-group-delete.md) [группы узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group), будут недоступны. Пользовательская нагрузка на приложение продолжит обрабатываться.

Если значение `max_expansion` больше нуля, при обновлении групп узлов {{ managed-k8s-name }} создаются новые узлы. На них переводится вся нагрузка, а старые группы узлов удаляются. Простой при этом будет равен времени рестарта [пода](../../managed-kubernetes/concepts/index.md#pod) при перемещении в новую группу узлов {{ managed-k8s-name }}.

#### Можно ли обновить кластер {{ managed-k8s-name }} в один этап? {#upgrade-in-one-step}

Зависит от того, с какой на какую версию вы хотите перевести кластер {{ managed-k8s-name }}. За один этап кластер {{ managed-k8s-name }} можно обновить только до следующей минорной версии относительно текущей. Обновление до более новых версий производится в несколько этапов, например: 1.19 → 1.20 → 1.21. Подробнее в разделе [{#T}](../../managed-kubernetes/operations/update-kubernetes.md#cluster-upgrade).

Если при обновлении вы хотите пропустить промежуточные версии, [создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) с нужной версией и перенесите нагрузку на него со старого кластера.

#### Обновляется ли плагин Container Network Interface вместе с кластером {{ managed-k8s-name }}? {#upgrade-cni}

Да. Если вы используете контроллеры [Calico](../../managed-kubernetes/concepts/network-policy.md#calico) и [Cilium](../../managed-kubernetes/concepts/network-policy.md#cilium), они обновляются вместе с кластером {{ managed-k8s-name }}. Чтобы обновить кластер {{ managed-k8s-name }}, выполните одно из действий:
* [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) с нужной версией и перенесите нагрузку на него со старого кластера.
* [Обновите кластер {{ managed-k8s-name }} вручную](../../managed-kubernetes/operations/update-kubernetes.md#cluster-manual-upgrade).

Чтобы вовремя получать обновления для текущей версии кластера {{ managed-k8s-name }}, [настройте автоматическое обновление](../../managed-kubernetes/operations/update-kubernetes.md#cluster-auto-upgrade).

#### Можно ли прислать вам YAML-файл с конфигурацией, чтобы вы применили его к моему кластеру? {#configs}

Нет. Вы можете использовать kubeconfig-файл, чтобы применить YAML-файл с конфигурацией кластера самостоятельно.

#### Можете ли вы установить Web UI Dashboard, Rook и другие инструменты? {#install-tools}

Нет. Вы можете установить все необходимые инструменты самостоятельно.

#### Что делать, если после обновления {{ k8s }} не подключаются тома? {#pvc}

Если после обновления {{ k8s }} вы получаете ошибку:

```text
AttachVolume.Attach failed for volume "pvc":
Attach timeout for volume yadp-k8s-volumes/pvc
```

Проверьте установленную версию и настройки [CSI для {{ objstorage-name }}](../../managed-kubernetes/operations/volumes/s3-csi-integration.md). Используйте [поддерживаемый драйвер](https://github.com/yandex-cloud/k8s-csi-s3) и инструкции по его установке. Обновление отдельного компонента `csi-attacher` не является универсальным решением ошибки.

Если проблема сохраняется, [создайте запрос в техническую поддержку]({{ link-console-support }}). Укажите идентификатор кластера, время возникновения ошибки и результаты диагностики.

#### Как использовать сертификаты из {{ certificate-manager-name }} в приложениях в {{ managed-k8s-name }}? {#application-certificate}

Способ подключения зависит от приложения и контроллера, который завершает TLS-соединение. Для [Ingress-контроллера {{ alb-name }}](../../managed-kubernetes/alb-ref/ingress.md) можно указать сертификат из {{ certificate-manager-name }} в конфигурации Ingress.

Если приложению нужен сертификат в виде файла, [выгрузите сертификат](../../certificate-manager/operations/managed/cert-get-content.md) из {{ certificate-manager-name }} и настройте его использование в приложении. Однократная выгрузка не обеспечивает обновление файла в приложении при перевыпуске сертификата: обновление нужно настроить отдельно.

#### Как задать часовой пояс для приложения или CronJob? {#timezone}

Для приложения настройте преобразование времени в нужный часовой пояс средствами самого приложения.

Для CronJob укажите часовой пояс в поле `.spec.timeZone`, например `Europe/Moscow`. Если поле не задано, расписание интерпретируется в часовом поясе kube-controller-manager. Подробнее о [часовых поясах CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#time-zones).

Если для вашего сценария требуется изменить часовой пояс самого узла, [создайте запрос в техническую поддержку]({{ link-console-support }}). Укажите идентификатор кластера и опишите сценарий.
