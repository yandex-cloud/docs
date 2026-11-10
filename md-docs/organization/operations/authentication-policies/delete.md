[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > [Пошаговые инструкции](../index.md) > Аутентификация > Управление политиками аутентификации > Удалить политику аутентификации

# Удалить политику аутентификации

[Политики аутентификации](../../concepts/authentication-policy.md) — это инструмент Yandex Identity Hub, позволяющий гибко настраивать доступ [пользователей](*user_accounts) и [групп пользователей](*user_groups) к [приложениям](*applications) Yandex Identity Hub, запрещая или разрешая аутентификацию в зависимости от условий, заданных в области применения политики.

[*user_groups]: Пользователей Yandex Identity Hub можно объединять в группы, что упрощает управление доступом в Yandex Cloud. Подробнее читайте в разделе [Группы пользователей](../../concepts/groups.md).

[*applications]: SAML- и OIDC-приложения Yandex Identity Hub позволяют пользователям Yandex Cloud аутентифицироваться в сервисах сторонних поставщиков услуг. Подробнее читайте в разделе [Приложения в Yandex Identity Hub](../../concepts/applications/index.md).

[*user_accounts]: В Yandex Cloud используются аккаунты пользователей на Яндексе, а также федеративные и локальные пользовательские аккаунты. Подробнее читайте в разделе [Аккаунты в Yandex Cloud](../../../iam/concepts/users/accounts.md).

[*organization]: _Организация_ — это высший ресурс в иерархии ресурсной модели Yandex Cloud, который объединяет ресурсы всех остальных сервисов, а также используется для управления пользователями и параметрами их аутентификации и авторизации. Подробнее читайте в разделе [Организация](../../concepts/organization.md).

Управлять политиками аутентификации может пользователь, которому назначена [роль](*org_manager_admin) `organization-manager.admin` или выше.

[*org_manager_admin]: Роль `organization-manager.admin` позволяет управлять настройками организации, федерациями удостоверений, пулами пользователей, SAML-приложениями, OIDC-приложениями, пользователями и их группами, а также правами доступа пользователей к организации и ресурсам в ней. Подробнее читайте в разделе [Управление доступом в Yandex Identity Hub](../../security/index.md#organization-manager-admin).

Чтобы удалить политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **Настройки безопасности** и перейдите на вкладку **Политики аутентификации**.
  1. В строке с нужной политикой аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Посмотрите описание команды CLI для удаления политики аутентификации:

      ```bash
      yc organization-manager authentication-policy-rule delete --help
      ```
  1. Получите список политик аутентификации в организации, указав ее [идентификатор](../organization-get-id.md):
     
     ```bash
     yc organization-manager authentication-policy-rule list \
       --organization-id <идентификатор_организации>
     ```
     
     Результат:
     
     ```text
     +----------------------+--------------------+----------------------+------------------------+----------+-------------+--------+---------------------+---------------------+
     |          ID          |        NAME        |   ORGANIZATION ID    |         EFFECT         |  STATUS  | DESCRIPTION | LABELS |     CREATED AT      |     UPDATED AT      |
     +----------------------+--------------------+----------------------+------------------------+----------+-------------+--------+---------------------+---------------------+
     | bpf03arsgnjr******** | new-auth-policy    | bpf2c65rqcl8******** | ALLOW_WITH_OBLIGATIONS | ACTIVE   |             |        | 2026-11-09 14:26:57 | 2026-11-09 14:27:12 |
     | bpfvj2906vfq******** | sample-auth-policy | bpf2c65rqcl8******** | DENY                   | INACTIVE |             |        | 2026-11-09 14:26:33 | 2026-11-09 14:27:26 |
     +----------------------+--------------------+----------------------+------------------------+----------+-------------+--------+---------------------+---------------------+
     ```
     
     Сохраните идентификатор (значение поля `ID`) нужной политики аутентификации. Он понадобится позднее.
  1. Удалите политику аутентификации, указав ее идентификатор:

      ```bash
      yc organization-manager authentication-policy-rule delete <идентификатор_политики>
      ```
  1. Убедитесь, что политика аутентификации была удалена. Для этого повторно выполните команду `yc organization-manager authentication-policy-rule list`.

- API {#api}

  Воспользуйтесь методом REST API [delete](../../policy/api-ref/AuthenticationPolicyRule/delete.md) для ресурса [AuthenticationPolicyRule](../../policy/api-ref/AuthenticationPolicyRule/index.md) или вызовом gRPC API [AuthenticationPolicyRuleService/Delete](../../policy/api-ref/grpc/AuthenticationPolicyRule/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Приложения в Yandex Identity Hub](../../concepts/applications/index.md)
* [Политики аутентификации в Yandex Identity Hub](../../concepts/authentication-policy.md)
* [Создать политику аутентификации](create.md)
* [Активировать и деактивировать политику аутентификации](activate-deactivate.md)
* [Изменить политику аутентификации](update.md)