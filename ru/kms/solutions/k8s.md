# Шифрование секретов в {{ managed-k8s-full-name }}

Используйте ключ {{ kms-short-name }} для шифрования секретов — конфиденциальной информации, такой как пароли, OAuth-токены и SSH-ключи, в {{ managed-k8s-full-name }}. Для этого при создании кластера укажите ключ {{ kms-short-name }}, который будет использоваться при шифровании и расшифровке.

{% list tabs %}

- Консоль управления

    Укажите ключ при создании кластера {{ k8s }}:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан кластер {{ k8s }}.
    1. В списке сервисов выберите **{{ managed-k8s-name }}**.
    1. Нажмите кнопку **Создать кластер**.
    1. В поле **Ключ шифрования** укажите необходимый ключ или [создайте новый](../operations/key.md#create).
    1. Закончите заполнение параметров [создания кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
    1. Нажмите кнопку **Создать кластер**.
    
{% endlist %}

Взаимодействие {{ managed-k8s-name }} с {{ kms-short-name }} происходит с помощью [механизма {{ kms-short-name }} провайдеров](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} поддерживает {{ kms-short-name }}-плагин, который используется для шифрования и расшифровки ключей шифрования данных (DEK) в {{ kms-short-name }}. Шифрование секретов осуществляется стандартными средствами {{ k8s }}.

## См. также {#see-also}

* [Начало работы с {{ managed-k8s-name }}](../../managed-kubernetes/quickstart.md).
* [{#T}](../concepts/envelope.md).
* [Создание секретов в Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/#creating-your-own-secrets).
