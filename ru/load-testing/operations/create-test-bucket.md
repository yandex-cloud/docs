---
title: Как создать тест с данными из бакета в {{ load-testing-full-name }}
description: Следуя данной инструкции, вы сможете создать тест с данными из бакета.
---

# Создание теста с данными из бакета

В {{ load-testing-name }} тестовые данные можно загрузить из [бакета](../../storage/concepts/bucket.md) [{{ objstorage-full-name }}](../../storage/). Этот способ позволяет:
* работать с тестовыми данными больших размеров (больше 100 МБ);
* хранить данные и легко их переиспользовать;
* обеспечить максимальную безопасность (тестовые данные не покидают облако пользователя и связанных с ним сетей).

## Подготовка инфраструктуры {#infrastructure-prepare}

1. [Создайте](create-agent.md) агент тестирования.
1. [Создайте](../../storage/operations/buckets/create.md) бакет и [загрузите](../../storage/operations/objects/upload.md) в него файл с тестовыми данными.
1. Выдайте сервисному аккаунту, привязанному к [агенту](../concepts/agent.md), права на чтение в бакете. Для этого отредактируйте [ACL](../../storage/concepts/acl.md) бакета:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится бакет.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
    1. Напротив нужного бакета нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
    1. В открывшемся окне ведите имя сервисного аккаунта, выберите права на чтение в бакете — `READ` и нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

    Сервисному аккаунту будут предоставлены права на чтение данных только из этого бакета.

    {% note info %}

    Вместо редактирования ACL бакета вы можете [назначить](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../../storage/security/#storage-editor) `storage.editor`. 

    Этот способ менее безопасный, поскольку у сервисного аккаунта будут права на выполнение любых операций со всеми бакетами в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder): создание, удаление, изменение или открытие публичного доступа.

    {% endnote %}

## Создание теста {#create-test}


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvmjqlnyyas67xt55d?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=a0Xh4vxdVW4).



{% list tabs group=instructions %}

- Консоль управления {#console}
  1. В [консоли управления]({{ link-console-main }}) выберите каталог для тестирования.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
  1. На вкладке ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
  1. [Выберите](../concepts/agent-select.md) или создайте агент тестирования.
  1. В блоке **Прикрепленные файлы**:
      1. Нажмите кнопку **{{ ui-key.yacloud.load-testing.label_choose-from-bucket }}**.
      1. Найдите бакет в выпадающем списке и укажите путь к файлу с тестовыми данными.

      Также вы можете **Выбрать файлы** с компьютера. В этом случае файлы необходимо загружать заново при каждом выполнении теста.

  1. В зависимости от выбранного способа настройки задайте параметры в блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

      {% include [test settings](../../_includes/load-testing/test-settings.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для создания теста:

     ```bash
     yc loadtesting test create --help
     ```

  1. Загрузите файл конфигурации теста в формате YAML:

     ```bash
     yc loadtesting test-config create --from-yaml-file <путь_к_файлу>
     ```

  1. Загрузите [тестовые данные](../../load-testing/concepts/payload). Для этого создайте [IAM-токен](../../ydb/terraform/credentials):

     ```bash
     export YC_TOKEN=$(yc iam create-token)
     export TEST_PAYLOAD_FILE="sample/_requests.uri"
     export S3_PAYLOAD_BUCKET="my_bucket"
     export S3_PAYLOAD_FILENAME="my_requests.uri"
     curl -H "X-YaCloud-SubjectToken: ${$YC_TOKEN}" --upload-file - "https://storage.yandexcloud.net/${$S3_PAYLOAD_BUCKET}/${$S3_PAYLOAD_FILENAME}" < ${$TEST_PAYLOAD_FILE}
     ```

  1. Создайте тест в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     loadtesting test create \
     --name "yc-examples-test" \
     --description "Test has been created using YC" \
     --labels source=gh,type=tutorial \
     --configuration id=ff6hvk749g71********,agent-id=ff633vbrst7a********,test-data=requests.uri \
     --test-data name=requests.uri,s3bucket=my_bucket,s3file=my_requests.uri
     ```

     Где:
     * `--name` — имя теста.
     * `--description` — описание теста.
     * `--labels` — [метки](../../resource-manager/concepts/labels.md) теста.
     * `--configuration` — настройки конфигурации теста:
         * `id` — идентификатор конфигурации теста. Укажите идентификатор файла конфигурации, загруженного на шаге 2. Чтобы получить список идентификаторов конфигураций, выполните команду `yc loadtesting test-config list`.
         * `agent-id` — идентификатор агента тестирования.
         * `test-data` — имя объекта с тестовыми данными.
     * `--test-data` — настройки тестовых данных:
         * `name` — имя объекта с тестовыми данными.
         * `s3bucket` — имя бакета, в котором хранятся тестовые данные.
         * `s3file` — имя файла с тестовыми данными в бакете.

     Подробнее о создании теста с помощью CLI см. в [репозитории Yandex Cloud Examples](https://github.com/yandex-cloud-examples/yc-load-testing-start-test).

  1. Для того чтобы просмотреть список тестов в каталоге для тестирования с помощью CLI, воспользуйтесь следующей командой:

     ```bash
     yc loadtesting test list
     ```

     Подробнее о выводе тестов с помощью CLI см. в [репозитории Yandex Cloud Examples](https://github.com/yandex-cloud-examples/yc-load-testing-list-tests).
    

{% endlist %}