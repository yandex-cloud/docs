---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Изменить политику удаления

После создания [политики удаления](../../concepts/lifecycle-policy.md) вы можете изменить ее правила, а также статус, имя или описание.

Для обращения к политике используйте ее идентификатор. Как узнать идентификатор политики, читайте в разделе [{#T}](lifecycle-policy-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды CLI для обновления параметров политики:

     ```bash
     yc container repository lifecycle-policy update --help
     ```

  1. Измените параметры политики, например, переименуйте политику:

     ```bash
     yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-name new-policy
     ```

{% endlist %}

{% include [ограничения политики](../../../_includes/container-registry/lifecycle-restrictions.md) %}

## Примеры {#examples}

### Изменить правила политики удаления {#update-rules}

{% list tabs %}

- CLI

  1. Подготовьте новые [правила политики](../../concepts/lifecycle-policy.md#lifecycle-rules) и сохраните их в файл `new-rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Измените правила политики, выполнив команду со следующим параметром:
     * `new-rules` — путь к файлу с новым описанием политик.

     {% note alert %}

     Обновление политики полностью перезаписывает все текущие правила — они будут удалены.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-rules ./new-rules.json
     ```

     Результат выполнения команды:

     ```bash
     WARN: All current lifecycle rules will be overwritten. Are you sure?[y/N] y
     id: crp6lg1868p3i0emkv1b
     name: test-policy
     repository_id: crp3cpm16edqql0t30s2
     description: disabled lifecycle-policy for tests
     status: DISABLED
     created_at: "2020-05-28T15:05:58.143719Z"
     rules:
     - description: remove prod images older than 60 days except 20 last ones
       expire_period: 5184000s
       tag_regexp: prod
       retained_top: "20"
     - description: remove all test and untagged images older than 48 hours
       expire_period: 172800s
       tag_regexp: test.*
       untagged: true
     ```

{% endlist %}

### Изменить статус политики удаления {#update-status}

#### Активируйте политику удаления {#activate}

{% list tabs %}

- CLI

  Сделайте выключенную политику активной, выполнив команду с флагом `--activate`:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --activate
  ```

  Результат выполнения команды:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  description: disabled lifecycle-policy for tests
  status: ACTIVE
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

#### Выключите политику удаления {#disabled}

{% list tabs %}

- CLI

  Выключите активную политику, выполнив команду с флагом `--disable`:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --disable
  ```

  Результат выполнения команды:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  description: disabled lifecycle-policy for tests
  status: DISABLED
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Изменить имя политики удаления {#update-name}

{% list tabs %}

- CLI

  Измените имя политики, выполнив команду со следующим параметром:
  * `new-name` — новое имя политики.

    {% include [name-format](../../../_includes/name-format.md) %}

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-name new-policy
  ```

  Результат выполнения команды:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: new-policy
  repository_id: crp3cpm16edqql0t30s2
  description: disabled lifecycle-policy for tests
  status: DISABLED
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Изменить описание политики удаления {#update-description}

{% list tabs %}

- CLI

  Измените описание политики, выполнив команду со следующим параметром:
  * `new-description` — новое описание политики.

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-description "new description"
  ```

  Результат выполнения команды:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  description: new description
  status: DISABLED
  created_at: "2020-05-28T15:05:58.143719Z"
  rules:
  - description: remove prod images older than 60 days except 20 last ones
    expire_period: 5184000s
    tag_regexp: prod
    retained_top: "20"
  - description: remove all test and untagged images older than 48 hours
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}