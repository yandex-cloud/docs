---
title: "Как начать работать с {{ mgl-full-name }}"
description: "Следуя данной инструкции, вы сможете создать и настроить кластер {{ GL }}."
---

# Как начать работать с {{ mgl-name }}

Чтобы начать работу с сервисом:
1. [Создайте инстанс](#instance-create).
1. [Настройте рабочее окружение](#configure-mgl).
1. [Начните работу с репозиторием](#start-work-with-git).

## Перед началом работы {#before-you-begin}

{% list tabs %}

- Консоль управления

  1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
  1. Если у вас еще нет каталога, создайте его:

     {% include [create-folder](../_includes/create-folder.md) %}

{% endlist %}

## Создайте инстанс {#instance-create}

{% list tabs %}

- Консоль управления

  {% include [instance-create-console](../_includes/managed-gitlab/instance-create-console.md) %}

{% endlist %}

## Настройте рабочее окружение {#configure-mgl}

В этом разделе вы узнаете, как подготовить инстанс {{ mgl-name }} к работе.
1. [Настройте группу безопасности по умолчанию](operations/connect.md#configuring-security-groups) для облачной сети так, чтобы был разрешен весь необходимый трафик.
1. Активируйте ваш инстанс {{ mgl-name }}:
   1. Перейдите по ссылке, полученной на электронную почту администратора при регистрации инстанса.
   1. Измените пароль для администратора.
   1. Авторизуйтесь с помощью логина и пароля администратора.
1. [Создайте группу](https://docs.gitlab.com/ee/user/group/#create-a-group), в которой будет размещен ваш проект.
1. [Создайте пользователя](https://docs.gitlab.com/ee/user/profile/account/create_accounts.html) и [добавьте его в группу](https://docs.gitlab.com/ee/user/project/members/#add-users-to-a-project) с ролью `Maintainer` или `Owner`.
1. [Создайте SSH-ключ](https://docs.gitlab.com/ee/user/ssh.html) и [присвойте его аккаунту пользователя](https://docs.gitlab.com/ee/ssh/#add-an-ssh-key-to-your-gitlab-account).
1. [Создайте пустой проект](https://docs.gitlab.com/ee/user/project/), в котором будет размещен ваш репозиторий.

## Начните работу с репозиторием {#start-work-with-git}

В этом разделе вы узнаете, как начать работу с локальной копией вашего репозитория от имени созданного пользователя. Выполните эти действия на локальном компьютере:
1. [Установите клиент Git](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#install-git).
1. [Клонируйте репозиторий](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-a-repository) на локальный компьютер.
1. Перейдите в каталог с репозиторием:

   ```bash
   cd <имя_проекта>
   ```

1. Создайте файл `README.md`:

   ```bash
   echo "This is my new project" > README.md
   ```

1. Проиндексируйте файл `README.md`:

   ```bash
   git add README.md
   ```

1. Примените изменения в локальном репозитории с помощью команды:

   ```bash
   git commit -m "Add README.md"
   ```

   Подробнее см. в [документации {{ GL }}](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#add-and-commit-local-changes).

1. [Передайте изменения](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#send-changes-to-gitlabcom) в {{ mgl-name }}:

   ```bash
   git push origin main
   ```
