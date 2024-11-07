В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

* Выберите **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**, чтобы [подключаться](../../../compute/operations/vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [{{ oslogin }}](../../../organization/concepts/os-login.md) в {{ org-full-name }}.

    Используя {{ oslogin }}, вы сможете подключаться к ВМ по SSH-ключам и SSH-сертификатам с помощью стандартного SSH-клиента или [интерфейса командной строки {{ yandex-cloud }}](../../../cli/quickstart.md). {{ oslogin }} позволяет ротировать SSH-ключи, используемые для доступа к ВМ, и является наиболее [безопасным](../../../security/domains/iaas-checklist.md#vm-security) вариантом доступа.

* Если доступ по {{ oslogin }} вам не подходит, выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

        {% note alert %}

        Не используйте логин `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

        {% endnote %}

    * {% include [access-ssh-key](./access-ssh-key.md) %}

Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../../compute/concepts/vm-metadata.md#how-to-send-metadata) данные этих пользователей в блоке **{{ ui-key.yacloud.common.metadata }}**. С помощью метаданных вы также можете [установить дополнительное ПО](../../../compute/operations/vm-create/create-with-cloud-init-scripts.md) на ВМ при ее создании.

{% include [vm-connect-linux](../../vm-connect-linux.md) %}