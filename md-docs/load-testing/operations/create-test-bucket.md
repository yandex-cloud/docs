# Создание теста с данными из бакета

{% note warning %}

С 1 июля 2026 года сервис Load Testing прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](../sunset.md).

{% endnote %}


В Load Testing тестовые данные можно загрузить из [бакета](../../storage/concepts/bucket.md) [Yandex Object Storage](../../storage/index.md). Этот способ позволяет:
* работать с тестовыми данными больших размеров (больше 100 МБ);
* хранить данные и легко их переиспользовать;
* обеспечить максимальную безопасность (тестовые данные не покидают облако пользователя и связанных с ним сетей).

## Подготовка инфраструктуры {#infrastructure-prepare}

1. [Создайте](create-agent.md) агент тестирования.
1. [Создайте](../../storage/operations/buckets/create.md) бакет и [загрузите](../../storage/operations/objects/upload.md) в него файл с тестовыми данными.
1. Выдайте сервисному аккаунту, привязанному к [агенту](../concepts/agent.md), права на чтение в бакете. Для этого отредактируйте [ACL](../../storage/concepts/acl.md) бакета:
    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится бакет.
    1. Перейдите в сервис **Object Storage**.
    1. Напротив нужного бакета нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Настроить ACL**.
    1. В открывшемся окне ведите имя сервисного аккаунта, выберите права на чтение в бакете — `READ` и нажмите кнопку **Добавить**.
    1. Нажмите кнопку **Сохранить**.

    Сервисному аккаунту будут предоставлены права на чтение данных только из этого бакета.

    {% note info %}

    Вместо редактирования ACL бакета вы можете [назначить](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../../storage/security/index.md#storage-editor) `storage.editor`. 

    Этот способ менее безопасный, поскольку у сервисного аккаунта будут права на выполнение любых операций со всеми бакетами в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder): создание, удаление, изменение или открытие публичного доступа.

    {% endnote %}

## Создание теста {#create-test}


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvmjqlnyyas67xt55d?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=a0Xh4vxdVW4).



{% list tabs group=instructions %}

- Консоль управления {#console}
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог для тестирования.
  1. Перейдите в сервис **Object Storage**.
  1. На вкладке ![image](../../_assets/load-testing/test.svg) **Тесты** нажмите **Создать тест**.
  1. [Выберите](../concepts/agent-select.md) или создайте агент тестирования.
  1. В блоке **Прикрепленные файлы**:
      1. Нажмите кнопку **Выбрать из бакета**.
      1. Найдите бакет в выпадающем списке и укажите путь к файлу с тестовыми данными.

      Также вы можете **Выбрать файлы** с компьютера. В этом случае файлы необходимо загружать заново при каждом выполнении теста.

  1. В зависимости от выбранного способа настройки задайте параметры в блоке **Настройки теста**:

      {% list tabs %}
      
      - Форма
      
        1. Выберите [генератор нагрузки](../concepts/load-generator.md).
        1. В полях **Адрес цели** и **Порт цели** введите адрес и порт тестируемого сервиса.
        1. (Опционально) Включите **Защищенное соединение**.
        1. В поле **Тестирующие потоки** укажите количество тестирующих потоков.
        1. В блоке **Тип нагрузки**:
            * Выберите тип.
            * Нажмите кнопку ![image](../../_assets/plus-sign.svg) **Профиль нагрузки** и добавьте один или более [профилей нагрузки](../concepts/load-profile.md) сервера.
        1. В поле **Способ настройки** выберите тип [тестовых данных](../concepts/payload.md) **Прикрепленный файл**.
        1. (Опционально) Если хотите сократить время тестирования, задайте условие для автоматической остановки теста в меню **Автостоп**. Нажмите ![image](../../_assets/plus-sign.svg) **Автостоп** и укажите:
            * **Тип автостопа** — параметр, при определенном значении которого тестирование прервется;
            * Значения параметров автостопа.
      
                Для разных типов автостопа необходимо указать разные наборы параметров.
        1. В поле **Время принудительной остановки теста** укажите время, после которого сработает автостоп, если тест не будет остановлен по другим причинам. Значение параметра должно быть немного больше ожидаемой продолжительности теста.
        1. (Опционально) Включите опцию **Мониторинг агента**. Подробнее см. в разделе [Мониторинг агентов тестирования](../concepts/monitoring.md).
        1. В блоке **Информация о тесте** укажите имя, описание, номер версии и метки теста.
      
      - Конфигурационный файл
      
        Нажмите **Прикрепить файл** и откройте файл конфигурации с вашего компьютера. Если у вас нет файла конфигурации, повторите уже проведенный тест или сформируйте конфигурационный файл на основе [документации](https://yandextank.readthedocs.io/en/latest/config_reference.html#phantom).
      
        {% note warning %}
      
        В файле конфигурации обязательно укажите предельное время работы теста в блоке `autostop`:
      
        ```yaml
        autostop:
          enabled: true
          package: yandextank.plugins.Autostop
          autostop:
            - limit (5m)
        ```
      
        {% endnote %}
      
        {% note info %}
        
        Во время тестирования агент автоматически очищает место на диске. Вы можете управлять размером освобождаемого места через параметр `disk_limit` в блоке `rcheck`:
      
        ```yaml
        rcheck:
          enabled: true
          package: yandextank.plugins.ResourceCheck
          disk_limit: 2048
          interval: 10s
          mem_limit: 512
        ```
        
        {% endnote %}
      
      {% endlist %}

  1. Нажмите **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для создания теста:

     ```bash
     yc loadtesting test create --help
     ```

  1. Загрузите файл конфигурации теста в формате YAML:

     ```bash
     yc loadtesting test-config create --from-yaml-file <путь_к_файлу>
     ```

  1. Загрузите [тестовые данные](../concepts/payload.md). Для этого создайте [IAM-токен](../../ydb/terraform/credentials.md):

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