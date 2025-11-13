## Окружение {#environment}

Выберите окружение, в котором нужно создать кластер {{ mkf-name }} (после создания кластера изменить окружение невозможно):
  * `PRODUCTION` — для стабильных версий приложений.
  * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению, и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

## Класс хостов {#broker-class}

В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите [платформу](../../../compute/concepts/vm-platforms.md), тип и класс хостов.

Класс хостов определяет технические характеристики [виртуальных машин](../../../compute/concepts/vm.md), на которых будут развернуты хосты-брокеры {{ KF }}. Все доступные варианты перечислены в разделе [Классы хостов](../../../managed-kafka/concepts/instance-types.md).

При [изменении класса хостов](../../../managed-kafka/operations/cluster-update.md#change-brokers) для кластера {{ mkf-name }} меняются характеристики всех уже созданных экземпляров.

## Конфигурация хостов по умолчанию {#default-config}

По умолчанию для хостов {{ ZK }} и {{ kraft-short-name }} задаются следующие характеристики:

* [класс хоста](../../../managed-kafka/concepts/instance-types.md) — `s3-c2-m8`;
* объем диска — `10` ГБ;
* [тип диска](../../../managed-kafka/concepts/storage.md) — `network-ssd`.

## Автоматическое увеличение размера хранилища {#auto-rescale}

Чтобы в кластере не заканчивалось место на диске, создайте кластер с [автоматическим увеличением размера хранилища](../../../managed-kafka/concepts/storage.md#auto-rescale):

```bash
{{ yc-mdb-kf }} cluster create \
...
--disk-size-autoscaling disk-size-limit=<максимальный_размер_хранилища_в_байтах>,`
                        `planned-usage-threshold=<процент_для_планового_увеличения>,`
                        `emergency-usage-threshold=<процент_для_незамедлительного_увеличения> \
...
```

{% include [description-of-parameters](disk-auto-scaling.md) %}

{% include [warn-storage-resize](../mpg/warn-storage-resize.md) %}

## Статус кластера {#status}

Дождитесь, когда кластер {{ mkf-name }} будет готов к работе: его статус на панели {{ mkf-name }} сменится на `Running`, а состояние — на `Alive`. Это может занять некоторое время.

## Предупреждение про зоны доступности и создание кластера {#note-warning}

{% note warning %}
        
Если создать кластер {{ mkf-name }} с одной [зоной доступности](../../../overview/concepts/geo-scope.md), в дальнейшем увеличить количество зон и хостов-брокеров будет невозможно.
        
{% endnote %}

## Настройка времени технического обслуживания {#maintenance}

Чтобы настроить время [технического обслуживания](../../../managed-kafka/concepts/maintenance.md) (в т. ч. для выключенных кластеров {{ mkf-name }}), передайте нужное значение в параметре `--maintenance-window` при создании кластера:

```bash
{{ yc-mdb-kf }} cluster create \
...
--maintenance-window type=<тип_технического_обслуживания>,`
                    `day=<день_недели>,`
                    `hour=<час_дня> \
...
```

Где `type` — тип технического обслуживания:

{% include [maintenance-window](../cli/maintenance-window-description.md) %}

## Предупреждение про комбинированный режим и передачу конфигурации хостов {#note-warning-combined-mode}

{% note warning %}
                    
Если вы создаете кластер с [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../../../managed-kafka/concepts/kraft.md#cluster-topology), не передавайте конфигурацию хостов {{ kraft-short-name }}.
                    
{% endnote %}

## Защита кластера от удаления {#protect-from-deletion}

{% note info %}

Включенная защита кластера от удаления не помешает удалить пользователя или топик, а также подключиться вручную и удалить данные.

{% endnote %}
