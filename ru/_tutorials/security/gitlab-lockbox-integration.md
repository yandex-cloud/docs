# Безопасное хранение паролей для {{ GL }} CI в виде секретов {{ lockbox-full-name }}

Вы можете безопасно хранить пароли в виде [секретов {{ lockbox-full-name }}](../../lockbox/concepts/secret.md) и использовать их в своих сценариях CI в {{ mgl-full-name }}. Так вы можете защитить и скрыть пароли в CI-скриптах от пользователей {{ GL }}, в том числе администраторов.

Интеграция с {{ lockbox-name }} устроена следующим образом. Вы подготавливаете секрет {{ lockbox-name }} и переменную окружения {{ GL }}, которая ссылается на этот секрет. Также вы устанавливаете {{ GLR }} на виртуальную машину и привязываете к ней сервисный аккаунт. После этого вы создаете указанный ниже CI-скрипт. Он содержит специальную команду, которая запрашивает IAM-токен сервисного аккаунта. С помощью полученного IAM-токена и переменной окружения скрипт извлекает пароль из секрета. В результате пароль используется в CI-скрипте, но хранится во внешнем хранилище.

Чтобы инстанс {{ mgl-name }} мог обращаться к секретам {{ lockbox-name }}:

1. [Подготовьте инфраструктуру](#infra).
1. [Настройте сценарий CI](#ci).
1. [Проверьте результат](#check-result).
1. [Устраните потенциальные уязвимости](#eliminate-vulnerabilities).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#infra}

1. [Создайте и активируйте инстанс](../../managed-gitlab/operations/instance/instance-create.md) {{ mgl-name }}.
1. [Создайте проект {{ GL }}]({{ gl.docs }}/ee/user/project/).
1. [Создайте секрет](../../lockbox/operations/secret-create.md) {{ lockbox-name }} с названием `MY_SECRET`.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `{{ roles-lockbox-payloadviewer }}`.

   У этой роли нет прав на получение списка секретов, в результате без идентификатора секрета злоумышленник не сможет получить пароль из секрета.

1. [Создайте переменную окружения]({{ gl.docs }}/ee/ci/variables/#for-a-project) {{ GL }} для проекта. Укажите в ней следующие настройки:

   * **Key** — `MY_SECRET`.
   * **Value** — идентификатор созданного секрета {{ lockbox-name }}.
   * **Mask variable** — включено.

      Чтобы защитить пароли от кражи злоумышленниками, замаскируйте переменную. Так только пользователи с ролями `Maintainer` или `Owner` в проекте {{ GL }} смогут увидеть значение переменной — идентификатор секрета {{ lockbox-name }}. Если злоумышленник подключится к виртуальной машине с {{ GLR }}, без идентификатора секрета он не сможет узнать пароль из этого секрета.

1. [Установите {{ GLR }}](../../managed-gitlab/tutorials/install-gitlab-runner.md) на отдельной виртуальной машине {{ compute-full-name }}. При создании ВМ укажите созданный ранее сервисный аккаунт.

   В настройках {{ GLR }} укажите, что он доступен только для [защищенных веток]({{ gl.docs }}/ee/user/project/protected_branches.html) и конкретных проектов (опции **Protected** и **Lock to current projects**). Если не указать эти настройки, CI-скрипты с паролями можно будет запустить в проектах, которые не отслеживают сотрудники информационной безопасности. В результате пароли могут быть скомпрометированы.

   {% cut "Как настроить {{ GLR }}" %}

   1. Откройте проект {{ GL }} в браузере.
   1. В меню слева перейдите в раздел **Settings** → **CI/CD**.
   1. В разделе **Runners** нажмите кнопку **Expand**.
   1. В строке с нужным {{ GLR }} нажмите кнопку ![icon](../../_assets/console-icons/pencil.svg) и включите следующие опции:

      * **Protected** — {{ GLR }} будет работать только с защищенными ветками;
      * **Lock to current projects** — {{ GLR }} будет работать только с текущими проектами.

   1. Нажмите кнопку **Save changes**.

   Подробнее о настройках {{ GLR }} см. в [документации {{ GL }}]({{ gl.docs }}/ee/ci/runners/configure_runners.html).

   {% endcut %}

## Настройте сценарий CI {#ci}

1. Создайте ветку для сценария CI. [Включите для нее защиту]({{ gl.docs }}/ee/user/project/protected_branches.html#for-one-project) на уровне проекта.
1. Переключитесь локально на созданную ветку.
1. В корне репозитория создайте файл `.gitlab-ci.yml` и вставьте в него CI-скрипт, который выводит значение секрета {{ lockbox-name }}:

   ```yaml
   stages:
     - build
   build:
     stage: build
     script:
       - >
         export IAM_TOKEN_JSON=`curl -s -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token`
       - export TOKEN=`echo $IAM_TOKEN_JSON | jq -rMc '.access_token'`
       - >
         curl -s -H "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload
       - >
         export SECRET_JSON=`curl -s -H "Authorization: Bearer $TOKEN" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload`
       - export VALUE_OF_MY_SECRET=`echo $SECRET_JSON | jq -rMc '.entries[] | select(.key | contains("MY_SECRET")) | .textValue'`
       - echo $VALUE_OF_MY_SECRET
   ```

1. Создайте коммит и отправьте его в удаленный репозиторий `origin`:

   ```bash
   git add . && git commit -m "Added .gitlab-ci.yml" && git push
   ```

После этого запустится сборка, которая запишет значение секрета {{ lockbox-name }} в переменную окружения `VALUE_OF_MY_SECRET`.

## Проверьте результат {#check-result}

1. В меню слева в {{ GL }} перейдите в раздел **Build** → **Pipelines**.
1. Убедитесь, что сборка принимает статус **Passed**. Он означает, что сборка прошла успешно.

## Устраните потенциальные уязвимости {#eliminate-vulnerabilities}

1. [Включите и настройте](../../managed-gitlab/operations/approval-rules.md) правила ревью кода в ветке для сценария CI.

   Так злоумышленники не смогут получить значение переменной с помощью таких команд, как `env`, `printenv` или `echo`. Сотрудники информационной безопасности смогут отслеживать изменения в ветке.

1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md) для ВМ с {{ GLR }}. Запретите в ней входящий трафик, который разрешает подключения к ВМ извне.

   
   Если злоумышленник подключился к ВМ с {{ GLR }} и знает идентификатор секрета {{ lockbox-name }}, он может получить доступ к секрету.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [инстанс {{ GL }}](../../managed-gitlab/operations/instance/instance-delete.md);
* [секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md);
* [ВМ с {{ GLR }}](../../compute/operations/vm-control/vm-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).
