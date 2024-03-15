# Источники данных {{ TF }}

[Источники данных (Data Sources)](https://developer.hashicorp.com/terraform/language/data-sources) {{ TF }} позволяют получать актуальную информацию о существующих облачных ресурсах и использовать эти данные в конфигурации вашей инфраструктуры.

С помощью [{{ TF }}-провайдера {{ yandex-cloud }}]({{ tf-docs-link }}) вы можете получить информацию о различных облачных ресурсах: [виртуальных машинах](../../compute/concepts/vm.md), [дисках](../../compute/concepts/disk.md), [облачных сетях](../../vpc/concepts/network.md) и других облачных ресурсах.

Источники данных доступны только для чтения — это гарантирует, что вы не измените внешние ресурсы.

Получим с помощью источников данных {{ TF }} идентификатора образа [Ubuntu 22.04 LTS](marketplace/products/yc/ubuntu-22-04-lts) из {{ marketplace-name }}.

Чтобы получить идентификатор образа `Ubuntu 22.04 LTS` с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите и настройте {{ TF }}](#prepare-terraform).
1. [Опишите источник данных](#prepare-plan).
1. [Проверьте результат](#check).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Установите и настройте {{ TF }} {#prepare-terraform}

{% include notitle [terraform-prepare.md](../../_tutorials/infrastructure/terraform-prepare.md) %}

## Опишите источник данных {#prepare-plan}

{% note tip %}

Источники данных определяются в коде {{ TF }} с использованием блока `data`.

{% endnote %}

1. В файле конфигурации после настроек провайдера добавьте:

    ```
    data "yandex_compute_image" "my_image" {
      family = "ubuntu-2204-lts"
    }

    output "my_image_id" {
      value = data.yandex_compute_image.my_image.id
    }
    ```

    Где:

    * `data "yandex_compute_image"` — описание образа диска в качестве источника данных:
        * `family` — [семейство образов](../../compute/concepts/image.md#family).
    * `output "resource_active"` — выходная переменная, которая содержит информацию о текущем идентификаторе образа для указанного семейства:
        * `value` — возвращаемое значение.

    Более подробно о параметрах источника данных `yandex_compute_image` см. в [документации провайдера]({{ tf-provider-datasources-link }}/datasource_compute_image).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

    {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале.

## Проверьте результат {#check}

Чтобы проверить результат, выполните команду:

```bash
terraform output
```

Результат:

```
my_image_id = "fd8li2lvvfc6bdj4c787"
```

Далее вы можете использовать полученный идентификатор для [создания ВМ](../../compute/operations/images-with-pre-installed-software/create.md), например:

```
resource "yandex_compute_disk" "boot-disk" {
  name     = "<имя_диска>"
  type     = "<тип_диска>"
  zone     = "<зона_доступности>"
  size     = "<размер_диска>"
  image_id = data.yandex_compute_image.my_image.id
}

...
```

## См. также {#see-also}

* [Начало работы с {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Загрузка состояний {{ TF }} в {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Блокировка состояний {{ TF }} с помощью {{ ydb-name }}](../../tutorials/infrastructure-management/terraform-state-lock.md).
* [Использование модулей {{ yandex-cloud }} в {{ TF }}](../../tutorials/infrastructure-management/terraform-modules.md).