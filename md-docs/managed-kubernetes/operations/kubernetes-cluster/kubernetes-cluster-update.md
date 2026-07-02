[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Управление кластером Kubernetes > Изменение кластера Kubernetes

# Изменение кластера Managed Service for Kubernetes

Для обращения к кластеру Kubernetes используйте его имя или уникальный идентификатор, которые можно узнать с помощью команды:

```bash
yc managed-kubernetes cluster list
```

Результат:

```bash
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
|          ID          |   NAME   |     CREATED AT      | HEALTH  | STATUS  |    EXTERNAL ENDPOINT    |   INTERNAL ENDPOINT   |
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
| cati493bu7ia******** | k8s-demo | 2019-11-20 11:26:36 | HEALTHY | RUNNING | https://84.201.174.147/ | https://192.168.0.27/ |
+----------------------+----------+---------------------+---------+---------+-------------------------+-----------------------+
```

## Изменить кластер Managed Service for Kubernetes {#update-cluster}

{% note warning %}

[Публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) можно назначить только при [создании](kubernetes-cluster-create.md) кластера Managed Service for Kubernetes. После этого назначить публичный IP-адрес существующему кластеру невозможно.

{% endnote %}

Вы можете изменить следующие параметры [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster):
* Имя.
* Описание.
* [Сервисные аккаунты](../../../iam/operations/sa/create.md).
* [Конфигурацию ресурсов](../../concepts/index.md#master-resources) для мастера.
* [Версию Kubernetes](../../concepts/release-channels-and-updates.md).
* Политику [обновлений](../../concepts/release-channels-and-updates.md#updates).
* Список [групп безопасности](../connect/security-groups.md).
* Настройки отправки логов в [Yandex Cloud Logging](../../../logging/index.md).

  {% note alert %}

  Не удаляйте группы безопасности, привязанные к работающему кластеру Managed Service for Kubernetes: это может привести к нарушению его работы и потере данных.

  {% endnote %}

* Маску [подсети](../../../vpc/concepts/network.md#subnet) [узлов Managed Service for Kubernetes](../../concepts/index.md#node-group).

  {% note warning %}

  * Если изменить маску подсети для работающего кластера Managed Service for Kubernetes, его блоки CIDR могут быть израсходованы, тогда развертывание [подов](../../concepts/index.md#pod) на новых группах узлов станет невозможным.
  * После изменения маски подсети необходимо пересоздать группы узлов кластера.

  {% endnote %}

Инструкция по изменению [зоны доступности](../../../overview/concepts/geo-scope.md) кластера приведена в разделе [Миграция ресурсов Kubernetes в другую зону доступности](../../tutorials/migration-to-an-availability-zone.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить кластер Managed Service for Kubernetes:
  1. Откройте раздел **Managed Service for&nbsp;Kubernetes** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер Managed Service for Kubernetes.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В открывшемся окне измените необходимые параметры.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить кластер Managed Service for Kubernetes:
  1. Посмотрите описание команды CLI для изменения кластера Managed Service for Kubernetes:

     ```bash
     yc managed-kubernetes cluster update --help
     ```

  1. Выполните команду, передав список изменяемых настроек (в примере приведены не все настройки):

     ```bash
     yc managed-kubernetes cluster update <имя_кластера_Managed_Service_for_Kubernetes> \
       --new-name <новое_имя_кластера_Managed_Service_for_Kubernetes> \
       --description <описание_кластера_Managed_Service_for_Kubernetes> \
       --service-account-id <идентификатор_сервисного_аккаунта_для_ресурсов> \
       --service-account-name <имя_сервисного_аккаунта_для_ресурсов> \
       --node-service-account-id <идентификатор_сервисного_аккаунта_для_узлов_Kubernetes> \
       --security-group-ids <список_идентификаторов_групп_безопасности> \
       --master-logging enabled=<отправка_логов>,`
           `log-group-id=<идентификатор_лог-группы>,`
           `folder-id=<идентификатор_каталога>,`
           `kube-apiserver-enabled=<отправка_логов_kube-apiserver>,`
           `cluster-autoscaler-enabled=<отправка_логов_cluster-autoscaler>,`
           `events-enabled=<отправка_событий_Kubernetes>`
           `audit-enabled=<отправка_событий_аудита>
     ```

     Где:
     * `--new-name` — имя кластера Managed Service for Kubernetes.
     * `--description` — описание кластера Managed Service for Kubernetes.
     * `--service-account-id`, `--service-account-name` — сервисный аккаунт для управления кластером Managed Service for Kubernetes.
     * `--node-service-account-id`, `--node-service-account-name` — сервисный аккаунт для управления узлами Managed Service for Kubernetes.
     * `--security-group-ids` — группы безопасности кластера Managed Service for Kubernetes.

       {% note warning %}
       
       От [настройки групп безопасности](../connect/security-groups.md) зависит работоспособность и доступность кластера, а также запущенных в нем сервисов.
       
       {% endnote %}

     * `--master-logging` — отправка логов в [Yandex Cloud Logging](../../../logging/index.md):

       * `enabled` — флаг отправки логов: `true` или `false`.
       * `log-group-id` — идентификатор [лог-группы](../../../logging/concepts/log-group.md), в которую нужно отправлять логи.
       * `folder-id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
       * `kube-apiserver-enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/): `true` или `false`.
       * `cluster-autoscaler-enabled` — флаг отправки логов `cluster-autoscaler`: `true` или `false`.
       * `events-enabled` — флаг отправки событий Kubernetes: `true` или `false`.
       * `audit-enabled` — флаг отправки событий аудита: `true` или `false`.

       Для отправки логов в Yandex Cloud Logging [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [logging.writer](../../../logging/security/index.md#loggingwriter).

       Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

     * `--version` — версию Kubernetes.
     * `--latest-revision` — получить все доступные обновления для текущей версии [мастера Managed Service for Kubernetes](../../concepts/index.md#master).
     * `--auto-upgrade` — управлять автоматическими обновлениями кластера Managed Service for Kubernetes.
     * Управление окном обновлений:
       * `--anytime-maintenance-window` — обновлять в любое время.
       * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
       * `--weekly-maintenance-window` — обновлять в выбранные дни.

         {% note info %}
         
         Если вы включили обновление ежедневно или в отдельные дни, оно может начаться позже указанного времени.  
         
         {% endnote %}

- Terraform {#tf}

  Чтобы изменить кластер Managed Service for Kubernetes:
  1. Откройте актуальный конфигурационный файл с описанием кластера Managed Service for Kubernetes.

     О том, как создать такой файл, читайте в разделе [Создание кластера Managed Service for Kubernetes](kubernetes-cluster-create.md).
  1. Измените нужные параметры в описании кластера Managed Service for Kubernetes.

     Чтобы изменить настройки отправки логов в [Yandex Cloud Logging](../../../logging/index.md), измените значения параметров в блоке `master_logging`. Если такого блока нет — создайте его.

     >```hcl
     >resource "yandex_kubernetes_cluster" "<имя_кластера>" {
     >  ...
     >  master {
     >    ...
     >    master_logging {
     >      enabled                    = <отправка_логов>
     >      log_group_id               = "<идентификатор_лог-группы>"
     >      folder_id                  = "<идентификатор_каталога>"
     >      kube_apiserver_enabled     = <отправка_логов_kube-apiserver>
     >      cluster_autoscaler_enabled = <отправка_логов_cluster-autoscaler>
     >      events_enabled             = <отправка_событий_Kubernetes>
     >      audit_enabled              = <отправка_событий_аудита>
     >    }
     >  }
     >}
     >```

     Где:

     * `enabled` — флаг отправки логов: `true` или `false`.
     * `log_group_id` — идентификатор [лог-группы](../../../logging/concepts/log-group.md), в которую нужно отправлять логи.
     * `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
     * `kube_apiserver_enabled` — флаг отправки логов [kube-apiserver](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/): `true` или `false`.
     * `cluster_autoscaler_enabled` — флаг отправки логов `cluster-autoscaler`: `true` или `false`.
     * `events_enabled` — флаг отправки событий Kubernetes: `true` или `false`.
     * `audit_enabled` — флаг отправки событий аудита: `true` или `false`.

       Для отправки логов в Yandex Cloud Logging [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [logging.writer](../../../logging/security/index.md#loggingwriter).

       Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится [кластер Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на создание и изменение кластера Managed Service for Kubernetes 30 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_cluster" "<имя_кластера>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     Подробнее в [документации провайдера Terraform](../../../terraform/resources/kubernetes_cluster.md).

- API {#api}

  Чтобы изменить параметры кластера Managed Service for Kubernetes, воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../../managed-kubernetes/api-ref/grpc/Cluster/update.md).

  Чтобы изменить настройки отправки логов в Cloud Logging, измените их значения в параметре `masterSpec.masterLogging` для REST API или `master_spec.master_logging` для gRPC API.

  Для отправки логов в Yandex Cloud Logging [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту для ресурсов роль [logging.writer](../../../logging/security/index.md#loggingwriter).

{% endlist %}

## Управлять облачными метками кластера Managed Service for Kubernetes {#manage-label}

Вы можете выполнять следующие действия с [облачными метками кластера](../../concepts/index.md#cluster-labels) Managed Service for Kubernetes:

* [Добавить](#add-label).
* [Изменить](#update-label).
* [Удалить](#remove-label).

### Добавить облачную метку {#add-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте раздел **Managed Service for&nbsp;Kubernetes** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где расположен кластер Managed Service for Kubernetes.
    1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. В поле **Метки** нажмите **Добавить метку**.
    1. Введите ключ и значение и нажмите **Enter**.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
  ```

  Результат:

  ```text
  done (1s)
  id: abcd123ef4gh********
  folder_id: l1m01nopqr1s********
  ...
  description: My test Kubernetes cluster
  labels:
    new_label: test_label
  ...
  ```

{% endlist %}

### Изменить облачную метку {#update-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить облачную метку, потребуется удалить ее и создать заново:

    1. Откройте раздел **Managed Service for&nbsp;Kubernetes** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где расположен кластер Managed Service for Kubernetes.
    1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. В поле **Метки** нажмите на крестик рядом с нужной меткой, чтобы удалить ее.
    1. Нажмите **Добавить метку** и введите ключ и/или значение новой метки.
    1. Нажмите **Enter**, а затем — **Сохранить**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
  ```

  {% note warning %}
  
  Существующий набор меток (`labels`) полностью перезаписывается набором, переданным в запросе.
  
  {% endnote %}

  Результат:

  ```text
  done (1s)
  id: abcd123ef4gh********
  folder_id: l1m01nopqr1s********
  ...
  description: My test Kubernetes cluster
  labels:
    test_label: my_k8s_label
  ...
  ```

{% endlist %}

### Удалить облачную метку {#remove-label}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте раздел **Managed Service for&nbsp;Kubernetes** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где расположен кластер Managed Service for Kubernetes.
    1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
    1. Нажмите кнопку **Редактировать** в правом верхнем углу.
    1. В поле **Метки** нажмите на крестик рядом с нужной меткой.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
  ```

  Результат:

  ```text
  done (1s)
  id: cati493bu7ia********
  folder_id: b1g88tflru0e********
  created_at: "2019-11-20T11:26:36Z"
  name: k8s-demo
  ...
  ```

{% endlist %}

## Изменить конфигурацию ресурсов мастера {#manage-resources}

{% note warning %}

С 18 июня 2026 года тарификация мастеров изменилась — плата взимается за количество vCPU и объем RAM мастера, выбранные при [создании](kubernetes-cluster-create.md) или [изменении](kubernetes-cluster-update.md#manage-resources) кластера. Чтобы рассчитать необходимое количество ресурсов мастера для своего кластера, воспользуйтесь таблицей [Рекомендуемые конфигурации мастера](../../concepts/master-configuration.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте раздел **Managed Service for&nbsp;Kubernetes** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить кластер Managed Service for Kubernetes.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В блоке **Конфигурация мастера** раскройте секцию **Вычислительные ресурсы** и выберите [конфигурацию ресурсов](../../concepts/index.md#master-resources) для мастера.

      Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

      _По умолчанию_ для работы одного хоста мастера предоставляются следующие ресурсы:
      * [платформа](../../../compute/concepts/vm-platforms.md) — Intel Cascade Lake;
      * гарантированная доля vCPU — 100%;
      * количество vCPU — 2;
      * объем RAM — 8 ГБ.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Укажите нужную конфигурацию ресурсов мастера в команде изменения кластера:

  ```bash
  yc managed-kubernetes cluster update <имя_кластера_Managed_Service_for_Kubernetes> \
    --master-scale-policy policy=auto,min-resource-preset-id=<класс_хостов_мастера>
  ```

  Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

  Результат:

  ```text
  done (1s)
  id: abcd123ef4gh********
  folder_id: l1m01nopqr1s********
  ...
  description: My test Kubernetes cluster
  master:
    scale_policy:
      auto_scale:
        min_resource_preset_id: <класс_хостов_мастера>
  ...
  ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл с описанием кластера Managed Service for Kubernetes.

     О том, как создать такой файл, читайте в разделе [Создание кластера Managed Service for Kubernetes](kubernetes-cluster-create.md).

  1. Добавьте или измените в описании кластера Managed Service for Kubernetes конфигурацию [вычислительных ресурсов мастера](../../concepts/index.md#master-resources) в блоке `scale_policy`:

     >```hcl
     >resource "yandex_kubernetes_cluster" "<имя_кластера>" {
     >  ...
     >  master {
     >    ...
     >    scale_policy {
     >      auto_scale  {
     >        min_resource_preset_id = "<класс_хостов_мастера>"
     >      }
     >    }
     >  }
     >}
     >```

     Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите изменение ресурсов.

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     {% note warning "Ограничения по времени" %}
     
     Провайдер Terraform ограничивает время на создание и изменение кластера Managed Service for Kubernetes 30 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_cluster" "<имя_кластера>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     Подробнее в [документации провайдера Terraform](../../../terraform/resources/kubernetes_cluster.md).

- API {#api}

  Чтобы изменить конфигурацию ресурсов мастера, воспользуйтесь методом REST API [update](../../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../../managed-kubernetes/api-ref/grpc/Cluster/update.md) и передайте в запросе параметр:

  * `masterSpec.scalePolicy.autoScale.minResourcePresetId` — для REST API.
  * `master_spec.scale_policy.auto_scale.min_resource_preset_id` — для gRPC API.

  Выбранная конфигурация задает минимальные значения ресурсов для мастера. В зависимости от нагрузки объем RAM и количество vCPU мастера будут автоматически увеличиваться.

{% endlist %}