# Интеграция группы ВМ с {{ network-load-balancer-name }} или {{ alb-name }}

Сервисы [{{ network-load-balancer-full-name }}](/services/network-load-balancer) и [{{ alb-full-name }}](/services/application-load-balancer) позволяют распределять входящую нагрузку между виртуальными машинами {{ compute-full-name }}. [Группу виртуальных машин](index.md) можно интегрировать с этими сервисами: {{ compute-name }} автоматически создаст из группы ВМ целевую группу {{ network-load-balancer-name }} или {{ alb-name }} и будет следить, чтобы в группу не добавлялись «нездоровые» ВМ.


## Как работает интеграция {#principles}

### Создание целевой группы {#principles-creation}

В сервисах балансировки нагрузки {{ yandex-cloud }} _целевая группа_ — это набор ресурсов, на которых запущены ваши сетевые приложения. Балансировщик, к которому привязана целевая группа, распределяет входящие запросы между ее ресурсами. Подробнее о целевых группах см. в документации [{{ network-load-balancer-name }}](../../../network-load-balancer/concepts/target-resources.md) и [{{ alb-name }}](../../../application-load-balancer/concepts/target-group.md).

Как правило, целевые группы состоят из виртуальных машин {{ compute-name }}. Поэтому группу ВМ можно настроить так, чтобы из нее автоматически создалась целевая группа {{ network-load-balancer-name }} или {{ alb-name }}. Созданная таким образом целевая группа будет связана с группой ВМ:

* когда ВМ добавляется в группу ВМ или запускается после остановки, она добавляется в целевую группу;
* когда ВМ останавливается или удаляется из группы ВМ, она удаляется из целевой группы.

Чтобы целевая группа начала получать трафик, ее нужно привязать к балансировщику. {{ compute-name }} не делает этого автоматически. 

* Целевую группу {{ network-load-balancer-name }} нужно [привязать к балансировщику](../../../network-load-balancer/operations/target-group-attach.md) напрямую. 
* Целевую группу {{ alb-name }} нужно привязать к [группе бэкендов](../../../application-load-balancer/concepts/backend-group.md), а группу бэкендов — к балансировщику, напрямую или через [HTTP-роутеру](../../../application-load-balancer/concepts/http-router.md), в зависимости от типа балансировки. Подробнее см. в [инструкциях по управлению ресурсами {{ alb-name }}](../../../application-load-balancer/operations/index.md). 


### Проверки состояния от балансировщиков {#principles-health-checks}

Когда целевая группа привязана к балансировщику, он отправляет машинам в этой группе _проверки состояния_, чтобы при распределении трафика знать, какие ВМ «здоровы», а какие нет. Подробнее о проверках состояния см. в документации [{{ network-load-balancer-name }}](../../../network-load-balancer/concepts/health-check.md) и [{{ alb-name }}](../../../application-load-balancer/concepts/backend-group.md#health-checks).

ВМ, добавленная в группу ВМ или запущенная после остановки, попадает в целевую группу, получает [статус `OPENING_TRAFFIC` в группе ВМ](statuses.md#vm-statuses), и балансировщик начинает отправлять на нее проверки состояния. Если ВМ пройдет нужное количество проверок (порог работоспособности, который указывается в настройках проверки), то балансировщик сочтет ее «здоровой» — она начнет получать трафик от балансировщика и перейдет в статус `RUNNING_ACTUAL`.

По умолчанию ВМ может находиться в статусе `OPENING_TRAFFIC` неограниченное время, пока не станет «здоровой». Вы можете ограничить это время в [настройках интеграции](#settings) (поле `max_opening_traffic_duration`). Тогда {{ compute-name }} автоматически восстановит ВМ, которая не получает трафик слишком долго с момента добавления в группу или запуска. Подробнее о восстановлении см. в разделе [{#T}](autohealing.md#healthcheck-cases).


## Настройки {#settings}

Интеграцию группы ВМ с {{ network-load-balancer-name }} или {{ alb-name }} можно настроить в консоли управления или описать в [YAML-спецификации](specification.md) группы, чтобы передать спецификацию через один из программных инструментов — интерфейс командной строки (CLI) или API {{ yandex-cloud }}. Настройки можно указать при [создании](../../operations/index.md#ig-create) или [изменении](../../operations/index.md#ig-control) группы.

Группа ВМ может быть интегрирована только с одним из сервисов: либо с {{ network-load-balancer-name }}, либо с {{ alb-name }}. Настроить интеграцию группы ВМ с обоими сервисами сразу нельзя.

Ниже описаны поля с настройками в YAML-спецификации и соответствующие им поля в консоли управления.

### Настройки интеграции с {{ network-load-balancer-name }} {#settings-nlb}

```yaml
load_balancer_spec:
  target_group_spec:
    name: "ig-tg"
    description: "Instance group as target group"
    labels:
      foo: "baz"
      bar: "baz"
  max_opening_traffic_duration: 30s
```

Поля и опции в консоли управления находятся в блоке **{{ ui-key.yacloud.compute.groups.create.section_ylb }}** на страницах создания и редактирования группы ВМ.

| Ключ в YAML<br/>Поле или опция в консоли | Описание |
| --- | --- |
| `load_balancer_spec`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** | Настройки интеграции группы ВМ с {{ network-load-balancer-name }}. Если ключа нет в YAML-спецификации или опция в консоли управления отключена, группа не будет интегрирована с {{ network-load-balancer-name }}. |
| `target_group_spec` | Параметры [целевой группы {{ network-load-balancer-name }}](../../../network-load-balancer/concepts/target-resources.md), создаваемой из группы ВМ. |
| `name`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** | Имя целевой группы. |
| `description`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-description }}** | Описание целевой группы. |
| `labels` | [Метки](../../../resource-manager/concepts/labels.md) целевой группы в формате `<имя_метки>: <значение_метки>`. |
| `max_opening_traffic_duration`<br/>**{{ ui-key.yacloud.compute.groups.create.field_nlb-pre-checks-timeout }}** | Время, в течение которого новая ВМ в группе должна пройти проверку состояния от балансировщика. Возможные значения — 0 и от 1 секунды. Значение по умолчанию — 0: время ожидания не ограничено. Подробнее см. в разделе [{#T}](#principles-health-checks). |

### Настройки интеграции с {{ alb-name }} {#settings-alb}

```yaml
application_load_balancer_spec:
  target_group_spec:
    name: "ig-tg"
    description: "Instance group as target group"
    labels:
      foo: "baz"
      bar: "baz"
  max_opening_traffic_duration: 30s
```

Поля и опции в консоли управления находятся в блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** на страницах создания и редактирования группы ВМ.

| Ключ в YAML<br/>Поле или опция в консоли | Описание |
| --- | --- |
| `application_load_balancer_spec`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** | Настройки интеграции группы ВМ с {{ alb-name }}. Если ключа нет в YAML-спецификации или опция в консоли управления отключена, группа не будет интегрирована с {{ alb-name }}. |
| `target_group_spec` | Параметры [целевой группы {{ alb-name }}](../../../application-load-balancer/concepts/target-group.md), создаваемой из группы ВМ. |
| `name`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-name }}** | Имя целевой группы. |
| `description`<br/>**{{ ui-key.yacloud.compute.groups.create.field_target-group-description }}** | Описание целевой группы. |
| `labels` | [Метки](../../../resource-manager/concepts/labels.md) целевой группы в формате `<имя_метки>: <значение_метки>`. |
| `max_opening_traffic_duration`<br/>**{{ ui-key.yacloud.compute.groups.create.field_alb-pre-checks-timeout }}** | Время, в течение которого новая ВМ в группе должна пройти проверку состояния от балансировщика. Возможные значения — 0 и от 1 секунды. Значение по умолчанию — 0: время ожидания не ограничено. Подробнее см. в разделе [{#T}](#principles-health-checks). |