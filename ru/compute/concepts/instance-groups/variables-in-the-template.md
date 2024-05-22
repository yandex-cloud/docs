# Переменные в шаблоне виртуальной машины

{{ ig-name }} позволяет создать группу однотипных виртуальных машин из [шаблона](instance-template.md). Чтобы такие ВМ имели разные характеристики, используйте механизм подстановок системных и пользовательских переменных в шаблоне. Например, с помощью переменных и [тегов](./policies/allocation-policy.md#tags) вы можете [создать группу ВМ с фиксированными IP-адресами](../../operations/instance-groups/create-with-fixed-ip.md).

_Системная переменная_ — значение, которое {{ ig-name }} вычисляет во время создания ВМ и подставляет его в шаблон для дальнейшего использования.

_Пользовательская переменная_ — значение, которое {{ ig-name }} берет из списка. Он заранее сформирован пользователем, переменные в нем описаны в формате `ключ:значение`.

## Поля, в которых поддерживаются переменные {#support-fields}

Шаблон ВМ описывается в YAML-файле с помощью ключа `instance_template`. Вы можете указать системные и пользовательские переменные вместо значений следующих полей шаблона:

* `instance_template.fqdn` — [FQDN](../../../glossary/fqdn.md) хоста.
* `instance_template.hostname` — имя хоста.
* `instance_template.metadata` — метаданные ВМ. Переменные можно использовать только в значениях ключей поля `metadata`.
* `instance_template.name` — имя ВМ.
* `instance_template.labels` — метки ВМ. Переменные можно использовать только в значениях ключей поля `labels`.
* `instance_template.boot_disk_spec.disk_id` — идентификатор загрузочного диска.
* `instance_template.boot_disk_spec.disk_spec.description` — описание загрузочного диска.
* `instance_template.boot_disk_spec.disk_spec.image_id` — идентификатор образа загрузочного диска.
* `instance_template.boot_disk_spec.disk_spec.snapshot_id` — идентификатор снимка загрузочного диска.
* `instance_template.boot_disk_spec.disk_spec.type_id` — тип загрузочного диска.
* `instance_template.network_interface_specs.primary_v4_address_spec.one_to_one_nat_spec.address` — конфигурация внешнего IP-адреса версии IPv4.
* `instance_template.network_interface_specs.primary_v6_address_spec.one_to_one_nat_spec.address` — конфигурация внешнего IP-адреса версии IPv6.
* `instance_template.placement_policy.placement_group_id` — идентификатор [группы размещения](../placement-groups.md).
* `instance_template.secondary_disk_specs.disk_id` — идентификатор дополнительного диска.
* `instance_template.secondary_disk_specs.disk_spec.description` — описание дополнительного диска.
* `instance_template.secondary_disk_specs.disk_spec.image_id` — идентификатор образа дополнительного диска.
* `instance_template.secondary_disk_specs.disk_spec.snapshot_id` — идентификатор снимка дополнительного диска.
* `instance_template.secondary_disk_specs.disk_spec.type_id` — тип дополнительного диска.

## Этапы подстановки переменных {#substitution-rules}

{{ ig-name }} заменит системные и пользовательские переменные на значения в два этапа:

1. [Замена системных переменных на вычисленные значения](#first-stage).
1. [Замена пользовательских переменных на значения из списка](#second-stage).

Преобразование может быть составным. В этом случае значение, полученное на первом этапе, является переменной для второго этапа.

[Пример](#example) прохождения этапов подстановки описан ниже.

### Первый этап подстановки значений {#first-stage}

{{ ig-name }} заменит на вычисленные значения только фиксированный список системных переменных:

Системная переменная | Описание
--- | ---
`{instance_group.id}` | Идентификатор группы ВМ.
`{instance_group.labels.label_key}` | Значение метки с ключом `label_key`.
`{instance.index}` | Уникальный номер ВМ в группе.</br>Возможные значения: от 1 до N, где N — количество ВМ в группе.
`{instance.index_in_zone}` | Номер ВМ в зоне. Уникален в рамках зоны для конкретной группы</br>ВМ.
`{instance.short_id}` | Идентификатор ВМ, уникальный в рамках группы. Состоит из четырех букв.
`{instance.tag}` | Тег ВМ в группе внутри зоны доступности. Подробнее см. [Политика распределения](policies/allocation-policy.md).
`{instance.zone_id}` | Идентификатор зоны.

>Например, при создании группы ВМ {{ ig-name }} присвоит группе идентификатор и подставит его вместо `{instance_group.id}` каждой ВМ.

### Второй этап подстановки значений {#second-stage}

Для того чтобы на этом этапе {{ ig-name }} подставил значения, заранее сформируйте список пользовательских переменных в формате `ключ:значение`.

На данном этапе {{ ig-name }}:

1. Сравнит переменные с ключами из пользовательского списка.
1. Проставит им значения, указанные в ключах.

## Преобразования переменных {#converting-rules}

Системные и пользовательские переменные указываются в качестве значений полей шаблона в фигурных скобках `{}`. {{ ig-name }} преобразует их по указанным ниже правилам.

Значение поля в шаблоне | Значение поля</br>после преобразования | Описание преобразования
--- | --- | ---
`{заданный_ключ}` | `значение`  | Значение будет подставлено из заранее подготовленного списка.
`{неизвестный_ключ}` | `{неизвестный_ключ}` | Если указан ключ, который не поддерживается механизмом подстановок, {{ ig-name }} не заменит его.
`{{заданный_ключ}}` | `{заданный_ключ}` | На первом этапе внутренний уровень скобок будет раскрыт.
`{{неизвестный_ключ}}` | `{{неизвестный_ключ}}` | Ключ, который не поддерживается механизмом подстановок, не изменится.

## Пример прохождения этапов подстановки {#example}

1. В шаблоне ВМ указаны:

   * Список пользовательских переменных в формате `ключ:значение` в блоке `variables`.
   * Системные и пользовательские переменные в [допустимых](#support-fields) полях:
     * в поле `instance_template.name` указаны пользовательская переменная `{short_zone_var_{instance.zone_id}}` и системная — `{instance.index}`;
     * в поле `instance_template.hostname` указана системная переменная `{instance.index}`.

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-d
       value: rc1d
   instance_template:
     name: production-{short_zone_var_{instance.zone_id}}-{instance.index}
     hostname: production-{instance.index}
     platform_id: standard-v3
   ...
   ```

1. На первом этапе {{ ig-name }} заменит [системные переменные](#first-stage) на вычисленные значения.

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-d
       value: rc1d
   instance_template:
     name: production-{short_zone_var_{{ region-id }}-a}-1
     hostname: production-1
     platform_id: standard-v3
   ...
   ```

   Где:

   * В поле `instance_template.name`:
     * переменная `{short_zone_var_{instance.zone_id}}` будет преобразована в переменную `{short_zone_var_{{ region-id }}-a}`;
     * системная переменная `{instance.index}` будет преобразована в индекс `1`.
   * В поле `instance_template.hostname` системная переменная `{instance.index}` будет преобразована в индекс `1`.

1. На втором этапе {{ ig-name }} преобразует полученные переменные в значения из списка в блоке `variables`:

   ```yaml
   ...
   variables:
     - key: short_zone_var_{{ region-id }}-a
       value: rc1a
     - key: short_zone_var_{{ region-id }}-b
       value: rc1b
     - key: short_zone_var_{{ region-id }}-d
       value: rc1d
   instance_template:
     name: production-rc1a-1
     hostname: production-1
     platform_id: standard-v3
   ...
   ```

   В поле `instance_template.name`: переменная `{short_zone_var_{{ region-id }}-a}` будет преобразована в значение `rc1a`.

### См. также {#see-also}

* [{#T}](specification.md)
* [{#T}](instance-template.md)
* [{#T}](../../operations/instance-groups/create-with-fixed-ip.md)