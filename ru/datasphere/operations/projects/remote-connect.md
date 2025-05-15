# Подключение к {{ jlab }}Lab проекта из локальной IDE

{{ ml-platform-name }} позволяет работать с проектом из любой локальной IDE, если она поддерживает работу с удаленными серверами {{ jlab }}. По умолчанию эта возможность выключена, администратор сообщества может включить ее в [настройках сообщества](../community/manage-community-config.md).

{% note info %}

Для включения возможности работы с удаленной IDE в сообществе у вас должна быть [роль](../../security/index.md#roles-list) `{{ roles-datasphere-communities-admin }}`. Получить ссылку для подключения к проекту из IDE может только пользователь с ролью `{{ roles-datasphere-project-developer }}` или выше.

{% endnote %}

Подключение к проекту на примере [Visual Studio Code](https://code.visualstudio.com/):

1. {% include [include](../../../_includes/datasphere/ui-find-community.md) %}
1. Выберите сообщество, в котором находится ваш проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.restrictions }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.restrictions.project-mode }}** включите опцию **{{ ui-key.yc-ui-datasphere.restrictions.JUPYTER_TOKEN }}**.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.projects }}** и выберите ваш проект.
1. В настройках проекта в блоке **{{ ui-key.yc-ui-datasphere.common.general }}** нажмите **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.external-ide.external-ide-vm-configuration }}** выберите [конфигурацию ВМ](../../concepts/configurations.md) и нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь загрузки проекта.
1. В правом верхнем углу нажмите **Поделиться** ⟶ **Ссылка для внешней IDE**.
1. Нажмите **Копировать ссылку**.
1. Откройте файл формата `ipynb` в Visual Studio Code.
1. В правом верхнем углу нажмите на кнопку со своей версией Python.
1. На открывшейся панели выберите **Select Notebook Kernel** ⟶ **Existing {{ jlab }} Server**.
1. Вставьте полученную ссылку и нажмите **Enter** на клавиатуре.

После подключения все вычисления будут запускаться в {{ ml-platform-name }}. Запущенная ВМ будет работать до тех пор, пока вы не остановите ее в интерфейсе {{ ml-platform-name }}.
