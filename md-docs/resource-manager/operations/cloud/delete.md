[Документация Yandex Cloud](../../../index.md) > [Yandex Resource Manager](../../index.md) > [Пошаговые инструкции](../index.md) > Облако > Удаление облака

# Удаление облака

Чтобы удалить облако, у вас должна быть роль [resource-manager.editor](../../security/index.md#resource-manager-editor) или выше на это облако. Если вы не можете выполнить эту операцию, обратитесь к [владельцу облака](../../concepts/resources-hierarchy.md#owner).

{% note info %}

Удаление облака может быть запрещено, если для этого облака или [организации](*organization), к которой оно относится, создана [политика авторизации](*access_policies) `resourceManager.denyCloudRemoval`. Такой запрет действует даже в том случае, если пользователю назначена [роль](*roles), разрешающая удаление облаков.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
  1. Справа от названия облака нажмите ![image](../../../_assets/console-icons/ellipsis.svg).
  1. Выберите ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить облако**.

     ![delete-cloud1](../../../_assets/resource-manager/delete-cloud-1.png)

  1. Выберите срок удаления облака, по истечении которого облако будет удалено. Выберите один из возможных периодов или `Удалить сейчас`. Срок удаления облака по умолчанию — 7 дней.
  1. Введите название облака, чтобы подтвердить удаление.
  1. Нажмите **Удалить**.

     ![delete-cloud2](../../../_assets/resource-manager/delete-cloud-2.png)

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Посмотрите описание команды удаления облака:

      ```bash
      yc resource-manager cloud delete --help
      ```

  1. Получите список доступных облаков:

      ```
      yc resource-manager cloud list
      ```
      Результат:
      
      ```
      +----------------------+------------+----------------------+--------+
      |          ID          |    NAME    |   ORGANIZATION ID    | LABELS |
      +----------------------+------------+----------------------+--------+
      | b1g66mft1vop******** | my-cloud-1 | bpf2c65rqcl8******** |        |
      | b1gd129pp9ha******** | my-cloud-2 | bpf2c65rqcl8******** |        |
      +----------------------+------------+----------------------+--------+
      ```

  1. Удалите облако, указав его имя или идентификатор:

      ```bash
      yc resource-manager cloud delete <имя_или_идентификатор_облака> \
        --delete-after <срок_удаления_облака> \
        --async
      ```

      Где:

      * `--delete-after` — срок удаления облака в формате `HhMmSs`. Процесс удаления облака начнется по истечении заданного срока. Например: `--delete-after 22h30m50s`.
      
          Чтобы удалить облако сейчас, укажите `0s`.
      * `--async` — флаг асинхронного удаления.
      
          Удаление облака может занять до 72 часов. Выполняйте команду в асинхронном режиме, чтобы вернуть управление терминалом, не дожидаясь завершения выполнения команды.

      Результат:

      ```text
      id: b1gqkbbj04d9********
      description: Delete cloud
      created_at: "2024-10-17T05:16:30.648219069Z"
      created_by: ajei280a73vc********
      modified_at: "2024-10-17T05:16:30.648219069Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.resourcemanager.v1.DeleteCloudMetadata
        cloud_id: b1g66mft1vop********
        delete_after: "2024-10-18T03:47:19.441433Z"
      ```

      Где `id` — идентификатор операции, с помощью которого вы сможете позднее отследить ее статус.

  1. (Опционально) Получите информацию о статусе операции удаления:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      После завершения удаления облака, ответ будет содержать поле `done` со значением `true` (`done: true`).

  Подробнее о команде `yc resource-manager cloud delete` читайте в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/cloud/delete.md).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить облако, созданное с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием облака.

      {% cut "Пример описания облака в конфигурации Terraform" %}

      ```hcl
      ...
      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "cloud-main"
        organization_id = "bpf7nhb9hkph********"
      }
      ...
      ```

      {% endcut %}

      Подробнее о параметрах ресурса `yandex_resourcemanager_cloud` в Terraform читайте в [документации провайдера](../../../terraform/resources/resourcemanager_cloud.md).

  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```

      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc resource-manager cloud list
      ```

- API {#api}

  Чтобы удалить облако, воспользуйтесь вызовом gRPC API [CloudService/Delete](../../api-ref/grpc/Cloud/delete.md).

{% endlist %}

Удаление начинается с остановки ресурсов. Облако переходит в статус `PENDING_DELETION`. Запускается подготовка к удалению. Время нахождения в этом статусе зависит от выбранного срока удаления. Удаление облака, находящегося в статусе `PENDING_DELETION`, можно [отменить](delete-cancel.md).

{% note alert %}

Пока облако находится в статусе `PENDING_DELETION`, ваши диски, зарезервированные IP-адреса и другие данные продолжают храниться. Стоимость хранения рассчитывается по прежнему тарифу. Следите за тарификацией ресурсов в [сервисе Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts).

{% endnote %}

После завершения подготовки к удалению и срока удаления облако переходит в статус `DELETING`. В этом статусе происходит процесс необратимого удаления, занимающий до 72 часов. В результате вместе с облаком будут удалены все его ресурсы.

[*organization]: [Подробнее](../../../organization/concepts/organization.md) об организациях в Yandex Cloud.

[*roles]: [Подробнее](../../security/index.md) о ролях, действующих в сервисе Yandex Resource Manager.

[*access_policies]: _Политики авторизации_ — это механизм контроля доступа Yandex Identity and Access Management, который позволяет управлять разрешениями на выполнение определенных операций с [ресурсами Yandex Cloud](../../../overview/roles-and-resources.md). Политики дополняют систему [ролей](../../../iam/concepts/access-control/roles.md) и позволяют сделать [управление доступом](../../../iam/concepts/access-control/index.md) более гибким. [Подробнее](../../../iam/concepts/access-control/access-policies.md) о политиках авторизации в Yandex Cloud.