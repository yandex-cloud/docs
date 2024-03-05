# Отключить диск от виртуальной машины

Отключить диск можно как от работающей, так и от остановленной виртуальной машины. 


{% note info %}

От ВМ нельзя отключить загрузочный диск. От ВМ на [выделенном хосте](../../concepts/dedicated-host.md) нельзя отключить локальный диск.

{% endnote %}


Чтобы диск был успешно отключен от работающей ВМ, операционная система машины должна быть готова принимать команды на отключение диска. Перед отключением диска убедитесь, что ОС загружена, или остановите виртуальную машину — иначе операция отключения диска завершится с ошибкой. При возникновении ошибки остановите ВМ и повторите операцию. 

Чтобы отключить диск от виртуальной машины:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
  1. Напротив нужного диска нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.compute.disks.button_action-detach }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.disks.popup_detach-disk_button_detach }}**.

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для отключения дисков:
  
      ```
      yc compute instance detach-disk --help
      ```
  
  1. Получите список виртуальных машин в каталоге по умолчанию:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  
  1. Получите список дисков, подключенных к виртуальной машине:
  
      ```
      yc compute instance get --full first-instance
      ```
  
  1. Выберите `disk_id` нужного диска, например `fhm4aq4hvq5g********`.
  1. Отключите диск:
  
      ```
      yc compute instance detach-disk first-instance \
        --disk-id fhm4aq4hvq5g********
      ```
      
      Если возникла ошибка, остановите виртуальную машину:
      
      ```
      yc compute instance stop first-instance
      ```
      
      Затем отключите диск повторно.
  
  1. Если виртуальная машина была остановлена, запустите ее заново:
  
      ```
      yc compute instance start first-instance
      ```
  
- API {#api}
  
  Воспользуйтесь методом REST API [detachDisk](../../api-ref/Instance/detachDisk.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/DetachDisk](../../api-ref/grpc/instance_service.md#DetachDisk).
  
{% endlist %}
