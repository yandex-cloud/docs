# Тестирование приложений с помощью {{ GL }}

[{{ GL }}](https://about.gitlab.com/) — это сайт и система управления репозиториями кода для Git. Также {{ GL }} позволяет разработчикам вести непрерывный процесс для создания, тестирования и развертывания кода.

В этом сценарии вы настроите {{ GL }} на [виртуальной машине](../../compute/concepts/vm.md), создадите простой проект на языке программирования C++, настроите сценарий тестирования проекта и проверите его выполнение.

Чтобы создать и протестировать проект в среде {{ GL }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Необходимые платные ресурсы](#paid-resources).
1. [Создайте ВМ с {{ GL }}](#create-vm).
1. [Настройте {{ GL }}](#confgure-gitlab).
1. [Задайте настройки приватности](#disable-signup).
1. [Создайте проект](#create-project).
1. [Настройте и запустите тестирование для проекта](#ci-cd).
1. [Настройте и зарегистрируйте раннер](#configure-runner).
1. [Создайте сценарий тестирования](#create-test-case).
1. [Создайте ошибку в проекте](#create).
1. [Как удалить созданные ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки сервера для {{ GL }} входит:
* Плата за [диск](../../compute/concepts/disk.md) и постоянно запущенную ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование динамического или статического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте виртуальную машину с {{ GL }} {#create-vm}

1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Gitlab` и выберите публичный образ [{{ GL }}](/marketplace/products/yc/gitlab).
1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет создана ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** выберите [тип диска](../../compute/concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-ssd_4Mmub }}` и задайте размер `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
    * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}, или выберите статический адрес из списка, если вы зарезервировали его заранее.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `gitlab`.
1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Подождите примерно пять минут, пока не будет создана ВМ и на ней не запустятся все сервисы. После полного запуска всех сервисов, {{ GL }} станет доступен через веб-интерфейс в браузере.

## Настройте {{ GL }} {#confgure-gitlab}

1. На странице сервиса {{ compute-name }} выберите созданную ВМ `gitlab` и скопируйте ее публичный IP-адрес.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Получите пароль администратора {{ GL }} с помощью команды ВМ:

   ```bash
   sudo cat /etc/gitlab/initial_root_password
   ```

1. Скопируйте пароль из строки `Password` (исключая пробелы) в буфер обмена или отдельный файл.
1. Откройте в браузере ссылку `http://<публичный_IP-адрес_ВМ>`. Откроется веб-интерфейс {{ GL }}.
1. Войдите в систему с учетной записью администратора:
   * **Username or email** — `root`.
   * **Password** — пароль, скопированный ранее.

   Если вы не можете войти, [сбросьте пароль учетной записи администратора](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password).
1. [Смените пароль учетной записи администратора](https://docs.gitlab.com/ee/user/profile/#change-your-password).
1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.

### Задайте настройки приватности {#disable-signup}

Отключите возможность регистрации других пользователей через страницу авторизации:
1. Перейдите в раздел **Admin area**.
1. В панели слева перейдите в раздел **Settings** и выберите вкладку **General**.
1. В блоке **Sign-up restrictions** нажмите кнопку **Expand**.
1. Отключите опцию **Sign-up enabled**.
1. Нажмите кнопку **Save changes**.

Теперь зарегистрировать новых пользователь может только администратор, через вкладку **Users** в разделе **Overview**.

## Создайте проект {#create-project}

Для того, чтобы создать проект:
1. На главной странице {{ GL }} выберите **Create a project**.
1. На открывшейся странице укажите:
   * Имя проекта: `My Project`.
   * Группу и идентификатор проекта: `root` и `my-project`.
   * При необходимости задайте описание и область видимости проекта.
1. Нажмите кнопку **Create project**.

   ![Создание проекта](../../_assets/tutorials/gitlab/gitlab1.png)

1. После создания проекта в панели слева перейдите в раздел **Settings** и выберите вкладку **CI/CD**.
1. В блоке **Auto DevOps** нажмите кнопку **Expand**, отключите опцию **Default to Auto DevOps pipeline** и сохраните изменения кнопкой **Save changes**.

   ![Отключение Auto DevOps](../../_assets/tutorials/gitlab/gitlab2.png)

1. Добавьте файл проекта.
   1. В панели слева перейдите в проект {{ GL }}.
   1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `test.cpp`. Добавьте в него код программы, которая проверяет результат умножения 2 × 2 и выводит `Hello World`, если результат равен 4:

      ```cpp
      #include <iostream>
      #include <cassert>

      int main() {
        assert(2 * 2 == 4);
        std::cout << "Hello world!" << std::endl;
        return 0;
      }
      ```

      ![Добавление файла](../../_assets/tutorials/gitlab/gitlab3.png)

   1. Укажите название коммита в поле **Commit message**.
   1. Нажмите кнопку **Commit changes**.

## Настройте и запустите тестирование для проекта {#ci-cd}

Раннер — это программа, которая осуществляет процесс тестирования и сборки проекта в среде {{ GL }} по заданной инструкции.

### Настройте и зарегистрируйте раннер {#configure-runner}

1. [Зайдите по SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) на ВМ и перейдите в режим администратора в консоли:

   ```bash
   sudo -i
   ```

1. Загрузите раннер:

   ```bash
   curl --location --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
   ```

1. Сделайте раннер исполняемым:

   ```bash
   chmod +x /usr/local/bin/gitlab-runner
   ```

1. Создайте отдельного пользователя для запуска раннера:

   ```bash
   useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
   ```

1. Установите и запустите раннер:

   ```bash
   gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
   gitlab-runner start
   ```

1. Зарегистрируйте раннер в {{ GL }}:
   1. Запустите интерактивную регистрацию командой `gitlab-runner register`.
   1. Введите адрес вашего {{ GL }}-сервера. При запросе:

      ```text
      Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com)
      ```

      введите `http://<публичный_IP-адрес_вашей_ВМ>`.
   1. Введите регистрационный токен для раннера. Чтобы его найти, нужно перейти в {{ GL }} на страницу проекта, затем в панели слева выбрать **Settings** и открыть вкладку **CI/CD**. После этого нажмите кнопку **Expand** в блоке **Runners**. В разделе **Set up a specific Runner manually** скопируйте токен из третьего пункта и введите его в ответ на запрос:

      ```text
      Please enter the gitlab-ci token for this runner
      <токен>
      ```

      ![Получение токена](../../_assets/tutorials/gitlab/gitlab4.png)

   1. На запрос:

      ```text
      Please enter the gitlab-ci description for this runner
      ```

      введите описание раннера: `My runner`.
   1. В поле ввода тегов не указывайте ничего, нажмите **Enter**. Иначе по умолчанию раннер не будет выполнять работу без указания соответствующих тегов для проекта.
   1. Укажите среду выполнения. В нашем случае, на запрос:

      ```text
      Please enter the executor: ssh, docker+machine, docker-ssh+machine, kubernetes, docker, parallels, virtualbox, docker-ssh, shell:
      ```

      введите: `shell`.

На этом установка и настройка раннера выполнены. Если все сделано правильно, то на странице, где вы копировали регистрационный токен, должен появиться раздел **Runners activated for this project**, в котором будет отображаться зарегистрированный раннер.

![Успешная настройка](../../_assets/tutorials/gitlab/gitlab5.png)

### Создайте сценарий тестирования {#create-test-case}

Создайте сценарий тестирования, который будет выполнять раннер. Сценарий описывается в специальном файле `.gitlab-ci.yml`, который должен находиться в корневой директории проекта. По сценарию раннер будет компилировать исходный файл проекта в исполняемый файл, а затем запускать его.

Так как тестирование будет выполняться в операционной системе ВМ, установите приложения, которые необходимы для тестирования: `git` для клонирования проекта из репозитория и `g++` для компиляции проекта.

Чтобы создать сценарий тестирования:
1. Подключитесь к ВМ по SSH и установите необходимые приложения:

   ```bash
   sudo apt update
   sudo apt install -y git g++
   ```

1. Добавьте сценарий тестирования:
   1. Откройте веб-интерфейс {{ GL }}.
   1. Откройте проект {{ GL }}.
   1. На открывшейся странице нажмите кнопку **Set up CI/CD**.
   1. Откроется страница с предложением добавить новый файл `.gitlab-ci.yml`, в котором в формате [YAML](https://yaml.org/) нужно описать сценарий. Добавьте текст сценария:

      ```yaml
      stages:
        - build
        - test
        - pack

      cache:
        paths:
          - hello

      build:
        stage: build
        script: g++ test.cpp -o hello

      test:
        stage: test
        script: ./hello

      pack:
        stage: pack
        script: gzip -c hello > hello.gz
        artifacts:
          paths:
            - hello.gz
      ```

      В сценарии указано, что работа разделена на три этапа, которые выполняются последовательно:
      * `build` — на первом этапе выполняется компиляция проекта в исполняемый файл `hello`.
      * `test` — на втором исполняемый файл запускается.
      * `pack` — на третьем этапе создается архив с исполняемым файлом, который можно будет загрузить через веб-интерфейс {{ GL }} после успешного завершения сценария. В блоке `artifacts` указаны файлы, доступные для загрузки.

      В блоке `cache` указываются файлы и директории, которые необходимо передавать между этапами. Если его не указать, то на этапе `test` файл `hello` не будет доступен и произойдет ошибка.

      ![Сценарий тестирования](../../_assets/tutorials/gitlab/gitlab6.png)

   1. Нажмите **Commit changes**

После коммита система автоматически начнет тестировать последний коммит. Чтобы проверить результаты тестирования, на панели слева в проекте {{ GL }} выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**. В результате должна появиться строчка с первым тестом и статусом `passed`. Нажав на значок с облаком вы можете загрузить артефакты сборки.

### Создайте ошибку в проекте {#create}

Теперь сделайте так, чтобы в проекте произошла ошибка, которую раннер должен помочь найти в процессе выполнения тестирования. Для этого:
1. Зайдите в репозиторий проекта и откройте файл `test.cpp`.
1. Нажмите **Edit**.
1. Укажите в проверке (assert), что результат выполнения умножения 2 на 2 должен быть равен 5. В этом случае при выполнении программы произойдет ошибка и она завершится некорректно.

   ```cpp
   ...
   assert(2 * 2 == 5);
   ...
   ```

1. Назовите коммит `Wrong assert in test.cpp`.
1. Нажмите **Commit Changes**.

Откройте раздел **Build** → **Pipelines**. В столбце **Stages** видно, что в результате выполнения теста был успешно пройден первый этап `build`, а на втором этапе `test` произошла ошибка. Третий этап `pack` был пропущен и итоговые артефакты не были сформированы.

Если нажать на статус выполнения `failed` и перейти на вкладку **Failed Jobs**, можно увидеть текст ошибки, где указано, что не выполнился `assert`:

![Ошибка выполнения](../../_assets/tutorials/gitlab/gitlab7.png)

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутый сервер, достаточно удалить созданную ВМ `gitlab`.

Если вы зарезервировали статический публичный IP-адрес специально для этой ВМ:
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в вашем каталоге.
1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**.
1. Найдите нужный адрес, нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
