#### smart-web-security.user {#smart-web-security-user}

Роль `smart-web-security.user` предназначена для использования ресурсов {{ sws-name }} из других сервисов, например {{ alb-full-name }}. Пользователи с этой ролью могут:
* выполнять все действия, входящие в роль [smart-web-security.viewer](#smart-web-security-viewer);
* использовать ресурсы {{ sws-name }}.

Выдать роль может пользователь с ролью [admin](#admin) в облаке или [smart-web-security.admin](#smart-web-security-admin) в каталоге.
