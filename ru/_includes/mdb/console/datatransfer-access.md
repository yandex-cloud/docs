**{{ ui-key.yacloud.mdb.forms.additional-field-datatransfer }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ data-transfer-full-name }}](../../../data-transfer/) в Serverless-режиме.

Это позволит через специальную сеть подключаться к {{ data-transfer-full-name }}, запущенному в {{ k8s }}. В результате будут быстрее выполняться, например, запуск и деактивация трансфера.
