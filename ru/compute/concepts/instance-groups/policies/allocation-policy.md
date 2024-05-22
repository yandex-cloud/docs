# Политика распределения


При создании группы виртуальных машин можно выбрать, в каких [зонах доступности](../../../../overview/concepts/geo-scope.md) {{ yandex-cloud }} будут размещаться ВМ, а также задать список тегов для ВМ внутри каждой зоны доступности.

Переместить виртуальные машины в другие зоны доступности невозможно, но вы можете [обновить группу](../../../operations/instance-groups/deploy/rolling-update.md) с новыми значениями зон.

## Теги {#tags}

Для логической маркировки виртуальных машин внутри зоны доступности используются _теги_. Передать список тегов в группу ВМ можно с помощью [YAML-спецификации](../specification.md). После этого каждой ВМ в зоне доступности будет присваиваться единственный уникальный тег из списка.

С помощью тегов можно достичь более гранулярного декларативного управления ВМ в группе. Теги можно использовать как [системные переменные](../variables-in-the-template.md#first-stage), например в имени ВМ. Если удалить какой-либо тег из списка в YAML-спецификации, то после применения конфигурации из группы будет удалена и сама ВМ с этим тегом, размер группы при этом не изменится, будет создана новая ВМ со следующим свободным тегом из списка. Также теги позволяют сохранить определенность конфигурации при изменении размера группы: каждой ВМ последовательно будут присвоены теги из списка в соответствии с количеством ВМ в зоне доступности.

Кроме этого, теги можно использовать в переменных, чтобы [создавать группы ВМ с фиксированными IP-адресами](../../../operations/instance-groups/create-with-fixed-ip.md).

## Спецификация {#specification}

Политика распределения задается в YAML-спецификации в ключе `allocation-policy`. Список зон доступности определяется в ключе `zones`, а список тегов — в ключе `instance_tags_pool`. Вы можете указать любые доступные зоны — виртуальные машины в группе будут равномерно распределяться между ними.

Пример записи в YAML-спецификации:

```yaml
...
allocation_policy:
  zones:
    - zone_id: {{ region-id }}-a
      instance_tags_pool:
      - first-tag
      - second-tag
    - zone_id: {{ region-id }}-b
      instance_tags_pool:
      - third-tag
      - fourth-tag
    - zone_id: {{ region-id }}-d
      instance_tags_pool:
      - fifth-tag
      - sixth-tag
...
```

Где:

Ключ | Значение
----- | -----
`zones` | Список зон. Каждая зона задается в ключе `zone_id`, в виде пары `ключ:значение`.
`zone_id` | Идентификатор зоны.
`instance_tags_pool` | (опционально) Список тегов ВМ в группе.<br/>Ограничения:<ul><li>Количество тегов должно быть не менее значения ключа `size` в секции `scale_policy` для групп ВМ фиксированного размера и не менее значения ключа `max_size` в секции `scale_policy` для групп ВМ с автоматическим масштабированием.</li><li>Теги должны быть уникальными для всей группы, а не только внутри одной зоны.</li><li>Длина тега — от 3 до 50 символов.</li><li>Тег может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.</li></ul>

### Пример {#example}

В примере YAML-спецификации описана [группа виртуальных машин фиксированного размера](../../../operations/instance-groups/create-fixed-group.md). ВМ размещены в одной зоне доступности, имена ВМ включают в себя теги из списка `instance_tags_pool`.

```yaml
name: first-fixed-group
service_account_id: ajeujptarqa4********
description: "This instance group was created from YAML config."
instance_template:
  name: production-{instance.tag}
  platform_id: standard-v3
  resources_spec:
    memory: 2g
    cores: 2
  boot_disk_spec:
    mode: READ_WRITE
    disk_spec:
      image_id: fd8v80pep5m9********
      type_id: network-hdd
      size: 5g
  network_interface_specs:
    - network_id: enpgf5vu9dd7********
      primary_v4_address_spec: {}
  scheduling_policy:
    preemptible: false
deploy_policy:
  max_unavailable: 1
  max_expansion: 0
scale_policy:
  fixed_scale:
    size: 3
allocation_policy:
  zones:
    - zone_id: {{ region-id }}-a
      instance_tags_pool:
      - first
      - second
      - third
```

### См. также {#see-also}

* [{#T}](healing-policy.md)
* [{#T}](scale-policy.md)
* [{#T}](deploy-policy.md)
* [{#T}](../../../operations/instance-groups/create-with-fixed-ip.md)
