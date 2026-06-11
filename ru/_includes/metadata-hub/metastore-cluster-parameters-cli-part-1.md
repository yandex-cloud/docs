* `--description` — описание кластера.
* `--labels` — список [меток](../../resource-manager/concepts/labels.md). Метки задаются в формате `<ключ>=<значение>`.
* `--service-account-id` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
* `--version` — версия {{ metastore-name }}.

  {% include [metastore-version](metastore-version-cluster-create.md) %}

* `--warehouse-bucket` — имя бакета {{ objstorage-name }}, который будет использован в качестве хранилища данных {{ metastore-name }} (warehouse).
* `--warehouse-path` — путь внутри бакета, который будет использоваться как префикс для данных {{ metastore-name }}. Опциональный параметр.
