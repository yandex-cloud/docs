* [dataproc.agent](../../data-proc/security/index.md#dataproc-agent) — чтобы сервисный аккаунт мог получать информацию о состоянии хостов кластера, [заданиях](../../data-proc/concepts/jobs.md) и [лог-группах](../../logging/concepts/log-group.md).
* [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner) — чтобы сервисный аккаунт мог взаимодействовать с автоматически масштабируемой группой ВМ. Тогда будет доступно [автомасштабирование подкластеров](../../data-proc/concepts/autoscaling.md).
* [resource-manager.auditor](../../resource-manager/security/index.md#resource-manager-auditor) и выше на каталог, в котором нужно создать кластер {{ dataproc-name }} — для подключения к кластеру с помощью [{{ oslogin }}](../../organization/concepts/os-login.md).

{% note tip %}

Чтобы ограничить права сервисного аккаунта кластера (его IAM-токен доступен при выполнении заданий):

1. Укажите отдельный сервисный аккаунт для автомасштабирования подкластеров при [создании](../../data-proc/operations/cluster-create.md) или [изменении кластера](../../data-proc/operations/cluster-update.md) через интерфейсы {{ yandex-cloud }} CLI, {{ TF }} или API.
1. Назначьте роль `dataproc.provisioner` только этому аккаунту.

{% endnote %}
