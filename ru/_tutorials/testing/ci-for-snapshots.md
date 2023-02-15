# Создание тестовых виртуальных машин через {{ GL }} CI

С помощью {{ yandex-cloud }} вы можете автоматизировать рутинные действия, например, запускать определенный скрипт после каждого коммита в ветку `master` репозитория Git. В примере ниже после каждого коммита создается и тестируется [ВМ](../../compute/concepts/vm.md).

Чтобы настроить непрерывную интеграцию ({% if lang == "ru" %}[Continuous Integration](https://cloud.yandex.ru/blog/posts/2022/10/ci-cd){% else %}Continuous Integration{% endif %}, CI) для [снимков дисков](../../compute/concepts/snapshot.md) ВМ:
1. [Создайте ВМ для тестового приложения](#create-vm) — создайте новую ВМ, снимок диска которой будет использоваться для создания новых ВМ с помощью CI.
1. [Подготовьте ВМ с тестовым приложением](#configure-vm) — установите на ВМ веб-сервер и набор компонентов для работы тестового приложения. Напишите тестовое приложение, которое будет переворачивать слова в переданном на сервер тексте.
1. [Проверьте работу приложения](#test-app) — проверьте настройки сервера и работу приложения с помощью пробного запроса.
1. [Создайте снимок диска ВМ](#create-snapshot) — создайте снимок диска ВМ из которого CI будет создавать новые ВМ.
1. [Создайте ВМ с {{ GL }}](#create-gitlab-vm) — создайте ВМ с [{{ GL }}](https://about.gitlab.com/), где в репозитории будут храниться настройки CI и скрипт функционального тестирования.
1. [Настройте {{ GL }}](#configure-gitlab) — создайте репозиторий для файлов и получите необходимые для конфигурации параметры.
1. [Настройте Runner](#configure-runner) — инструмент для выполнения задач.
1. [Настройте CI](#configure-ci) — задайте конфигурацию CI, указав необходимые параметры для команд и тестирования.
1. [Проверьте работу приложения на ВМ, созданной с помощью CI](#test-new-vm) — убедитесь, что создающиеся с помощью CI и снимка ВМ создаются, а тестовое приложение работает.

Если созданные ВМ больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Перед тем, как создавать ВМ:
1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будете выполнять операции.
1. Убедитесь, что в выбранном каталоге есть [сеть](../../vpc/concepts/network.md#network) с [подсетью](../../vpc/concepts/network.md#subnet), к которой можно подключить ВМ. Для этого на странице каталога выберите сервис **{{ vpc-name }}**. Если в списке есть сеть — нажмите на нее, чтобы увидеть список подсетей. Если ни одной подсети или сети нет, [создайте их](../../vpc/quickstart.md).

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за хранение созданных образов (см. [тарифы {{ compute-name }}](../../compute/pricing.md#prices-storage)).
* Плата за использование динамических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

{% endif %}

## Создайте виртуальную машину для тестового приложения {#create-vm}

Создайте ВМ, на которой будут установлены тестовое приложение, набор необходимых для его работы компонентов и веб-сервер:
1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя ВМ: `ci-tutorial-test-app`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите публичный образ [Ubuntu 18.04](/marketplace/products/yc/ubuntu-18-04-lts).
1. В блоке **Вычислительные ресурсы** выберите следующую конфигурацию:
   * **Платформа** — Intel Ice Lake.
   * **Гарантированная доля vCPU** — 20%.
   * **vCPU** — 2.
   * **RAM** — 1 ГБ.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить ВМ при создании.
1. Укажите данные для доступа на ВМ:
   * В поле **Логин** введите имя пользователя.
   * В поле **SSH-ключ** скопируйте содержимое файла открытого ключа.

     Пару ключей для подключения по {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %} необходимо [создать самостоятельно](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете перейти к ее настройке.

При создании ВМ назначаются [IP-адрес и имя хоста (FQDN)](../../vpc/concepts/address.md). Эти данные можно использовать для доступа по SSH.

## Подготовьте виртуальную машину с тестовым приложением {#configure-vm}

На созданную ВМ нужно установить набор необходимых для работы тестового приложения компонентов и веб-сервер для обработки запросов. Само приложение будет написано на языке Python 2.
1. В блоке **Сеть** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

   ```bash
   ssh <Логин>@<Публичный_IP-адрес_ВМ>
   ```

1. Выполните команду `apt update`, чтобы обновить списки доступных для установки пакетов.
1. Установите необходимые пакеты: JSON-процессор jq, Git-клиент, менеджер пакетов PIP, систему управления виртуальными средами virtualenv, набор заголовочных файлов для Python C API и веб-сервер Nginx:

   ```bash
   sudo apt-get --yes install jq git python-pip virtualenv python-dev nginx-full
   ```

1. Создайте директорию, в которой будет находиться приложение. Также сделайте пользователя, от имени которого вы подключились к ВМ, владельцем директории:

   ```bash
   sudo mkdir /srv/test-app
   sudo chown -R $USER /srv/test-app
   ```

1. Перейдите в директорию и создайте в ней виртуальное окружение `virtualenv`:

   ```bash
   cd /srv/test-app
   virtualenv test-venv
   ```

1. Запустите виртуальное окружение:

   ```bash
   . test-venv/bin/activate
   ```

1. Установите в виртуальное окружение фреймворк Flask и веб-сервер uWSGI:

   ```bash
   pip install flask uwsgi
   ```

1. Деактивируйте виртуальное окружение:

   ```bash
   deactivate
   ```

1. Создайте в директории `/srv/test-app` файл `api.py`:

   ```bash
   touch api.py
   ```

1. Откройте файл `api.py` любым текстовым редактором и скопируйте в него код на языке Python, который:
   * Принимает на вход текстовую строку в параметре `text`.
   * Записывает каждое слово из переданной строки наоборот.
   * Возвращает ответ:
     * В формате JSON, если клиентское приложение может принимать JSON.
     * Обычный текст, если клиентское приложение не может принять JSON.

   ```python
   # api.py
   import json
   from flask import Flask, request, make_response as response

   app = Flask(__name__)

   @app.route("/")
   def index():
       text = request.args.get('text')
       json_type = 'application/json'
       json_accepted = json_type in request.headers.get('Accept', '')
       if text:
           words = text.split()
           reversed_words = [word[::-1] for word in words]
           if json_accepted:
               res = response(json.dumps({'text': reversed_words}), 200)
           else:
               res = response(' '.join(reversed_words), 200)
       else:
           res = response('text not found', 501)
       res.headers['Content-Type'] = json_type if json_accepted else 'text/plain'
       return res
   ```

1. Создайте в директории `/srv/test-app` файл `wsgi.py`:

   ```bash
   touch wsgi.py
   ```

1. Откройте файл `wsgi.py` любым текстовым редактором и скопируйте в него код, запускающий тестовое приложение:

   ```python
   # wsgi.py
   from api import app

   if __name__ == "__main__":
       app.run()
   ```

1. Создайте в директории `/srv/test-app` файл `test-app.ini`:

   ```bash
   touch test-app.ini
   ```

1. Откройте файл `test-app.ini` любым текстовым редактором и скопируйте в него конфигурацию сервера uWSGI:

   ```ini
   #test-app.ini
   [uwsgi]
   module = wsgi:app

   master = true
   processes = 1

   socket = test-app.sock
   chmod-socket = 660
   vacuum = true

   die-on-term = true
   ```

1. Назначьте пользователя `www-data` владельцем директории `/srv/test-app` и файлов в ней:

   ```bash
   sudo chown -R www-data:www-data /srv/test-app
   ```

1. Подготовьте сервис для запуска вашего uWSGI-сервера. Для этого приведите файл `/etc/systemd/system/test-app.service` к следующему виду:

   ```ini
   #/etc/systemd/system/test-app.service
   [Unit]
   Description=uWSGI instance to serve test API
   After=network.target

   [Service]
   User=www-data
   Group=www-data
   WorkingDirectory=/srv/test-app
   Environment="PATH=/srv/test-app/test-venv/bin"
   ExecStart=/srv/test-app/test-venv/bin/uwsgi --ini test-app.ini

   [Install]
   WantedBy=multi-user.target
   ```

1. Укажите настройки нового виртуального сервера в конфигурации Nginx, приведя файл `/etc/nginx/sites-available/test-app.conf` к следующему виду:

   ```nginx
   #/etc/nginx/sites-available/test-app.conf
   server {
       #server_name test-app.yandex www.test-app.yandex;

       listen 80;

       location /test/ {
           include uwsgi_params;
           uwsgi_param SCRIPT_NAME /test;
           uwsgi_modifier1 30;
           uwsgi_pass unix:/srv/test-app/test-app.sock;
       }
   }
   ```

1. Создайте символическую ссылку, указывающую на конфигурационный файл Nginx `test-app.conf`:

   ```bash
   sudo ln -s /etc/nginx/sites-available/test-app.conf /etc/nginx/sites-enabled/
   ```

1. Удалите символическую ссылку, указывающую на конфигурацию Nginx по умолчанию:

   ```bash
   sudo unlink /etc/nginx/sites-enabled/default
   ```

1. Добавьте сервис в список автозапуска системы:

   ```bash
   sudo systemctl enable test-app.service
   ```

## Проверьте работу тестового приложения {#test-app}

Чтобы убедиться, что тестовое приложение работает, а веб-сервер настроен верно, выполните простой запрос.
1. В строке браузера введите URL для проверки работы веб-сервера и приложения:

   ```http
   http://<публичный_IP-адрес_ВМ>/test/?text=hello_world
   ```

1. Если все выполнено верно, на экране отобразится текст с перевернутыми словами из параметра `text`.

## Подготовьте снимок диска виртуальной машины {#create-snapshot}

Чтоб легко переносить созданное приложение и конфигурацию веб-сервера на создаваемые с помощью CI ВМ, нужно сделать снимок диска тестовой ВМ.
1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите каталог, в котором создана ВМ.
1. Выберите сервис **{{ compute-name }}**.
1. Найдите ВМ `ci-tutorial-test-app` и выберите ее.
1. Нажмите кнопку **Остановить**.
1. В открывшемся окне нажмите кнопку **Остановить**.
1. После остановки ВМ выберите вкладку **Диски**.
1. В строке диска нажмите кнопку ![vertical-ellipsis](../../_assets/vertical-ellipsis.svg) и выберите пункт **Создать снимок**.
1. В открывшемся окне введите имя снимка: `test-app-snap`.
1. Нажмите кнопку **Создать снимок**.

## Создайте виртуальную машину с {{ GL }} {#create-gitlab-vm}

Один из способов настроить CI в {{ yandex-cloud }} — воспользоваться публичным образом с предустановленной системой {{ GL }}. В {{ GL }} входит набор инструментов для управления репозиториями Git и средства для настройки CI.
1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
1. В поле **Имя** введите имя ВМ: `ci-tutorial-gitlab`.
1. Выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
1. В блоке **Выбор образа/загрузочного диска** перейдите на вкладку **{{ marketplace-name }}** и выберите образ [{{ GL }}](/marketplace/products/yc/gitlab).
1. В блоке **Вычислительные ресурсы** выберите следующую конфигурацию:
   * **Гарантированная доля vCPU** — 100%.
   * **vCPU** — 2.
   * **RAM** — 2 ГБ.
1. В блоке **Сетевые настройки** выберите, к какой подсети необходимо подключить ВМ при создании.
1. Укажите данные для доступа на ВМ:
   * В поле **Логин** введите имя пользователя.
   * В поле **SSH-ключ** скопируйте содержимое файла открытого ключа.

     Пару ключей для подключения по SSH необходимо [создать самостоятельно](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys). Для создания ключей используйте сторонние инструменты, например утилиты `ssh-keygen` в Linux и macOS или [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) в Windows.
1. Нажмите кнопку **Создать ВМ**.

Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING`, вы можете перейти к ее настройке.

При создании ВМ назначаются [IP-адрес и имя хоста (FQDN)](../../vpc/concepts/address.md). Эти данные можно использовать для доступа по SSH.

## Настройте {{ GL }} {#configure-gitlab}

Чтобы настроить {{ GL }} и подготовить процесс CI, создайте новый проект и введите параметры для авторизации в CI:
1. На странице сервиса {{ compute-name }} выберите созданную ВМ и скопируйте ее публичный IP-адрес.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Получите пароль администратора {{ GL }} с помощью команды ВМ:

   ```bash
   sudo cat /etc/gitlab/initial_root_password
   ```

1. Скопируйте пароль из строки `Password` (исключая пробелы) в буфер обмена или отдельный файл.
1. Откройте в браузере ссылку `http://<публичный IP-адрес ВМ>`. Откроется веб-интерфейс {{ GL }}.
1. Войдите в систему с учетной записью администратора:
   * **Username or email** — `root`.
   * **Password** — пароль, скопированный ранее.

   Если вы не можете войти, [сбросьте пароль учетной записи администратора](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password).
1. [Смените пароль учетной записи администратора](https://docs.gitlab.com/ee/user/profile/#change-your-password).
1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.
1. Выберите **Create a project**.
1. Задайте имя проекта: `gitlab-test`.
1. Нажмите кнопку **Create project**.
1. Получите OAuth-токен в сервисе Яндекс OAuth. Для этого перейдите по [ссылке]({{ link-cloud-oauth }}) и нажмите **Разрешить**.
1. Откройте в браузере ссылку вида `http://<публичный-IP-адрес-ВМ>/root`.
1. Выберите проект `gitlab-test`.
1. На открывшемся экране выберите слева вкладку **Settings**, а во всплывающем меню — **CI/CD**.
1. В разделе **Variables** нажмите кнопку **Expand**.
1. Создайте новую переменную:
   * В качестве имени переменной укажите `YC_OAUTH`.
   * В качестве значения переменной укажите полученный OAuth-токен.
   * Нажмите кнопку **Save variables**.
1. В разделе **Runners** нажмите кнопку **Expand**.
1. В разделе **Set up a specific Runner automatically** указан **адрес сервера** для подключения и **токен** для регистрации сервера в проекте. Используйте эти значения при регистрации Runner.

## Настройте Runner {#configure-runner}

Runner — это инструмент для выполнения задач, которые создает пользователь. Runner необходимо установить на ВМ и зарегистрировать его в {{ GL }}. Чтобы Runner мог выполнять задачи, подготовьте дополнительные компоненты — установите CLI {{ yandex-cloud }} и создайте тест для проверки созданной ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ с {{ GL }} по SSH:

   ```bash
   ssh <Логин>@<публичный_IP-адрес_ВМ_с_{{ GL }}>
   ```

1. Добавьте новый репозиторий в менеджер пакетов:

   ```bash
   curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   ```

1. Установите Runner, который будет выполнять скрипты вашего CI:

   ```bash
   sudo apt-get -y install gitlab-runner
   ```

1. Зарегистрируйте Runner:
   * На шаге `Please enter the gitlab-ci coordinator URL` укажите адрес сервера {{ GL }}.
   * На шаге `Please enter the gitlab-ci token for this runner` укажите токен Runner.
   * На шаге `Please enter the gitlab-ci description for this runner` введите описание `gitlab test runner`.
   * На шаге `Please enter the gitlab-ci tags for this runner` не вводите ничего, нажмите **Enter**.
   * На шаге `Please enter the executor` укажите `shell`.

   ```bash
   sudo gitlab-runner register
   Runtime platform                                    arch=amd64 os=linux pid=8197 revision=3afdaba6 version=11.5.0
   Running in system-mode.

   Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
   http://<IP-адрес-ci-gitlab>/
   Please enter the gitlab-ci token for this runner:
   <токен-Runner>
   Please enter the gitlab-ci description for this runner:
   [ci-tutorial-gitlab]: gitlab test runner
   Please enter the gitlab-ci tags for this runner (comma separated):

   Registering runner... succeeded                     runner=wZqzyy9s
   Please enter the executor: virtualbox, docker+machine, docker-ssh+machine, kubernetes, docker, docker-ssh, shell, ssh, parallels:
   shell
   Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
   ```

1. Чтобы скрипт CI мог создавать ВМ, установите CLI {{ yandex-cloud }}:

   ```bash
   curl https://{{ s3-storage-host }}{{ yc-install-path }} --output install.sh
   sudo bash install.sh -n -i /opt/{{ product }}
   ```

1. Для проведения функционального тестирования установите пакет `pytest`:

   ```bash
   sudo apt-get install python-pytest
   ```

1. Создайте файл `test.py` со скриптом для функционального тестирования:
   1. Откройте главную страницу репозитория `gitlab-test`.
   1. Нажмите кнопку **+** и выберите пункт **New file**.
   1. В открывшемся окне дайте файлу имя `test.py`.
   1. В тело файла скопируйте следующий код:

      ```python
      # test.py
      import pytest
      import json
      import socket as s

      @pytest.fixture
      def hostname(request):
          with open("instance-creation.out", "r") as fd:
              fqdn = json.loads(fd.read()).get("fqdn")

          return fqdn

      @pytest.fixture
      def socket(request):
          _socket = s.socket(s.AF_INET, s.SOCK_STREAM)
          def socket_teardown():
              _socket.close()
          request.addfinalizer(socket_teardown)
          return _socket

      def test_server_connect(socket, hostname):
          socket.connect((hostname, 80))
          assert socket
      ```

   1. Напишите любое сообщение коммита и нажмите кнопку **Commit changes**.

## Настройте CI {#configure-ci}

Для CI необходимо задать конфигурацию.
1. Откройте главную страницу репозитория `gitlab-test`:

   ```http
   http://<публичный_IP-адрес_ВМ_c_{{ GL }}>/root/gitlab-test
   ```

1. Нажмите кнопку **Set up CI/CD**. Откроется экран добавления нового файла.
1. {{ GL }} автоматически даст файлу имя `.gitlab-ci.yml` — не изменяйте его. Скопируйте в файл следующую конфигурацию:

   ```yaml
   #.gitlab-ci.yml
   stages:
     - build
     - test

   build:
     stage: build
     variables:
       snapshot_name: test-app-snap
       folder_id: <идентификатор-каталога>
       subnet_name: <имя-подсети>
     script:
       - export instance_name="ci-tutorial-test-app-$(date +%s)"
       - export PATH="/opt/{{ product }}/bin:${PATH}"
       - yc config set token $YC_OAUTH
       - yc compute instance create
         --format json
         --name $instance_name
         --folder-id $folder_id
         --zone {{ region-id }}-a
         --network-interface subnet-name=$subnet_name,nat-ip-version=ipv4
         --create-boot-disk name=$instance_name-boot,type=network-ssd,size=15,snapshot-name=$snapshot_name,auto-delete=true
         --memory 1
         --cores 1
         --hostname $instance_name > instance-creation.out
       - sleep 30
     artifacts:
       when: on_success
       paths:
       - instance-creation.out
       expire_in: 10 mins

   test_external:
     stage: test
     script:
       - py.test test.py > pytest-external.out
     artifacts:
       paths:
       - pytest-external.out
       expire_in: 1 hour
   ```

1. В поле `snapshot_name` укажите имя снимка первой ВМ.
   В поле `folder_id` укажите идентификатор каталога, в котором создаются ВМ.
   В поле `subnet_name` укажите имя подсети, к которой будут подключаться ВМ — имя можно получить в консоли управления, открыв нужный каталог и перейдя на страницу сервиса {{ vpc-name }}.
1. Нажмите кнопку **Commit changes**.

## Проверьте работу приложения на виртуальной машине, созданной с помощью CI {#test-new-vm}

После коммита необходимо убедиться в том, что CI отработал корректно. В нужной директории должна появиться новая ВМ, на которой развернуты тестовое приложение и веб-сервер.

Чтобы проверить созданную ВМ:
1. Откройте консоль управления {{ yandex-cloud }}.
1. В каталоге, где создавались ВМ, выберите сервис **{{ compute-name }}**.
1. Если все было настроено верно, в списке ВМ должна появиться новая ВМ с именем вида `ci-tutorial-test-app-1543910277`.
1. Выберите созданную ВМ и скопируйте публичный адрес созданной ВМ.
1. В браузере откройте ссылку вида:

   ```http
   http://<публичный_IP-адрес_созданной_ВМ>/test/?text=hello_world
   ```

1. Созданное на предыдущих шагах приложение должно работать и на созданной ВМ: возвращать перевернутые слова из параметра `text`.

### Удалите созданные ресурсы {#clear-out}

Если вам больше не нужны ВМ и образы:
* [Удалите созданные ВМ](../../compute/operations/vm-control/vm-delete.md).
* [Удалите созданные образы](../../compute/operations/image-control/delete.md).
