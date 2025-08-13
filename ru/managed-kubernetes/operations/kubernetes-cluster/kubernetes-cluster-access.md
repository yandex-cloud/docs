---
title: Управление доступом к кластеру {{ managed-k8s-full-name }}
description: Следуя данной инструкции, вы настроите права доступа к кластеру {{ managed-k8s-name }}.
---

# Управление доступом к кластеру {{ managed-k8s-name }}

Чтобы предоставить [субъекту](../../../iam/concepts/access-control/index.md#subject) доступ к [кластеру](../../concepts/index.md#kubernetes-cluster), назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на кластер.

## Получить список ролей, назначенных на кластер {#list-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
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
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на кластер:
  
      ```bash
      {{ yc-k8s }} cluster add-access-binding --help
      ```
  
  1. Назначьте роль, выполнив команду:

      ```bash
      {{ yc-k8s }} cluster add-access-binding <имя_или_идентификатор_кластера> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```
      
      Где:

      * `--role` — идентификатор назначаемой [роли](../../security/index.md#roles-list).
      * `--subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

        Например: 
        
        * `serviceAccount:aje6p030************`,
        * `userAccount:aje8tj79************`,
        * `system:allAuthenticatedUsers`.

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

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
        role       = "<идентификатор_роли>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — идентификатор назначаемой [роли](../../security/index.md#roles-list).
      * `member` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.
    
        Например: 
        
        * `serviceAccount:${yandex_iam_service_account.k8s_sa.id}`,
        * `userAccount:ajerq94v************`,
        * `system:allAuthenticatedUsers`.

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
      
      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../../cli/):
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

{% endlist %}

## Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
        --access-binding role=<идентификатор_роли_1>,subject=<тип_субъекта>:<идентификатор_субъекта_1> \
        --access-binding role=<идентификатор_роли_2>,subject=<тип_субъекта>:<идентификатор_субъекта_2>
      ```
    
      Где `--access-binding` — назначает роль субъекту. Вы можете назначить несколько ролей одновременно, описав каждую в отдельном параметре `--access-binding`.
      
        * `role` — идентификатор назначаемой [роли](../../security/index.md#roles-list).
        * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

          Например:
          
          * `serviceAccount:aje6p030************`,
          * `userAccount:aje8tj79************`,
          * `system:allAuthenticatedUsers`.

          {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

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
        role       = "<идентификатор_роли_1>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }

      resource "yandex_kubernetes_cluster_iam_member" "<локальное_имя_ресурса_2>" {
        cluster_id = "<идентификатор_кластера>"
        role       = "<идентификатор_роли_2>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `cluster_id` — идентификатор кластера.
      * `role` — идентификатор назначаемой [роли](../../security/index.md#roles-list).
      * `member` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.
    
        Например:
        
        * `serviceAccount:${yandex_iam_service_account.k8s_sa.id}`,
        * `userAccount:ajerq94v************`,
        * `system:allAuthenticatedUsers`.

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}

  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
      
      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../../cli/):
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

{% endlist %}

## Отозвать роль {#remove-access-binding}

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — идентификатор отзываемой [роли](../../security/index.md#roles-list).
      * `--subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначена роль, в формате: `<тип_субъекта>:<идентификатор_субъекта>`.

        Например:
        
        * `serviceAccount:aje6p030************`,
        * `userAccount:aje8tj79************`,
        * `system:allAuthenticatedUsers`.

        {% include [access-control-subject](../../../_includes/managed-kubernetes/access-control-subject.md) %}


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
        role       = "<идентификатор_роли>"
        member     = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
      
      Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

  1. Проверьте список ролей, назначенных на кластер, выполнив команду [CLI](../../../cli/):
    
      ```bash
      {{ yc-k8s }} cluster list-access-bindings <имя_или_идентификатор_кластера>
      ```

{% endlist %}