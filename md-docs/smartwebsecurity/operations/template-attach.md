[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Шаблоны ответов > Добавить шаблон к профилю или правилу

# Добавить шаблон страницы ответа к профилю или правилу

Шаблон страницы ответа можно добавить к профилю безопасности или профилю ARL, а также к отдельным правилам в этих профилях.

Инструкции для CLI и API ниже относятся к профилю безопасности и его правилам. Для профиля ARL и его правил используйте консоль управления.

## Добавление шаблона к профилю {#template-to-profile}

При блокировке запроса используется шаблон, назначенный сработавшему правилу. Если у правила нет своего шаблона, используется шаблон профиля. Если шаблон не назначен ни правилу, ни профилю, клиенту возвращается стандартная страница Yandex Cloud.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности или ARL.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **Профили безопасности** или ![arl](../../_assets/smartwebsecurity/arl.svg) **Профили ARL**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В списке **Шаблон страницы ответа** выберите существующий шаблон или [создайте новый](template-create.md).
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды изменения профиля:

     ```bash
     yc smartwebsecurity security-profile update --help
     ```

  1. [Получите идентификатор шаблона](template-manage.md#get-template-info).
  1. Добавьте шаблон к профилю безопасности:

     ```bash
     yc smartwebsecurity security-profile update \
       --id <идентификатор_профиля> \
       --custom-page-id <идентификатор_шаблона> \
       --update-mask custom_page_id
     ```

     Где:

     * `--id` — идентификатор профиля безопасности. Обязательный параметр.
     * `--custom-page-id` — идентификатор шаблона страницы ответа.
     * `--update-mask` — список полей, которые нужно изменить. Значение `custom_page_id` позволяет изменить только привязку шаблона к профилю.

- API {#api}

    Воспользуйтесь методом REST API [update](../api-ref/SecurityProfile/update.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Update](../api-ref/grpc/SecurityProfile/update.md).

    В запросе укажите:

    * `securityProfileId` (в gRPC — `security_profile_id`) — идентификатор профиля безопасности.
    * `customPageId` (в gRPC — `custom_page_id`) — [идентификатор шаблона](template-manage.md#get-template-info).
    * `updateMask` — маску обновления со значением `customPageId`. В gRPC укажите путь `custom_page_id` в поле `update_mask`.

    Маска обновления позволяет изменить только привязку шаблона и сохранить остальные настройки профиля.

{% endlist %}

## Добавление шаблона к правилу {#template-to-rule}

[Правила](../concepts/rules.md), которым можно назначить шаблон страницы ответа:

* Правила профиля безопасности:
  * **Базовое** с действием `Запретить`.
  * **Smart Protection** в режиме `Полная защита` или `Защита API`.
  * **Web Application Firewall** в режиме `Полная защита` или `Защита API`.
* Правила профиля ARL с действиями `Блокировать запросы свыше лимита` или `Временно блокировать все запросы на`.

Дополнительно можно изменить внешний вид окна с проверкой SmartCaptcha. Для этого [создайте новую](../../smartcaptcha/operations/create-captcha.md) или измените уже существующую капчу, привязанную к профилю безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности или ARL.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите **Профили безопасности** или **Профили ARL**.
  1. Выберите профиль, в котором находится нужное правило.
  1. В строке с правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В списке **Шаблон страницы ответа** выберите существующий шаблон или [создайте новый](template-create.md).
  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды изменения профиля:

     ```bash
     yc smartwebsecurity security-profile update --help
     ```

  1. [Получите идентификатор шаблона](template-manage.md#get-template-info).
  1. Сохраните текущую конфигурацию профиля безопасности в файл:

     ```bash
     yc smartwebsecurity security-profile get \
       --id <идентификатор_профиля> \
       --format yaml > profile.yaml
     ```

  1. Скопируйте из `profile.yaml` поле `security_rules` со всеми правилами в отдельный файл `request.yaml`. В нужном правиле добавьте или измените поле `custom_page_id` на одном уровне с `name` и `priority`:

     ```yaml
     custom_page_id: <идентификатор_шаблона>
     ```

     {% note warning %}

     При обновлении заменяется весь список правил. Правила, которых нет в запросе, будут удалены.

     {% endnote %}

  1. Примените изменения:

     ```bash
     yc smartwebsecurity security-profile update \
       --id <идентификатор_профиля> \
       --request-file request.yaml \
       --update-mask security_rules
     ```

     Параметр `--request-file` задает файл с полным списком правил, а `--update-mask security_rules` ограничивает обновление этим списком.

- API {#api}

    1. Получите текущие правила методом REST API [get](../api-ref/SecurityProfile/get.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Get](../api-ref/grpc/SecurityProfile/get.md).
    1. В массиве `securityRules` (в gRPC — `security_rules`) найдите нужное правило и укажите в его поле `customPageId` (в gRPC — `custom_page_id`) [идентификатор шаблона](template-manage.md#get-template-info).
    1. Обновите профиль методом REST API [update](../api-ref/SecurityProfile/update.md) или вызовом gRPC API [SecurityProfileService/Update](../api-ref/grpc/SecurityProfile/update.md). Передайте идентификатор профиля и полный массив правил, включая неизмененные. В поле `updateMask` укажите `securityRules`; для gRPC — путь `security_rules` в поле `update_mask`.

    {% note warning %}

    При обновлении заменяется весь список правил. Правила, которых нет в запросе, будут удалены. Маска обновления позволит сохранить остальные настройки профиля.

    {% endnote %}

{% endlist %}

#### Полезные ссылки {#see-also}

* [Добавить правило в профиль безопасности](rule-add.md)
* [Изменить правило в профиле безопасности](rule-update.md)
* [Подключить профиль безопасности к ресурсу](host-connect.md)
* [Удалить профиль безопасности](profile-delete.md)