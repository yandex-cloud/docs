[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for GitLab](../index.md) > [Концепции](index.md) > Преимущества сервиса перед пользовательской инсталляцией GitLab

# Преимущества Managed Service for GitLab перед пользовательской инсталляцией GitLab Community Edition

_Пользовательская инсталляция_ — это GitLab, который установлен на сервер или локальный компьютер (self-managed GitLab). Ниже рассматривается пользовательская инсталляция [GitLab Community Edition](https://about.gitlab.com/install/ce-or-ee/).

Managed Service for GitLab имеет поддержку [правил ревью кода](approval-rules.md), которой нет в Community Edition. Правила являются альтернативой инструменту [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) в GitLab Enterprise Edition.

Пользовательская инсталляция устанавливается и администрируется вручную. Это требует больше затрат по сравнению с поддержкой Managed Service for GitLab. Администрирование сервиса включает в себя следующие преимущества:

* GitLab [развертывается](../operations/instance/instance-create.md) в один клик. Развертывание также включает автоматическую генерацию SSL-сертификата.
* Yandex Cloud регулярно обслуживает [инстансы GitLab](index.md#instance) и обновляет версию GitLab.
* Yandex Cloud регулярно создает [резервные копии](backup.md) инстанса по расписанию, указанному в его настройках.

## Что дальше {#whats-next}

* [Попробуйте Yandex Managed Service for GitLab](https://console.yandex.cloud/link/managed-gitlab/).
* Перенесите свои проекты из пользовательской инсталляции в Managed Service for GitLab и сократите затраты на администрирование сервиса. Подробнее о миграции читайте в разделе [Порядок предоставления услуги по миграции из GitLab в Managed Service for GitLab](migration.md).