---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Добавление учетных данных в конфигурационный файл kubectl

При добавлении учетных данных обратите внимание: 

{% include [note-about-conf](../../../_includes/managed-kubernetes/note-about-conf.md) %}

{% list tabs %}

- CLI
        
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы добавить учетные данные кластера {{ k8s }} в конфигурационный файл kubectl:
    1. Посмотрите описание команды CLI:
    
        ```
        $ yc managed-kubernetes cluster get-credentials --help
        ```
    1. Добавьте учетные данные в конфигурационный файл kubectl:
     
        ```
        $ yc managed-kubernetes cluster get-credentials test-k8s-cluster --external
        ```  
    1. Проверьте конфигурацию kubectl после добавления учетных данных: 
    
        ```
        $ kubectl config view
        apiVersion: v1
        clusters:
        - cluster:
            certificate-authority-data: DATA+OMITTED
            server: https://84.201.150.175/
          name: yc-managed-k8s-cata9ertn6tcr09bh8ht
        contexts:
        ...
        ``` 

{% endlist %}
