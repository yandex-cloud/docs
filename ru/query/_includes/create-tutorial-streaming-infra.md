1. Создайте соединение:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать соединение.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
    1. На панели слева выберите ![study](../../_assets/console-icons/graduation-cap.svg) **{{ ui-key.yql.yq-navigation.tutorial.menu-text }}**.
    1. Перейдите в **{{ ui-key.yql.yq-tutorial.tutorial-type-toggle.option-streaming }}** раздел.
    1. В блоке **{{ ui-key.yql.yq-tutorial.create-tutorial-infrastructure.label }}** нажмите кнопку **{{ ui-key.yql.yq-tutorial.create-connection.button-label }}**.
    1. В открывшемся окне в блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}** выберите базу данных и сервисный аккаунт, созданные ранее.
    1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

1. Создайте [привязку к данным](../concepts/glossary.md):

    1. Откроется страница для создания привязки к данным.
    1. В блоке **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}** выберите поток `yellow-taxi`, созданный ранее.
    1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.
