### Настройте безопасное SSH-подключение к тестовой ВМ через промежуточную ВМ {#setup-ssh-connection}

1. На вашем локальном компьютере в любом текстовом редакторе откройте файл `~/.ssh/config`. Если такого файла не существует, создайте его.

    Тильда (`~`) в пути означает домашний каталог пользователя (например, `/home/user` в Linux или `C:\Users\user` в Windows).
1. Добавьте в файл `~/.ssh/config` следующие правила подключения:

    {% note info %}

    Если текущий файл `~/.ssh/config` содержит раздел `Host *` с общими правилами подключения, новые правила необходимо добавить перед этим разделом.

    {% endnote %}

    ```text
    Host jump-vm
        HostName <публичный_IP-адрес_промежуточной_ВМ>
        User yc-user
        IdentityFile <локальный_путь_к_закрытому_SSH-ключу>
        IdentitiesOnly yes
        ForwardAgent no

    Host cr-private-vm
        HostName 192.168.10.20
        User yc-user
        IdentityFile <локальный_путь_к_закрытому_SSH-ключу>
        IdentitiesOnly yes
        ProxyJump jump-vm
        ForwardAgent no
    ```

    Где:

    * `<публичный_IP-адрес_промежуточной_ВМ>` — публичный IP-адрес ВМ `jump-vm`, который можно узнать в поле **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** сетевого интерфейса в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}/link/compute) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md) `yc compute instance get jump-vm`.
    * `<локальный_путь_к_закрытому_SSH-ключу>` — локальный путь к закрытой части SSH-ключа, который вы указали при создании виртуальных машин. Например: `~/.ssh/id_ed25519`.
1. Настройте необходимые права доступа к созданному файлу конфигурации. Способ настройки зависит от операционной системы вашего компьютера:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux}

      В терминале выполните команду:

      ```bash
      chmod 600 ~/.ssh/config
      ```

    - Windows (PowerShell) {#windows}

      В терминале PowerShell выполните команды:

      ```powershell
      icacls "$env:USERPROFILE\.ssh\config" /inheritance:r
      icacls "$env:USERPROFILE\.ssh\config" /grant:r "$($env:USERNAME):(R,W)"
      ```

    {% endlist %}

### Подключитесь к тестовой виртуальной машине {#connect-to-test-vm}

1. Чтобы подключиться к тестовой виртуальной машине через промежуточную ВМ, в терминале вашего локального компьютера выполните команду:

    ```bash
    ssh cr-private-vm
    ```

    Результат:

    ```text
    The authenticity of host '51.250.***.*** (51.250.***.***)' can't be established.
    ED25519 key fingerprint is: SHA256:C/+mc/qPAhH6ls2NhwSNyYZoRziZ8GOd3z5********
    This key is not known by any other names.
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

1. Дважды разрешите подключение (введите `yes` и нажмите `ENTER`).

    Результат:

    ```bash
    yc-user@cr-private-vm:~$
    ```

### Проверьте работу DNS и убедитесь, что на тестовой ВМ нет доступа в интернет {#check-internet-connection}

В терминале тестовой виртуальной машины выполните действия:

1. Проверьте разрешение DNS-имен во [внутренней DNS-зоне](../../../dns/concepts/dns-zone.md#private-zones):

    ```bash
    getent ahostsv4 registry.yandexcloud.net | awk '{print $1}' | sort -u
    getent ahostsv4 storage.yandexcloud.net | awk '{print $1}' | sort -u
    ```

    Результат:

    ```text
    192.168.10.11
    192.168.10.10
    ```
1. Убедитесь, что публичные сайты недоступны:

    ```bash
    curl --connect-timeout 5 --max-time 10 https://yandex.ru
    ```

    Если все настроено правильно, команда должна завершиться ошибкой:

    ```text
    curl: (28) Failed to connect to yandex.ru port 443 after 4427 ms: Connection timed out
    ```

### Аутентифицируйтесь в {{ cloud-registry-name }} {#authenticate-in-cr}

В терминале тестовой виртуальной машины выполните действия:

1. Через [сервис метаданных](../../../compute/concepts/vm-metadata.md#metadata-formats) ВМ получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта `cr-pusher`, который привязан к ВМ:

    ```bash
    IAM_TOKEN="$(
      curl --silent --fail \
        --header Metadata-Flavor:Google \
        http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token \
      | sed -n 's/.*"access_token"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'
    )"
    ```
1. Убедитесь, что IAM-токен успешно получен и сохранен в переменную:

    ```bash
    if test -n "$IAM_TOKEN"; then
      echo "IAM-токен получен"
    else
      echo "Не удалось получить IAM-токен из метаданных" >&2
      exit 1
    fi
    ```

    Результат:

    ```text
    IAM-токен получен
    ```
1. Аутентифицируйтесь в {{ cloud-registry-name }} с помощью полученного IAM-токена:

    ```bash
    printf '%s' "$IAM_TOKEN" | docker login \
      --username iam \
      --password-stdin \
      registry.yandexcloud.net
    ```

    Результат:

    ```text
    ...
    Login Succeeded
    ```
1. Удалите переменную с IAM-токеном:

    ```bash
    unset IAM_TOKEN
    ```

### Соберите локальный Docker-образ {#compile-image}

На тестовой виртуальной машине отсутствует доступ в интернет, поэтому скачать классический пример тестового образа `hello-world` из [Docker Hub](https://hub.docker.com/) не получится.

Вместо этого в целях тестирования вы соберете локальный Docker-образ с использованием статического исполняемого файла [busybox](https://www.busybox.net/) с набором утилит для Linux. Этот файл доступен в образе {{ coi }}, из которого создана тестовая виртуальная машина.

В терминале тестовой виртуальной машины выполните действия:

1. Создайте локальный Docker-образ:

    ```bash
    mkdir -p /tmp/img/bin && cd /tmp/img
    cp $(which busybox) bin/busybox
    tar -cf rootfs.tar bin/busybox
    docker import rootfs.tar my-busybox:latest
    ```

    Результат:

    ```text
    sha256:137a8aff429ba2f8445450f8d063c2db394496d7a0e683555a573ab8********
    ```
1. Запустите локальный Docker-образ, чтобы убедиться в его работоспособности:

    ```bash
    docker run --rm my-busybox:latest /bin/busybox echo "Hello offline"
    ```

    Результат:

    ```text
    Hello offline
    ```

### Загрузите Docker-образ в реестр {#push-image}

В терминале тестовой виртуальной машины выполните действия:

1. Получите список доступных Docker-образов:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
    my-busybox    latest    137a********   18 minutes ago   2.19MB
    ```
1. Присвойте Docker-образу URL вида, в котором его можно загрузить в реестр {{ cloud-registry-name }}:

    ```bash
    docker tag my-busybox:latest \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Где `<идентификатор_реестра>` — идентификатор реестра {{ cloud-registry-name }}, который вы создали ранее. Получить идентификатор реестра вы можете в [консоли управления]({{ link-console-main }}/link/cloud-registry) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/cloud-registry/cli-ref/registry/list.md) `yc cloud-registry registry list`.
1. Загрузите собранный образ `my-busybox` в ваш реестр {{ cloud-registry-name }}:

    ```bash
    docker push \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Результат:

    ```text
    The push refers to repository [registry.yandexcloud.net/cn1tsdfufbue********/my-busybox]
    a7c1********: Pushed 
    latest: digest: sha256:2ab6804ba443d3621bf4be33f19c576775c59eef7e059da5735a0fcb******** size: 527
    ```

### Скачайте Docker-образ из реестра {#pull-image}

В терминале тестовой виртуальной машины выполните действия:

1. Получите список доступных Docker-образов:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY                                                 TAG       IMAGE ID       CREATED          SIZE
    my-busybox                                                 latest    137a********   25 minutes ago   2.19MB
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox   latest    137a********   25 minutes ago   2.19MB
    ```
1. Перед скачиванием удалите все имеющиеся локальные образы:

    ```bash
    docker rmi -f $(docker images -q)
    ```
1. Убедитесь, что локальных образов больше нет:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
    ```
1. Скачайте образ из реестра {{ cloud-registry-name }}:

    ```bash
    docker pull \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Результат:

    ```text
    latest: Pulling from cn1tsdfufbue********/my-busybox
    1391********: Pull complete 
    Digest: sha256:2ab6804ba443d3621bf4be33f19c576775c59eef7e059da5735a0fcb********
    Status: Downloaded newer image for registry.yandexcloud.net/cn1tsdfufbue********/my-busybox:latest
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox:latest
    ```
1. Убедитесь, что скачанный образ появился в локальном списке:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY                                                 TAG       IMAGE ID       CREATED          SIZE
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox   latest    137a********   33 minutes ago   2.19MB
    ```
1. Запустите скачанный Docker-образ, чтобы убедиться в его работоспособности:

    ```bash
    docker run --rm \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest /bin/busybox echo "Hello offline"
    ```

    Результат:

    ```text
    Hello offline
    ```

### Убедитесь в прохождении трафика через сервисные подключения {#check-traffic}

С помощью [метрик](../../../monium/metrics/quickstart-app.md) {{ monium-full-name }} убедитесь, что через сервисные подключения `storage-pe` и `cloud-registry-pe` при загрузке и скачивании Docker-образа проходил сетевой трафик:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Откройте [{{ monium-name }}]({{ link-monium }}) и на панели сверху выберите [проект каталога](*monium-folder-project), в котором находится ваша инфраструктура.
  
      Имя и идентификатор проекта {{ monium-name }}, в который выгружается телеметрия ресурсов в вашем каталоге, соответствуют имени и идентификатору этого каталога.
  1. На панели слева выберите ![compass](../../../_assets/console-icons/compass.svg) **Обзор**, затем ![rectangle-pulse](../../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
  1. В строке формирования запроса включите режим кода, нажав ![image](../../../_assets/console-icons/code.svg), и введите следующий запрос:

      ```json
      {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__private-endpoint__", name = "processed_bytes"}
      ```
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}**, переключите его в режим кода и введите еще один запрос:

      ```json
      {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__private-endpoint__", name = "processed_packets"}
      ```
  1. Включите опцию **{{ ui-key.yacloud_monitoring.wizard.one-graph-per-query.label }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
  1. Убедитесь, что на графиках отображается прохождение входящего и исходящего трафика через сервисные подключения в моменты времени, когда вы загружали Docker-образ в реестр и скачивали его из реестра.

      {% note tip %}

      Используйте шкалу времени в верхней части экрана, чтобы изменить или сместить в нужном направлении анализируемое окно времени.

      {% endnote %}

{% endlist %}

[*monium-folder-project]: {% include [folder-project](../../../_includes/monium/folder-project.md) %}