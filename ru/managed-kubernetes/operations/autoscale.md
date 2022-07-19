# Настройка автомасштабирования

Для {{ managed-k8s-name }} доступны три способа автоматического масштабирования:

* [Автоматическое масштабирование кластера](#ca).
* [Горизонтальное автомасштабирование подов](#hpa).
* [Вертикальное автомасштабирование подов](#vpa).

Подробнее см. в разделе [{#T}](../concepts/autoscale.md).

## Перед началом работы {#before-you-begin}

1. [Создайте кластер](kubernetes-cluster/kubernetes-cluster-create.md) любой подходящей конфигурации.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Настройка автоматического масштабирования кластера {#ca}

{% note warning %}

Автоматическое масштабирование этого типа можно включить только при создании группы узлов.

{% endnote %}

Чтобы создать автомасштабируемую группу узлов:

{% list tabs %}

- Консоль управления

  [Создайте группу узлов](../operations/node-group/node-group-create.md) со следующими параметрами:
  * **Тип масштабирования**: `Автоматический`.
  * **Минимальное кол-во узлов**: укажите количество узлов, которое должно оставаться в группе при минимальной нагрузке.
  * **Максимальное кол-во узлов**: укажите максимально допустимое количество узлов в группе.
  * **Начальное кол-во узлов**: количество узлов, которые следует создать вместе с группой (должно быть не меньше минимального и не больше максимального количества узлов в группе).

- CLI

  1. {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Изучите команду создания группы узлов:

     ```bash
     {{ yc-k8s }} node-group create --help
     ```

  1. Создайте автомасштабируемую группу узлов:

     ```bash
     {{ yc-k8s }} node-group create \
     ...
       --auto-scale min=<минимальное количество узлов>, max=<максимальное количество узлов>, initial=<начальное количество узлов>
     ```

- {{ TF }}

  1. {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

     Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Откройте актуальный конфигурационный файл {{ TF }} с описанием группы узлов.

     О том, как создать такой файл, см. в разделе [{#T}](../operations/node-group/node-group-create.md).
  1. Добавьте описание новой группы узлов, указав настройки автомасштабирования в блоке `scale_policy.auto_scale`:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя группы узлов>" {
     ...
       scale_policy {
         auto_scale {
           min     = <минимальное количество узлов в группе>
           max     = <максимальное количество узлов в группе>
           initial = <начальное количество узлов в группе>
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

     * `--cpu-percent` — желаемая нагрузка пода на vCPU.
     * `--min` — минимальное количество подов.
     * `--max` — максимальное количество подов.

  1. Проверьте состояние {{ k8s-hpa }}:

     ```bash
     kubectl describe hpa/<имя приложения>
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
       name: <имя приложения>
     spec:
       targetRef:
         apiVersion: "apps/v1"
         kind:       Deployment
         name:       <имя приложения>
     updatePolicy:
       updateMode: "<режим работы VPA: Auto или Off>"
     ```

     Задайте режим работы {{ k8s-vpa }} в параметре `updateMode`: `Auto` или `Off`.

  1. Создайте {{ k8s-vpa }} для вашего приложения:

     ```bash
     kubectl apply -f vpa.yaml
     ```

  1. Проверьте состояние {{ k8s-vpa }}:

     ```bash
     kubectl describe vpa <имя приложения>
     ```

{% endlist %}

Подробнее о {{ k8s-vpa }} см. в разделе [{#T}](../concepts/autoscale.md#vpa).