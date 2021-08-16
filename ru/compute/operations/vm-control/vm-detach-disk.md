# Отключить диск от виртуальной машины

Отключить диск можно как от работающей, так и от остановленной виртуальной машины. 

{% note info %}

Загрузочный диск отключить нельзя.

{% endnote %}

Чтобы диск был успешно отключен от работающей ВМ, операционная система машины должна быть готова принимать команды на отключение диска. Перед отключением диска убедитесь, что ОС загружена, или остановите виртуальную машину — иначе операция отключения диска завершится с ошибкой. При возникновении ошибки остановите ВМ и повторите операцию. 

Чтобы отключить диск от виртуальной машины:

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для отключения дисков:
  
      ```
      $ yc compute instance detach-disk --help
      ```
  
  1. Получите список виртуальных машин в каталоге по умолчанию:
  
      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}
  
  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  
  1. Получите список дисков, подключенных к виртуальной машине:
  
      ```
      $ yc compute instance get --full first-instance
      ```
  
  1. Выберите `disk_id` нужного диска, например `fhm4aq4hvq5g3nepvt9b`.
  1. Отключите диск:
  
      ```
      $ yc compute instance detach-disk first-instance \
          --disk-id fhm4aq4hvq5g3nepvt9b
      ```
      
      Если возникла ошибка, остановите виртуальную машину:
      
      ```
      $ yc compute instance stop first-instance
      ```
      
      Затем отключите диск повторно.
  
  1. Если виртуальная машина была остановлена, запустите ее заново:
  
      ```
      $ yc compute instance start first-instance
      ```
  
- API
  
  Воспользуйтесь методом [detachDisk](../../api-ref/Instance/detachDisk.md) для ресурса [Instance](../../api-ref/Instance/).
  
{% endlist %}
