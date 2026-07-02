[Документация Yandex Cloud](../../../index.md) > [Yandex Container Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление политиками автоматического удаления Docker-образов > Изменить политику удаления

# Изменить политику удаления

После создания [политики удаления](../../concepts/lifecycle-policy.md) вы можете изменить ее правила, а также статус, имя или описание.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан [реестр](../../concepts/registry.md).
  1. Перейдите в сервис **Container Registry**.
  1. Выберите реестр и нажмите на строку с его именем.
  1. Выберите [репозиторий](../../concepts/repository.md) и нажмите на строку с его именем.
  1. На панели слева нажмите ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **Жизненный цикл**.
  1. В строке с нужной политикой удаления нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Измените параметры политики удаления:
     * **Имя**.
     * **Описание**.
     * **Статус**.
     * В блоке **Правила политики удаления** измените параметры правил:

       * **Тег** — тег Docker-образа для фильтрации. Поддерживаются регулярные выражения языка Java. Например, выражение `test.*` позволяет получить все образы с тегами, начинающимися на `test`.
       * **Образов без тегов** — флаг для применения правила к Docker-образам без тегов.
       * **Время от создания образа, в сутках** — время, через которое Docker-образ может попадать под политику удаления.
       * **Образов оставить** — количество Docker-образов, которые не будут удалены, даже если подходят по правилу.

       * **Описание**.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для обновления параметров политики:

     ```bash
     yc container repository lifecycle-policy update --help
     ```

  1. Измените параметры политики, например, переименуйте политику:

     ```bash
     yc container repository lifecycle-policy update <идентификатор_политики> \
        --new-name=new-policy
     ```

     Чтобы узнать идентификатор политики, получите [список политик удаления в репозитории или в реестре](lifecycle-policy-list.md#lifecycle-policy-list).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте конфигурационный файл и отредактируйте фрагмент с описанием политики:

     ```hcl
     resource "yandex_container_repository_lifecycle_policy" "my_lifecycle_policy" {
       name          = "best-policy"
       status        = "active"
       repository_id = "crpfvi6o4ra7********"

       rule {
         description   = "rule for applying policy"
         untagged      = true
         tag_regexp    = ".*"
         retained_top  = 1
         expire_period = "48h"
       }
     }
     ```

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
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

  После этого в указанном [репозитории](../../concepts/repository.md) будет изменена политика удаления. Проверить изменение политики можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc container repository lifecycle-policy list --registry-id <идентификатор_реестра>
  ```

- API {#api}

  Чтобы изменить политику удаления, воспользуйтесь методом [Update](../../api-ref/grpc/LifecyclePolicy/update.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md). В свойстве `lifecycle_policy_id` укажите идентификатор политики.

  Получить список политик удаления можно с помощью метода [List](../../api-ref/grpc/LifecyclePolicy/list.md) для ресурса [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md).

{% endlist %}

## Примеры {#examples}

### Изменить правила политики удаления {#update-rules}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Подготовьте новые [правила политики](../../concepts/lifecycle-policy.md#lifecycle-rules) и сохраните их в файл `new-rules.json`.

     Пример содержимого файла с правилами, где:
     * `description` — описание правила политики.
     * `tag_regexp` — тег Docker-образа для фильтрации. Поддерживаются регулярные выражения языка Java. Например, выражение `test.*` позволяет получить все образы с тегами, начинающимися на `test`.
     * `untagged` — флаг для применения правила к Docker-образам без тегов.
     * `expire_period` — время, через которое Docker-образ может попадать под политику удаления. Формат параметра — число и единица измерения `s`, `m`, `h` или `d` (секунды, минуты, часы или дни). `expire_period` должен быть кратен 24 часам.
     * `retained_top` — количество Docker-образов, которые не будут удалены, даже если подходят по правилу.
     
     ```json
     [
       {
         "description": "delete prod Docker images older than 60 days but retain 20 last ones",
         "tag_regexp": "prod",
         "expire_period": "60d",
         "retained_top": 20
       },
       {
         "description": "delete all test Docker images except 10 last ones",
         "tag_regexp": "test.*",
         "retained_top": 10
       },
       {
         "description": "delete all untagged Docker images older than 48 hours",
         "untagged": true,
         "expire_period": "48h"
       }
     ]
     ```

  1. Измените правила политики, выполнив команду со следующим параметром:
     * `new-rules` — путь к файлу с новым описанием политик.

     {% note alert %}

     Обновление политики полностью перезаписывает все текущие правила — они будут удалены.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy update crp6lg1868p3******** --new-rules ./new-rules.json
     ```

     Результат:

     ```text
     WARN: All current lifecycle rules will be overwritten. Are you sure?[y/N] y
     id: crp6lg1868p3********
     name: test-policy
     ...
       expire_period: 172800s
       tag_regexp: test.*
       untagged: true
     ```

{% endlist %}

### Изменить статус политики удаления {#update-status}

#### Активируйте политику удаления {#activate}

{% list tabs group=instructions %}

- CLI {#cli}

  Сделайте выключенную политику активной, выполнив команду с флагом `--activate`:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --activate
  ```

  Результат:

  ```text
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

#### Выключите политику удаления {#disabled}

{% list tabs group=instructions %}

- CLI {#cli}

  Выключите активную политику, выполнив команду с флагом `--disable`:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --disable
  ```

  Результат:

  ```text
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Изменить имя политики удаления {#update-name}

{% list tabs group=instructions %}

- CLI {#cli}

  Измените имя политики, выполнив команду:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --new-name new-policy
  ```

  Где `--new-name` — новое имя политики. Требования к имени:

  * длина — от 3 до 63 символов;
  * может содержать строчные буквы латинского алфавита, цифры и дефисы;
  * первый символ — буква, последний — не дефис.

  Результат:

  ```text
  id: crp6lg1868p3********
  name: new-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Изменить описание политики удаления {#update-description}

{% list tabs group=instructions %}

- CLI {#cli}

  Измените описание политики, выполнив команду:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --new-description "new description"
  ```

  Где `--new-description` — новое описание политики.

  Результат:

  ```text
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}