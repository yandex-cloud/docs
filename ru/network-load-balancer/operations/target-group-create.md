# Создать целевую группу {{ network-load-balancer-name }}

{% list tabs %}

- Консоль управления
  
  Чтобы создать новую [целевую группу](../concepts/target-resources.md):
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется создать целевую группу.
  1. В списке сервисов выберите **{{ network-load-balancer-name }}**.
  1. На панели слева выберите ![image](../../_assets/trgroups.svg) **Целевые группы**.
  1. Нажмите кнопку **Создать целевую группу**.
  1. Введите имя целевой группы.
  
      {% include [name-format](../../_includes/name-format.md) %}
  
  1. Выберите [виртуальные машины](../../glossary/vm.md), которые нужно добавить в целевую группу.
  1. Нажмите кнопку **Создать**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания целевой группы:
  
     ```bash
     yc load-balancer target-group create --help
     ```

  1. Создайте целевую группу и добавьте в нее нужные виртуальные машины в качестве целевых ресурсов, указав параметры виртуальных машин в одном или нескольких параметрах `--target`:

     ```bash
     yc load-balancer target-group create <имя целевой группы> \
        --target subnet-id=<идентификатор подсети>,`
                `address=<внутренний IP-адрес виртуальной машины>
     ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса целевой группы.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_lb_target_group" "foo" {
       name      = "<имя целевой группы>"
       target {
         subnet_id = "<идентификатор подсети>"
         address   = "<внутренний IP-адрес ресурса>"
       }
       target {
         subnet_id = "<идентификатор подсети>"
         address   = "<внутренний IP-адрес ресурса 2>"
       }
     }
     ```

     * `name` — имя целевой группы.
     * `target` — описание целевого ресурса:
        * `subnet_id` — идентификатор подсети, к которой подключены целевые объекты. Все целевые объекты в целевой группе должны находится в пределах одной зоны доступности.
        * `address` — внутренний IP-адрес ресурса.

     Более подробную информацию о параметрах ресурса `yandex_lb_target_group` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/lb_target_group).

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте целевую группу.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/TargetGroup/create.md) и передайте в запросе:

  * Идентификатор каталога, в котором должен быть размещена целевая группа, в параметре `folderId`.
  * Имя целевой группы в параметре `name`.
  * Идентификатор подсети и внутренний IP-адрес целевых ресурсов в параметре `targets`.

  Целевые ресурсы можно добавить после создания целевой группы с помощью метода API [addTargets](../api-ref/TargetGroup/addTargets).

{% endlist %}
