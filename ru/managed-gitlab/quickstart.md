---
title: Как начать работать с {{ mgl-full-name }}
description: Следуя данной инструкции, вы сможете создать и настроить кластер {{ GL }}.
---

# Как начать работать с {{ mgl-name }}

Чтобы начать работу с сервисом:
1. [Создайте инстанс](#instance-create).
1. [Настройте рабочее окружение](#configure-mgl).
1. [Добавьте SSH-ключи в {{ GL }}](#ssh).
1. [Начните работу с репозиторием](#start-work-with-git).

{% note warning %}

Если вы начинаете работу с {{ mgl-name }}, чтобы перенести в него проекты из пользовательской инсталляции {{ GL }}, обратитесь к [инструкции](operations/instance/migration.md).

{% endnote %}

Подробнее об отличиях {{ mgl-name }} от пользовательской инсталляции {{ GL }} Community Edition читайте в разделе [Преимущества сервиса перед пользовательской инсталляцией {{ GL }}](concepts/managed-gitlab-vs-custom-installation.md).

## Перед началом работы {#before-you-begin}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
  1. Если у вас еще нет каталога, создайте его:

     {% include [create-folder](../_includes/create-folder.md) %}

  1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) и роль [{{ roles.gitlab.editor }} или выше](security/index.md#roles-list). Эти роли позволяют создать инстанс.

      {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

  1. [Настройте](operations/configure-security-group.md) группу безопасности по умолчанию для обеспечения доступа к инстансу {{ mgl-name }}.

      {% note warning %}

      От настройки группы безопасности зависит работоспособность и доступность инстанса {{ mgl-name }}.

      {% endnote %}

{% endlist %}

## Создайте инстанс {#instance-create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [instance-create-console](../_includes/managed-gitlab/instance-create-console.md) %}

{% endlist %}

{% include [HTTPS info](../_includes/managed-gitlab/note-https.md) %}

## Настройте рабочее окружение {#configure-mgl}

1. Активируйте инстанс {{ mgl-name }}:
   1. Перейдите по ссылке, полученной на электронную почту администратора после создания инстанса.
   1. Измените пароль администратора.
   1. Авторизуйтесь с помощью логина и пароля администратора.
1. (Опционально) [Создайте группу](https://docs.gitlab.com/ee/user/group/#create-a-group), в которой будет размещен проект с репозиторием.

   Если есть несколько проектов, удобно объединять пользователей в группы. Это позволяет:

   * предоставлять права в определенные проекты каждой группе;
   * просматривать Issues и мерж-реквесты по группам;
   * просматривать аналитику по активности группы.

   Подробнее см. в [документации {{ GL }}](https://docs.gitlab.com/ee/user/group/).

1. [Создайте пустой проект](https://docs.gitlab.com/ee/user/project/), в котором будет размещен репозиторий.
1. [Создайте пользователей и добавьте](operations/create-user.md) их в группу или проект с ролью `Maintainer` или `Owner`.

   Добавить членов вашей команды в группу или проект можно, только создав для них аккаунты в {{ GL }}.

## Добавьте SSH-ключи в {{ GL }} {#ssh}

1. Создайте пару из открытого и закрытого SSH-ключей для аккаунта в {{ GL }}:

   {% include [vm-ssh-prepare-key](../_includes/vm-ssh-prepare-key.md) %}

1. {% include [turn-on-ssh-agent](../_includes/turn-on-ssh-agent.md) %}
1. Добавьте ключ в SSH-агент:

   ```bash
   ssh-add <путь_к_закрытому_ключу>
   ```

1. [Присвойте публичный SSH-ключ](https://docs.gitlab.com/ee/user/ssh.html#add-an-ssh-key-to-your-gitlab-account) аккаунту в {{ GL }}.
1. Проверьте, что вы можете подключиться к {{ GL }}:

   ```bash
   ssh -T git@<домен_инстанса_{{ GL }}>
   ```

   Пример:

   ```bash
   ssh -T git@example.gitlab.yandexcloud.net
   ```

   Если вы подключаетесь в первый раз, отобразится подобное сообщение:

   ```text
   The authenticity of host 'gitlab.example.com (35.231.145.151)' can't be established.
   ECDSA key fingerprint is SHA256:HbW3g8zUjNSksFbqTiUWPWg2Bq1x8xdGUrliXFzSnUw.
   Are you sure you want to continue connecting (yes/no)? yes
   Warning: Permanently added 'gitlab.example.com' (ECDSA) to the list of known hosts.
   ```

   Введите `yes` и нажмите **Enter**.

   Если вы подключаетесь не в первый раз, в случае успеха появится сообщение:

   ```text
   Welcome to GitLab, @<логин>!
   ```

   В случае ошибки запустите подключение в режиме Verbose, чтобы получить логи:

   ```bash
   ssh -Tvvv git@<домен_инстанса_{{ GL }}>
   ```

Попросите каждого участника вашей группы или проекта создать пару SSH-ключей таким образом и присвоить публичный ключ своему аккаунту в {{ GL }}.

## Начните работу с репозиторием {#start-work-with-git}

Чтобы начать работу с локальной копией вашего репозитория от имени созданного аккаунта, выполните следующие действия на локальном компьютере:

1. [Установите клиент Git](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#install-git).
1. [Клонируйте репозиторий](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-a-repository) по протоколу SSH.

   {% cut "Что делать в случае ошибки `Permission denied (publickey)`" %}

   При клонировании может возникнуть ошибка:

   ```text
   Cloning into '<название_проекта>'...
   git@<домен_инстанса_{{ GL }}>: Permission denied (publickey).
   fatal: Could not read from remote repository.

   Please make sure you have the correct access rights
   and the repository exists.
   ```

   Если вы получили такую ошибку:

   1. Создайте и откройте конфигурационный файл для настройки SSH-ключей:

      ```bash
      nano ~/.ssh/config
      ```

   1. Добавьте в него содержимое:

      ```bash
      Host <домен_инстанса_{{ GL }}>
         IdentityFile <путь_к_закрытому_ключу>
      ```

      В параметре `IdentityFile` укажите абсолютный путь к закрытому ключу, который вы создали для проекта {{ GL }}.

   1. Сохраните файл.
   1. Снова склонируйте репозиторий по SSH.

   {% endcut %}

1. Перейдите в каталог с репозиторием:

   ```bash
   cd <имя_проекта>
   ```

1. Внесите изменения в файлы репозитория.
1. [Проиндексируйте и примените изменения](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#add-and-commit-local-changes) в локальном репозитории:

   ```bash
   git add . && git commit -m "<название_коммита>"
   ```

1. Отправьте изменения в удаленный репозиторий:

   ```bash
   git push origin main
   ```
