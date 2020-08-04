# Получить информацию о политиках удаления

Узнайте, как получить:
* [Список политик удаления в репозитории или в реестре](#lifecycle-policy-list)
* [Подробную информацию о политике удаления](#lifecycle-policy-get)

## Получить список политик удаления в репозитории или в реестре {#lifecycle-policy-list}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    * Получите список [политик удаления](../../concepts/lifecycle-policy.md) в репозитории:
    
        ```
        $ yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
      
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
        |                      |             |                      |          |                     | tests                          |
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        ```
    * Получите список [политик удаления](../../concepts/lifecycle-policy.md) в реестре:
    
        ```
        $ yc container repository lifecycle-policy list --registry-id crp2hlbs67tj4ggrfodb
      
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
        |                      |             |                      |          |                     | tests                          |
        | crpbia0qsdqpi28444jn |             | crpo17tgeemuto888jdh | DISABLED | 2020-05-28 08:06:14 |                                |
        +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
        ```
  
{% endlist %}

## Получить информацию о политике удаления {#lifecycle-policy-get}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Получите подробную информацию о политике удаления с помощью `id` из [предыдущего](#lifecycle-policy-list) пункта:
    
    ```
    $ yc container repository lifecycle-policy get crp6lg1868p3i0emkv1b
  
    id: crp6lg1868p3i0emkv1b
    name: test-policy
    repository_id: crp3cpm16edqql0t30s2
    description: disabled lifecycle-policy for tests
    status: DISABLED
    created_at: "2020-05-28T15:05:58.143Z"
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



