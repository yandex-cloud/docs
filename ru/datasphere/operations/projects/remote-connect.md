# Подключение к {{ jlab }}Lab проекта из локальной IDE

{{ ml-platform-name }} позволяет работать с проектом, запущенным в режиме [{{ dd }}](../../concepts/project.md#dedicated), из любой локальной IDE, если она поддерживает работу с удаленными серверами {{ jlab }}.

{% note info %}

Получить ссылку для подключения к проекту из IDE может только пользователь с [ролью](../../security/index.md#roles-list) `{{ roles-datasphere-project-developer }}` или выше.

{% endnote %}

Подключение к проекту на примере [Visual Studio Code](https://code.visualstudio.com/):

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}

1. Запустите проект в режиме {{ dd }}. В настройках проекта необходимо выбрать [конфигурацию ВМ](../../concepts/configurations.md) для удаленного подключения.

1. В правом верхнем углу нажмите **Поделиться** ⟶ **Ссылка для внешней IDE**.

1. Нажмите **Копировать ссылку**.

1. Откройте ноутбук в Visual Studio Code.

1. В правом верхнем углу нажмите **Select Notebook Kernel** ⟶ **Existing {{ jlab }} Server**.

1. Вставьте ссылку и нажмите **Enter** на клавиатуре. 

После подключения все вычисления будут запускаться в {{ ml-platform-name }}. Запущенная ВМ будет работать до тех пор, пока вы не остановите ее в интерфейсе {{ ml-platform-name }}.
