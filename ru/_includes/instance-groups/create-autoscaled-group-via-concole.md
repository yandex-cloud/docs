1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать группу виртуальных машин.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. На панели слева выберите ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
   * Введите имя и описание группы ВМ. Требования к имени:

     {% include [name-format](../name-format.md) %}

     {% include [name-fqdn](../compute/name-fqdn.md) %}

   * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту роль `editor`. По умолчанию все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.

     {% include [sa-dependence-brief](../../_includes/instance-groups/sa-dependence-brief.md) %}

   * Включите опцию **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}** при необходимости. Пока опция включена, невозможно удалить группу.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** в поле **{{ ui-key.yacloud.compute.groups.create.field_zone }}** выберите нужные. ВМ группы могут находиться в [разных зонах и регионах доступности](../../overview/concepts/geo-scope.md).
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**, чтобы задать конфигурацию базовой ВМ:
   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** введите описание [шаблона](../../compute/concepts/instance-groups/instance-template.md).
   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите, какую систему развернуть на загрузочном [диске](../../compute/concepts/disk.md) ВМ.

   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_disk }}**:
     * Выберите [тип диска](../../compute/concepts/disk.md#disks_types).
     * Укажите размер диска.
     * Чтобы добавить дополнительные диски, нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Выберите [платформу](../../compute/concepts/vm-platforms.md).
     * Укажите необходимое количество vCPU, [гарантированную долю vCPU](../../compute/concepts/performance-levels.md) и объем RAM.
     * {% include [include](specify-preemptible-vm.md) %}
   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

     {% include [network-settings-group](../../_includes/compute/network-settings-group.md) %}

   * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
     * Выберите сервисный аккаунт, который следует привязать к ВМ.
     * Если выбран [образ](../../compute/concepts/image.md) на основе Linux, заполните поля **{{ ui-key.yacloud.compute.instances.create.field_user }}** и **{{ ui-key.yacloud.compute.instances.create.field_key }}**. В качестве ключа укажите содержимое файла [открытого ключа](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Если выбран образ на основе Windows, укажите пароль пользователя `Administrator`.
     * При необходимости выберите опцию `{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}`.
   * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** укажите, на какое количество ВМ можно превышать размер группы.
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}** укажите, на какое количество ВМ можно уменьшать размер группы.
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** укажите, сколько ВМ можно одновременно создавать.
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}** укажите срок, после которого ВМ начнет получать нагрузку.
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** укажите, сколько ВМ можно одновременно останавливать.
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** укажите одну из [стратегий](../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy):
     * `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}` — {{ ig-name }} самостоятельно выбирает, какие ВМ остановить при обновлении или уменьшении группы.
     * `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}` — {{ ig-name }} ожидает, когда ВМ остановятся самостоятельно или будут остановлены пользователем.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
   * Выберите `{{ ui-key.yacloud.compute.groups.create.value_scale-auto }}` [тип масштабирования](../../compute/concepts/instance-groups/scale.md).
   * Укажите:
     * **{{ ui-key.yacloud.compute.groups.create.field_auto-scale-type }}** — `{{ ui-key.yacloud.compute.groups.create.value_scale-zonal }}` автомасштабирование регулирует количество ВМ отдельно в каждой зоне доступности, указанной в настройках группы. `{{ ui-key.yacloud.compute.groups.create.value_scale-regional }}` — во всей группе ВМ.
     * **{{ ui-key.yacloud.compute.groups.create.field_min-zone-size }}**.
     * **{{ ui-key.yacloud.compute.groups.create.field_max-size }}**.
     * **{{ ui-key.yacloud.compute.groups.create.field_measurement-duration }}**, за который следует усреднять замеры нагрузки для каждой ВМ в группе.
     * **{{ ui-key.yacloud.compute.groups.create.field_warmup-duration }}** — время прогрева ВМ в группе.
     * **{{ ui-key.yacloud.compute.groups.create.field_cooldown-duration }}** — период, в течение которого требуемое количество ВМ в группе не может быть снижено.
     * **{{ ui-key.yacloud.compute.groups.create.field_initial-size }}**.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.label_custom-metrics }}** укажите:
   * В поле **{{ ui-key.yacloud.compute.groups.create.field_metric }}**:
     * [{{ ui-key.yacloud.compute.groups.create.metric-type-cpu }}](../../compute/concepts/instance-groups/scale.md#cpu-utilization) — укажите средний уровень загрузки CPU, который должен поддерживать {{ ig-name }}.
     * [{{ ui-key.yacloud.compute.groups.create.metric-type-custom }}](../../compute/concepts/instance-groups/scale.md#custom-metrics) — укажите имя пользовательской метрики и целевое значение, которое должен поддерживать {{ ig-name }}.
1. При необходимости активируйте опцию **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** для получения сведений о состоянии ВМ и их автоматического восстановления в случае сбоя.
   * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** выберите протокол проверок состояния: `{{ ui-key.yacloud.ylb.health-check.label_http }}` или `{{ ui-key.yacloud.ylb.health-check.label_tcp }}`.
   * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** (для типа HTTP) укажите URL‐путь запроса, на который {{ ig-name }} будет отправлять запросы проверки для HTTP.
   * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** укажите номер порта от 1 до 32767, на который {{ ig-name }} будет отправлять запросы проверки.
   * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** укажите время ожидания ответа от 1 до 60 секунд.
   * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** укажите интервал между повторными проверками от 1 до 60 секунд. Интервал должен быть больше времени ожидания минимум на 1 секунду.
   * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** укажите количество успешных проверок, после которого ВМ будет считаться работающей нормально.
   * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** укажите количество неудачных проверок, после которого ВМ будет считаться неработающей.
1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_variables }}** при необходимости укажите пары `{{ ui-key.yacloud.common.label_key }}`-`{{ ui-key.yacloud.common.label_value }}`.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
