[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Пошаговые инструкции](../index.md) > DataSphere Notebook > Настроить создание ноутбуков по шаблону

# Настроить создание ноутбуков JupyterLab по шаблону

Чтобы создавать ноутбуки JupyterLab по шаблону, активируйте расширение JupyterLab-templates. Для этого:

1. Создайте папку `datasphere-templates` в корневой папке проекта.
1. В `datasphere-templates` создайте вложенную папку с произвольным именем, например `template-group-1`. В ней создайте шаблонный ноутбук с произвольным именем, например `template_notebook1.ipynb`.
1. Вы можете создать несколько шаблонов для разных случаев и группировать их в разных папках.

    Пример структуры папки `datasphere-templates` для хранения шаблонов JupyterLab:

    ```text
    datasphere-templates/
                         |
                         |_ template-group-1/
                         |                   |
                         |                   |_ template_notebook1.ipynb
                         |                   |_ template_notebook2.ipynb
                         |
                         |_ template-group-2/
                                             |
                                             |_ template_notebook3.ipynb
                                             |_ template_notebook4.ipynb
    ```

1. Обновите страницу браузера.
1. На главной странице JupyterLab в блоке **Notebook** появится кнопка **Template**. Нажмите на нее и выберите нужную папку и ноутбук.