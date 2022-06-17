Чтобы настроить {{ GL }} и подготовить процесс [непрерывной интеграции]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Непрерывная_интеграция){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Continuous_integration){% endif %} (Continuous integration, CI), создайте новый проект и введите параметры для авторизации в CI:
1. На странице сервиса {{ compute-full-name }} выберите созданную виртуальную машину и найдите ее публичный IP-адрес.
1. [Подключитесь к ВМ по SSH](../../compute/operations/vm-connect/ssh.md).
1. Чтобы узнать пароль пользователя `root` {{ GL }}, выполните команду:

   ```bash
   sudo cat /etc/gitlab/initial_root_password
   ```

1. Откройте в браузере ссылку `http://<публичный IP-адрес ВМ>`. Откроется административная панель {{ GL }}.
1. Введите логин `root` и пароль, полученный ранее. Нажмите кнопку **Sign in**.
1. Выберите **Create a project**.
1. Задайте имя проекта, например: `gitlab-test`.
1. Нажмите кнопку **Create project**.