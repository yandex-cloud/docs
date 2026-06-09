# Мониторинг кластера {{ managed-k8s-full-name }} с помощью Filebeat OSS

# Мониторинг кластера с помощью Filebeat OSS


[Filebeat OSS](https://www.elastic.co/beats/filebeat) — плагин, который позволяет собирать и передавать логи в экосистему {{ OS }}. Filebeat устанавливается в [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), собирает логи кластера и [подов](../../managed-kubernetes/concepts/index.md#pod), а затем отправляет их в сервис [{{ mos-full-name }}](../../managed-opensearch/index.md).

Чтобы настроить мониторинг кластера {{ managed-k8s-name }} с помощью Filebeat OSS:

1. [Установите Filebeat OSS](#filebeat-oss-install).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

* Мастер {{ managed-k8s-name }} (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Узлы кластера {{ managed-k8s-name }}: использование вычислительных ресурсов и хранилища (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Кластер {{ mos-name }}: использование вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mos-name }}](../../managed-opensearch/pricing.md)).
* Публичные IP-адреса для хостов кластера {{ mos-name }} и узлов кластера {{ managed-k8s-name }}, если для них включен публичный доступ (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Перед началом работы {#before-you-begin}

1. Создайте кластер {{ managed-k8s-name }} и [группу узлов](../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и группа узлов.

     1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

   - {{ TF }} {#tf}

     1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Скачайте в ту же рабочую директорию файл конфигурации кластера {{ managed-k8s-name }} [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера {{ managed-k8s-name }} и группы узлов.
        * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера {{ managed-k8s-name }} и групп узлов.
        * CIDR кластера {{ managed-k8s-name }}.
        * Имя сервисного аккаунта. Оно должно быть уникальным в рамках [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
     1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

   {% endlist %}

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).
1. [Создайте кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-create.md) любой подходящей конфигурации.

## Установите Filebeat OSS {#filebeat-oss-install}

Установите Filebeat OSS согласно [инструкции](../../managed-kubernetes/operations/applications/filebeat-oss.md).

## Проверьте результат {#check-result}

Убедитесь, что логи кластера {{ managed-k8s-name }} поступают в кластер {{ mos-name }}:

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду:

  ```bash
  curl \
    --user admin:<пароль_пользователя_admin_кластера_Managed_Service_for_{{ OS }}> \
    --cacert CA.pem \
    --request GET 'https://<имя_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/_cat/indices?v'
  ```

- {{ OS }} Dashboards {#opensearch}

  1. Подключитесь к кластеру {{ mos-name }} с помощью [{{ OS }} Dashboards](../../managed-opensearch/operations/connect/clients.md#dashboards).
  1. Выберите общий тенант `Global`.
  1. Откройте панель управления, нажав на значок ![os-dashboards-sandwich](../../_assets/os-dashboards-sandwich.svg).
  1. В разделе **{{ OS }} Plugins** выберите **Index Management**.
  1. Перейдите в раздел **Indices**.

{% endlist %}

В списке должны быть индексы `filebeat-7.12.1-<дата_лога>` c логами кластера {{ managed-k8s-name }}.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать.

[Удалите кластер {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md).

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Удалите созданные подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
  1. [Удалите созданный сервисный аккаунт](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

  1. В терминале перейдите в директорию с планом инфраструктуры.
  
      {% note warning %}
  
      Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
  
      {% endnote %}
  
  1. Удалите ресурсы:
  
      1. Выполните команду:
  
          ```bash
          terraform destroy
          ```
  
      1. Подтвердите удаление ресурсов и дождитесь завершения операции.
  
      Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

{% endlist %}