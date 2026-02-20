{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите инстанс {{ mgl-name }}, для которого нужно создать раннер.
  1. Выберите вкладку **{{ ui-key.yacloud.gitlab.title_runners }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_runners_empty-create }}**.
  1. Задайте имя раннера:
      * длина — от 2 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  1. (Опционально) Введите произвольное описание раннера.
  1. Введите токен {{ GLR }}, [полученный ранее](#gitlab-token).
  1. Выберите или создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для раннера.

      {% include [sa-runner-info](sa-runner-info.md) %}

  1. (Опционально) Добавьте [метки](../../resource-manager/concepts/labels.md) для разделения раннеров на логические группы.
  1. В блоке **{{ ui-key.yacloud.gitlab.label_autoscale-section }}** укажите:

      {% include [runner-workers](../../_includes/managed-gitlab/runner-workers.md) %}

  1. (Опционально) Добавьте метки для воркера.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выберите конфигурацию вычислительных ресурсов.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный диск:
      * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
      * Задайте размер диска.
  1. (Опционально) Выберите или создайте сервисный аккаунт для воркера.

      {% include [sa-worker-info](sa-worker-info.md) %}

  1. (Опционально) Выберите [группу безопасности](../../vpc/concepts/security-groups.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}