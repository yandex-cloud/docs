# Изменение группы узлов

{% include [yc-node-group-list](../../../_includes/managed-kubernetes/node-group-list.md) %}

## Изменить имя группы узлов {#update-name}

Вы можете изменить следующие параметры группы узлов:
* Имя.
* Описание.
* Количество узлов.
* Версию {{ k8s }}.
* Вычислительные ресурсы и размер диска узлов.
* Политику обновлений.

{% list tabs %}

- Консоль управления

   Чтобы изменить [группу узлов](../../concepts/index.md#node-group):
   1. Откройте раздел **{{ managed-k8s-name }}** в каталоге, где требуется изменить кластер {{ k8s }}.
   1. Нажмите на имя нужного кластера {{ k8s }}.
   1. Перейдите во вкладку **Группы узлов**.
   1. Нажмите кнопку **Редактировать** в правом верхнем углу.
   1. В открывшемся окне измените необходимые параметры.
   1. Нажмите кнопку **Сохранить изменения**.

- CLI

  Получите подробную информацию о команде для изменения группы узлов:

  ```bash
  yc managed-kubernetes node-group update --help
  ```

  Для изменения группы узлов воспользуйтесь следующими параметрами:
  * `--new-name` — изменить имя.
  * `--description` — изменить описание.
  * `--service-account-id`, `--service-account-name` — изменить сервисный аккаунт для ресурсов.
  * `--node-service-account-id`, `--node-service-account-name` — изменить сервисный аккаунт для узлов.
  * `--version` — изменить версию {{ k8s }}.
  * `--latest-revision` — получить все доступные обновления для текущей версии мастера.
  * `--auto-upgrade` — управялять автоматическими обновлениями.
  * Управление окном обновлений:
    * `--anytime-maintenance-window` — обновлять в любое время.
    * `--daily-maintenance-window` — обновлять ежедневно в выбранное время.
    * `--weekly-maintenance-window` — обновлять в выбранные дни.

- API

  Чтобы изменить параметры группы узлов, воспользуйтесь методом [update](../../api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../api-ref/NodeGroup).

{% endlist %}

## Управлять метками группы узлов {#manage-label}

Вы можете выполнять следующие действия с метками группы узлов:
* [Добавить](#add-label)
* [Изменить](#update-label)
* [Удалить](#remove-label)

### Добавить метку {#add-label}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте метку группе узлов:

  ```bash
  yc managed-kubernetes node-group add-labels my-node-group --labels new_label=test_label
  ```

  Результат выполнения команды:

  ```bash
  done (28s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI

  Измените метку группы узлов:

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

  ```bash
  yc managed-kubernetes node-group update my-node-group --labels test_label=my_ng_label
  ```

  Результат выполнения команды:

  ```bash
  done (3s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI

  Удалите метку группы узлов:

  ```bash
  yc managed-kubernetes node-group remove-labels my-node-group --labels test_label
  ```

  Результат выполнения команды:

  ```bash
  done (2s)
  id: catpl8c44kiibp20u4f3
  cluster_id: catcsqidoos7tq0513us
  ...
  ```

{% endlist %}

{% note warning %}

* Не поддерживается использование ключа метаданных `user-data` для донастройки ВМ и передачи пользовательских данных.
* Для управления ssh-ключами можно [воспользоваться ключом `ssh-keys`](../../../compute/concepts/vm-metadata).
* Для донастройки узлов используйте привилегированные наборы DaemonSet. Например, [sysctl-tuner](https://github.com/elemir/yc-recipes/tree/master/sysctl-tuner).

{% endnote %}