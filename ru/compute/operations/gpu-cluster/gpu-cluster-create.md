---
title: "Как создать кластер GPU"
description: "Следуя данной инструкции, вы сможете создать кластер GPU."
---

# Создать кластер GPU

{% note info %}

Кластеры GPU переходят в [общий доступ](../../../overview/concepts/launch-stages.md) и начнут тарифицироваться 1 сентября 2023 года.

{% endnote %}

{% note info %}

По умолчанию в облаке установлена нулевая [квота](../../concepts/limits.md#compute-quotas) на создание кластеров GPU. Чтобы изменить [квоту]({{ link-console-quotas }}), обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}

В этом разделе приведена инструкция для создания кластера GPU. Кластеры GPU сейчас можно создавать только в зоне `ru-central1-a`.

После создания кластера вы сможете [добавлять](gpu-add-to-cluster.md) к нему виртуальные машины из той же зоны доступности.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания кластера GPU:

      ```bash
      yc compute gpu-cluster create --help
      ```
      
     Обратите внимание, что сейчас создаются только кластеры с типом соединения `infiniband`.

  1. Создайте кластер в зоне доступности по умолчанию:
      
      ```bash
      yc compute gpu-cluster create --interconnect-type infiniband
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

          
      ```hcl
      provider "yandex" {
        zone = "{{ region-id }}-a"
      }

      resource "yandex_compute_gpu_cluster" "default" {
        name               = "<имя_кластера>"
        interconnect_type  = "<тип_соединения>"
        zone               = "{{ region-id }}-a"
        labels             = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
        }
      }
      ```



      Где:

      * `name` — имя кластера. Обязательный параметр.
      * `interconnect_type` — тип соединения. Сейчас создаются только кластеры с типом соединения `infiniband`. Обязательный параметр.
      * `labels` — [метка](../../../resource-manager/concepts/labels.md) ресурса в формате `<ключ> = "<значение>"`. Необязательный параметр.

      Подробную информацию о параметрах ресурса `yandex_compute_gpu_cluster` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_gpu_cluster).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создан кластер GPU. Проверить появление кластера и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc compute gpu-cluster get <имя_кластера>
    ```

{% endlist %}
