# Управление доступом к кластеру {{ managed-k8s-name }}

Вы можете предоставить пользователю или сервисному аккаунту [роль для доступа к {{ k8s }} API](../../security/index.md#k8s-api) конкретного [кластера](../../concepts/index.md#kubernetes-cluster).

Таким образом вы можете гранулярно назначать разные роли на конкретные кластеры для разных пользователей и сервисных аккаунтов.

{% note warning %}

Учитывайте, что помимо роли для доступа к {{ k8s }} API кластера у пользователя должна быть минимальная роль для просмотра ресурсов в каталоге, например [k8s.viewer](../../security/index.md#k8s-viewer) (для просмотра информации обо всех кластерах в каталоге) или примитивная [viewer](../../../iam/security/index.md#viewer) (для просмотра всех ресурсов в каталоге). 

Например, вы можете выдать пользователю роль [k8s.viewer](../../security/index.md#k8s-viewer) на каталог и роль [k8s.cluster-api.editor](../../security/index.md#k8s-cluster-api-editor) для управления ресурсами {{ k8s }} конкретного кластера. Таким образом пользователь сможет просматривать информацию обо всех кластерах каталога, а работать с API только конкретного кластера.

Для разграничения возможности просмотра списка кластеров разными пользователями рекомендуем использовать разные каталоги в облаке.

{% endnote %}

## Получить список ролей, назначенных на кластер {#list-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Получите список кластеров в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster list
      ```
  
  1. Получите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

{% endlist %}

## Назначить роль {#add-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения роли на кластер:
  
      ```bash
      {{ yc-k8s }} cluster add-access-binding --help
      ```
  
  1. Назначьте роль, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster add-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```
      
      Где:

      * `--role` — назначаемая [роль](../../security/index.md#roles-list), например `k8s.cluster-api.editor`.
      * `--subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

        Например: 
        
        * `serviceAccount:aje6p030************`,
        * `userAccount:aje8tj79************`,
        * `system:allAuthenticatedUsers`.

        Допустимые типы субъектов: 
          
          * `userAccount` — [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport), добавленный в {{ yandex-cloud }}, или аккаунт из [пула пользователей](../../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), созданный в {{ yandex-cloud }}.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../../organization/concepts/add-federation.md).
          * `group` — группа пользователей [{{ org-full-name }}](../../../organization/index.md).
          * `system` — [публичная группа](../../../iam/concepts/access-control/public-group.md) пользователей.
            
            Допустимые значения идентификатора субъекта:
        
            * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
            * `allUsers` — [любой пользователь](../../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
        
        Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../../iam/concepts/access-control/index.md#subject).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```      

- {{ TF }} {#tf}

  {% note warning %}
    
  Не используйте ресурс `yandex_kubernetes_cluster_iam_member` для назначения ролей, которые управляются ресурсом `yandex_kubernetes_cluster_iam_binding`.
    
  {% endnote %} 
  
  1. Откройте актуальный конфигурационный файл с описанием кластера {{ managed-k8s-name }}.
  
      О том, как создать такой файл, см. в разделе [{#T}](kubernetes-cluster-create.md).
  
  1. Добавьте описание ресурса:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<локальное_имя_ресурса>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — назначаемая [роль](../../security/index.md#roles-list), например `k8s.cluster-api.editor`.
      * `member` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.
    
        Например: 
        
        * `serviceAccount:${yandex_iam_service_account.k8s_sa.id}`,
        * `userAccount:ajerq94v************`,
        * `system:allAuthenticatedUsers`.

        Допустимые типы субъектов: 
          
          * `userAccount` — [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport), добавленный в {{ yandex-cloud }}, или аккаунт из [пула пользователей](../../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), созданный в {{ yandex-cloud }}.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../../organization/concepts/add-federation.md).
          * `group` — группа пользователей [{{ org-full-name }}](../../../organization/index.md).
          * `system` — [публичная группа](../../../iam/concepts/access-control/public-group.md) пользователей.
            
            Допустимые значения идентификатора субъекта:
        
            * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
            * `allUsers` — [любой пользователь](../../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
        
        Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../../iam/concepts/access-control/index.md#subject).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.
      
      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../../cli/index.md):
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  {% note alert %}

  Команда `set-access-bindings` удаляет все назначенные на кластер роли и задает новые.
  
  {% endnote %}  

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```
  
  1. Посмотрите описание команды CLI для назначения ролей на кластер:
  
      ```bash
      {{ yc-k8s }} cluster set-access-bindings --help
      ```

  1. Назначьте роли, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster set-access-bindings <имя_или_идентификатор_кластера> \
        --access-binding role=<роль_1>,subject=<тип_субъекта>:<идентификатор_субъекта_1> \
        --access-binding role=<роль_2>,subject=<тип_субъекта>:<идентификатор_субъекта_2>
      ```
    
      Где `--access-binding` — назначает роль субъекту. Вы можете назначить несколько ролей одновременно, описав каждую в отдельном параметре `--access-binding`.
      
        * `role` — назначаемая [роль](../../security/index.md#roles-list), например `k8s.cluster-api.editor`.
        * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:
          
          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          Допустимые типы субъектов: 
            
            * `userAccount` — [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport), добавленный в {{ yandex-cloud }}, или аккаунт из [пула пользователей](../../../organization/concepts/user-pools.md).
            * `serviceAccount` — [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), созданный в {{ yandex-cloud }}.
            * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../../organization/concepts/add-federation.md).
            * `group` — группа пользователей [{{ org-full-name }}](../../../organization/index.md).
            * `system` — [публичная группа](../../../iam/concepts/access-control/public-group.md) пользователей.
              
              Допустимые значения идентификатора субъекта:
          
              * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
              * `allUsers` — [любой пользователь](../../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
          
          Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../../iam/concepts/access-control/index.md#subject).

- {{ TF }} {#tf}

  {% note warning %}
    
  Не используйте ресурс `yandex_kubernetes_cluster_iam_member` для назначения ролей, которые управляются ресурсом `yandex_kubernetes_cluster_iam_binding`.
    
  {% endnote %} 

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](kubernetes-cluster-create.md).

  1. Добавьте описание ресурсов:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<локальное_имя_ресурса_1>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль_1>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }

      resource "yandex_kubernetes_cluster_iam_member" "<локальное_имя_ресурса_2>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль_2>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — назначаемая [роль](../../security/index.md#roles-list), например `k8s.cluster-api.editor`.
      * `member` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.
    
        Например:
        
        * `serviceAccount:${yandex_iam_service_account.k8s_sa.id}`,
        * `userAccount:ajerq94v************`,
        * `system:allAuthenticatedUsers`.

        Допустимые типы субъектов: 
          
          * `userAccount` — [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport), добавленный в {{ yandex-cloud }}, или аккаунт из [пула пользователей](../../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), созданный в {{ yandex-cloud }}.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../../organization/concepts/add-federation.md).
          * `group` — группа пользователей [{{ org-full-name }}](../../../organization/index.md).
          * `system` — [публичная группа](../../../iam/concepts/access-control/public-group.md) пользователей.
            
            Допустимые значения идентификатора субъекта:
        
            * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
            * `allUsers` — [любой пользователь](../../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
        
        Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../../iam/concepts/access-control/index.md#subject).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.
      
      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../../cli/index.md):
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

{% endlist %}

## Отозвать роль {#remove-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}
  
  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите список ролей, назначенных на кластер, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```
  
  1. Посмотрите описание команды CLI для отзыва роли на кластер:
  
      ```bash
      {{ yc-k8s }} cluster remove-access-binding --help
      ```
  1. Отзовите роль, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster remove-access-binding <имя_или_идентификатор_кластера> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — отзываемая [роль](../../security/index.md#roles-list), например `k8s.cluster-api.editor`.
      * `--subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначена роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

        Например:
        
        * `serviceAccount:aje6p030************`,
        * `userAccount:aje8tj79************`,
        * `system:allAuthenticatedUsers`.

        Допустимые типы субъектов: 
          
          * `userAccount` — [аккаунт на Яндексе](../../../iam/concepts/users/accounts.md#passport), добавленный в {{ yandex-cloud }}, или аккаунт из [пула пользователей](../../../organization/concepts/user-pools.md).
          * `serviceAccount` — [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), созданный в {{ yandex-cloud }}.
          * `federatedUser` — аккаунт пользователя [федерации удостоверений](../../../organization/concepts/add-federation.md).
          * `group` — группа пользователей [{{ org-full-name }}](../../../organization/index.md).
          * `system` — [публичная группа](../../../iam/concepts/access-control/public-group.md) пользователей.
            
            Допустимые значения идентификатора субъекта:
        
            * `allAuthenticatedUsers` — [все пользователи, прошедшие аутентификацию](../../../iam/concepts/access-control/public-group.md#allAuthenticatedUsers).
            * `allUsers` — [любой пользователь](../../../iam/concepts/access-control/public-group.md#allUsers), прохождение аутентификации не требуется.
        
        Подробнее о типах субъектов см. в разделе [Субъект, которому назначается роль](../../../iam/concepts/access-control/index.md#subject).


- {{ TF }} {#tf}

  {% note warning %}
    
  Не используйте ресурс `yandex_kubernetes_cluster_iam_member` для назначения ролей, которые управляются ресурсом `yandex_kubernetes_cluster_iam_binding`.
    
  {% endnote %} 

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [Создание кластера](kubernetes-cluster-create.md).

  1. Найдите описание ресурса с ролью, которую вы хотите отозвать, и удалите его:
    
      ```hcl
      resource "yandex_kubernetes_cluster_iam_member" "<локальное_имя_ресурса>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<роль>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Подтвердите изменение ресурсов.

      1. Выполните команду для просмотра планируемых изменений:
      
         ```bash
         terraform plan
         ```
      
         Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
      
      1. Если вас устраивают планируемые изменения, внесите их:
         1. Выполните команду:
      
            ```bash
            terraform apply
            ```
      
         1. Подтвердите изменение ресурсов.
         1. Дождитесь завершения операции.
      
      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../../cli/index.md):
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

{% endlist %}

## Примеры {#examples}

### Добавить сервисному аккаунту доступ к управлению кластером {#sa-cluster-control}

1. Чтобы сервисный аккаунт мог просматривать информацию обо всех кластерах {{ managed-k8s-name }} в каталоге, но изменять ресурсы {{ k8s }} только конкретного кластера, выдайте ему роль `k8s.viewer` на каталог и роль `k8s.cluster-api.editor` на этот кластер:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Назначьте роль на каталог:
  
          ```bash
          yc resource-manager folder add-access-binding \
            --id <идентификатор_каталога> \
            --role k8s.viewer \
            --subject=serviceAccount:<идентификатор_сервисного_аккаунта>
          ```

      1. Назначьте роли на кластер:

          ```bash
          {{ yc-k8s }} cluster set-access-bindings <имя_или_идентификатор_кластера> \
            --access-binding role=k8s.cluster-api.editor,subject=serviceAccount:<идентификатор_сервисного_аккаунта>
          ```

    - {{ TF }} {#tf}

      1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
          О том, как создать такой файл, см. в разделе [Создание кластера](kubernetes-cluster-create.md).

      1. Добавьте описание ресурсов:

          ```hcl
          resource "yandex_resourcemanager_folder_iam_member" "k8s-viewer-account-iam" {
            folder_id   = "<идентификатор_каталога>"
            role        = "k8s.viewer"
            member      = "serviceAccount:<идентификатор_сервисного_аккаунта>"
          }

          resource "yandex_kubernetes_cluster_iam_member" "k8s-cluster-api-editor" {
            cluster_id = "<идентификатор_кластера>"
            role       = "k8s.cluster-api.editor"
            member     = "serviceAccount:<идентификатор_сервисного_аккаунта>"
          }
          ```

      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
          1. Выполните команду:
          
             ```bash
             terraform validate
             ```
          
             Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

      1. Подтвердите изменение ресурсов.

          1. Выполните команду для просмотра планируемых изменений:
          
             ```bash
             terraform plan
             ```
          
             Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
          
          1. Если вас устраивают планируемые изменения, внесите их:
             1. Выполните команду:
          
                ```bash
                terraform apply
                ```
          
             1. Подтвердите изменение ресурсов.
             1. Дождитесь завершения операции.

    {% endlist %}

1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../../cli/index.md):

    ```bash
    {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
    ```