# Удалить группу безопасности

Функция находится на [стадии Preview](../../overview/concepts/launch-stages.md).

{% note warning %}

Нельзя удалить группу безопасности, по умолчанию созданную в сети.

{% endnote %}

Чтобы удалить группу безопасности: 

{% list tabs %}

- Консоль управления

  1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется удалить группу безопасности.
  1. Откройте вкладку **Группы безопасности**. 
  1. Нажмите значок ![image](../../_assets/options.svg) в строке группы, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления групп безопасности:

      ```
      $ yc vpc security-group delete --help
      ```

  1. Получите список всех групп безопасности в каталоге по умолчанию:

      ```
      $ yc vpc security-group list
      +----------------------+-------------+-------------+----------------------+
      |          ID          |    NAME     | DESCRIPTION |      NETWORK-ID      |
      +----------------------+-------------+-------------+----------------------+
      | enpkf7dbjonf45gda6cd | test-sg-cli |             | enpgkbe17td89r34satu |
      +----------------------+-------------+-------------+----------------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Удалите сеть:

      ```
      $ yc vpc security-group delete test-sg-cli
      ```

- Terraform

  {% include [terraform-definition](../../_includes/solutions/terraform-definition.md) %}

  Подробнее о Terraform [читайте в документации](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы создавали группу безопасности с помощью Terraform, вы можете удалить ее:

   1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.
   2. Удалите ресурсы с помощью команды:
      ```
      $ terraform destroy
      ```
      
      {% note alert %}
      
      Terraform удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, виртуальные машины и т. д.
      
      {% endnote %}
    
    3. Подтвердите удаление ресурсов.

{% endlist %}