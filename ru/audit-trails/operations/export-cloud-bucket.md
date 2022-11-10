# Загрузка аудитных логов облака в {{ objstorage-name }}

По этой инструкции вы создадите новый трейл, который будет загружать аудитные логи ресурсов облака в бакет {{ objstorage-name }}.

{% if product == "yandex-cloud" %}

{% include [bucket-encryption-tip](../../_includes/audit-trails/bucket-encryption-tip.md) %}

{% endif %}


## Подготовить окружение {#before-you-begin}

Для сбора аудитных логов отдельного облака:

1. [Создайте новый бакет](../../storage/operations/buckets/create.md) для загрузки в него аудитных логов.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. Назначьте роли сервисном аккаунту:

    {% list tabs %}

    - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * Назначьте [роль `audit-trails.viewer`](../security/index.md#roles) на облако, со всех ресурсов которого будут собираться аудитные логи:

        ```
        yc resource-manager cloud add-access-binding \
          --role audit-trails.viewer \
          --id <идентификатор_облака> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:
        * `role` — назначаемая роль;
        * `id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которого будут собираться аудитные логи;
        * `service-account-id` — идентификатор сервисного аккаунта.

      * Назначьте [роль `storage.uploader`](../../storage/security/index.md#storage-uploader) на каталог, в котором будет находиться трейл:

        ```
        yc resource-manager folder add-access-binding \
          --role storage.uploader \
          --id <идентификатор_каталога> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:
        * `role` — назначаемая роль;
        * `id` — идентификатор каталога, в котором будет находиться трейл;
        * `service-account-id` — идентификатор сервисного аккаунта.

    {% endlist %}

1. На странице [Права доступа]({{ link-console-access-management }}) убедитесь, что у вас есть роли:
    * `iam.serviceAccounts.user` на сервисный аккаунт;
    * `audit-trails.editor` на каталог, где будет находиться трейл;
    * `audit-trails.viewer` на облако, с которого будут собираться аудитные логи;
    * `storage.viewer` на бакет или каталог.


{% if product == "yandex-cloud" %}

{% include [bucket-encryption-section](../../_includes/audit-trails/bucket-encryption-section.md) %}

{% endif %}

## Создать трейл {#the-trail-creation}

Чтобы создать первый трейл в {{ at-name }} и запустить процесс управления аудитными логами:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. Выберите сервис **{{ at-name }}**.
  1. Нажмите кнопку **Создать трейл** и укажите:
      * **Имя** — имя создаваемого трейла.
      * **Описание** — описание трейла, необязательный параметр.
  1. В блоке **Фильтр** задайте параметры области сбора аудитных логов:
      * **Ресурс** — выберите `Облако`.
      * **Облако** — не требует заполнения, содержит имя облака, в котором будет находиться трейл.
      * **Каталоги** — оставьте значение по умолчанию `все каталоги`.
  1. В блоке **Назначение** задайте параметры объекта назначения:
      * **Назначение** —  `{{ objstorage-name }}`.
      * **Бакет** — выберите бакет, в который будут загружаться аудитные логи.
      * **Префикс объекта** — необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.

      {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

  1. В блоке **Сервисный аккаунт** выберите сервисный аккаунт, от имени которого трейл будет загружать файлы аудитного лога в бакет.
  1. Нажмите кнопку **Создать**.

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в бакет.

## Что дальше {#whats-next} 

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске по аудитным логам в бакете](../tutorials/search-bucket.md).
