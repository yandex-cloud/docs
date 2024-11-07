# Подключение к серийной консоли виртуальной машины по SSH

{% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

После [включения доступа](./index.md), вы можете подключиться к серийной консоли для взаимодействия с [ВМ](../../concepts/vm.md). Перед [подключением](../../../glossary/ssh-keygen.md) к серийной консоли внимательно ознакомьтесь с разделом [{#T}](#security).

## Безопасность {#security}

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

Важным моментом при удаленном доступе является защита от [атак посредника (MITM-атак)](https://ru.wikipedia.org/wiki/Атака_посредника). Защититься от MITM-атак можно, используя шифрование между клиентом и сервером.

Установить безопасное подключение можно следующими способами:
* Вы можете скачивать текущий [SHA256 Fingerprint](https://{{ s3-storage-host }}/cloud-certs/serialssh-fingerprint.txt) (отпечаток) SSH-ключа перед каждым подключением к ВМ.

  При первом подключении к ВМ клиент сообщает отпечаток SSH-ключа и ожидает решения по установке соединения:
  * `YES` — установить соединение.
  * `NO` — отказаться.

  Убедитесь, что отпечаток по ссылке совпадает с отпечатком, полученным от клиента.
* Вы можете скачивать публичный [SSH-ключ](https://{{ s3-storage-host }}/cloud-certs/serialssh-knownhosts) хоста перед каждым подключением к серийной консоли.

  Используйте полученный публичный SSH-ключ при подключении к серийной консоли.

  Рекомендуемые параметры запуска:

  ```bash
  ssh -o ControlPath=none -o IdentitiesOnly=yes -o CheckHostIP=no -o StrictHostKeyChecking=yes -o UserKnownHostsFile=./serialssh-knownhosts -p 9600 -i ~/.ssh/<имя_закрытого_SSH-ключа> <идентификатор_ВМ>.<имя_пользователя>@{{ serial-ssh-host }}
  ```

  Публичный SSH-ключ хоста в будущем может быть изменен.

Чаще сверяйтесь с указанными файлами. Скачивайте данные файлы только по протоколу HTTPS, предварительно убедившись в валидности сертификата сайта `https://{{ s3-storage-host }}`. Если из-за проблем с сертификатом сайт не может обеспечить безопасное шифрование ваших данных, браузер предупреждает об этом.

## Подключиться к серийной консоли {#connect-to-serial-console}

{% note info %}

Работа серийной консоли зависит от настроек используемой операционной системы. Сервис {{ compute-name }} обеспечивает канал между пользователем и COM-портом ВМ и не гарантирует стабильность работы консоли со стороны ОС.

{% endnote %}

Для подключения к ВМ необходимо знать ее идентификатор. Как получить идентификатор ВМ читайте в разделе [{#T}](../vm-info/get-info.md).

Дальнейший порядок действий по подключению зависит от того, включен ли для ВМ доступ по [{{ oslogin }}](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по {{ oslogin }}, подключиться к серийной консоли можно с использованием экспортированного SSH-сертификата. Для подключения к ВМ с выключенным доступом по {{ oslogin }} используются [SSH-ключи](../../../glossary/ssh-keygen.md).

Некоторые ОС могут запрашивать данные пользователя для доступа на ВМ. Поэтому перед подключением к серийной консоли таких ВМ необходимо создать локальный пароль пользователя.

{% list tabs %}

- С SSH-ключом

  1. Создайте локальный пароль пользователя на ВМ:
      1. [Подключитесь](../vm-connect/ssh.md) к ВМ по SSH.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Отключитесь от ВМ. Для этого введите команду `logout`.

  1. Подключитесь к ВМ.

      Пример команды подключения:

      ```bash
      ssh -t -p 9600 -o IdentitiesOnly=yes -i <путь_к_закрытому_SSH-ключу> <идентификатор_ВМ>.<имя_пользователя>@{{ serial-ssh-host }}
      ```

      Где: 
      * `путь_к_закрытому_SSH-ключу` — путь к закрытой части [SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), полученного при [создании ВМ](../vm-create/create-linux-vm.md).
      * `идентификатор_ВМ` — идентификатор виртуальной машины. Как получить идентификатор ВМ читайте в разделе [{#T}](../vm-info/get-info.md).
      * `имя_пользователя` — имя администратора, указанное при создании ВМ.

      ```bash
      ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519 fhm0b28lgfp4********.yc-user@{{ serial-ssh-host }}
      ```

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

- С SSH-сертификатом по {{ oslogin }}

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте локальный пароль пользователя на ВМ:
      1. [Подключитесь](../vm-connect/os-login.md) к ВМ по {{ oslogin }}.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Отключитесь от ВМ. Для этого введите команду `logout`.

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}

  1. [Экспортируйте](../vm-connect/os-login-export-certificate.md) сертификат {{ oslogin }}, указав [идентификатор](../../../organization/operations/organization-get-id.md) вашей организации:

      ```bash
      yc compute ssh certificate export \
        --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      Identity: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername
      Certificate: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername-cert.pub
      ```

      Экспортированный сертификат действителен один час.

  1. Подключитесь к ВМ.

      Пример команды подключения:

      ```bash
      ssh -t -p 9600 -i <путь_к_SSH-сертификату> <идентификатор_ВМ>.<логин_пользователя_OS_Login>@{{ serial-ssh-host }}
      ```

      Где:
      * `<путь_к_SSH-сертификату>` — путь к экспортированному SSH-сертификату, значение поля `Identity`.
      * `<идентификатор_ВМ>` — идентификатор виртуальной машины, к серийной консоли которой требуется подключиться.
      * `<имя_пользователя_OS_Login>` — идентификатор пользователя {{ oslogin }} в организации. Логин пользователя {{ oslogin }} указан в конце имени экспортированного сертификата после [идентификатора](../../../organization/operations/organization-get-id.md) организации.

          Также логин пользователя можно получить с помощью команды `yc organization-manager os-login profile list` [{{ yandex-cloud }} CLI](../../../cli/cli-ref/managed-services/organization-manager/oslogin/profile/list.md) или в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) в профиле пользователя на вкладке **{{ ui-key.yacloud_org.page.user.title_tab-os-login }}**.

          {% include [os-login-profile-tab-access-notice](../../../_includes/organization/os-login-profile-tab-access-notice.md) %}

      Пример для пользователя с логином `yid-orgusername` и ВМ с идентификатором `epd22a2tj3gd********`:

      ```bash
      ssh -p 9600 -i /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername epd22a2tj3gd********.yid-orgusername@{{ serial-ssh-host }}
      ```

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

{% endlist %}

Вы также можете подключиться к серийной консоли с помощью [SSH-ключей для других пользователей](../vm-connect/ssh.md#vm-authorized-keys).


### Решение проблем {#troubleshooting}

* Если после подключения к серийной консоли на экране ничего не отображается:
  * Нажмите на клавиатуре клавишу **Enter**.
  * Перезапустите ВМ (для ВМ, созданных до 22 февраля 2019 года).
* Если при подключении с помощью SSH-ключа возникает ошибка `Warning: remote host identification has changed!`, выполните команду `ssh-keygen -R <IP-адрес_ВМ>`.
* Если при подключении с помощью SSH-сертификата возникает ошибка `Permission denied (publickey).`, убедитесь, что для ВМ включена авторизация по {{ oslogin }} при подключении к серийной консоли, а сертификат — не просрочен. При необходимости включите для ВМ авторизацию по {{ oslogin }} при подключении к серийной консоли или повторно экспортируйте SSH-сертификат.

## Отключиться от серийной консоли {#turn-off-serial-console}

Чтобы отключиться от серийной консоли:
1. Нажмите на клавиатуре клавишу **Enter**.
1. Введите последовательно символы `~.`.