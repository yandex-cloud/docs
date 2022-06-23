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
1. Активируйте ваш инстанс {{ mgl-name }}:
   1. Перейдите по ссылке, полученной на электронную почту администратора при регистрации инстанса.
   1. Измените пароль для администратора.
   1. Авторизуйтесь с помощью логина и пароля администратора.
1. [Создайте группу](https://docs.gitlab.com/ee/ssh/#add-an-ssh-key-to-your-gitlab-account), в которой будет размещен ваш проект.
1. [Создайте пользователя](https://docs.gitlab.com/ee/user/profile/account/create_accounts.html) и [добавьте его в группу](https://docs.gitlab.com/ee/user/group/#add-users-to-a-group).
1. Создайте SSH-ключ и [присвойте его аккаунту пользователя](https://docs.gitlab.com/ee/ssh/#add-an-ssh-key-to-your-gitlab-account).
1. [Создайте пустой проект](https://docs.gitlab.com/ee/user/project/working_with_projects.html#blank-projects), в котором будет размещен ваш репозиторий.

## Начните работу с репозиторием {#start-work-with-git}

В этом разделе вы узнаете, как начать работу с локальной копией вашего репозитория. Выполните эти действия на локальном компьютере:
1. [Установите клиент Git](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#install-git).
1. [Клонируйте репозиторий](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-a-repository) на локальный компьютер.
1. Начните работу с репозиторием. Создайте файл `README.md`, и сохраните его в каталоге с репозиторием:

   ```bash
   echo "This is my new project" > README.md
   ```

1. Добавьте файл в репозиторий с помощью команды:

   ```bash
   git add README.md
   ```

1. Примените изменения в локальном репозитории с помощью команды:

   ```bash
   git commit -m "Add README.md"
   ```

   Подробнее см. в [документации {{ GL}}](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#add-and-commit-local-changes).
1. [Передайте изменения](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#add-and-commit-local-changes) в {{ mgl-name }}:

   ```bash
   git push origin master
   ```