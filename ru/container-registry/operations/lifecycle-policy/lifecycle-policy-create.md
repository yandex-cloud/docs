---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Создать политику удаления

Для создания политики удаления необходимо указать [имя репозитория](../repository/repository-list.md#repository-get).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Подготовьте [правила политики](../../concepts/lifecycle-policy.md#lifecycle-rules) и сохраните их в файл `rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Создайте политику удаления, выполнив команду со следующими параметрами:
     * `repository-name` — имя репозитория.
     * `rules` — путь к файлу с описанием политик.
     * `description` — (опционально) описание политики удаления.
     * `name` — (опционально) имя политики.

       {% include [name-format](../../../_includes/name-format.md) %}

     {% note info %}

     Политика по умолчанию создается выключенной (в статусе `DISABLED`). Не рекомендуется создавать сразу активную политику с флагом `--active`.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy create \
       --repository-name crp3cpm16edqql0t30s2/ubuntu \
       --name test-policy \
       --description "disabled lifecycle-policy for tests" \
       --rules ./rules.json
     ```

     Результат выполнения команды:

     ```bash
     id: crp6lg1868p3i0emkv1b
     name: test-policy
     repository_id: crp3cpm16edqql0t30s2
     description: disabled lifecycle-policy for tests
     status: DISABLED
     created_at: "2021-03-08T16:58:32.984940Z"
     rules:
     - description: delete prod Docker images older than 60 days but retain 20 last ones
       expire_period: 5184000s
       tag_regexp: prod
       retained_top: "20"
     - description: delete all test Docker images except 10 last ones
       tag_regexp: test.*
       retained_top: "10"
     - description: delete all untagged Docker images older than 48 hours
       expire_period: 172800s
       untagged: true
     ```

     Значение параметра `expired_period` в ответе отображается в секундах. Это техническое ограничение, формат будет изменен.

  1. Проверьте, что политика создалась, выполнив команду со следующим параметром:

     * `repository-name` — имя репозитория.

     ```bash
     yc container repository lifecycle-policy list --repository-name crp3cpm16edqql0t30s2/ubuntu
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
     |                      |             |                      |          |                     | tests                          |
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     ```

     {% note tip %}

     Вы можете [протестировать политику удаления](lifecycle-policy-dry-run.md), чтоб проверить, какие Docker-образы соответствуют правилам политики. Реального удаления Docker-образов при тестовом запуске не происходит.

     {% endnote %}

{% endlist %}
 
