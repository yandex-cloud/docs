# Изменить реестр

Узнайте, как изменить:
* [Имя реестра](#update-name).
* [Метку реестра](#update-label).

Для обращения к [реестру](../../concepts/registry.md) используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

## Изменить имя реестра {#update-name}

{% list tabs %}

- Консоль управления

  Чтобы изменить имя [реестра](../../concepts/registry.md):
  1. Откройте раздел **{{ container-registry-name }}** в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется изменить реестр.
  1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) в строке реестра, который требуется изменить.
  1. В открывшемся меню нажмите кнопку **Изменить**.
  1. В открывшемся окне укажите нужное имя реестра.
  1. Нажмите кнопку **Изменить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените имя реестра:

  ```bash
  yc container registry update my-reg --new-name new-reg
  ```

  Результат выполнения команды:

  ```bash
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  ```

- API

  Чтобы изменить имя реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}

## Изменить метку реестра {#update-label}

{% list tabs %}

- CLI

  Измените метку реестра (не путайте с тегами Docker-образа):

  ```bash
  yc container registry update new-reg --labels new_label=test_label
  ```

  Результат выполнения команды:

  ```bash
  id: crp3qleutgksvd1prhvb
  folder_id: b1g88tflru0ek1omtsu0
  name: new-reg
  status: ACTIVE
  created_at: "2019-01-15T14:39:48.154Z"
  labels:
    new_label: test_label
  ```

- API

  Чтобы изменить метку реестра, воспользуйтесь методом [update](../../api-ref/Registry/update.md) для ресурса [Registry](../../api-ref/Registry/).

{% endlist %}