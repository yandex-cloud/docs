В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** добавьте [целевую группу](../../network-load-balancer/concepts/target-resources.md):

1. Нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
1. Выберите целевую группу или [создайте новую](../../network-load-balancer/operations/target-group-create.md):

    1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** выберите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
    1. В открывшемся окне введите имя целевой группы.
    1. (Опционально) Задайте описание целевой группы и добавьте метки.
    1. Добавьте в целевую группу виртуальные машины.
    1. Нажмите **{{ ui-key.yacloud.common.create }}**.

1. {% include [configure-health-check](configure-health-check.md) %}