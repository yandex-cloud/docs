# Изменить группу виртуальных машин

После создания группы виртуальных машин вы можете:

* [Изменить имя и описание](#change-name).
* [Изменить вычислительные ресурсы](#change-compute-resources).
* [Увеличить размер диска](#change-disk-size).

## Изменить имя и описание {#change-name}

Чтобы изменить имя и описание группы виртуальных машин:

{% list tabs %}

- Консоль управления

  1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Нажмите на имя группы, которую желаете изменить.
  1. Нажмите **Изменить** в правом верхнем углу страницы.
  1. Укажите нужное имя и описание группы.
  1. Нажмите **Сохранить**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

     ```
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Укажите нужное имя и описание в YAML-файле, по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API

  Изменить имя и описание группы можно с помощью метода API [update](../../api-ref/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

## Изменить вычислительные ресурсы {#change-compute-resources}

После создания группы виртуальных машин вы можете изменить:

* гарантированную долю vCPU;
* количество vCPU и объем RAM.

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

Чтобы изменить вычислительные ресурсы группы виртуальных машин:

{% list tabs %}

- Консоль управления

  1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Нажмите на имя группы, которую желаете изменить.
  1. Нажмите **Изменить** в правом верхнем углу страницы.
  1. Удалите текущий шаблон виртуальной машины и создайте новый с нужными параметрами ВМ.
  1. Нажмите **Сохранить**.
  1. Нажмите **Сохранить** на странице **Изменение группы виртуальных машин**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

     ```
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Укажите нужные параметры виртуальной машины в YAML-файле (ключ `resources_spec`), по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API

  Изменить вычислительные ресурсы можно с помощью метода API [update](../../api-ref/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

## Увеличить размер диска {#change-disk-size}

{% include [include](../../../_includes/instance-groups/update-stopped-group-disclaimer.md) %}

Чтобы увеличить размер диска группы виртуальных машин:

{% list tabs %}

- Консоль управления

  1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Нажмите на имя группы, которую желаете изменить.
  1. Нажмите **Изменить** в правом верхнем углу страницы.
  1. Нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) в правом верхнем углу блока **Шаблон виртуальной машины** и выберите пункт **Редактировать**.
  1. В блоке **Диски** укажите нужный размер диска.
  1. Нажмите **Сохранить**.
  1. Нажмите **Сохранить** на странице **Изменение группы виртуальных машин**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения группы:

     ```
     {{ yc-compute-ig }} update --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

      {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Укажите нужный размер хранилища в YAML-файле (ключ `boot_disk_spec`), по которому создавалась группа, например `specification.yaml`. Если YAML-файл не сохранился, [получите информацию](get-info.md) о группе виртуальных машин и создайте новый. Подробнее читайте в разделе [{#T}](create-fixed-group.md).
  1. Обновите группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} update --name first-instance-group --file specification.yaml
      ```

     {{ ig-name }} запустит операцию изменения группы виртуальных машин.

- API

  Изменить размер диска можно с помощью метода API [update](../../api-ref/InstanceGroup/update.md).

  Список доступных групп запрашивайте методом [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}

