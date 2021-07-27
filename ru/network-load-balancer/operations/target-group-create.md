---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Создать целевую группу

{% list tabs %}

- Консоль управления
  
  Чтобы создать новую [целевую группу](../concepts/target-resources.md):
  
  1. Откройте раздел **Load Balancer** в каталоге, где требуется создать целевую группу.
  1. Откройте вкладку **Целевые группы**.
  1. Нажмите кнопку **Создать целевую группу**.
  1. Введите имя целевой группы.
  
      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Выберите виртуальные машины, которые нужно добавить в целевую группу.
  1. Нажмите кнопку **Создать целевую группу**.
  
- CLI
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды CLI для создания целевой группы:
  
     ```
     $ yc load-balancer target-group create --help
     ```
  
  1. Получите список виртуальных машин:
  
     ```
     $ yc compute instance list
     +----------------------+------------+---------------+---------+
     |          ID          |    NAME    |    ZONE ID    | STATUS  |
     +----------------------+------------+---------------+---------+
     ...
     | fhmajnpl7cvhl6v1s12i | test-vm-1  | ru-central1-a | RUNNING |
     | fhmajv6f27n0a4a1sbml | test-vm-2  | ru-central1-a | RUNNING |
     ...
     +----------------------+------------+---------------+---------+
     ```
  
  1. Выберите `ID` виртуальной машины, которую следует добавить в целевую группу, и получите о ней сведения:
  
     ```
     $ yc compute instance get fhmajnpl7cvhl6v1s12i
       ...
       subnet_id: e9bhjah6j3k7e6v8t5fa
       primary_v4_address:
         address: 192.168.0.3
       ...
     ```
  
  1. Создайте целевую группу и добавьте в нее нужную виртуальную машину в качестве целевого ресурса, указав `subnet-id` и `address` виртуальной машины во флаге `--target`:
  
     ```
     $ yc load-balancer target-group create \
     --region-id ru-central1 \
     --name test-tg-1 \
     --target subnet-id=e9bhjah6j3k7e6v8t5fa,address=192.168.0.3
     ```
  
- API
  
  Создать новую целевую группу можно с помощью метода API [create](../api-ref/TargetGroup/create.md).
  
  После создания целевой группы следует добавить в нее целевые ресурсы, по которым будет распределяться нагрузка. Целевые ресурсы добавляются в группу с помощью метода [addTargets](../api-ref/TargetGroup/addTargets).
  
{% endlist %}