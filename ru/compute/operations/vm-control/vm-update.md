# Изменить виртуальную машину

После создания виртуальной машины вы можете изменить ее имя, описание, метки, платформу или метаданные.

Как изменить конфигурацию виртуальной машины, читайте в разделе [{#T}](vm-update-resources.md).

{% list tabs %}

- Консоль управления

   Чтобы изменить виртуальную машину:
   1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
   1. Выберите сервис **{{ compute-name }}**.
   1. Нажмите на имя нужной виртуальной машины.
   1. Нажмите **Изменить ВМ**.
   1. Измените параметры виртуальной машины, например, переименуйте машину, отредактировав поле **Имя**.
   1. Внизу страницы нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров виртуальных машин:

      ```
      $ yc compute instance update --help
      ```

  1. Получите список виртуальных машин в каталоге по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Измените параметры виртуальной машины, например, переименуйте машину:

      ```
      $ yc compute instance update first-instance \
          --new-name windows-vm
      ```

- API

  Чтобы изменить виртуальную машину, воспользуйтесь методом [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/).

{% endlist %}

{% note info %}

При изменении имени виртуальной машины, имя хоста и, соответственно, FQDN не изменяются. Подробнее про генерацию имени FQDN читайте в разделе [{#T}](../../concepts/network.md#hostname).

{% endnote %}

## Примеры {#examples}

### Просмотреть список изменяемых параметров {#viewing-a-list-of-configurable-parameters}

Чтобы просмотреть список изменяемых параметров, выполните команду:

{% list tabs %}

- CLI

  ```
  $ yc compute instance update --help
  ```
{% endlist %}

### Изменить имя и описание {#changing-the-name-and-description}

Чтобы изменить имя и описание виртуальной машины, выполните следующие шаги:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список виртуальных машин в каталоге по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Измените имя и описание виртуальной машины:

      ```
      $ yc compute instance update first-instance \
          --new-name first-vm \
          --description "changed description vm via CLI"
      ```

{% endlist %}

### Изменить метаданные {#changing-metadata}

Метаданные на базе разных операционных систем могут отличаться. При изменении имеющийся набор метаданных полностью перезаписывается набором, переданным в команде.

Чтобы изменить метаданные виртуальной машины, выполните следующие шаги:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список виртуальных машин в каталоге по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной машины, например `first-instance`.
  1. Получите информацию о виртуальной машине вместе с метаданными. Все пользовательские метаданные определены в ключе `user-data`.

      ```
      $ yc compute instance get --full first-instance
      ```

  1. Измените метаданные виртуальной машины. Изменить метаданные можно с помощью флагов:

      - `--metadata` — для изменения значения из одной строки;
      - `--metadata-from-file` — для изменения значения из нескольких строк.

      {% if product == "yandex-cloud" %}
     
      Пример изменения пароля администратора на виртуальной машине, на базе ОС Windows:

      1. Создайте YAML-файл (например, `metadata.yaml`) и укажите следующие данные:

          ```yaml
          #ps1
          net user administrator '<пароль>'
          ```

      1. Выполните команду:

          ```
          $ yc compute instance update first-instance \
              --metadata-from-file user-data=metadata.yaml
          ```

          Имеющийся набор метаданных будет полностью перезаписан.
 
      {% endif %}

{% endlist %}
