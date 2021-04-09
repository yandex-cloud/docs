# Создать политику удаления

Для создания политики удаления необходимо указать [идентификатор репозитория](../repository/repository-list.md#repository-get).

{% list tabs %}
  
- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [ограничения политики](../../../_includes/container-registry/lifecycle-restrictions.md) %}
    
    1. Подготовьте [правила политики](../../concepts/lifecycle-policy.md#lifecycle-rules) и сохраните их в файл `rules.json`.
     
        {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}
    1. Создайте политику удаления, выполнив команду со следующими параметрами: 
        
        * `repository-id` — идентификатор репозитория.
        * `name` — (опционально) имя политики.
        
            {% include [name-format](../../../_includes/name-format.md) %}
            
        * `description` — (опционально) описание политики удаления.
        * `rules` — путь к файлу с описанием политик.
       
        {% note info %}
        
        Политика по умолчанию создается выключенной (в статусе `DISABLED`). Можно (но не рекомендуется) создать сразу активную политику, указав флаг `--active`, или [активировать политику](../../operations/lifecycle-policy/lifecycle-policy-update.md#update-status) после создания.
        
        {% endnote %}
        
        ```
        $ yc container repository lifecycle-policy create \
           --repository-id crp3cpm16edqql0t30s2 \
           --name test-policy \
           --description "disabled lifecycle-policy for tests" \
           --rules ./rules.json
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
        
        Значение параметра `expired_period` в ответе отображается в секундах. Это техническое ограничение, формат будет изменен.
    1. Проверьте, что политика создалась, выполнив команду со следующим параметром: 
                
        * `repository-id` — идентификатор репозитория.
    
        ```
        $ yc container repository lifecycle-policy list --repository-id crp3cpm16edqql0t30s2
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
        |                      |             |                      |          |                     | tests                          |
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        ```
    
{% endlist %}
 
