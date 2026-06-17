# Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox

# Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox

Вы можете безопасно хранить пароли в виде [секретов Yandex Lockbox](../../lockbox/concepts/secret.md) и использовать их в своих сценариях CI в Yandex Managed Service for GitLab. Так вы можете защитить и скрыть пароли в CI-скриптах от пользователей GitLab, в том числе администраторов.

Интеграция с Yandex Lockbox устроена следующим образом. Вы подготавливаете секрет Yandex Lockbox и переменную окружения GitLab, которая ссылается на этот секрет. Также вы устанавливаете GitLab Runner на виртуальную машину и привязываете к ней сервисный аккаунт. После этого вы создаете указанный ниже CI-скрипт. Он содержит специальную команду, которая запрашивает IAM-токен сервисного аккаунта. С помощью полученного IAM-токена и переменной окружения скрипт извлекает пароль из секрета. В результате пароль используется в CI-скрипте, но хранится во внешнем хранилище.

Чтобы инстанс Managed Service for GitLab мог обращаться к секретам Yandex Lockbox:

1. [Подготовьте инфраструктуру](#infra).
1. [Настройте сценарий CI](#ci).
1. [Проверьте результат](#check-result).
1. [Устраните потенциальные уязвимости](#eliminate-vulnerabilities).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за хранение секрета и запросы к нему ([тарифы Yandex Lockbox](../../lockbox/pricing.md)).
* Плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

## Подготовьте инфраструктуру {#infra}

1. [Создайте и активируйте инстанс](../../managed-gitlab/operations/instance/instance-create.md) Managed Service for GitLab.
1. [Создайте проект GitLab](https://docs.gitlab.com/ee/user/project/).
1. [Создайте секрет](../../lockbox/operations/secret-create.md) Yandex Lockbox с названием `MY_SECRET`.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `lockbox.payloadViewer`.

   У этой роли нет прав на получение списка секретов, в результате без идентификатора секрета злоумышленник не сможет получить пароль из секрета.

1. [Создайте переменную окружения](https://docs.gitlab.com/ee/ci/variables/#for-a-project) GitLab для проекта. Укажите в ней следующие настройки:

   * **Key** — `MY_SECRET`.
   * **Value** — идентификатор созданного секрета Yandex Lockbox.
   * **Mask variable** — включено.

      Чтобы защитить пароли от кражи злоумышленниками, замаскируйте переменную. Так только пользователи с ролями `Maintainer` или `Owner` в проекте GitLab смогут увидеть значение переменной — идентификатор секрета Yandex Lockbox. Если злоумышленник подключится к виртуальной машине с GitLab Runner, без идентификатора секрета он не сможет узнать пароль из этого секрета.

1. [Установите GitLab Runner](../../managed-gitlab/tutorials/install-gitlab-runner.md) на отдельной виртуальной машине Yandex Compute Cloud. При создании ВМ укажите созданный ранее сервисный аккаунт.

   В настройках GitLab Runner укажите, что он доступен только для [защищенных веток](https://docs.gitlab.com/ee/user/project/protected_branches.html) и конкретных проектов (опции **Protected** и **Lock to current projects**). Если не указать эти настройки, CI-скрипты с паролями можно будет запустить в проектах, которые не отслеживают сотрудники информационной безопасности. В результате пароли могут быть скомпрометированы.

   {% cut "Как настроить GitLab Runner" %}

   1. Откройте проект GitLab в браузере.
   1. В меню слева перейдите в раздел **Settings** → **CI/CD**.
   1. В разделе **Runners** нажмите кнопку **Expand**.
   1. В строке с нужным GitLab Runner нажмите кнопку ![icon](../../_assets/console-icons/pencil.svg) и включите следующие опции:

      * **Protected** — GitLab Runner будет работать только с защищенными ветками;
      * **Lock to current projects** — GitLab Runner будет работать только с текущими проектами.

   1. Нажмите кнопку **Save changes**.

   Подробнее о настройках GitLab Runner см. в [документации GitLab](https://docs.gitlab.com/ee/ci/runners/configure_runners.html).

   {% endcut %}

## Настройте сценарий CI {#ci}

1. Создайте ветку для сценария CI. [Включите для нее защиту](https://docs.gitlab.com/ee/user/project/protected_branches.html#for-one-project) на уровне проекта.
1. Переключитесь локально на созданную ветку.
1. В корне репозитория создайте файл `.gitlab-ci.yml` и вставьте в него CI-скрипт, который выводит значение секрета Yandex Lockbox:

   ```yaml
   stages:
     - build
   build:
     stage: build
     script:
       - >
         export IAM_TOKEN_JSON=`curl --silent --header "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token`
       - export TOKEN=`echo $IAM_TOKEN_JSON | jq -rMc '.access_token'`
       - >
         curl --silent -header "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload
       - >
         export SECRET_JSON=`curl --silent --header "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload`
       - export VALUE_OF_MY_SECRET=`echo $SECRET_JSON | jq -rMc '.entries[] | select(.key | contains("MY_SECRET")) | .textValue'`
       - echo $VALUE_OF_MY_SECRET
   ```

1. Создайте коммит и отправьте его в удаленный репозиторий `origin`:

   ```bash
   git add . && git commit -m "Added .gitlab-ci.yml" && git push
   ```

После этого запустится сборка, которая запишет значение секрета Yandex Lockbox в переменную окружения `VALUE_OF_MY_SECRET`.

## Проверьте результат {#check-result}

1. В меню слева в GitLab перейдите в раздел **Build** → **Pipelines**.
1. Убедитесь, что сборка принимает статус **Passed**. Он означает, что сборка прошла успешно.

## Устраните потенциальные уязвимости {#eliminate-vulnerabilities}

1. [Включите и настройте](../../managed-gitlab/operations/approval-rules.md) правила ревью кода в ветке для сценария CI.

   Так злоумышленники не смогут получить значение переменной с помощью таких команд, как `env`, `printenv` или `echo`. Сотрудники информационной безопасности смогут отслеживать изменения в ветке.

1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md) для ВМ с GitLab Runner. Запретите в ней входящий трафик, который разрешает подключения к ВМ извне.

   
   Если злоумышленник подключился к ВМ с GitLab Runner и знает идентификатор секрета Yandex Lockbox, он может получить доступ к секрету.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [инстанс GitLab](../../managed-gitlab/operations/instance/instance-delete.md);
* [секрет Yandex Lockbox](../../lockbox/operations/secret-delete.md);
* [ВМ с GitLab Runner](../../compute/operations/vm-control/vm-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).