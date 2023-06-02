## Настройте {{ GL }} {#configure-gitlab}

Чтобы настроить {{ GL }} и подготовить процесс непрерывной интеграции ([Continuous Integration](/blog/posts/2022/10/ci-cd), CI), создайте новый проект и введите параметры для авторизации в CI:

{% list tabs %}

- Инстанс {{ mgl-name }}

  1. Авторизуйтесь в веб-интерфейсе [инстанса {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance).
  1. Нажмите кнопку **Create a project**.
  1. Нажмите кнопку **Create blank project**.
  1. Заполните поля:
     * **Project name** — `gitlab-test`.
     * **Project URL** — выберите пользователя-администратора в поле рядом с FQDN инстанса {{ mgl-name }}.

     Остальные поля оставьте без изменений.
  1. Нажмите кнопку **Create project**.

- Виртуальная машина с образом {{ GL }}

  1. На странице сервиса {{ compute-full-name }} выберите созданную [ВМ](../../compute/concepts/vm.md) и скопируйте ее [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
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
  1. [Смените пароль учетной записи администратора](https://docs.gitlab.com/ee/user/profile/user_passwords.html#change-your-password).
  1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.
  1. Выберите **Create a project**.
  1. Задайте имя проекта: `gitlab-test`.
  1. Нажмите кнопку **Create project**.

{% endlist %}