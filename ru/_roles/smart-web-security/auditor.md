Роль `smart-web-security.auditor` позволяет просматривать информацию о профилях безопасности Smart Web Security и метаинформацию облака и каталога.

Пользователи с этой ролью могут:
* просматривать информацию о [профилях безопасности](../../smartwebsecurity/concepts/profiles.md) Smart Web Security;
* просматривать информацию о [привязках](../../iam/concepts/access-control/index.md#access-bindings) прав доступа к профилям безопасности;
* просматривать список [виртуальных хостов](../../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика Yandex Application Load Balancer, к которым подключен профиль безопасности;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Назначить роль `smart-web-security.auditor` может пользователь с ролью `admin` в облаке или `smart-web-security.admin` в каталоге.