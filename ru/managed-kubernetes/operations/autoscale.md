# Настройка автомасштабирования

Для {{ managed-k8s-name }} доступны три способа [автоматического масштабирования](../concepts/autoscale.md):
* [Автоматическое масштабирование кластера](#ca).
* [Горизонтальное автомасштабирование подов](#hpa).
* [Вертикальное автомасштабирование подов](#vpa).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Настройка автоматического масштабирования кластера {#ca}

{% note warning %}

Автоматическое масштабирование этого типа можно включить только при создании [группы узлов {{ managed-k8s-name }}](../concepts/index.md#node-group).

{% endnote %}

Чтобы создать автомасштабируемую группу узлов {{ managed-k8s-name }}:

{% list tabs %}

- Консоль управления

  [Создайте группу узлов {{ managed-k8s-name }}](../operations/node-group/node-group-create.md) со следующими параметрами:
  * **Тип масштабирования**: `Автоматический`.
  * **Минимальное кол-во узлов**: укажите количество узлов {{ managed-k8s-name }}, которое должно оставаться в группе при минимальной нагрузке.
  * **Максимальное кол-во узлов**: укажите максимально допустимое количество узлов {{ managed-k8s-name }} в группе.
  * **Начальное кол-во узлов**: количество узлов {{ managed-k8s-name }}, которые следует создать вместе с группой (должно быть не меньше минимального и не больше максимального количества узлов в группе).

- CLI

  1. {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Изучите команду создания группы узлов {{ managed-k8s-name }}:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Создайте автомасштабируемую группу узлов {{ managed-k8s-name }}:

     ```bash
     {{ yc-k8s }} node-group create \
     ...
       --auto-scale min=<минимальное_количество_узлов>, max=<максимальное_количество_узлов>, initial=<начальное_количество_узлов>
     ```

- {{ TF }}

  1. {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

     {% include [terraform-install](../../_includes/terraform-install.md) %}
  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, см. в разделе [{#T}](../operations/node-group/node-group-create.md).
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

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

Подробнее о {{ k8s-ca }} см. в разделе [{#T}](../concepts/autoscale.md#ca).

## Настройка горизонтального автомасштабирования подов {#hpa}

{% list tabs %}

- CLI

  1. Создайте {{ k8s-hpa }} для вашего приложения, например:

     ```bash
     kubectl autoscale deployment/<имя приложения> --cpu-percent=50 --min=1 --max=3
     ```

     Где:
     * `--cpu-percent` — желаемая нагрузка [пода {{ managed-k8s-name }}](../concepts/index.md#pod) на vCPU.
     * `--min` — минимальное количество подов {{ managed-k8s-name }}.
     * `--max` — максимальное количество подов {{ managed-k8s-name }}.
  1. Проверьте состояние {{ k8s-hpa }}:

     ```bash
     kubectl describe hpa/<имя_приложения>
     ```

{% endlist %}

Подробнее о {{ k8s-hpa }} см. в разделе [{#T}](../concepts/autoscale.md#hpa).

## Настройка вертикального автомасштабирования подов {#vpa}

{% list tabs %}

- CLI

  1. Установите {{ k8s-vpa }} из [репозитория](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler):

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
       updateMode: "<режим_работы_VPA:_Auto_или_Off>"
     ```

     Задайте режим работы {{ k8s-vpa }} в параметре `updateMode`: `Auto` или `Off`.
  1. Создайте {{ k8s-vpa }} для вашего приложения:

     ```bash
     kubectl apply -f vpa.yaml
     ```

  1. Проверьте состояние {{ k8s-vpa }}:

     ```bash
     kubectl describe vpa <имя_приложения>
     ```

{% endlist %}

Подробнее о {{ k8s-vpa }} см. в разделе [{#T}](../concepts/autoscale.md#vpa).

## Удаление подов в статусе Terminated {#delete-terminated}

Иногда во время автоматического масштабирования поды узлов {{ managed-k8s-name }} не удаляются, а остаются в статусе **Terminated**. Это происходит из-за того, что контроллер [Pod garbage collector (PodGC)](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-garbage-collection) не успевает удалять их.

Вы можете удалить зависшие поды {{ managed-k8s-name }}:
* [Вручную](#manually).
* [Автоматически с помощью CronJob](#automatically-cronjob).

### Вручную {#manually}

Выполните команду:

```bash
kubectl get pods --all-namespaces | grep -i Terminated \
| awk '{print $1, $2}' | xargs -n2 kubectl delete pod -n
```

### Автоматически с помощью CronJob {#automatically-cronjob}

Чтобы автоматически удалять зависшие поды {{ managed-k8s-name }}:
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
               image: bitnami/kubectl
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

1. Получите имя пода {{ managed-k8s-name }}, в котором выполнялось задание:

   ```bash
   kubectl get pods --selector=job-name=<имя_задания> --output=jsonpath={.items[*].metadata.name}
   ```

1. Просмотрите логи пода {{ managed-k8s-name }}:

   ```bash
   kubectl logs <имя_пода>
   ```

   В логе будет список удаленных подов {{ managed-k8s-name }}. Если лог пустой, подов {{ managed-k8s-name }} в статусе **Terminated** на момент выполнения задания не было.

#### Удаление CronJob {#delete-cronjob}

Чтобы удалить CronJob и его ресурсы, выполните команду:

```bash
kubectl delete cronjob terminated-pod-cleaner && \
kubectl delete serviceaccount terminated-pod-cleaner && \
kubectl delete clusterrole terminated-pod-cleaner && \
kubectl delete clusterrolebinding terminated-pod-cleaner
```