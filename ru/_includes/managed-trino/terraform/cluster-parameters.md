Пример структуры конфигурационного файла:

```hcl
resource "yandex_trino_cluster" "<имя_кластера>" {
  name                = "<имя_кластера>"
  service_account_id  = "<идентификатор_сервисного_аккаунта>"
  subnet_ids          = [yandex_vpc_subnet.<имя_подсети>.id]
  security_group_ids  = [<список_идентификаторов_групп_безопасности>]
  deletion_protection = <защитить_кластер_от_удаления>

  coordinator = {
    resource_preset_id = "<класс_вычислительных_ресурсов>"
  }

  worker = {
    fixed_scale = {
      count = 4
    }
    resource_preset_id = "<класс_вычислительных_ресурсов>"
  }
}

resource "yandex_vpc_network" "<имя_сети>" {
  name = "<имя_сети>"
}

resource "yandex_vpc_subnet" "<имя_подсети>" {
  name           = "<имя_подсети>"
  zone           = "<зона_доступности>"
  network_id     = "yandex_vpc_network.<имя_сети>.id"
  v4_cidr_blocks = ["<диапазон>"]
}
```

Где:

* `name` — имя кластера. Оно должно быть уникальным в рамках каталога.
* `service_account_id` — идентификатор сервисного аккаунта.
* `subnet_ids` — список идентификаторов подсетей.
* `security_group_ids` — список идентификаторов групп безопасности.
* `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

    Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

* `coordinator` — конфигурация [координатора](../../../managed-trino/concepts/index.md#coordinator):

    * `resource_preset_id` — [класс вычислительных ресурсов](../../../managed-trino/concepts/instance-types.md) координатора.

* `worker` — конфигурация [воркера](../../../managed-trino/concepts/index.md#workers):

    * `resource_preset_id` — [класс вычислительных ресурсов](../../../managed-trino/concepts/instance-types.md) воркера.

    * `fixed_scale` — фиксированная политика масштабирования воркеров.

        * `count` — количество воркеров.

    * `auto_scale` — автоматическая политика масштабирования воркеров.

        * `min_count` — минимальное количество воркеров.
        * `max_count` — максимальное количество воркеров.

    Укажите либо фиксированное количество воркеров (`fixed_scale.count`), либо минимальное и максимальное количество воркеров (`auto_scale.min_count`, `auto_scale.max_count`) для автоматического масштабирования.
