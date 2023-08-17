# Создание теста с данными из бакета

В {{ load-testing-name }} тестовые данные можно загрузить из [бакета](../../storage/concepts/bucket.md) [{{ objstorage-full-name }}](../../storage/). Этот способ позволяет:
* работать с тестовыми данными больших размеров (больше 100 МБ);
* хранить данные и легко их переиспользовать;
* обеспечить максимальную безопасность (тестовые данные не покидают облако пользователя и связанных с ним сетей).

## Подготовка инфраструктуры {#infrastructure-prepare}

1. [Создайте](create-agent.md) агент тестирования.
1. Привяжите бакет к {{ load-testing-name }}:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог для тестирования.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
    1. На вкладке ![image](../../_assets/load-testing/storage.svg) **{{ ui-key.yacloud.load-testing.label_test-data_list }}** нажмите **{{ ui-key.yacloud.load-testing.button_add-bucket }}**.
    1. Выберите бакет.
1. [Загрузите](../../storage/operations/objects/upload.md) файл с тестовыми данными в бакет.
1. Выдайте сервисному аккаунту, привязанному к [агенту](../concepts/agent.md), права на чтение в бакете. Для этого отредактируйте [ACL](../../storage/concepts/acl.md) бакета:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится бакет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Напротив нужного бакета нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
    1. В открывшемся окне ведите имя сервисного аккаунта, выберите права на чтение в бакете — `READ` и нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    Сервисному аккаунту будут предоставлены права на чтение данных только из этого бакета.

    {% note info %}

    Вместо редактирования ACL бакета вы можете [назначить](../../iam/operations/roles/grant.md#access-to-sa) сервисному аккаунту [роль](../../storage/security/#storage-editor) `storage.editor`. 

    Этот способ менее безопасный, поскольку у сервисного аккаунта будут права на выполнение любых операций со всеми бакетами в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder): создание, удаление, изменение или открытие публичного доступа.

    {% endnote %}

## Создание теста {#create-test}

1. В [консоли управления]({{ link-console-main }}) выберите каталог для тестирования.
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На вкладке ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. Выберите или создайте агент тестирования.
1. (Опционально) Выберите или создайте [лог-группу](../../logging/concepts/log-group.md).
1. В блоке **{{ ui-key.yacloud.load-testing.test-data-section }}**:
    1. Выберите способ передачи данных: **{{ ui-key.yacloud.load-testing.label_bucket-source }}**.
    1. Найдите бакет в выпадающем списке и укажите путь к файлу с тестовыми данными. Если файл не был загружен заранее:

        1. Выберите способ передачи данных: **{{ ui-key.yacloud.load-testing.label_local-source }}**.
        1. Нажмите **Прикрепить файл** и загрузите файл с тестовыми данными с вашего компьютера.
        1. Включите опцию **Сохранить в {{ objstorage-name }}**.
        1. Выберите или [создайте](../../storage/operations/buckets/create.md) бакет, в который хотите сохранить данные.

1. В зависимости от выбранного способа настройки задайте параметры в блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

    {% include [test settings](../../_includes/load-testing/test-settings.md) %}

1. Нажмите **{{ ui-key.yacloud.common.create }}**.