# Удалить HTTP-роутер

Чтобы удалить HTTP-роутер:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит HTTP-роутер.
  1. Выберите сервис **{{ alb-name }}**.
  1. Выберите роутер и нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
  1. В открывшемся меню выберите пункт **Удалить**.

      Чтобы выполнить это действие с несколькими HTTP-роутерами, выделите нужные в списке и нажмите кнопку **Удалить** в нижней части экрана.

  1. Подтвердите удаление.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления HTTP-роутера:
     ```
     yc alb http-router delete --help
     ```

  1. Выполните команду, указав имя HTTP-роутера:
     ```
     yc alb http-router delete --name <имя HTTP-роутера>
     ```

     Чтобы проверить удаление, получите список HTTP-роутеров, выполнив команду:
     ```
     yc alb http-router list
     ```

{% endlist %}
