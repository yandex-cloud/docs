# Привязать облако к платежному аккаунту

К [платежному аккаунту](../concepts/billing-account.md) можно привязать одно или несколько облаков. Привязывать можно как новые облака, так и уже существующие. Отвязать облако от платежного аккаунта нельзя, но вместо этого можно перепривязать его к другому платежному аккаунту.

Если платежный аккаунт добавлен в [организацию](../concepts/organization.md), то в сервисе Yandex Cloud Billing можно привязать к нему облака из своей организации и облака из других организаций, к которым был [выдан доступ](../../resource-manager/security/index.md).


Каждое облако в Yandex Cloud должно быть привязано только к одному платежному аккаунту. Перепривязывая существующее облако, вы переносите его с одного платежного аккаунта на другой. Для юридических лиц нельзя перепривязать облако и сервисы [DataSphere](../../datasphere/index.md), [Tracker](https://yandex.ru/support/tracker/ru) и [DataLens](../../datalens/index.md) с платного аккаунта на аккаунт в пробном периоде.

![image](../../_assets/billing/clouds-and-accounts.svg)

## Что нужно для привязки облака {#bind-roles}

Перед привязкой [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) убедитесь, что соблюдены следующие условия:
1. [Платежный аккаунт](../concepts/billing-account.md) прошел активацию (находится в [статусе](../concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`).
1. Пользователь обладает одновременно [ролями](../../iam/concepts/access-control/roles.md):
   * [resource-manager.clouds.owner](../../resource-manager/security/index.md#resource-manager-clouds-owner) на облако;
   * [billing.accounts.editor](../security/index.md#billing-accounts-editor) и выше в платежном аккаунте.

## Как привязать облако {#bind-cloud}

Чтобы привязать облако к платежному аккаунту или перепривязать облако к другому аккаунту:

{% list tabs group=instructions %}

- Интерфейс Yandex Cloud Billing {#billing}

  1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
  1. Выберите платежный аккаунт, к которому хотите привязать облако.
  1. На панели слева выберите ![image](../../_assets/console-icons/cloud.svg) **Облака и сервисы**.
  1. Нажмите ![image](../../_assets/console-icons/link.svg) **Привязать** в верхнем правом углу страницы.

     ![image](../../_assets/billing/billing-pin-cloud-1-4.png)
  
  1. В поле **Тип** выберите нужный тип сущности из списка, а затем — ресурс, который хотите привязать к платежному аккаунту.
  1. Нажмите кнопку **Привязать** — добавленное облако или сервис появится в списке.
  1. Погасите задолженность на старом платежном аккаунте, если перепривязали облако.

     ![image](../../_assets/billing/billing-pin-cloud-5-6.png) 

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Для привязки облака у [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) должна быть [назначена роль](../security/index.md#set-role) не ниже `billing.accounts.editor` на платежный аккаунт, к которому будет привязано облако.

  Чтобы привязать облако к платежному аккаунту:
  
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_billing_cloud_binding" "mycloud" {
       billing_account_id = "<идентификатор_платежного_аккаунта>"
       cloud_id           = "<идентификатор_облака>"
     }
     ```

     Где:
     * `billing_account_id` — идентификатор платежного аккаунта, к которому вы хотите привязать облако.
     * `cloud_id` — идентификатор облака, которое вы хотите привязать к платежному аккаунту.

     Более подробную информацию о параметрах ресурса `yandex_billing_cloud_binding` в Terraform, см. в [документации провайдера](../../terraform/resources/billing_cloud_binding.md).
  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  После этого облако будет привязано к платежному аккаунту.

- API {#api}

  Чтобы привязать облако, воспользуйтесь методом REST API [bindBillableObject](../api-ref/BillingAccount/bindBillableObject.md) для ресурса [BillingAccount](../api-ref/BillingAccount/index.md) или вызовом gRPC API [BillingAccountService/BindBillableObject](../api-ref/grpc/BillingAccount/bindBillableObject.md).

{% endlist %}

{% note warning %}

Привязка облака или другого контейнера к [заблокированному аккаунту](../concepts/billing-account-statuses.md) приведет к остановке всех ваших ресурсов.

{% endnote %}

## Как проверить привязку облака {#check-binding}

Чтобы проверить привязку облака или сервиса к платежному аккаунту:

{% list tabs group=instructions %}

- Интерфейс Yandex Cloud Billing {#billing}
  
  1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
  1. Выберите платежный аккаунт, к которому привязали новое облако или сервис.
  1. На панели слева выберите ![image](../../_assets/console-icons/cloud.svg) **Облака и сервисы**.

  В списке должна появиться новая строка с идентификатором привязанного облака или сервиса.

{% endlist %}

## Особенности управления ресурсами в организациях {#bind-cloud-organization}

1. После добавления вашего платежного аккаунта в [организацию](../concepts/organization.md) для привязки в сервисе [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) будут доступны:
     * облака и экземпляры сервисов [DataSphere](https://yandex.cloud/ru/services#ml-ai), [Yandex DataLens](../../datalens/index.md) или [Яндекс Трекер](https://yandex.ru/support/tracker/ru), которые созданы в вашей организации;
     * облака и сущности из других организаций, к которым был [выдан доступ](../../resource-manager/security/index.md).
     
   Чтобы получить доступ к [тарифицируемым](../../organization/pricing.md#pricing-management) возможностям сервиса [Yandex Identity Hub](../../organization/index.md), [привяжите](../../organization/operations/manage-billing.md#add-billing-account) платежный аккаунт к инстансу Yandex Identity Hub.
1. [Тарифный план технической поддержки](../../support/pricing.md) действует на уровне организации и может быть изменен только владельцем организации. С помощью одного платежного аккаунта можно оплачивать фиксированную часть тарифа поддержки для разных организаций, в которых могут быть подключены разные тарифы поддержки.

Если вы хотите перестать использовать старый платежный аккаунт, проверьте, что в нем подключен бесплатный тарифный план «Базовый», чтобы предотвратить списания. В противном случае, даже если у аккаунта не останется привязанных облаков, начисления за платный тарифный план продолжат списываться.