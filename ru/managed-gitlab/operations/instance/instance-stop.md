# Остановка и запуск инстанса {{ GL }}

При необходимости вы можете остановить [инстанс {{ GL }}](../../concepts/index.md#instance) и запустить его заново. При остановке инстанса все данные в нем сохранятся.

Время простоя остановленного инстанса не тарифицируется: вы продолжаете платить только за объем хранимых данных инстанса и объем резервных копий, которые хранятся в {{ objstorage-full-name }}, в соответствии с [тарифом](../../pricing.md#prices-storage).

## Остановить инстанс {#stop-instance}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Найдите нужный инстанс в списке, нажмите на значок ![options](../../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся диалоге подтвердите остановку инстанса и нажмите кнопку **{{ ui-key.yacloud.common.stop }}**.

{% endlist %}

## Запустить инстанс {#start-instance}

Инстанс в статусе **Stopped** можно запустить заново.

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Найдите нужный остановленный инстанс в списке, нажмите на значок ![options](../../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.start }}**.
  1. В открывшемся диалоге подтвердите запуск инстанса нажатием на кнопку **{{ ui-key.yacloud.common.start }}**.

{% endlist %}