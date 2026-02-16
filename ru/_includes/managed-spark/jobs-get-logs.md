{% note warning %}

Чтобы получать логи выполнения заданий, включите запись логов в кластере при его [создании](../../managed-spark/operations/cluster-create.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}**.
    1. Нажмите на имя нужного задания.
    1. В поле **{{ ui-key.yacloud.dataproc.jobs.label_job-logs }}** нажмите на ссылку.

- CLI {#cli}
    
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
    
    Чтобы получить логи выполнения задания:

    1. Посмотрите описание команды CLI для получения логов задания:

        ```bash
        yc managed-spark job log --help
        ```
    
    1. Получите логи задания, выполнив команду:

        ```bash
        yc managed-spark job log <идентификатор_задания> \
          --cluster-id <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](../../managed-spark/operations/cluster-list.md#list-clusters).

        Идентификатор задания можно получить со [списком заданий в кластере](#list).

        Чтобы получить логи нескольких заданий, перечислите их идентификаторы через пробел, например:
        
        ```bash
        yc managed-spark job log c9q9veov4uql******** c9qu8uftedte******** \
          --cluster-id c9q8ml85r1oh********
        ```

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../managed-spark/api-ref/authentication.md) и поместите токен в переменную среды окружения:

       {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [JobService.ListLog](../../managed-spark/api-ref/grpc/Job/listLog.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/job_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                   "cluster_id": "<идентификатор_кластера>",
                   "job_id": "<идентификатор_задания>"
               }' \
            {{ api-host-spark }}:{{ port-https }} \
            yandex.cloud.spark.v1.JobService.ListLog
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-spark/operations/cluster-list.md#list-clusters), идентификатор задания — со [списком заданий в кластере](#list).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../managed-spark/api-ref/grpc/Job/listLog.md#yandex.cloud.spark.v1.ListJobLogResponse).

{% endlist %}
