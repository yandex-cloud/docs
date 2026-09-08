---
title: Миграция из публичного облака в {{ managed-k8s-name }}
description: Руководство по переносу рабочих нагрузок {{ k8s }} из публичного облака в {{ managed-k8s-name }}.
---

# Миграция из публичного облака в {{ managed-k8s-name }}

В этом руководстве описан перенос рабочих нагрузок {{ k8s }} из управляемого сервиса другого облачного провайдера в {{ managed-k8s-name }}.

Ключевой принцип миграции — поэтапный перенос с параллельной работой кластеров. Это позволяет минимизировать влияние на production-сервисы и сохранить возможность отката.

Чтобы перенести рабочие нагрузки в {{ managed-k8s-name }}:

1. [Разработайте план миграции](#inventory).
1. [Подготовьте инфраструктуру {{ yandex-cloud }}](#infrastructure).
1. [Перенесите образы контейнеров](#images).
1. [Перенесите stateful-нагрузки](#stateful).
1. [Перенесите stateless-нагрузки](#stateless).
1. [Настройте балансировщики и переключите DNS](#dns).
1. [Завершите миграцию](#finalization).


## Необходимые платные ресурсы {#paid-resources}

* Мастер {{ managed-k8s-name }} ([тарифы {{ managed-k8s-name }}](../../../managed-kubernetes/pricing.md)).
* Узлы кластера {{ managed-k8s-name }}: использование вычислительных ресурсов и хранилища ([тарифы {{ compute-full-name }}](../../../compute/pricing.md)).
* Публичные IP-адреса для мастера и узлов кластера {{ managed-k8s-name }}, если для них включен публичный доступ ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md#prices-public-ip)).
* Каждый активный L7-балансировщик, если используется контроллер Gwin: использование вычислительных ресурсов ([тарифы {{ alb-name }}](../../../application-load-balancer/pricing.md)).
* Каждый сетевой балансировщик, если используются Service типа `LoadBalancer`: обработанный балансировщиком входящий и исходящий трафик ([тарифы {{ network-load-balancer-full-name }}](../../../network-load-balancer/pricing.md)).
* Сервис {{ container-registry-name }}: хранение перенесенных Docker-образов ([тарифы {{ container-registry-name }}](../../../container-registry/pricing.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными ([тарифы {{ objstorage-full-name }}](../../../storage/pricing.md)).
* Трансферы {{ data-transfer-name }}, если используется перенос управляемых баз данных ([тарифы {{ data-transfer-full-name }}](../../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Разработайте план миграции {#inventory}

Перед миграцией важно провести инвентаризацию рабочих нагрузок, оценить совместимость исходного и целевого кластеров, чтобы получить представление о сложности миграции, определить порядок переноса сервисов и план отката на случай критических проблем.

### Проведите инвентаризацию рабочих нагрузок {#workloads-inventory}

Получите список ресурсов исходного кластера для всех пространств имен — приложения, версии, зависимости, сетевые правила. Заранее ознакомьтесь с полным планом миграции, чтобы определить последовательность переноса ресурсов.

Убедитесь, что все stateful-нагрузки — управляемые базы данных, StatefulSets с PersistentVolume — имеют актуальные резервные копии.

Команда для выгрузки полного списка ресурсов из исходного кластера:

```bash
for ns in $(kubectl get ns --no-headers -o custom-columns=':metadata.name'); do
  echo "=== Namespace: $ns ==="
  kubectl get deploy,sts,ds,job,cronjob,svc,ingress,pvc,cm,secret,hpa,pdb -n $ns
done
```

Чек-лист инвентаризации:

#|
|| **Ресурс** | **Что зафиксировать** ||
|| Deployments, StatefulSets, DaemonSets, Jobs, CronJobs | Количество, namespace, образы ||
|| PersistentVolumeClaim | Размер, StorageClass, режим доступа (RWO/RWX) ||
|| Services типа LoadBalancer | Внешние IP, DNS-имена ||
|| Ingress / HTTPRoute | Хосты, TLS, IngressClass или GatewayClass ||
|| ConfigMap и Secret | Список ||
|| CustomResourceDefinitions и Operators | Список установленных CRD и операторов ||
|#

### Оцените совместимость {#compatibility-assessment}

Чтобы компоненты кластера корректно работали после миграции, предварительно оцените их совместимость с целевым кластером. Составьте список изменений, которые нужно внести в манифесты, а также план замены несовместимых компонентов исходного кластера на аналогичные в {{ yandex-cloud }}.

Объем изменений зависит от разницы версий {{ k8s }} в исходном и целевом кластерах. Чем больше разница, тем больше изменений потребуется — могут отличаться как вендор-специфичные CRD, так и стандартные API-группы {{ k8s }}. Поддерживаемые версии смотрите в разделе [Поддержка версий {{ k8s }}](../../concepts/k8s-supported-versions.md).

{% note tip %}

API-ресурсы можно сравнить командой `kubectl api-resources` на исходном и целевом кластерах, а также использовать утилиту для проверки совместимости манифестов [kube-no-trouble (kubent)](https://github.com/doitintl/kube-no-trouble).

{% endnote %}

При оценке особенно обратите внимание на следующие моменты:

* Проверьте наличие вендор-специфичных CRD исходного кластера, которые могут быть недоступны в {{ yandex-cloud }}. Замените компоненты [сервисами {{ yandex-cloud }}]({{ link-cloud-services }}) или [решениями из {{ marketplace-full-name }}](../../operations/applications/marketplace.md).
* PodSecurityPolicy удалены в {{ k8s }} версий 1.25 и выше. Если вы используете PodSecurityPolicy в исходном кластере, [мигрируйте на PodSecurity Admission](https://kubernetes.io/docs/tasks/configure-pod-container/migrate-from-psp).
* В манифестах замените классы хранилищ (`storageClassName`) на те, [которые поддерживаются в {{ managed-k8s-name }}](../../operations/volumes/manage-storage-class.md).
* Для L7-балансировки рекомендуется использовать [контроллер Gwin](../../alb-ref/gwin-index.md).

### Составьте план переноса сервисов {#planning}

Определите порядок переноса сервисов — начинайте с наименее критичных, заканчивайте production-нагрузками. Для переключения трафика используйте стратегию [сине-зеленого развертывания](https://martinfowler.com/bliki/BlueGreenDeployment.html) (blue-green deployment) без простоя или поэтапное переключение с окном обслуживания.

Учитывайте следующие критические моменты:

* Проведите полный цикл миграции на staging-среде перед переносом в production.
* Подготовьте план отката на случай критических проблем и согласуйте его с командой заранее.
* Координируйте работу с командами разработки и поддержки на всех этапах.
* Выберите часы минимальной нагрузки для выполнения миграции.
* Следите за метриками до, во время и после миграции с помощью [{{ monitoring-full-name }}](../../../monitoring/index.yaml).

## Подготовьте инфраструктуру {{ yandex-cloud }} {#infrastructure}

Подготовьте целевую среду в {{ yandex-cloud }} для переноса нагрузок.

### Настройте доступы и права {#access-and-permissions}

[Создайте сервисные аккаунты](../../../iam/operations/sa/create.md) для управления ресурсами кластера и рабочих узлов и [назначьте им роли](../../../iam/operations/sa/assign-role-for-sa.md).

{% cut "Какие роли могут потребоваться?" %}

Для управления кластером:

* `k8s.clusters.agent`
* `k8s.tunnelClusters.agent` — вместо `k8s.clusters.agent`, если кластер создается в режиме туннелирования.

Подробнее о [ролях {{ managed-k8s-name }}](../../security/index.md).

Для управления сетевыми ресурсами:

* `vpc.publicAdmin`
* `vpc.privateAdmin`
* `vpc.user`
* `vpc.bridgeAdmin` — если VPC находится в другом каталоге.

Подробнее о [ролях {{ vpc-short-name }}](../../../vpc/security/index.md).

Для работы с образами:

* `container-registry.images.puller`
* `cloud-registry.artifacts.puller` — если {{ cloud-registry-name }} используется как альтернатива {{ container-registry-short-name }}.

Подробнее о [ролях {{ container-registry-short-name }}](../../../container-registry/security/index.md) и [ролях {{ cloud-registry-name }}](../../../cloud-registry/security/index.md).

Если используется шифрование секретов:

* `kms.keys.encrypterDecrypter`

Подробнее о [ролях {{ kms-short-name }}](../../../kms/security/index.md).

Если используется {{ objstorage-short-name }} для резервного копирования:

* `storage.editor`

Подробнее о [ролях {{ objstorage-short-name }}](../../../storage/security/index.md).

{% endcut %}

### Создайте сетевую инфраструктуру {#network-infrastructure}

Настройте сетевую инфраструктуру, необходимую для работы кластера, — изолированную сеть с настроенными правилами безопасности для всех типов трафика кластера.

1. Создайте [VPC](../../../vpc/operations/network-create.md) и [подсети](../../../vpc/operations/subnet-create.md) в трех зонах для обеспечения высокой доступности.
1. Создайте [группы безопасности](../../operations/connect/security-groups.md) для изоляции трафика кластера, узлов и входящих соединений. Всего создается [пять групп](../../operations/connect/security-groups.md#apply).

### Создайте кластер {{ managed-k8s-name }} {#cluster}

1. [Создайте кластер](../../operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }}. Выбирайте версию {{ k8s }} не ниже версии в исходном кластере.
1. [Создайте группу узлов](../../operations/node-group/node-group-create.md) в каждой зоне доступности.

## Перенесите образы контейнеров {#images}

Последовательно [перенесите образы контейнеров](../../../container-registry/operations/docker-image/docker-image-push.md) в {{ container-registry-full-name }} с сохранением тегов и метаданных.

В качестве альтернативного сервиса для хранения образов можно использовать [{{ cloud-registry-full-name }}](../../../cloud-registry/index.yaml). В отличие от {{ container-registry-full-name }}, {{ cloud-registry-name }} предназначен для хранения не только Docker-образов, но и других типов артефактов.

## Перенесите stateful-нагрузки {#stateful}

Перенос stateful-нагрузок — управляемых баз данных, StatefulSets с PersistentVolumes — является самым сложным шагом миграции, так как они хранят данные и их нельзя пересоздать без потерь.

{% note warning %}

Убедитесь, что все stateful-нагрузки — управляемые базы данных, StatefulSets с PersistentVolume — имеют актуальные резервные копии.

{% endnote %}

### Перенесите управляемые базы данных {#managed-databases}

Для переноса управляемых баз данных используйте [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml). Сервис позволяет перенести данные с сохранением рабочего состояния источника и минимизировать время простоя для использующих его приложений.

Проверьте в [матрице трансферов](../../../data-transfer/transfer-matrix.md), что для вашей комбинации источника и приемника поддерживается трансфер типа [{{ dt-type-copy-repl }}](../../../data-transfer/concepts/transfer-lifecycle.md#copy-and-replication), и выполните миграцию в соответствии с [руководством для вашей базы данных](../../../data-transfer/tutorials/index.md#migration).

{% note info %}

Убедитесь, что открыт сетевой доступ от {{ data-transfer-name }} до базы данных источника. Актуальные диапазоны IP-адресов {{ data-transfer-name }} смотрите в [документации сервиса](../../../data-transfer/concepts/network.md#source-external).

{% endnote %}

Если {{ data-transfer-name }} не поддерживает нужный источник или требуется больший контроль, ознакомьтесь с документацией управляемых баз данных, куда запланирована миграция.

### Перенесите StatefulSets с PersistentVolumes {#statefulsets-persistent-volumes}

Для переноса StatefulSets с PersistentVolumes используйте [Velero](https://velero.io/) с резервным копированием файловой системы через `node-agent` (бывший kopia). Этот способ работает с любыми PVC и не зависит от CSI-провайдера.

{% note tip %}

Если объем данных меньше 50 ГБ или Velero недоступен, можно перенести данные вручную с помощью `rsync`. Для этого потребуется прямая сетевая связность между кластерами.

{% endnote %}

Порядок действий:

1. Создайте бакет в [{{ objstorage-full-name }}](../../../storage/index.yaml) для хранения резервных копий.

1. Создайте файл `credentials-velero` с данными [статического ключа доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для [сервисного аккаунта](../../../iam/operations/sa/create.md), имеющего доступ к бакету:

   ```
   [default]
   aws_access_key_id = <идентификатор_ключа>
   aws_secret_access_key = <секретный_ключ>
   ```
   
1. [Установите Velero CLI](https://velero.io/docs/main/basic-install/) на машину, с которой будет выполняться перенос и есть `kubectl`-доступ к исходному и целевому кластерам.

   {% note tip %}

   Версия плагина `velero-plugin-for-aws` в командах ниже может быть устаревшей. Актуальную версию смотрите в [документации Velero](https://velero.io/docs/main/supported-providers/).

   {% endnote %}

1. Установите Velero в исходном кластере:

   1. Убедитесь, что активен контекст исходного кластера:

      ```bash
      kubectl config current-context
      ```

   1. Создайте пространство имен для Velero:

      ```bash
      kubectl create namespace velero
      ```

   1. Установите Velero:

      ```bash
      velero install \
        --provider aws \
        --plugins velero/velero-plugin-for-aws:v1.14.0 \
        --bucket <имя_бакета> \
        --secret-file ./credentials-velero \
        --backup-location-config \
          region=ru-central1,s3ForcePathStyle=true,s3Url=https://storage.yandexcloud.net \
        --use-volume-snapshots=false \
        --use-node-agent \
        --uploader-type=kopia
      ```

      Где:

      * `--provider aws` — использует плагин AWS, совместимый с {{ objstorage-name }}.
      * `--use-node-agent` — включает DaemonSet для резервного копирования файловой системы.
      * `--uploader-type=kopia` — рекомендуемый загрузчик, работает быстрее restic.
      * `--use-volume-snapshots=false` — отключает CSI-снапшоты, данные переносятся через kopia.

   1. Проверьте статус компонентов:

      ```bash
      kubectl get pods -n velero
      kubectl get backupstoragelocation -n velero
      velero backup-location get
      ```

      `BackupStorageLocation` должен перейти в статус `Available`.

1. Создайте резервную копию нужных пространств имен:

   ```bash
   velero backup create migration-backup \
     --include-namespaces <пространство_имен> \
     --default-volumes-to-fs-backup \
     --wait
   ```

   Проверить статус и логи можно командами:

   ```bash
   velero backup describe migration-backup --details
   velero backup logs migration-backup
   ```

1. Установите Velero в целевом кластере {{ managed-k8s-name }}:

   1. Переключитесь на контекст целевого кластера:

      ```bash
      kubectl config use-context <контекст_целевого_кластера>
      ```

   1. Создайте пространство имен для Velero:

      ```bash
      kubectl create namespace velero
      ```

   1. Установите Velero с теми же параметрами, что и в исходном кластере, указав тот же бакет:

      ```bash
      velero install \
        --provider aws \
        --plugins velero/velero-plugin-for-aws:v1.14.0 \
        --bucket <имя_бакета> \
        --secret-file ./credentials-velero \
        --backup-location-config \
          region=ru-central1,s3ForcePathStyle=true,s3Url=https://storage.yandexcloud.net \
        --use-volume-snapshots=false \
        --use-node-agent \
        --uploader-type=kopia
      ```

   1. Убедитесь, что резервная копия из исходного кластера видна в целевом:

      ```bash
      kubectl get pods -n velero
      velero backup-location get
      velero backup get
      ```

      `BackupStorageLocation` должен перейти в статус `Available`, а резервная копия `migration-backup` — в статус `Completed`.

1. Восстановите данные из резервной копии:

   ```bash
   velero restore create \
     --from-backup migration-backup \
     --wait
   ```

   Проверить статус и логи можно командами:

   ```bash
   velero restore describe migration-backup --details
   velero restore logs migration-backup
   ```

   {% note tip %}

   Если StorageClass в исходном кластере и {{ managed-k8s-name }} называются по-разному, создайте ConfigMap с маппингом StorageClass до запуска восстановления:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: change-storage-class-config
     namespace: velero
     labels:
       velero.io/plugin-config: ""
       velero.io/change-storage-class: RestoreItemAction
   data:
     <исходный_storage_class>: yc-network-ssd
   ```

   {% endnote %}

## Перенесите stateless-нагрузки {#stateless}

Для переноса stateless-нагрузок экспортируйте манифесты исходного кластера, адаптируйте для применения в {{ yandex-cloud }} и примените в целевом кластере.

Чек-лист адаптации манифестов:

* Вендор-специфичные CRD заменены [сервисами {{ yandex-cloud }}]({{ link-cloud-services }}) или [решениями из {{ marketplace-full-name }}](../../operations/applications/marketplace.md).
* Устаревшие `apiVersion` заменены на актуальные для целевой версии Kubernetes.
* [Контроллер Gwin](../../alb-ref/gwin-index.md) (`gwin-default`) используется в `ingressClassName` и `gatewayClassName`.
* Аннотации ресурсов для настройки балансировщика нагрузки заменены на [аннотации {{ yandex-cloud }}](../../alb-ref/index.md).
* Ссылки на образы ведут в {{ container-registry-full-name }} (`cr.yandex/<id>/...`).

Для очистки манифестов можно использовать утилиту [kubectl-neat](https://github.com/itaysk/kubectl-neat).

## Настройте балансировщики и переключите DNS {#dns}

Переключите трафик на новый кластер.

{{ managed-k8s-name }} поддерживает два способа балансировки:

* [Gwin](../../alb-ref/gwin-index.md).
* Network Load Balancer — создается автоматически для Service типа `LoadBalancer`.

Порядок переключения трафика:

1. Разверните Gateway или Ingress-ресурсы в кластере {{ managed-k8s-name }}.
1. Получите внешние IP-адреса новых балансировщиков.
1. Проверьте работу сервисов через тестовые DNS-записи.
1. Снизьте TTL production DNS-записей заранее, затем поэтапно обновите их.
1. Следите за распространением DNS и обновлением TLS-сертификатов.

{% note tip %}

Если после переключения DNS обнаружены критические проблемы, верните DNS-записи на прежние IP-адреса. Исходный кластер должен оставаться в рабочем состоянии до истечения всех TTL и подтверждения успешной миграции.

{% endnote %}

## Завершите миграцию {#finalization}

Завершите миграцию и оптимизируйте конфигурацию.

1. Убедитесь, что все сервисы работают корректно в {{ managed-k8s-name }}.
1. Проверьте метрики и производительность в [{{ monitoring-full-name }}](../../../monitoring/index.yaml).
1. Отключите ресурсы в исходном облаке после подтверждения стабильной работы.
1. Оптимизируйте конфигурацию кластера под реальную нагрузку.
1. Удалите промежуточные ресурсы: бакет Velero, трансферы {{ data-transfer-name }}, VPN-туннели, временные учетные данные.
