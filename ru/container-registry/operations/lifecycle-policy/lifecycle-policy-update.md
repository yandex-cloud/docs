# Изменить политику удаления

После создания [политики удаления](../../concepts/lifecycle-policy.md) вы можете изменить ее правила, а также статус, имя или описание.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан [реестр](../../concepts/registry.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Выберите репозиторий и нажмите на строку с его именем.
  1. На панели слева нажмите ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. В строке с нужной политикой удаления нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры политики удаления:
     * **{{ ui-key.yacloud.common.name }}**.
     * **{{ ui-key.yacloud.common.description }}**.
     * **{{ ui-key.yacloud.common.label_status }}**.
     * В блоке **{{ ui-key.yacloud.cr.registry.label_lifecycle-rules }}** измените параметры правил:

       {% include [lifecycle-rules-console](../../../_includes/container-registry/lifecycle-rules-console.md) %}

       * **{{ ui-key.yacloud.common.description }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для обновления параметров политики:

     ```bash
     yc container repository lifecycle-policy update --help
     ```

  1. Измените параметры политики, например, переименуйте политику:

     ```bash
     yc container repository lifecycle-policy update <идентификатор_политики> \
        --new-name=new-policy
     ```

     Чтобы узнать идентификатор политики, получите [список политик удаления в репозитории или в реестре](lifecycle-policy-list.md#lifecycle-policy-list)

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте конфигурационный файл и отредактируйте фрагмент с описанием политики:

      ```hcl
      resource "yandex_container_repository_lifecycle_policy" "my_lifecycle_policy" {
        name          = "best-policy"
        status        = "active"
        repository_id = "crpfvi6o4ra7********"

        rule {
          description   = "rule for applying policy"
          untagged      = true
          tag_regexp    = ".*"
          retained_top  = 1
          expire_period = "48h"
        }
      }
      ```

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанном репозитории будет изменена политика удаления. Проверить изменение политики можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
     yc container repository lifecycle-policy list --registry-id <идентификатор_реестра>
    ```

- API {#api}

  Чтобы изменить политику удаления, воспользуйтесь методом [Update](../../api-ref/grpc/lifecycle_policy_service.md#Update) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md). В свойстве `lifecycle_policy_id` укажите идентификатор политики.

  Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/lifecycle_policy_service.md#List) для ресурса [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md).

{% endlist %}

## Примеры {#examples}

### Изменить правила политики удаления {#update-rules}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Подготовьте новые [правила политики](../../concepts/lifecycle-policy.md#lifecycle-rules) и сохраните их в файл `new-rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Измените правила политики, выполнив команду со следующим параметром:
     * `new-rules` — путь к файлу с новым описанием политик.

     {% note alert %}

     Обновление политики полностью перезаписывает все текущие правила — они будут удалены.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy update crp6lg1868p3******** --new-rules ./new-rules.json
     ```

     Результат:

     ```bash
     WARN: All current lifecycle rules will be overwritten. Are you sure?[y/N] y
     id: crp6lg1868p3********
     name: test-policy
     ...
       expire_period: 172800s
       tag_regexp: test.*
       untagged: true
     ```

{% endlist %}

### Изменить статус политики удаления {#update-status}

#### Активируйте политику удаления {#activate}

{% list tabs group=instructions %}

- CLI {#cli}

  Сделайте выключенную политику активной, выполнив команду с флагом `--activate`:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --activate
  ```

  Результат:

  ```bash
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

#### Выключите политику удаления {#disabled}

{% list tabs group=instructions %}

- CLI {#cli}

  Выключите активную политику, выполнив команду с флагом `--disable`:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --disable
  ```

  Результат:

  ```bash
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Изменить имя политики удаления {#update-name}

{% list tabs group=instructions %}

- CLI {#cli}

  Измените имя политики, выполнив команду:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --new-name new-policy
  ```

  Где `--new-name` — новое имя политики. Требования к имени:

  {% include [name-format](../../../_includes/name-format.md) %}

  Результат:

  ```bash
  id: crp6lg1868p3********
  name: new-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Изменить описание политики удаления {#update-description}

{% list tabs group=instructions %}

- CLI {#cli}

  Измените описание политики, выполнив команду:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --new-description "new description"
  ```

  Где `--new-description` — новое описание политики.

  Результат:

  ```bash
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}