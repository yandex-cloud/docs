# Настройка автомасштабирования

Для Managed Service for Kubernetes доступны следующие способы [автоматического масштабирования](../concepts/autoscale.md):
* [Автоматическое масштабирование кластера](#ca).
* [Автоматическое масштабирование мастера](../concepts/autoscale.md#master-autoscaler).
* [Горизонтальное автомасштабирование подов](#hpa).
* [Вертикальное автомасштабирование подов](#vpa).

{% note warning %}

С 18 июня 2026 года автоматическое масштабирование мастера работает на всех кластерах в [релизном канале](../concepts/release-channels-and-updates.md) `RAPID`, где мастер развернут в [высокодоступной конфигурации](../concepts/index.md#master).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. [Создайте кластер Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).

## Настройка автоматического масштабирования кластера {#ca}

{% note warning %}

Автоматическое масштабирование этого типа можно включить только при создании [группы узлов Managed Service for Kubernetes](../concepts/index.md#node-group).

{% endnote %}

Чтобы создать автомасштабируемую группу узлов Managed Service for Kubernetes:

{% list tabs group=instructions %}

- Консоль управления {#console}

  [Создайте группу узлов Managed Service for Kubernetes](node-group/node-group-create.md) со следующими параметрами:
  * **Тип** масштабирования: `Автоматический`.
  * **Минимальное кол-во узлов**: укажите количество узлов Managed Service for Kubernetes, которое должно оставаться в группе при минимальной нагрузке.
  * **Максимальное кол-во узлов**: укажите максимально допустимое количество узлов Managed Service for Kubernetes в группе.
  * **Начальное кол-во узлов**: количество узлов Managed Service for Kubernetes, которые следует создать вместе с группой (должно быть не меньше минимального и не больше максимального количества узлов в группе).

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Изучите команду создания группы узлов Managed Service for Kubernetes:

     ```bash
     yc managed-kubernetes node-group create --help
     ```

  1. Создайте автомасштабируемую группу узлов Managed Service for Kubernetes:

     ```bash
     yc managed-kubernetes node-group create \
     ...
       --auto-scale min=<минимальное_количество_узлов>, max=<максимальное_количество_узлов>, initial=<начальное_количество_узлов>
     ```

- Terraform {#tf}

  1. [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
     
     Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
     
     Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

     Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
  1. Откройте актуальный конфигурационный файл Terraform с описанием группы узлов.

     О том, как создать такой файл, читайте в разделе [Создание группы узлов](node-group/node-group-create.md).
  1. Добавьте описание новой группы узлов, указав настройки автомасштабирования в блоке `scale_policy.auto_scale`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
     ...
       scale_policy {
         auto_scale {
           min     = <минимальное_количество_узлов_в_группе>
           max     = <максимальное_количество_узлов_в_группе>
           initial = <начальное_количество_узлов_в_группе>
         }
       }
     }
     ```

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
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

{% endlist %}

Управление Cluster Autoscaler выполняется на стороне сервиса Managed Service for Kubernetes.

Подробнее о Cluster Autoscaler в разделе [Автоматическое масштабирование кластера](../concepts/autoscale.md#ca). Параметры, используемые по умолчанию, приведены в [документации Kubernetes](https://github.com/kubernetes/autoscaler/blob/c6b754c359a8563050933a590f9a5dece823c836/cluster-autoscaler/FAQ.md#what-are-the-parameters-to-ca).

Смотрите также раздел [Вопросы и ответы про автоматическое масштабирование группы узлов в Managed Service for Kubernetes](../qa/cluster-autoscaler.md).

## Настройка горизонтального автомасштабирования подов {#hpa}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте Horizontal Pod Autoscaler для вашего приложения, например:

     ```bash
     kubectl autoscale deployment/<имя_приложения> --cpu-percent=50 --min=1 --max=3
     ```

     Где:
     * `--cpu-percent` — желаемая нагрузка [пода Managed Service for Kubernetes](../concepts/index.md#pod) на vCPU.
     * `--min` — минимальное количество подов Managed Service for Kubernetes.
     * `--max` — максимальное количество подов Managed Service for Kubernetes.
  1. Проверьте состояние Horizontal Pod Autoscaler:

     ```bash
     kubectl describe hpa/<имя_приложения>
     ```

{% endlist %}

Подробнее о Horizontal Pod Autoscaler в разделе [Горизонтальное автомасштабирование подов](../concepts/autoscale.md#hpa).

## Настройка вертикального автомасштабирования подов {#vpa}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Установите Vertical Pod Autoscaler из [репозитория](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler):

     ```bash
     cd /tmp && \
       git clone https://github.com/kubernetes/autoscaler.git && \
       cd autoscaler/vertical-pod-autoscaler/hack && \
       ./vpa-up.sh
     ```

  1. Создайте конфигурационный файл `vpa.yaml` для вашего приложения:

     ```yaml
     apiVersion: autoscaling.k8s.io/v1
     kind: VerticalPodAutoscaler
     metadata:
       name: <имя_приложения>
     spec:
       targetRef:
         apiVersion: "apps/v1"
         kind:       Deployment
         name:       <имя_приложения>
       updatePolicy:
         updateMode: "<режим_работы_VPA>"
     ```

     Где `updateMode` — режим работы Vertical Pod Autoscaler: `Off`, `Initial`, `Recreate` или `InPlaceOrRecreate`. Подробнее в разделе [Вертикальное автомасштабирование подов](../concepts/autoscale.md#vpa).

  1. Создайте Vertical Pod Autoscaler для вашего приложения:

     ```bash
     kubectl apply -f vpa.yaml
     ```

  1. Проверьте состояние Vertical Pod Autoscaler:

     ```bash
     kubectl describe vpa <имя_приложения>
     ```

{% endlist %}

Подробнее о Vertical Pod Autoscaler в разделе [Вертикальное автомасштабирование подов](../concepts/autoscale.md#vpa).

## Удаление подов в статусе Terminated {#delete-terminated}

Иногда во время автоматического масштабирования поды узлов Managed Service for Kubernetes не удаляются, а остаются в статусе **Terminated**. Это происходит из-за того, что контроллер [Pod garbage collector (PodGC)](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-garbage-collection) не успевает удалять их.

Вы можете удалить зависшие поды Managed Service for Kubernetes:
* [Вручную](#manually).
* [Автоматически с помощью CronJob](#automatically-cronjob).

### Вручную {#manually}

Выполните команду:

```bash
kubectl get pods --all-namespaces | grep -i Terminated \
| awk '{print $1, $2}' | xargs -n2 kubectl delete pod -n
```

### Автоматически с помощью CronJob {#automatically-cronjob}

Чтобы автоматически удалять зависшие поды Managed Service for Kubernetes:
1. [Настройте CronJob](#setup-cronjob).
1. [Проверьте результаты заданий CronJob](#check-cronjob).

Если CronJob больше не нужен, [удалите его](#delete-cronjob).

#### Настройка автоматического удаления в CronJob {#setup-cronjob}

1. Создайте файл `cronjob.yaml` со спецификацией для [CronJob](https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/#creating-a-cron-job) и ресурсов, необходимых для его выполнения:

   ```yaml
   ---
   apiVersion: batch/v1
   kind: CronJob
   metadata:
     name: terminated-pod-cleaner
   spec:
     schedule: "*/5 * * * *"
     jobTemplate:
       spec:
         template:
           spec:
             serviceAccountName: terminated-pod-cleaner
             containers:
             - name: terminated-pod-cleaner
               image: bitnamilegacy/kubectl
               imagePullPolicy: IfNotPresent
               command: ["/bin/sh", "-c"]
               args: ["kubectl get pods --all-namespaces | grep -i Terminated | awk '{print $1, $2}' | xargs --no-run-if-empty -n2 kubectl delete pod -n"]
             restartPolicy: Never

   ---
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: terminated-pod-cleaner

   ---
   apiVersion: rbac.authorization.k8s.io/v1
   kind: ClusterRole
   metadata:
     name: terminated-pod-cleaner
   rules:
     - apiGroups: [""]
       resources:
         - pods
       verbs: [list, delete]

   ---
   apiVersion: rbac.authorization.k8s.io/v1
   kind: ClusterRoleBinding
   metadata:
     name: terminated-pod-cleaner
   subjects:
   - kind: ServiceAccount
     name: terminated-pod-cleaner
     namespace: default
   roleRef:
     kind: ClusterRole
     name: terminated-pod-cleaner
     apiGroup: rbac.authorization.k8s.io
   ```

   В строке `schedule: "*/5 * * * *"` задано расписание в cron-формате: выполнение задания каждые 5 минут. При необходимости измените интервал.
1. Создайте CronJob и ресурсы:

   ```bash
   kubectl create -f cronjob.yaml
   ```

   Результат:

   ```text
   cronjob.batch/terminated-pod-cleaner created
   serviceaccount/terminated-pod-cleaner created
   clusterrole.rbac.authorization.k8s.io/terminated-pod-cleaner created
   clusterrolebinding.rbac.authorization.k8s.io/terminated-pod-cleaner created
   ```

1. Проверьте, что CronJob создался:

   ```bash
   kubectl get cronjob terminated-pod-cleaner
   ```

   Результат:

   ```text
   NAME                    SCHEDULE     SUSPEND  ACTIVE  LAST SCHEDULE  AGE
   terminated-pod-cleaner  */5 * * * *  False    0       <none>         4s
   ```

   Через указанный в `SCHEDULE` интервал в столбце `LAST SCHEDULE` появится значение времени. Это означает, что задание было успешно выполнено или завершено с ошибкой.

#### Проверка результатов заданий CronJob {#check-cronjob}

1. Получите список заданий:

   ```bash
   kubectl get jobs
   ```

   Результат:

   ```text
   NAME           COMPLETIONS  DURATION  AGE
   <имя_задания>  1/1          4s        2m1s
   ...
   ```

1. Получите имя пода Managed Service for Kubernetes, в котором выполнялось задание:

   ```bash
   kubectl get pods --selector=job-name=<имя_задания> --output=jsonpath={.items[*].metadata.name}
   ```

1. Просмотрите логи пода Managed Service for Kubernetes:

   ```bash
   kubectl logs <имя_пода>
   ```

   В логе будет список удаленных подов Managed Service for Kubernetes. Если лог пустой, подов Managed Service for Kubernetes в статусе **Terminated** на момент выполнения задания не было.

#### Удаление CronJob {#delete-cronjob}

Чтобы удалить CronJob и его ресурсы, выполните команду:

```bash
kubectl delete cronjob terminated-pod-cleaner && \
kubectl delete serviceaccount terminated-pod-cleaner && \
kubectl delete clusterrole terminated-pod-cleaner && \
kubectl delete clusterrolebinding terminated-pod-cleaner
```