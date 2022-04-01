# Переименование облака

Чтобы переименовать облако, у вас должна быть роль [`editor`](../../../iam/concepts/access-control/roles.md#editor) или выше на это облако. Переименовать заблокированное облако нельзя. Если вы не можете выполнить эту операцию, обратитесь к [администратору](../../../iam/concepts/access-control/roles.md#admin) или [владельцу облака](../../concepts/resources-hierarchy.md#owner).

{% note info %}

В [консоли управления]({{ link-console-main }}) доступен выбор интерфейса навигации между ресурсами и сервисами. Чтобы сменить способ навигации, в блоке с информацией аккаунта нажмите кнопку ![image](../../../_assets/settings.svg), затем выберите ![image](../../../_assets/experiments.svg) **Эксперименты** и включите опцию **Новая навигация**.

{% endnote %}

{% list tabs %}

- Старая навигация

  1. В [консоли управления]({{ link-console-main }}) выберите облако в списке.
  1. Нажмите кнопку ![image](../../../_assets/options.svg) и выберите **Редактировать**.

      ![image](../../../_assets/iam/cloud-actions.png)

  1. В открывшемся окне введите новое имя облака. Требования к имени:

	 {% include [name-format.md](../../../_includes/name-format.md) %}

  1. Нажмите **Сохранить**.

- Новая навигация

  1. В [консоли управления]({{ link-console-main }}) выберите облако в списке слева.
  1. Нажмите кнопку ![***](../../../_assets/pencil.svg) **Редактировать** в правом верхнем углу.

      ![image](../../../_assets/iam/cloud-actions-n-n.png)

  1. В открывшемся окне введите новое имя облака. Требования к имени:

	 {% include [name-format.md](../../../_includes/name-format.md) %}

  1. Нажмите **Сохранить**.

- Terraform

  Подробнее о Terraform [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы переименовать облако, созданное с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените значение параметра `name` во фрагменте с описанием облака.

      {% cut "Пример описания облака в конфигурации Terraform" %}

      ```hcl
      ...
      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "cloud-main"
        organization_id = "bpf7nhb9hkphksfevi77"
      }
      ...
      ```

      {% endcut %}

      Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud` в Terraform, см. в [документации провайдера](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_cloud).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить измененное имя облака можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc resource-manager cloud list
      ```

{% endlist %}