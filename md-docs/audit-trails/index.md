[Документация Yandex Cloud](../index.md) > Yandex Audit Trails > Audit Trails

# Yandex Audit Trails

Yandex Audit Trails — сервис сбора и выгрузки аудитных логов ресурсов Yandex Cloud. Позволяет применять инструменты анализа и оперативного реагирования на события уровня ресурсов Yandex Cloud.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_audittrails/">Уровень обслуживания Yandex Audit Trails</a>.

# Yandex Audit Trails

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Создание трейла](operations/create-trail.md)

 - [Управление трейлом](operations/manage-trail.md)

 - [Подготовка спецификации трейла](operations/prepare-spec.md)

### Управление правами доступа к трейлу

 - [Посмотреть роли, назначенные на трейл](operations/role-list.md)

 - [Назначить роли на трейл](operations/role-add.md)

 - [Отозвать роли, назначенные на трейл](operations/role-revoke.md)

 - [Обработка ошибок](operations/error.md)

### Получение информации о трейле

 - [Получить список трейлов](operations/get-list.md)

 - [Получить информацию о трейле](operations/get-info.md)

 - [Просмотр операций с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Поиск событий Yandex Cloud в Object Storage](tutorials/search-bucket.md)

 - [Поиск событий Yandex Cloud в Cloud Logging](tutorials/search-cloud-logging.md)

### Поиск событий в аудитных логах

 - [Обзор](tutorials/search-events-audit-logs/index.md)

 - [Инструменты для работы с аудитными логами](tutorials/search-events-audit-logs/tools.md)

 - [Примеры запросов для поиска событий](tutorials/search-events-audit-logs/examples.md)

 - [Настройка работы с Yandex Query](tutorials/search-events-audit-logs/query.md)

 - [Настройка дашбордов и алертов в Monitoring](tutorials/alerts-monitoring.md)

 - [Настройка реагирования в Cloud Functions](tutorials/logging-functions.md)

 - [Обработка аудитных логов Audit Trails](tutorials/audit-trails.md)

### Экспорт аудитных логов в SIEM

 - [Загрузка аудитных логов в Yandex Managed Service for OpenSearch](tutorials/trails-logs-opensearch.md)

#### Загрузка аудитных логов в MaxPatrol SIEM

 - [Обзор](tutorials/maxpatrol/index.md)

 - [Консоль управления](tutorials/maxpatrol/console.md)

 - [Terraform](tutorials/maxpatrol/terraform.md)

 - [Загрузка аудитных логов в SIEM Splunk](tutorials/export-logs-to-splunk.md)

 - [Загрузка аудитных логов в SIEM ArcSight](tutorials/export-logs-to-arcsight.md)

#### Загрузка аудитных логов в SIEM KUMA

 - [Обзор](tutorials/audit-trails-events-to-kuma/index.md)

 - [Консоль управления, CLI, API](tutorials/audit-trails-events-to-kuma/console.md)

 - [Terraform](tutorials/audit-trails-events-to-kuma/terraform.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Трейл](concepts/trail.md)

 - [Лог диагностики](concepts/diagnostics.md)

 - [Сравнение логов событий уровня конфигурации и уровня сервисов](concepts/control-plane-vs-data-plane.md)

 - [Аудитный лог событий уровня конфигурации](concepts/format.md)

 - [Аудитный лог событий уровня сервисов](concepts/format-data-plane.md)

 - [Экспорт в SIEM](concepts/export-siem.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### trail

 - [Overview](cli-ref/trail/index.md)

 - [add-access-binding](cli-ref/trail/add-access-binding.md)

 - [create](cli-ref/trail/create.md)

 - [delete](cli-ref/trail/delete.md)

 - [get](cli-ref/trail/get.md)

 - [list](cli-ref/trail/list.md)

 - [list-access-bindings](cli-ref/trail/list-access-bindings.md)

 - [list-operations](cli-ref/trail/list-operations.md)

 - [remove-access-binding](cli-ref/trail/remove-access-binding.md)

 - [set-access-bindings](cli-ref/trail/set-access-bindings.md)

 - [update](cli-ref/trail/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### trail

 - [Overview](cli-ref/v0/trail/index.md)

 - [add-access-binding](cli-ref/v0/trail/add-access-binding.md)

 - [create](cli-ref/v0/trail/create.md)

 - [delete](cli-ref/v0/trail/delete.md)

 - [get](cli-ref/v0/trail/get.md)

 - [list](cli-ref/v0/trail/list.md)

 - [list-access-bindings](cli-ref/v0/trail/list-access-bindings.md)

 - [list-operations](cli-ref/v0/trail/list-operations.md)

 - [remove-access-binding](cli-ref/v0/trail/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/trail/set-access-bindings.md)

 - [update](cli-ref/v0/trail/update.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Trail

 - [Overview](api-ref/Trail/index.md)

 - [Get](api-ref/Trail/get.md)

 - [List](api-ref/Trail/list.md)

 - [Create](api-ref/Trail/create.md)

 - [Update](api-ref/Trail/update.md)

 - [Delete](api-ref/Trail/delete.md)

 - [ListOperations](api-ref/Trail/listOperations.md)

 - [ListAccessBindings](api-ref/Trail/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Trail/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Trail/updateAccessBindings.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Trail

 - [Overview](api-ref/grpc/Trail/index.md)

 - [Get](api-ref/grpc/Trail/get.md)

 - [List](api-ref/grpc/Trail/list.md)

 - [Create](api-ref/grpc/Trail/create.md)

 - [Update](api-ref/grpc/Trail/update.md)

 - [Delete](api-ref/grpc/Trail/delete.md)

 - [ListOperations](api-ref/grpc/Trail/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Trail/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Trail/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Trail/updateAccessBindings.md)

 - [Метрики Monitoring](concepts/user-metrics.md)

 - [Справочник событий уровня конфигурации](concepts/events.md)

 - [Справочник событий уровня сервисов](concepts/events-data-plane.md)

## Справочник аудитных логов (англ.)

### accesstransparency

 - [ComputeNodeAccess](audit/accesstransparency/events-ref/ComputeNodeAccess.md)

 - [MDBClusterAccess](audit/accesstransparency/events-ref/MDBClusterAccess.md)

### ai.assistants.searchindex

 - [CreateSearchIndex](audit/ai/assistants/searchindex/events-ref/CreateSearchIndex.md)

 - [DeleteFilesFromSearchIndex](audit/ai/assistants/searchindex/events-ref/DeleteFilesFromSearchIndex.md)

 - [DeleteSearchIndex](audit/ai/assistants/searchindex/events-ref/DeleteSearchIndex.md)

 - [UploadFilesToSearchIndex](audit/ai/assistants/searchindex/events-ref/UploadFilesToSearchIndex.md)

### ai.assistants

 - [CreateSearchIndex](audit/ai/assistants/events-ref/CreateSearchIndex.md)

 - [DeleteFilesFromSearchIndex](audit/ai/assistants/events-ref/DeleteFilesFromSearchIndex.md)

 - [DeleteSearchIndex](audit/ai/assistants/events-ref/DeleteSearchIndex.md)

 - [UploadFilesToSearchIndex](audit/ai/assistants/events-ref/UploadFilesToSearchIndex.md)

### ai.batch_inference

 - [CancelBatchInference](audit/ai/batch_inference/events-ref/CancelBatchInference.md)

 - [DeleteBatchInference](audit/ai/batch_inference/events-ref/DeleteBatchInference.md)

 - [StartBatchInference](audit/ai/batch_inference/events-ref/StartBatchInference.md)

### ai.dedicated_instance

 - [CreateDedicatedInstance](audit/ai/dedicated_instance/events-ref/CreateDedicatedInstance.md)

 - [DeleteDedicatedInstance](audit/ai/dedicated_instance/events-ref/DeleteDedicatedInstance.md)

 - [StartDedicatedInstance](audit/ai/dedicated_instance/events-ref/StartDedicatedInstance.md)

 - [StopDedicatedInstance](audit/ai/dedicated_instance/events-ref/StopDedicatedInstance.md)

 - [UpdateDedicatedInstance](audit/ai/dedicated_instance/events-ref/UpdateDedicatedInstance.md)

### ai.foundationmodels

 - [GetTextProcessingResult](audit/ai/foundationmodels/events-ref/GetTextProcessingResult.md)

 - [TextProcessing](audit/ai/foundationmodels/events-ref/TextProcessing.md)

 - [UpdateDataLogging](audit/ai/foundationmodels/events-ref/UpdateDataLogging.md)

### ai.guardrails

 - [BlockContentByClassifier](audit/ai/guardrails/events-ref/BlockContentByClassifier.md)

 - [BlockContentByDictionary](audit/ai/guardrails/events-ref/BlockContentByDictionary.md)

 - [ChangeDefaultGuardrail](audit/ai/guardrails/events-ref/ChangeDefaultGuardrail.md)

 - [CompleteContentCheck](audit/ai/guardrails/events-ref/CompleteContentCheck.md)

 - [CreateDictionary](audit/ai/guardrails/events-ref/CreateDictionary.md)

 - [CreateGuardrail](audit/ai/guardrails/events-ref/CreateGuardrail.md)

 - [DeleteDictionary](audit/ai/guardrails/events-ref/DeleteDictionary.md)

 - [DeleteGuardrail](audit/ai/guardrails/events-ref/DeleteGuardrail.md)

 - [SetBinding](audit/ai/guardrails/events-ref/SetBinding.md)

 - [UnsetBinding](audit/ai/guardrails/events-ref/UnsetBinding.md)

 - [UpdateDictionary](audit/ai/guardrails/events-ref/UpdateDictionary.md)

 - [UpdateDictionaryItems](audit/ai/guardrails/events-ref/UpdateDictionaryItems.md)

 - [UpdateGuardrail](audit/ai/guardrails/events-ref/UpdateGuardrail.md)

### ai.mcp_hub

 - [CreateMcpGateway](audit/ai/mcp_hub/events-ref/CreateMcpGateway.md)

 - [DeleteMcpGateway](audit/ai/mcp_hub/events-ref/DeleteMcpGateway.md)

 - [SetMcpGatewayAccessBindings](audit/ai/mcp_hub/events-ref/SetMcpGatewayAccessBindings.md)

 - [UpdateMcpGateway](audit/ai/mcp_hub/events-ref/UpdateMcpGateway.md)

 - [UpdateMcpGatewayAccessBindings](audit/ai/mcp_hub/events-ref/UpdateMcpGatewayAccessBindings.md)

### ai.ocr

 - [GetRecognition](audit/ai/ocr/events-ref/GetRecognition.md)

 - [RecognizeText](audit/ai/ocr/events-ref/RecognizeText.md)

### ai.responses

 - [CancelResponse](audit/ai/responses/events-ref/CancelResponse.md)

 - [CreateResponse](audit/ai/responses/events-ref/CreateResponse.md)

 - [DeleteResponse](audit/ai/responses/events-ref/DeleteResponse.md)

 - [FileSearchToolSearch](audit/ai/responses/events-ref/FileSearchToolSearch.md)

 - [GetResponse](audit/ai/responses/events-ref/GetResponse.md)

 - [McpToolApprovalRequest](audit/ai/responses/events-ref/McpToolApprovalRequest.md)

 - [McpToolApprovalResponse](audit/ai/responses/events-ref/McpToolApprovalResponse.md)

 - [McpToolCall](audit/ai/responses/events-ref/McpToolCall.md)

 - [McpToolList](audit/ai/responses/events-ref/McpToolList.md)

 - [WebSearchToolSearch](audit/ai/responses/events-ref/WebSearchToolSearch.md)

### ai.speechkit.stt

 - [GetRecognition](audit/ai/speechkit/stt/events-ref/GetRecognition.md)

 - [RecognizeSpeechAsync](audit/ai/speechkit/stt/events-ref/RecognizeSpeechAsync.md)

 - [RecognizeSpeechStream](audit/ai/speechkit/stt/events-ref/RecognizeSpeechStream.md)

### ai.speechkit.tts

 - [UtteranceSynthesis](audit/ai/speechkit/tts/events-ref/UtteranceSynthesis.md)

### ai.translate

 - [TranslateText](audit/ai/translate/events-ref/TranslateText.md)

### ai.tuning

 - [CancelTuning](audit/ai/tuning/events-ref/CancelTuning.md)

 - [StartTuning](audit/ai/tuning/events-ref/StartTuning.md)

### airflow

 - [CreateCluster](audit/airflow/events-ref/CreateCluster.md)

 - [DeleteCluster](audit/airflow/events-ref/DeleteCluster.md)

 - [RescheduleMaintenance](audit/airflow/events-ref/RescheduleMaintenance.md)

 - [StartCluster](audit/airflow/events-ref/StartCluster.md)

 - [StopCluster](audit/airflow/events-ref/StopCluster.md)

 - [UpdateCluster](audit/airflow/events-ref/UpdateCluster.md)

### apploadbalancer

 - [AddBackendGroupBackend](audit/apploadbalancer/events-ref/AddBackendGroupBackend.md)

 - [AddLoadBalancerListener](audit/apploadbalancer/events-ref/AddLoadBalancerListener.md)

 - [AddLoadBalancerSniMatch](audit/apploadbalancer/events-ref/AddLoadBalancerSniMatch.md)

 - [AddTargetGroupTargets](audit/apploadbalancer/events-ref/AddTargetGroupTargets.md)

 - [CancelZonalShift](audit/apploadbalancer/events-ref/CancelZonalShift.md)

 - [CreateBackendGroup](audit/apploadbalancer/events-ref/CreateBackendGroup.md)

 - [CreateHttpRouter](audit/apploadbalancer/events-ref/CreateHttpRouter.md)

 - [CreateLoadBalancer](audit/apploadbalancer/events-ref/CreateLoadBalancer.md)

 - [CreateTargetGroup](audit/apploadbalancer/events-ref/CreateTargetGroup.md)

 - [CreateVirtualHost](audit/apploadbalancer/events-ref/CreateVirtualHost.md)

 - [DeleteBackendGroup](audit/apploadbalancer/events-ref/DeleteBackendGroup.md)

 - [DeleteHttpRouter](audit/apploadbalancer/events-ref/DeleteHttpRouter.md)

 - [DeleteLoadBalancer](audit/apploadbalancer/events-ref/DeleteLoadBalancer.md)

 - [DeleteTargetGroup](audit/apploadbalancer/events-ref/DeleteTargetGroup.md)

 - [DeleteVirtualHost](audit/apploadbalancer/events-ref/DeleteVirtualHost.md)

 - [LoadBalancerHTTPAccessLog](audit/apploadbalancer/events-ref/LoadBalancerHTTPAccessLog.md)

 - [LoadBalancerTCPAccessLog](audit/apploadbalancer/events-ref/LoadBalancerTCPAccessLog.md)

 - [RemoveBackendGroupBackend](audit/apploadbalancer/events-ref/RemoveBackendGroupBackend.md)

 - [RemoveLoadBalancerListener](audit/apploadbalancer/events-ref/RemoveLoadBalancerListener.md)

 - [RemoveLoadBalancerSniMatch](audit/apploadbalancer/events-ref/RemoveLoadBalancerSniMatch.md)

 - [RemoveTargetGroupTargets](audit/apploadbalancer/events-ref/RemoveTargetGroupTargets.md)

 - [RemoveVirtualHostRoute](audit/apploadbalancer/events-ref/RemoveVirtualHostRoute.md)

 - [StartLoadBalancer](audit/apploadbalancer/events-ref/StartLoadBalancer.md)

 - [StartZonalShift](audit/apploadbalancer/events-ref/StartZonalShift.md)

 - [StopLoadBalancer](audit/apploadbalancer/events-ref/StopLoadBalancer.md)

 - [UpdateBackendGroup](audit/apploadbalancer/events-ref/UpdateBackendGroup.md)

 - [UpdateBackendGroupBackend](audit/apploadbalancer/events-ref/UpdateBackendGroupBackend.md)

 - [UpdateHttpRouter](audit/apploadbalancer/events-ref/UpdateHttpRouter.md)

 - [UpdateLoadBalancer](audit/apploadbalancer/events-ref/UpdateLoadBalancer.md)

 - [UpdateLoadBalancerListener](audit/apploadbalancer/events-ref/UpdateLoadBalancerListener.md)

 - [UpdateLoadBalancerSniMatch](audit/apploadbalancer/events-ref/UpdateLoadBalancerSniMatch.md)

 - [UpdateTargetGroup](audit/apploadbalancer/events-ref/UpdateTargetGroup.md)

 - [UpdateVirtualHost](audit/apploadbalancer/events-ref/UpdateVirtualHost.md)

 - [UpdateVirtualHostRoute](audit/apploadbalancer/events-ref/UpdateVirtualHostRoute.md)

### audittrails

 - [CreateTrail](audit/audittrails/events-ref/CreateTrail.md)

 - [DeleteTrail](audit/audittrails/events-ref/DeleteTrail.md)

 - [SetTrailAccessBindings](audit/audittrails/events-ref/SetTrailAccessBindings.md)

 - [UpdateTrail](audit/audittrails/events-ref/UpdateTrail.md)

 - [UpdateTrailAccessBindings](audit/audittrails/events-ref/UpdateTrailAccessBindings.md)

### backup

 - [ActivateProvider](audit/backup/events-ref/ActivateProvider.md)

 - [ApplyPolicy](audit/backup/events-ref/ApplyPolicy.md)

 - [CreateDirectory](audit/backup/events-ref/CreateDirectory.md)

 - [CreatePolicy](audit/backup/events-ref/CreatePolicy.md)

 - [DeleteArchive](audit/backup/events-ref/DeleteArchive.md)

 - [DeleteBackup](audit/backup/events-ref/DeleteBackup.md)

 - [DeletePolicy](audit/backup/events-ref/DeletePolicy.md)

 - [DeleteResource](audit/backup/events-ref/DeleteResource.md)

 - [ExecutePolicy](audit/backup/events-ref/ExecutePolicy.md)

 - [InitResource](audit/backup/events-ref/InitResource.md)

 - [RegisterResource](audit/backup/events-ref/RegisterResource.md)

 - [RevokePolicy](audit/backup/events-ref/RevokePolicy.md)

 - [StartRecoverBackup](audit/backup/events-ref/StartRecoverBackup.md)

 - [UpdatePolicy](audit/backup/events-ref/UpdatePolicy.md)

 - [UpdateResource](audit/backup/events-ref/UpdateResource.md)

### baremetal

 - [ApplyUpdatePrivateCloudConnection](audit/baremetal/events-ref/ApplyUpdatePrivateCloudConnection.md)

 - [BatchCreateServer](audit/baremetal/events-ref/BatchCreateServer.md)

 - [CreateImage](audit/baremetal/events-ref/CreateImage.md)

 - [CreatePrivateCloudConnection](audit/baremetal/events-ref/CreatePrivateCloudConnection.md)

 - [CreatePrivateSubnet](audit/baremetal/events-ref/CreatePrivateSubnet.md)

 - [CreatePublicPrefixPool](audit/baremetal/events-ref/CreatePublicPrefixPool.md)

 - [CreatePublicSubnet](audit/baremetal/events-ref/CreatePublicSubnet.md)

 - [CreateServer](audit/baremetal/events-ref/CreateServer.md)

 - [CreateVRF](audit/baremetal/events-ref/CreateVRF.md)

 - [DeleteImage](audit/baremetal/events-ref/DeleteImage.md)

 - [DeletePrivateCloudConnection](audit/baremetal/events-ref/DeletePrivateCloudConnection.md)

 - [DeletePrivateSubnet](audit/baremetal/events-ref/DeletePrivateSubnet.md)

 - [DeletePublicPrefixPool](audit/baremetal/events-ref/DeletePublicPrefixPool.md)

 - [DeletePublicSubnet](audit/baremetal/events-ref/DeletePublicSubnet.md)

 - [DeleteServer](audit/baremetal/events-ref/DeleteServer.md)

 - [DeleteVRF](audit/baremetal/events-ref/DeleteVRF.md)

 - [ExternalFlow](audit/baremetal/events-ref/ExternalFlow.md)

 - [PowerOffServer](audit/baremetal/events-ref/PowerOffServer.md)

 - [PowerOnServer](audit/baremetal/events-ref/PowerOnServer.md)

 - [RebootServer](audit/baremetal/events-ref/RebootServer.md)

 - [RegisterServerBackupAgent](audit/baremetal/events-ref/RegisterServerBackupAgent.md)

 - [ReinstallServer](audit/baremetal/events-ref/ReinstallServer.md)

 - [StartServerProlongation](audit/baremetal/events-ref/StartServerProlongation.md)

 - [StopServerProlongation](audit/baremetal/events-ref/StopServerProlongation.md)

 - [UpdateImage](audit/baremetal/events-ref/UpdateImage.md)

 - [UpdatePrivateCloudConnection](audit/baremetal/events-ref/UpdatePrivateCloudConnection.md)

 - [UpdatePrivateSubnet](audit/baremetal/events-ref/UpdatePrivateSubnet.md)

 - [UpdatePublicPrefixPool](audit/baremetal/events-ref/UpdatePublicPrefixPool.md)

 - [UpdatePublicSubnet](audit/baremetal/events-ref/UpdatePublicSubnet.md)

 - [UpdateServer](audit/baremetal/events-ref/UpdateServer.md)

 - [UpdateVRF](audit/baremetal/events-ref/UpdateVRF.md)

### cdn

 - [CachePrefetch](audit/cdn/events-ref/CachePrefetch.md)

 - [CachePurge](audit/cdn/events-ref/CachePurge.md)

 - [OriginCreate](audit/cdn/events-ref/OriginCreate.md)

 - [OriginDelete](audit/cdn/events-ref/OriginDelete.md)

 - [OriginGroupCreate](audit/cdn/events-ref/OriginGroupCreate.md)

 - [OriginGroupDelete](audit/cdn/events-ref/OriginGroupDelete.md)

 - [OriginGroupUpdate](audit/cdn/events-ref/OriginGroupUpdate.md)

 - [OriginUpdate](audit/cdn/events-ref/OriginUpdate.md)

 - [ProviderActivate](audit/cdn/events-ref/ProviderActivate.md)

 - [RawLogsActivate](audit/cdn/events-ref/RawLogsActivate.md)

 - [RawLogsDeactivate](audit/cdn/events-ref/RawLogsDeactivate.md)

 - [RawLogsUpdate](audit/cdn/events-ref/RawLogsUpdate.md)

 - [ResourceCreate](audit/cdn/events-ref/ResourceCreate.md)

 - [ResourceDelete](audit/cdn/events-ref/ResourceDelete.md)

 - [ResourceRuleCreate](audit/cdn/events-ref/ResourceRuleCreate.md)

 - [ResourceRuleDelete](audit/cdn/events-ref/ResourceRuleDelete.md)

 - [ResourceRuleUpdate](audit/cdn/events-ref/ResourceRuleUpdate.md)

 - [ResourceUpdate](audit/cdn/events-ref/ResourceUpdate.md)

### certificatemanager

 - [CreateCaUsageRestriction](audit/certificatemanager/events-ref/CreateCaUsageRestriction.md)

 - [CreateCertificate](audit/certificatemanager/events-ref/CreateCertificate.md)

 - [CreateDomain](audit/certificatemanager/events-ref/CreateDomain.md)

 - [DeleteCaUsageRestriction](audit/certificatemanager/events-ref/DeleteCaUsageRestriction.md)

 - [DeleteCertificate](audit/certificatemanager/events-ref/DeleteCertificate.md)

 - [DeleteDomain](audit/certificatemanager/events-ref/DeleteDomain.md)

 - [GetCertificateContent](audit/certificatemanager/events-ref/GetCertificateContent.md)

 - [GetExCertificateContent](audit/certificatemanager/events-ref/GetExCertificateContent.md)

 - [SetCaUsageRestrictionAccessBindings](audit/certificatemanager/events-ref/SetCaUsageRestrictionAccessBindings.md)

 - [SetCertificateAccessBindings](audit/certificatemanager/events-ref/SetCertificateAccessBindings.md)

 - [SetCertificateAuthorityAccessBindings](audit/certificatemanager/events-ref/SetCertificateAuthorityAccessBindings.md)

 - [SetDomainPrimaryCertificate](audit/certificatemanager/events-ref/SetDomainPrimaryCertificate.md)

 - [UpdateCaUsageRestriction](audit/certificatemanager/events-ref/UpdateCaUsageRestriction.md)

 - [UpdateCaUsageRestrictionAccessBindings](audit/certificatemanager/events-ref/UpdateCaUsageRestrictionAccessBindings.md)

 - [UpdateCertificate](audit/certificatemanager/events-ref/UpdateCertificate.md)

 - [UpdateCertificateAccessBindings](audit/certificatemanager/events-ref/UpdateCertificateAccessBindings.md)

 - [UpdateCertificateAuthorityAccessBindings](audit/certificatemanager/events-ref/UpdateCertificateAuthorityAccessBindings.md)

 - [UpdateDomain](audit/certificatemanager/events-ref/UpdateDomain.md)

 - [UpdateDomainAccessBindings](audit/certificatemanager/events-ref/UpdateDomainAccessBindings.md)

### cloudapps

 - [CreateCloudApplication](audit/cloudapps/events-ref/CreateCloudApplication.md)

 - [DeleteCloudApplication](audit/cloudapps/events-ref/DeleteCloudApplication.md)

 - [SetApplicationAccessBindings](audit/cloudapps/events-ref/SetApplicationAccessBindings.md)

 - [UpdateApplicationAccessBindings](audit/cloudapps/events-ref/UpdateApplicationAccessBindings.md)

 - [UpdateCloudApplication](audit/cloudapps/events-ref/UpdateCloudApplication.md)

### clouddesktop

 - [CopyDesktopImage](audit/clouddesktop/events-ref/CopyDesktopImage.md)

 - [CopyDesktopImageFromDesktop](audit/clouddesktop/events-ref/CopyDesktopImageFromDesktop.md)

 - [CreateDesktop](audit/clouddesktop/events-ref/CreateDesktop.md)

 - [CreateDesktopGroup](audit/clouddesktop/events-ref/CreateDesktopGroup.md)

 - [DeleteDesktop](audit/clouddesktop/events-ref/DeleteDesktop.md)

 - [DeleteDesktopGroup](audit/clouddesktop/events-ref/DeleteDesktopGroup.md)

 - [DeleteDesktopImage](audit/clouddesktop/events-ref/DeleteDesktopImage.md)

 - [GenerateDesktopRDPFile](audit/clouddesktop/events-ref/GenerateDesktopRDPFile.md)

 - [ResetDesktopPassword](audit/clouddesktop/events-ref/ResetDesktopPassword.md)

 - [RestartDesktop](audit/clouddesktop/events-ref/RestartDesktop.md)

 - [SetDesktopGroupAccessBindings](audit/clouddesktop/events-ref/SetDesktopGroupAccessBindings.md)

 - [StartDesktop](audit/clouddesktop/events-ref/StartDesktop.md)

 - [StopDesktop](audit/clouddesktop/events-ref/StopDesktop.md)

 - [UpdateDesktop](audit/clouddesktop/events-ref/UpdateDesktop.md)

 - [UpdateDesktopGroup](audit/clouddesktop/events-ref/UpdateDesktopGroup.md)

 - [UpdateDesktopGroupAccessBindings](audit/clouddesktop/events-ref/UpdateDesktopGroupAccessBindings.md)

 - [UpdateDesktopImage](audit/clouddesktop/events-ref/UpdateDesktopImage.md)

 - [UpdateDesktopProperties](audit/clouddesktop/events-ref/UpdateDesktopProperties.md)

### cloudregistry

 - [CreateArtifact](audit/cloudregistry/events-ref/CreateArtifact.md)

 - [CreateRegistry](audit/cloudregistry/events-ref/CreateRegistry.md)

 - [DeleteArtifact](audit/cloudregistry/events-ref/DeleteArtifact.md)

 - [DeleteRegistry](audit/cloudregistry/events-ref/DeleteRegistry.md)

 - [RevokeDelegation](audit/cloudregistry/events-ref/RevokeDelegation.md)

 - [SetArtifactAccessBindings](audit/cloudregistry/events-ref/SetArtifactAccessBindings.md)

 - [SetIpPermissions](audit/cloudregistry/events-ref/SetIpPermissions.md)

 - [SetRegistryAccessBindings](audit/cloudregistry/events-ref/SetRegistryAccessBindings.md)

 - [SetRegistryFolderAccessBindings](audit/cloudregistry/events-ref/SetRegistryFolderAccessBindings.md)

 - [SetupDelegation](audit/cloudregistry/events-ref/SetupDelegation.md)

 - [UpdateArtifact](audit/cloudregistry/events-ref/UpdateArtifact.md)

 - [UpdateArtifactAccessBindings](audit/cloudregistry/events-ref/UpdateArtifactAccessBindings.md)

 - [UpdateIpPermissions](audit/cloudregistry/events-ref/UpdateIpPermissions.md)

 - [UpdateRegistry](audit/cloudregistry/events-ref/UpdateRegistry.md)

 - [UpdateRegistryAccessBindings](audit/cloudregistry/events-ref/UpdateRegistryAccessBindings.md)

 - [UpdateRegistryFolderAccessBindings](audit/cloudregistry/events-ref/UpdateRegistryFolderAccessBindings.md)

### compute

 - [AddInstanceOneToOneNat](audit/compute/events-ref/AddInstanceOneToOneNat.md)

 - [AttachInstanceDisk](audit/compute/events-ref/AttachInstanceDisk.md)

 - [AttachInstanceFilesystem](audit/compute/events-ref/AttachInstanceFilesystem.md)

 - [AttachInstanceNetworkInterface](audit/compute/events-ref/AttachInstanceNetworkInterface.md)

 - [ChangeDiskStatus](audit/compute/events-ref/ChangeDiskStatus.md)

 - [ConnectSerialPort](audit/compute/events-ref/ConnectSerialPort.md)

 - [CrashInstance](audit/compute/events-ref/CrashInstance.md)

 - [CreateDisk](audit/compute/events-ref/CreateDisk.md)

 - [CreateDiskPlacementGroup](audit/compute/events-ref/CreateDiskPlacementGroup.md)

 - [CreateFilesystem](audit/compute/events-ref/CreateFilesystem.md)

 - [CreateGpuCluster](audit/compute/events-ref/CreateGpuCluster.md)

 - [CreateHostGroup](audit/compute/events-ref/CreateHostGroup.md)

 - [CreateImage](audit/compute/events-ref/CreateImage.md)

 - [CreateInstance](audit/compute/events-ref/CreateInstance.md)

 - [CreateInstanceGroup](audit/compute/events-ref/CreateInstanceGroup.md)

 - [CreatePlacementGroup](audit/compute/events-ref/CreatePlacementGroup.md)

 - [CreateReservedInstancePool](audit/compute/events-ref/CreateReservedInstancePool.md)

 - [CreateSnapshot](audit/compute/events-ref/CreateSnapshot.md)

 - [CreateSnapshotSchedule](audit/compute/events-ref/CreateSnapshotSchedule.md)

 - [DecommissionHost](audit/compute/events-ref/DecommissionHost.md)

 - [DeleteDisk](audit/compute/events-ref/DeleteDisk.md)

 - [DeleteDiskPlacementGroup](audit/compute/events-ref/DeleteDiskPlacementGroup.md)

 - [DeleteFilesystem](audit/compute/events-ref/DeleteFilesystem.md)

 - [DeleteGpuCluster](audit/compute/events-ref/DeleteGpuCluster.md)

 - [DeleteHostGroup](audit/compute/events-ref/DeleteHostGroup.md)

 - [DeleteImage](audit/compute/events-ref/DeleteImage.md)

 - [DeleteInstance](audit/compute/events-ref/DeleteInstance.md)

 - [DeleteInstanceGroup](audit/compute/events-ref/DeleteInstanceGroup.md)

 - [DeleteInstanceGroupInstances](audit/compute/events-ref/DeleteInstanceGroupInstances.md)

 - [DeletePlacementGroup](audit/compute/events-ref/DeletePlacementGroup.md)

 - [DeleteReservedInstancePool](audit/compute/events-ref/DeleteReservedInstancePool.md)

 - [DeleteSnapshot](audit/compute/events-ref/DeleteSnapshot.md)

 - [DeleteSnapshotSchedule](audit/compute/events-ref/DeleteSnapshotSchedule.md)

 - [DetachInstanceDisk](audit/compute/events-ref/DetachInstanceDisk.md)

 - [DetachInstanceFilesystem](audit/compute/events-ref/DetachInstanceFilesystem.md)

 - [DetachInstanceNetworkInterface](audit/compute/events-ref/DetachInstanceNetworkInterface.md)

 - [DisableSnapshotSchedule](audit/compute/events-ref/DisableSnapshotSchedule.md)

 - [DisableZones](audit/compute/events-ref/DisableZones.md)

 - [EnableSnapshotSchedule](audit/compute/events-ref/EnableSnapshotSchedule.md)

 - [EnableZones](audit/compute/events-ref/EnableZones.md)

 - [GuestStopInstance](audit/compute/events-ref/GuestStopInstance.md)

 - [MigrateInstance](audit/compute/events-ref/MigrateInstance.md)

 - [PauseInstanceGroup](audit/compute/events-ref/PauseInstanceGroup.md)

 - [PreemptInstance](audit/compute/events-ref/PreemptInstance.md)

 - [RemoveInstanceOneToOneNat](audit/compute/events-ref/RemoveInstanceOneToOneNat.md)

 - [RestartInstance](audit/compute/events-ref/RestartInstance.md)

 - [ResumeInstanceGroup](audit/compute/events-ref/ResumeInstanceGroup.md)

 - [RollingRecreateInstanceGroupInstances](audit/compute/events-ref/RollingRecreateInstanceGroupInstances.md)

 - [RollingRestartInstanceGroupInstances](audit/compute/events-ref/RollingRestartInstanceGroupInstances.md)

 - [SetInstanceGroupAccessBindings](audit/compute/events-ref/SetInstanceGroupAccessBindings.md)

 - [StartInstance](audit/compute/events-ref/StartInstance.md)

 - [StartInstanceGroup](audit/compute/events-ref/StartInstanceGroup.md)

 - [StopInstance](audit/compute/events-ref/StopInstance.md)

 - [StopInstanceGroup](audit/compute/events-ref/StopInstanceGroup.md)

 - [StopInstanceGroupInstances](audit/compute/events-ref/StopInstanceGroupInstances.md)

 - [UpdateDisk](audit/compute/events-ref/UpdateDisk.md)

 - [UpdateDiskPlacementGroup](audit/compute/events-ref/UpdateDiskPlacementGroup.md)

 - [UpdateFilesystem](audit/compute/events-ref/UpdateFilesystem.md)

 - [UpdateGpuCluster](audit/compute/events-ref/UpdateGpuCluster.md)

 - [UpdateHost](audit/compute/events-ref/UpdateHost.md)

 - [UpdateHostGroup](audit/compute/events-ref/UpdateHostGroup.md)

 - [UpdateImage](audit/compute/events-ref/UpdateImage.md)

 - [UpdateInstance](audit/compute/events-ref/UpdateInstance.md)

 - [UpdateInstanceGroup](audit/compute/events-ref/UpdateInstanceGroup.md)

 - [UpdateInstanceGroupAccessBindings](audit/compute/events-ref/UpdateInstanceGroupAccessBindings.md)

 - [UpdateInstanceMetadata](audit/compute/events-ref/UpdateInstanceMetadata.md)

 - [UpdateInstanceNetworkInterface](audit/compute/events-ref/UpdateInstanceNetworkInterface.md)

 - [UpdatePlacementGroup](audit/compute/events-ref/UpdatePlacementGroup.md)

 - [UpdateReservedInstancePool](audit/compute/events-ref/UpdateReservedInstancePool.md)

 - [UpdateSnapshot](audit/compute/events-ref/UpdateSnapshot.md)

 - [UpdateSnapshotSchedule](audit/compute/events-ref/UpdateSnapshotSchedule.md)

 - [UpdateSnapshotScheduleDisks](audit/compute/events-ref/UpdateSnapshotScheduleDisks.md)

### containerregistry

 - [CreateImage](audit/containerregistry/events-ref/CreateImage.md)

 - [CreateImageTag](audit/containerregistry/events-ref/CreateImageTag.md)

 - [CreateLifecyclePolicy](audit/containerregistry/events-ref/CreateLifecyclePolicy.md)

 - [CreateRegistry](audit/containerregistry/events-ref/CreateRegistry.md)

 - [CreateRepository](audit/containerregistry/events-ref/CreateRepository.md)

 - [CreateScanPolicy](audit/containerregistry/events-ref/CreateScanPolicy.md)

 - [DeleteImage](audit/containerregistry/events-ref/DeleteImage.md)

 - [DeleteImageTag](audit/containerregistry/events-ref/DeleteImageTag.md)

 - [DeleteLifecyclePolicy](audit/containerregistry/events-ref/DeleteLifecyclePolicy.md)

 - [DeleteRegistry](audit/containerregistry/events-ref/DeleteRegistry.md)

 - [DeleteRepository](audit/containerregistry/events-ref/DeleteRepository.md)

 - [DeleteScanPolicy](audit/containerregistry/events-ref/DeleteScanPolicy.md)

 - [ScanImage](audit/containerregistry/events-ref/ScanImage.md)

 - [SetIpPermission](audit/containerregistry/events-ref/SetIpPermission.md)

 - [SetRegistryAccessBindings](audit/containerregistry/events-ref/SetRegistryAccessBindings.md)

 - [SetRepositoryAccessBindings](audit/containerregistry/events-ref/SetRepositoryAccessBindings.md)

 - [UpdateIpPermission](audit/containerregistry/events-ref/UpdateIpPermission.md)

 - [UpdateLifecyclePolicy](audit/containerregistry/events-ref/UpdateLifecyclePolicy.md)

 - [UpdateRegistry](audit/containerregistry/events-ref/UpdateRegistry.md)

 - [UpdateRegistryAccessBindings](audit/containerregistry/events-ref/UpdateRegistryAccessBindings.md)

 - [UpdateRepositoryAccessBindings](audit/containerregistry/events-ref/UpdateRepositoryAccessBindings.md)

 - [UpdateScanPolicy](audit/containerregistry/events-ref/UpdateScanPolicy.md)

### datalens

 - [CopyEntriesToWorkbook](audit/datalens/events-ref/CopyEntriesToWorkbook.md)

 - [CopyEntry](audit/datalens/events-ref/CopyEntry.md)

 - [CopyTemplate](audit/datalens/events-ref/CopyTemplate.md)

 - [CopyWorkbook](audit/datalens/events-ref/CopyWorkbook.md)

 - [CreateCollection](audit/datalens/events-ref/CreateCollection.md)

 - [CreateColorPalette](audit/datalens/events-ref/CreateColorPalette.md)

 - [CreateEmbed](audit/datalens/events-ref/CreateEmbed.md)

 - [CreateEmbeddingSecret](audit/datalens/events-ref/CreateEmbeddingSecret.md)

 - [CreateEntityBinding](audit/datalens/events-ref/CreateEntityBinding.md)

 - [CreateEntry](audit/datalens/events-ref/CreateEntry.md)

 - [CreateWorkbook](audit/datalens/events-ref/CreateWorkbook.md)

 - [DeleteCollections](audit/datalens/events-ref/DeleteCollections.md)

 - [DeleteColorPalette](audit/datalens/events-ref/DeleteColorPalette.md)

 - [DeleteEmbed](audit/datalens/events-ref/DeleteEmbed.md)

 - [DeleteEmbeddingSecret](audit/datalens/events-ref/DeleteEmbeddingSecret.md)

 - [DeleteEntityBinding](audit/datalens/events-ref/DeleteEntityBinding.md)

 - [DeleteEntry](audit/datalens/events-ref/DeleteEntry.md)

 - [DeleteSharedEntry](audit/datalens/events-ref/DeleteSharedEntry.md)

 - [DeleteWorkbooks](audit/datalens/events-ref/DeleteWorkbooks.md)

 - [DisableBillingInstanceService](audit/datalens/events-ref/DisableBillingInstanceService.md)

 - [DisableFolders](audit/datalens/events-ref/DisableFolders.md)

 - [DisableTenantBilling](audit/datalens/events-ref/DisableTenantBilling.md)

 - [EnableBillingInstanceService](audit/datalens/events-ref/EnableBillingInstanceService.md)

 - [EnableTenantBilling](audit/datalens/events-ref/EnableTenantBilling.md)

 - [FolderEntryBatchModifyPermissions](audit/datalens/events-ref/FolderEntryBatchModifyPermissions.md)

 - [FolderEntryModifyPermissions](audit/datalens/events-ref/FolderEntryModifyPermissions.md)

 - [MigrateEntriesToWorkbook](audit/datalens/events-ref/MigrateEntriesToWorkbook.md)

 - [MoveCollections](audit/datalens/events-ref/MoveCollections.md)

 - [MoveEntry](audit/datalens/events-ref/MoveEntry.md)

 - [MoveSharedEntry](audit/datalens/events-ref/MoveSharedEntry.md)

 - [MoveWorkbooks](audit/datalens/events-ref/MoveWorkbooks.md)

 - [RenameEntry](audit/datalens/events-ref/RenameEntry.md)

 - [SetDefaultColorPalette](audit/datalens/events-ref/SetDefaultColorPalette.md)

 - [SwitchAiAssistantProhibition](audit/datalens/events-ref/SwitchAiAssistantProhibition.md)

 - [SwitchDataExportProhibition](audit/datalens/events-ref/SwitchDataExportProhibition.md)

 - [SwitchEntriesPublicationStatus](audit/datalens/events-ref/SwitchEntriesPublicationStatus.md)

 - [SwitchPublicationProhibition](audit/datalens/events-ref/SwitchPublicationProhibition.md)

 - [SwitchWorkbookFileExportProhibition](audit/datalens/events-ref/SwitchWorkbookFileExportProhibition.md)

 - [UpdateCollection](audit/datalens/events-ref/UpdateCollection.md)

 - [UpdateCollectionAccessBindings](audit/datalens/events-ref/UpdateCollectionAccessBindings.md)

 - [UpdateColorPalette](audit/datalens/events-ref/UpdateColorPalette.md)

 - [UpdateEmbed](audit/datalens/events-ref/UpdateEmbed.md)

 - [UpdateEntityBinding](audit/datalens/events-ref/UpdateEntityBinding.md)

 - [UpdateEntry](audit/datalens/events-ref/UpdateEntry.md)

 - [UpdateSharedEntryAccessBindings](audit/datalens/events-ref/UpdateSharedEntryAccessBindings.md)

 - [UpdateWorkbook](audit/datalens/events-ref/UpdateWorkbook.md)

 - [UpdateWorkbookAccessBindings](audit/datalens/events-ref/UpdateWorkbookAccessBindings.md)

### dataproc

 - [CreateCluster](audit/dataproc/events-ref/CreateCluster.md)

 - [CreateSubcluster](audit/dataproc/events-ref/CreateSubcluster.md)

 - [DeleteCluster](audit/dataproc/events-ref/DeleteCluster.md)

 - [DeleteSubcluster](audit/dataproc/events-ref/DeleteSubcluster.md)

 - [StartCluster](audit/dataproc/events-ref/StartCluster.md)

 - [StopCluster](audit/dataproc/events-ref/StopCluster.md)

 - [UpdateCluster](audit/dataproc/events-ref/UpdateCluster.md)

 - [UpdateSubcluster](audit/dataproc/events-ref/UpdateSubcluster.md)

### datasphere

 - [ActivateDataset](audit/datasphere/events-ref/ActivateDataset.md)

 - [ActivateDocker](audit/datasphere/events-ref/ActivateDocker.md)

 - [CancelJob](audit/datasphere/events-ref/CancelJob.md)

 - [CloneJob](audit/datasphere/events-ref/CloneJob.md)

 - [CloseProject](audit/datasphere/events-ref/CloseProject.md)

 - [CreateCommunity](audit/datasphere/events-ref/CreateCommunity.md)

 - [CreateDataset](audit/datasphere/events-ref/CreateDataset.md)

 - [CreateDocker](audit/datasphere/events-ref/CreateDocker.md)

 - [CreateFilestore](audit/datasphere/events-ref/CreateFilestore.md)

 - [CreateJob](audit/datasphere/events-ref/CreateJob.md)

 - [CreateModel](audit/datasphere/events-ref/CreateModel.md)

 - [CreateNode](audit/datasphere/events-ref/CreateNode.md)

 - [CreateProject](audit/datasphere/events-ref/CreateProject.md)

 - [CreateS3Connector](audit/datasphere/events-ref/CreateS3Connector.md)

 - [CreateSecret](audit/datasphere/events-ref/CreateSecret.md)

 - [CreateSparkConnector](audit/datasphere/events-ref/CreateSparkConnector.md)

 - [CreateYandexDataProcessing](audit/datasphere/events-ref/CreateYandexDataProcessing.md)

 - [DeactivateDataset](audit/datasphere/events-ref/DeactivateDataset.md)

 - [DeleteAllJobData](audit/datasphere/events-ref/DeleteAllJobData.md)

 - [DeleteCommunity](audit/datasphere/events-ref/DeleteCommunity.md)

 - [DeleteDataset](audit/datasphere/events-ref/DeleteDataset.md)

 - [DeleteDocker](audit/datasphere/events-ref/DeleteDocker.md)

 - [DeleteFilestore](audit/datasphere/events-ref/DeleteFilestore.md)

 - [DeleteJobData](audit/datasphere/events-ref/DeleteJobData.md)

 - [DeleteModel](audit/datasphere/events-ref/DeleteModel.md)

 - [DeleteNode](audit/datasphere/events-ref/DeleteNode.md)

 - [DeleteProject](audit/datasphere/events-ref/DeleteProject.md)

 - [DeleteS3Connector](audit/datasphere/events-ref/DeleteS3Connector.md)

 - [DeleteSecret](audit/datasphere/events-ref/DeleteSecret.md)

 - [DeleteSparkConnector](audit/datasphere/events-ref/DeleteSparkConnector.md)

 - [DeleteYandexDataProcessing](audit/datasphere/events-ref/DeleteYandexDataProcessing.md)

 - [ExecuteJob](audit/datasphere/events-ref/ExecuteJob.md)

 - [ExecuteJupyterNotebook](audit/datasphere/events-ref/ExecuteJupyterNotebook.md)

 - [ExportJupyterNotebook](audit/datasphere/events-ref/ExportJupyterNotebook.md)

 - [ExportJupyterProject](audit/datasphere/events-ref/ExportJupyterProject.md)

 - [OpenProject](audit/datasphere/events-ref/OpenProject.md)

 - [ResumeNode](audit/datasphere/events-ref/ResumeNode.md)

 - [SetCommunityAccessBindings](audit/datasphere/events-ref/SetCommunityAccessBindings.md)

 - [SetProjectAccessBindings](audit/datasphere/events-ref/SetProjectAccessBindings.md)

 - [SuspendNode](audit/datasphere/events-ref/SuspendNode.md)

 - [UpdateCommunity](audit/datasphere/events-ref/UpdateCommunity.md)

 - [UpdateCommunityAccessBindings](audit/datasphere/events-ref/UpdateCommunityAccessBindings.md)

 - [UpdateFilestore](audit/datasphere/events-ref/UpdateFilestore.md)

 - [UpdateJobDataTtl](audit/datasphere/events-ref/UpdateJobDataTtl.md)

 - [UpdateModel](audit/datasphere/events-ref/UpdateModel.md)

 - [UpdateNode](audit/datasphere/events-ref/UpdateNode.md)

 - [UpdateProject](audit/datasphere/events-ref/UpdateProject.md)

 - [UpdateProjectAccessBindings](audit/datasphere/events-ref/UpdateProjectAccessBindings.md)

 - [UpdateS3Connector](audit/datasphere/events-ref/UpdateS3Connector.md)

 - [UpdateSecret](audit/datasphere/events-ref/UpdateSecret.md)

 - [UpdateSparkConnector](audit/datasphere/events-ref/UpdateSparkConnector.md)

 - [UpdateYandexDataProcessing](audit/datasphere/events-ref/UpdateYandexDataProcessing.md)

### datatransfer

 - [ActivateTransfer](audit/datatransfer/events-ref/ActivateTransfer.md)

 - [AddTablesToTransfer](audit/datatransfer/events-ref/AddTablesToTransfer.md)

 - [CreateEndpoint](audit/datatransfer/events-ref/CreateEndpoint.md)

 - [CreateTransfer](audit/datatransfer/events-ref/CreateTransfer.md)

 - [DeactivateTransfer](audit/datatransfer/events-ref/DeactivateTransfer.md)

 - [DeleteEndpoint](audit/datatransfer/events-ref/DeleteEndpoint.md)

 - [DeleteTransfer](audit/datatransfer/events-ref/DeleteTransfer.md)

 - [FreezeTransferVersion](audit/datatransfer/events-ref/FreezeTransferVersion.md)

 - [PauseTransfer](audit/datatransfer/events-ref/PauseTransfer.md)

 - [RemoveTablesFromTransfer](audit/datatransfer/events-ref/RemoveTablesFromTransfer.md)

 - [RestartTransfer](audit/datatransfer/events-ref/RestartTransfer.md)

 - [ReUploadTransfer](audit/datatransfer/events-ref/ReUploadTransfer.md)

 - [StartTransfer](audit/datatransfer/events-ref/StartTransfer.md)

 - [TestTransfer](audit/datatransfer/events-ref/TestTransfer.md)

 - [UnfreezeTransferVersion](audit/datatransfer/events-ref/UnfreezeTransferVersion.md)

 - [UpdateEndpoint](audit/datatransfer/events-ref/UpdateEndpoint.md)

 - [UpdateTransfer](audit/datatransfer/events-ref/UpdateTransfer.md)

 - [UpdateTransferVersion](audit/datatransfer/events-ref/UpdateTransferVersion.md)

 - [UploadTransfer](audit/datatransfer/events-ref/UploadTransfer.md)

### dns

 - [CreateDnsFirewall](audit/dns/events-ref/CreateDnsFirewall.md)

 - [CreateDnsInboundEndpoint](audit/dns/events-ref/CreateDnsInboundEndpoint.md)

 - [CreateDnsZone](audit/dns/events-ref/CreateDnsZone.md)

 - [DeleteDnsFirewall](audit/dns/events-ref/DeleteDnsFirewall.md)

 - [DeleteDnsInboundEndpoint](audit/dns/events-ref/DeleteDnsInboundEndpoint.md)

 - [DeleteDnsZone](audit/dns/events-ref/DeleteDnsZone.md)

 - [MoveDnsFirewall](audit/dns/events-ref/MoveDnsFirewall.md)

 - [MoveDnsZone](audit/dns/events-ref/MoveDnsZone.md)

 - [ProcessDnsQuery](audit/dns/events-ref/ProcessDnsQuery.md)

 - [SetDnsFirewallAccessBindings](audit/dns/events-ref/SetDnsFirewallAccessBindings.md)

 - [SetDnsInboundEndpointAccessBindings](audit/dns/events-ref/SetDnsInboundEndpointAccessBindings.md)

 - [SetDnsZoneAccessBindings](audit/dns/events-ref/SetDnsZoneAccessBindings.md)

 - [UpdateDnsFirewall](audit/dns/events-ref/UpdateDnsFirewall.md)

 - [UpdateDnsFirewallAccessBindings](audit/dns/events-ref/UpdateDnsFirewallAccessBindings.md)

 - [UpdateDnsInboundEndpoint](audit/dns/events-ref/UpdateDnsInboundEndpoint.md)

 - [UpdateDnsInboundEndpointAccessBindings](audit/dns/events-ref/UpdateDnsInboundEndpointAccessBindings.md)

 - [UpdateDnsZone](audit/dns/events-ref/UpdateDnsZone.md)

 - [UpdateDnsZoneAccessBindings](audit/dns/events-ref/UpdateDnsZoneAccessBindings.md)

 - [UpdatePrivateNetworks](audit/dns/events-ref/UpdatePrivateNetworks.md)

 - [UpdateRecordSets](audit/dns/events-ref/UpdateRecordSets.md)

### gitlab

 - [BackupInstance](audit/gitlab/events-ref/BackupInstance.md)

 - [CleanupRegistryInstance](audit/gitlab/events-ref/CleanupRegistryInstance.md)

 - [CreateInstance](audit/gitlab/events-ref/CreateInstance.md)

 - [CreateInstanceBackup](audit/gitlab/events-ref/CreateInstanceBackup.md)

 - [CreateRunner](audit/gitlab/events-ref/CreateRunner.md)

 - [DeleteInstance](audit/gitlab/events-ref/DeleteInstance.md)

 - [DeleteRunner](audit/gitlab/events-ref/DeleteRunner.md)

 - [FinishMigration](audit/gitlab/events-ref/FinishMigration.md)

 - [PrepareBackupUpload](audit/gitlab/events-ref/PrepareBackupUpload.md)

 - [ReconfigureGitlab](audit/gitlab/events-ref/ReconfigureGitlab.md)

 - [RescheduleMaintenance](audit/gitlab/events-ref/RescheduleMaintenance.md)

 - [ResizeInstance](audit/gitlab/events-ref/ResizeInstance.md)

 - [RestoreInstanceBackup](audit/gitlab/events-ref/RestoreInstanceBackup.md)

 - [RollbackMigration](audit/gitlab/events-ref/RollbackMigration.md)

 - [ScheduleUpgrade](audit/gitlab/events-ref/ScheduleUpgrade.md)

 - [StartInstance](audit/gitlab/events-ref/StartInstance.md)

 - [StartMigration](audit/gitlab/events-ref/StartMigration.md)

 - [StartRunner](audit/gitlab/events-ref/StartRunner.md)

 - [StopInstance](audit/gitlab/events-ref/StopInstance.md)

 - [StopRunner](audit/gitlab/events-ref/StopRunner.md)

 - [UpdateInstance](audit/gitlab/events-ref/UpdateInstance.md)

 - [UpdateOmniauthInstance](audit/gitlab/events-ref/UpdateOmniauthInstance.md)

 - [UpdateRunner](audit/gitlab/events-ref/UpdateRunner.md)

 - [UpgradeInstance](audit/gitlab/events-ref/UpgradeInstance.md)

### iam

 - [AccessKeyLastUsed](audit/iam/events-ref/AccessKeyLastUsed.md)

 - [AddFederatedUserAccounts](audit/iam/events-ref/AddFederatedUserAccounts.md)

 - [ApplicationLoginEvent](audit/iam/events-ref/ApplicationLoginEvent.md)

 - [CheckSshPolicy](audit/iam/events-ref/CheckSshPolicy.md)

 - [CreateAccessKey](audit/iam/events-ref/CreateAccessKey.md)

 - [CreateApiKey](audit/iam/events-ref/CreateApiKey.md)

 - [CreateCertificate](audit/iam/events-ref/CreateCertificate.md)

 - [CreateEphemeralAccessKey](audit/iam/events-ref/CreateEphemeralAccessKey.md)

 - [CreateFederatedCredential](audit/iam/events-ref/CreateFederatedCredential.md)

 - [CreateFederation](audit/iam/events-ref/CreateFederation.md)

 - [CreateFederation](audit/iam/events-ref/CreateFederation.md)

 - [CreateIamCookieForSubject](audit/iam/events-ref/CreateIamCookieForSubject.md)

 - [CreateIamToken](audit/iam/events-ref/CreateIamToken.md)

 - [CreateKey](audit/iam/events-ref/CreateKey.md)

 - [CreateOAuthClient](audit/iam/events-ref/CreateOAuthClient.md)

 - [CreateOAuthClientSecret](audit/iam/events-ref/CreateOAuthClientSecret.md)

 - [CreateRefreshTokenForSubject](audit/iam/events-ref/CreateRefreshTokenForSubject.md)

 - [CreateServiceAccount](audit/iam/events-ref/CreateServiceAccount.md)

 - [CreateTemporaryAccessKey](audit/iam/events-ref/CreateTemporaryAccessKey.md)

 - [CreateUserCredential](audit/iam/events-ref/CreateUserCredential.md)

 - [CreateYcSsprToken](audit/iam/events-ref/CreateYcSsprToken.md)

 - [DeleteAccessKey](audit/iam/events-ref/DeleteAccessKey.md)

 - [DeleteApiKey](audit/iam/events-ref/DeleteApiKey.md)

 - [DeleteCertificate](audit/iam/events-ref/DeleteCertificate.md)

 - [DeleteFederatedCredential](audit/iam/events-ref/DeleteFederatedCredential.md)

 - [DeleteFederation](audit/iam/events-ref/DeleteFederation.md)

 - [DeleteFederation](audit/iam/events-ref/DeleteFederation.md)

 - [DeleteKey](audit/iam/events-ref/DeleteKey.md)

 - [DeleteOAuthClient](audit/iam/events-ref/DeleteOAuthClient.md)

 - [DeleteOAuthClientSecret](audit/iam/events-ref/DeleteOAuthClientSecret.md)

 - [DeleteServiceAccount](audit/iam/events-ref/DeleteServiceAccount.md)

 - [DeleteUserCredential](audit/iam/events-ref/DeleteUserCredential.md)

 - [DetectLeakedCredential](audit/iam/events-ref/DetectLeakedCredential.md)

 - [DisableService](audit/iam/events-ref/DisableService.md)

 - [EnableService](audit/iam/events-ref/EnableService.md)

 - [GenerateSshCertificate](audit/iam/events-ref/GenerateSshCertificate.md)

 - [ReactivateServiceAccount](audit/iam/events-ref/ReactivateServiceAccount.md)

 - [RevokeIamToken](audit/iam/events-ref/RevokeIamToken.md)

 - [RevokeLeakedCredential](audit/iam/events-ref/RevokeLeakedCredential.md)

 - [RevokeRefreshTokenForSubject](audit/iam/events-ref/RevokeRefreshTokenForSubject.md)

 - [RevokeSsoSession](audit/iam/events-ref/RevokeSsoSession.md)

 - [SetFederationAccessBindings](audit/iam/events-ref/SetFederationAccessBindings.md)

 - [SetServiceAccountAccessBindings](audit/iam/events-ref/SetServiceAccountAccessBindings.md)

 - [SuspendServiceAccount](audit/iam/events-ref/SuspendServiceAccount.md)

 - [UpdateAccessKey](audit/iam/events-ref/UpdateAccessKey.md)

 - [UpdateApiKey](audit/iam/events-ref/UpdateApiKey.md)

 - [UpdateCertificate](audit/iam/events-ref/UpdateCertificate.md)

 - [UpdateFederation](audit/iam/events-ref/UpdateFederation.md)

 - [UpdateFederation](audit/iam/events-ref/UpdateFederation.md)

 - [UpdateFederationAccessBindings](audit/iam/events-ref/UpdateFederationAccessBindings.md)

 - [UpdateKey](audit/iam/events-ref/UpdateKey.md)

 - [UpdateOAuthClient](audit/iam/events-ref/UpdateOAuthClient.md)

 - [UpdateServiceAccount](audit/iam/events-ref/UpdateServiceAccount.md)

 - [UpdateServiceAccountAccessBindings](audit/iam/events-ref/UpdateServiceAccountAccessBindings.md)

 - [UpdateUserCredential](audit/iam/events-ref/UpdateUserCredential.md)

 - [VerifyUserCredential](audit/iam/events-ref/VerifyUserCredential.md)

### iot

 - [AddBrokerCertificate](audit/iot/events-ref/AddBrokerCertificate.md)

 - [AddBrokerPassword](audit/iot/events-ref/AddBrokerPassword.md)

 - [AddDeviceCertificate](audit/iot/events-ref/AddDeviceCertificate.md)

 - [AddDevicePassword](audit/iot/events-ref/AddDevicePassword.md)

 - [AddRegistryCertificate](audit/iot/events-ref/AddRegistryCertificate.md)

 - [AddRegistryPassword](audit/iot/events-ref/AddRegistryPassword.md)

 - [CreateBroker](audit/iot/events-ref/CreateBroker.md)

 - [CreateDevice](audit/iot/events-ref/CreateDevice.md)

 - [CreateRegistry](audit/iot/events-ref/CreateRegistry.md)

 - [DeleteBroker](audit/iot/events-ref/DeleteBroker.md)

 - [DeleteBrokerCertificate](audit/iot/events-ref/DeleteBrokerCertificate.md)

 - [DeleteBrokerPassword](audit/iot/events-ref/DeleteBrokerPassword.md)

 - [DeleteDevice](audit/iot/events-ref/DeleteDevice.md)

 - [DeleteDeviceCertificate](audit/iot/events-ref/DeleteDeviceCertificate.md)

 - [DeleteDevicePassword](audit/iot/events-ref/DeleteDevicePassword.md)

 - [DeleteRegistry](audit/iot/events-ref/DeleteRegistry.md)

 - [DeleteRegistryCertificate](audit/iot/events-ref/DeleteRegistryCertificate.md)

 - [DeleteRegistryPassword](audit/iot/events-ref/DeleteRegistryPassword.md)

 - [UpdateBroker](audit/iot/events-ref/UpdateBroker.md)

 - [UpdateDevice](audit/iot/events-ref/UpdateDevice.md)

 - [UpdateRegistry](audit/iot/events-ref/UpdateRegistry.md)

### k8s

 - [ApiServerApprove](audit/k8s/events-ref/ApiServerApprove.md)

 - [ApiServerBind](audit/k8s/events-ref/ApiServerBind.md)

 - [ApiServerCreate](audit/k8s/events-ref/ApiServerCreate.md)

 - [ApiServerDelete](audit/k8s/events-ref/ApiServerDelete.md)

 - [ApiServerDeleteCollection](audit/k8s/events-ref/ApiServerDeleteCollection.md)

 - [ApiServerEscalate](audit/k8s/events-ref/ApiServerEscalate.md)

 - [ApiServerGet](audit/k8s/events-ref/ApiServerGet.md)

 - [ApiServerHead](audit/k8s/events-ref/ApiServerHead.md)

 - [ApiServerImpersonate](audit/k8s/events-ref/ApiServerImpersonate.md)

 - [ApiServerList](audit/k8s/events-ref/ApiServerList.md)

 - [ApiServerNonstandardVerb](audit/k8s/events-ref/ApiServerNonstandardVerb.md)

 - [ApiServerOptions](audit/k8s/events-ref/ApiServerOptions.md)

 - [ApiServerPatch](audit/k8s/events-ref/ApiServerPatch.md)

 - [ApiServerPost](audit/k8s/events-ref/ApiServerPost.md)

 - [ApiServerPut](audit/k8s/events-ref/ApiServerPut.md)

 - [ApiServerUpdate](audit/k8s/events-ref/ApiServerUpdate.md)

 - [ApiServerWatch](audit/k8s/events-ref/ApiServerWatch.md)

 - [AutoUpgradeCluster](audit/k8s/events-ref/AutoUpgradeCluster.md)

 - [AutoUpgradeNodeGroup](audit/k8s/events-ref/AutoUpgradeNodeGroup.md)

 - [CreateCluster](audit/k8s/events-ref/CreateCluster.md)

 - [CreateNodeGroup](audit/k8s/events-ref/CreateNodeGroup.md)

 - [DeleteCluster](audit/k8s/events-ref/DeleteCluster.md)

 - [DeleteNodeGroup](audit/k8s/events-ref/DeleteNodeGroup.md)

 - [DeleteStoppedCluster](audit/k8s/events-ref/DeleteStoppedCluster.md)

 - [InstallHelmRelease](audit/k8s/events-ref/InstallHelmRelease.md)

 - [ScaleMaster](audit/k8s/events-ref/ScaleMaster.md)

 - [SetClusterAccessBindings](audit/k8s/events-ref/SetClusterAccessBindings.md)

 - [StartCluster](audit/k8s/events-ref/StartCluster.md)

 - [StopCluster](audit/k8s/events-ref/StopCluster.md)

 - [UninstallHelmRelease](audit/k8s/events-ref/UninstallHelmRelease.md)

 - [UpdateCluster](audit/k8s/events-ref/UpdateCluster.md)

 - [UpdateClusterAccessBindings](audit/k8s/events-ref/UpdateClusterAccessBindings.md)

 - [UpdateClusterCertificate](audit/k8s/events-ref/UpdateClusterCertificate.md)

 - [UpdateHelmRelease](audit/k8s/events-ref/UpdateHelmRelease.md)

 - [UpdateNodeGroup](audit/k8s/events-ref/UpdateNodeGroup.md)

### kms

 - [AsymmetricDecrypt](audit/kms/events-ref/AsymmetricDecrypt.md)

 - [AsymmetricGetPublicKey](audit/kms/events-ref/AsymmetricGetPublicKey.md)

 - [AsymmetricGetPublicKey](audit/kms/events-ref/AsymmetricGetPublicKey.md)

 - [AsymmetricSign](audit/kms/events-ref/AsymmetricSign.md)

 - [AsymmetricSignHash](audit/kms/events-ref/AsymmetricSignHash.md)

 - [CancelAsymmetricEncryptionKeyDeletion](audit/kms/events-ref/CancelAsymmetricEncryptionKeyDeletion.md)

 - [CancelAsymmetricSignatureKeyDeletion](audit/kms/events-ref/CancelAsymmetricSignatureKeyDeletion.md)

 - [CancelDeleteSymmetricKey](audit/kms/events-ref/CancelDeleteSymmetricKey.md)

 - [CancelSymmetricKeyVersionDestruction](audit/kms/events-ref/CancelSymmetricKeyVersionDestruction.md)

 - [CreateAsymmetricEncryptionKey](audit/kms/events-ref/CreateAsymmetricEncryptionKey.md)

 - [CreateAsymmetricSignatureKey](audit/kms/events-ref/CreateAsymmetricSignatureKey.md)

 - [CreateSymmetricKey](audit/kms/events-ref/CreateSymmetricKey.md)

 - [Decrypt](audit/kms/events-ref/Decrypt.md)

 - [DeleteAsymmetricEncryptionKey](audit/kms/events-ref/DeleteAsymmetricEncryptionKey.md)

 - [DeleteAsymmetricSignatureKey](audit/kms/events-ref/DeleteAsymmetricSignatureKey.md)

 - [DeleteSymmetricKey](audit/kms/events-ref/DeleteSymmetricKey.md)

 - [Encrypt](audit/kms/events-ref/Encrypt.md)

 - [GenerateDataKey](audit/kms/events-ref/GenerateDataKey.md)

 - [ReEncrypt](audit/kms/events-ref/ReEncrypt.md)

 - [RotateSymmetricKey](audit/kms/events-ref/RotateSymmetricKey.md)

 - [ScheduleSymmetricKeyVersionDestruction](audit/kms/events-ref/ScheduleSymmetricKeyVersionDestruction.md)

 - [SetAsymmetricEncryptionKeyAccessBindings](audit/kms/events-ref/SetAsymmetricEncryptionKeyAccessBindings.md)

 - [SetAsymmetricSignatureKeyAccessBindings](audit/kms/events-ref/SetAsymmetricSignatureKeyAccessBindings.md)

 - [SetPrimarySymmetricKeyVersion](audit/kms/events-ref/SetPrimarySymmetricKeyVersion.md)

 - [SetSymmetricKeyAccessBindings](audit/kms/events-ref/SetSymmetricKeyAccessBindings.md)

 - [UpdateAsymmetricEncryptionKey](audit/kms/events-ref/UpdateAsymmetricEncryptionKey.md)

 - [UpdateAsymmetricEncryptionKeyAccessBindings](audit/kms/events-ref/UpdateAsymmetricEncryptionKeyAccessBindings.md)

 - [UpdateAsymmetricSignatureKey](audit/kms/events-ref/UpdateAsymmetricSignatureKey.md)

 - [UpdateAsymmetricSignatureKeyAccessBindings](audit/kms/events-ref/UpdateAsymmetricSignatureKeyAccessBindings.md)

 - [UpdateSymmetricKey](audit/kms/events-ref/UpdateSymmetricKey.md)

 - [UpdateSymmetricKeyAccessBindings](audit/kms/events-ref/UpdateSymmetricKeyAccessBindings.md)

### loadbalancer

 - [AddNetworkLoadBalancerListener](audit/loadbalancer/events-ref/AddNetworkLoadBalancerListener.md)

 - [AddTargetGroupTargets](audit/loadbalancer/events-ref/AddTargetGroupTargets.md)

 - [AttachNetworkLoadBalancerTargetGroup](audit/loadbalancer/events-ref/AttachNetworkLoadBalancerTargetGroup.md)

 - [CreateNetworkLoadBalancer](audit/loadbalancer/events-ref/CreateNetworkLoadBalancer.md)

 - [CreateTargetGroup](audit/loadbalancer/events-ref/CreateTargetGroup.md)

 - [DeleteNetworkLoadBalancer](audit/loadbalancer/events-ref/DeleteNetworkLoadBalancer.md)

 - [DeleteTargetGroup](audit/loadbalancer/events-ref/DeleteTargetGroup.md)

 - [DetachNetworkLoadBalancerTargetGroup](audit/loadbalancer/events-ref/DetachNetworkLoadBalancerTargetGroup.md)

 - [DisableNetworkLoadBalancerZones](audit/loadbalancer/events-ref/DisableNetworkLoadBalancerZones.md)

 - [EnableNetworkLoadBalancerZones](audit/loadbalancer/events-ref/EnableNetworkLoadBalancerZones.md)

 - [RemoveNetworkLoadBalancerListener](audit/loadbalancer/events-ref/RemoveNetworkLoadBalancerListener.md)

 - [RemoveTargetGroupTargets](audit/loadbalancer/events-ref/RemoveTargetGroupTargets.md)

 - [StartNetworkLoadBalancer](audit/loadbalancer/events-ref/StartNetworkLoadBalancer.md)

 - [StopNetworkLoadBalancer](audit/loadbalancer/events-ref/StopNetworkLoadBalancer.md)

 - [UpdateNetworkLoadBalancer](audit/loadbalancer/events-ref/UpdateNetworkLoadBalancer.md)

 - [UpdateTargetGroup](audit/loadbalancer/events-ref/UpdateTargetGroup.md)

### loadtesting

 - [CreateAgent](audit/loadtesting/events-ref/CreateAgent.md)

 - [CreateConfig](audit/loadtesting/events-ref/CreateConfig.md)

 - [CreateMigration](audit/loadtesting/events-ref/CreateMigration.md)

 - [CreateRegressionDashboard](audit/loadtesting/events-ref/CreateRegressionDashboard.md)

 - [CreateTest](audit/loadtesting/events-ref/CreateTest.md)

 - [DeleteAgent](audit/loadtesting/events-ref/DeleteAgent.md)

 - [DeleteConfig](audit/loadtesting/events-ref/DeleteConfig.md)

 - [DeleteRegressionDashboard](audit/loadtesting/events-ref/DeleteRegressionDashboard.md)

 - [DeleteTest](audit/loadtesting/events-ref/DeleteTest.md)

 - [RestartAgent](audit/loadtesting/events-ref/RestartAgent.md)

 - [StartAgent](audit/loadtesting/events-ref/StartAgent.md)

 - [StopAgent](audit/loadtesting/events-ref/StopAgent.md)

 - [StopTest](audit/loadtesting/events-ref/StopTest.md)

 - [UpdateAgent](audit/loadtesting/events-ref/UpdateAgent.md)

 - [UpdateRegressionDashboard](audit/loadtesting/events-ref/UpdateRegressionDashboard.md)

 - [UpdateTest](audit/loadtesting/events-ref/UpdateTest.md)

 - [UpgradeImageAgent](audit/loadtesting/events-ref/UpgradeImageAgent.md)

### lockbox

 - [ActivateSecret](audit/lockbox/events-ref/ActivateSecret.md)

 - [AddVersion](audit/lockbox/events-ref/AddVersion.md)

 - [CancelVersionDestruction](audit/lockbox/events-ref/CancelVersionDestruction.md)

 - [CreateSecret](audit/lockbox/events-ref/CreateSecret.md)

 - [DeactivateSecret](audit/lockbox/events-ref/DeactivateSecret.md)

 - [DeleteSecret](audit/lockbox/events-ref/DeleteSecret.md)

 - [GetPayload](audit/lockbox/events-ref/GetPayload.md)

 - [GetPayloadEx](audit/lockbox/events-ref/GetPayloadEx.md)

 - [RotateSecret](audit/lockbox/events-ref/RotateSecret.md)

 - [ScheduleVersionDestruction](audit/lockbox/events-ref/ScheduleVersionDestruction.md)

 - [SetSecretAccessBindings](audit/lockbox/events-ref/SetSecretAccessBindings.md)

 - [UpdateSecret](audit/lockbox/events-ref/UpdateSecret.md)

 - [UpdateSecretAccessBindings](audit/lockbox/events-ref/UpdateSecretAccessBindings.md)

### logging

 - [ChangeLogGroupAccessBindings](audit/logging/events-ref/ChangeLogGroupAccessBindings.md)

 - [CreateExport](audit/logging/events-ref/CreateExport.md)

 - [CreateLogGroup](audit/logging/events-ref/CreateLogGroup.md)

 - [CreateRoutingRule](audit/logging/events-ref/CreateRoutingRule.md)

 - [CreateSink](audit/logging/events-ref/CreateSink.md)

 - [DeleteExport](audit/logging/events-ref/DeleteExport.md)

 - [DeleteLogGroup](audit/logging/events-ref/DeleteLogGroup.md)

 - [DeleteRoutingRule](audit/logging/events-ref/DeleteRoutingRule.md)

 - [DeleteSink](audit/logging/events-ref/DeleteSink.md)

 - [SetExportAccessBindings](audit/logging/events-ref/SetExportAccessBindings.md)

 - [SetLogGroupAccessBindings](audit/logging/events-ref/SetLogGroupAccessBindings.md)

 - [SetRoutingRuleAccessBindings](audit/logging/events-ref/SetRoutingRuleAccessBindings.md)

 - [SetSinkAccessBindings](audit/logging/events-ref/SetSinkAccessBindings.md)

 - [UpdateExport](audit/logging/events-ref/UpdateExport.md)

 - [UpdateExportAccessBindings](audit/logging/events-ref/UpdateExportAccessBindings.md)

 - [UpdateLogGroup](audit/logging/events-ref/UpdateLogGroup.md)

 - [UpdateLogGroupAccessBindings](audit/logging/events-ref/UpdateLogGroupAccessBindings.md)

 - [UpdateRoutingRule](audit/logging/events-ref/UpdateRoutingRule.md)

 - [UpdateRoutingRuleAccessBindings](audit/logging/events-ref/UpdateRoutingRuleAccessBindings.md)

 - [UpdateSink](audit/logging/events-ref/UpdateSink.md)

 - [UpdateSinkAccessBindings](audit/logging/events-ref/UpdateSinkAccessBindings.md)

### marketplace.licensemanager

 - [ActivateSubscriptionAutoRenewal](audit/marketplace/licensemanager/events-ref/ActivateSubscriptionAutoRenewal.md)

 - [CancelSubscriptionAutoRenewal](audit/marketplace/licensemanager/events-ref/CancelSubscriptionAutoRenewal.md)

 - [CreateLicenseInstance](audit/marketplace/licensemanager/events-ref/CreateLicenseInstance.md)

 - [DeleteLicenseInstance](audit/marketplace/licensemanager/events-ref/DeleteLicenseInstance.md)

 - [LockLicenseInstance](audit/marketplace/licensemanager/events-ref/LockLicenseInstance.md)

 - [MoveLicenseInstance](audit/marketplace/licensemanager/events-ref/MoveLicenseInstance.md)

 - [UnlockLicenseInstance](audit/marketplace/licensemanager/events-ref/UnlockLicenseInstance.md)

### mdb.clickhouse

 - [AddClusterHosts](audit/mdb/clickhouse/events-ref/AddClusterHosts.md)

 - [AddClusterShard](audit/mdb/clickhouse/events-ref/AddClusterShard.md)

 - [AddClusterShards](audit/mdb/clickhouse/events-ref/AddClusterShards.md)

 - [AddClusterZookeeper](audit/mdb/clickhouse/events-ref/AddClusterZookeeper.md)

 - [BackupCluster](audit/mdb/clickhouse/events-ref/BackupCluster.md)

 - [CreateCluster](audit/mdb/clickhouse/events-ref/CreateCluster.md)

 - [CreateClusterExtension](audit/mdb/clickhouse/events-ref/CreateClusterExtension.md)

 - [CreateClusterExternalDictionary](audit/mdb/clickhouse/events-ref/CreateClusterExternalDictionary.md)

 - [CreateDatabase](audit/mdb/clickhouse/events-ref/CreateDatabase.md)

 - [CreateFormatSchema](audit/mdb/clickhouse/events-ref/CreateFormatSchema.md)

 - [CreateMlModel](audit/mdb/clickhouse/events-ref/CreateMlModel.md)

 - [CreateShardGroup](audit/mdb/clickhouse/events-ref/CreateShardGroup.md)

 - [CreateUser](audit/mdb/clickhouse/events-ref/CreateUser.md)

 - [DatabaseUserLogin](audit/mdb/clickhouse/events-ref/DatabaseUserLogin.md)

 - [DatabaseUserLogout](audit/mdb/clickhouse/events-ref/DatabaseUserLogout.md)

 - [DatabaseUserSQLRequest](audit/mdb/clickhouse/events-ref/DatabaseUserSQLRequest.md)

 - [DeleteBackup](audit/mdb/clickhouse/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/clickhouse/events-ref/DeleteCluster.md)

 - [DeleteClusterExtension](audit/mdb/clickhouse/events-ref/DeleteClusterExtension.md)

 - [DeleteClusterExternalDictionary](audit/mdb/clickhouse/events-ref/DeleteClusterExternalDictionary.md)

 - [DeleteClusterHosts](audit/mdb/clickhouse/events-ref/DeleteClusterHosts.md)

 - [DeleteClusterShard](audit/mdb/clickhouse/events-ref/DeleteClusterShard.md)

 - [DeleteClusterShards](audit/mdb/clickhouse/events-ref/DeleteClusterShards.md)

 - [DeleteDatabase](audit/mdb/clickhouse/events-ref/DeleteDatabase.md)

 - [DeleteFormatSchema](audit/mdb/clickhouse/events-ref/DeleteFormatSchema.md)

 - [DeleteMlModel](audit/mdb/clickhouse/events-ref/DeleteMlModel.md)

 - [DeleteShardGroup](audit/mdb/clickhouse/events-ref/DeleteShardGroup.md)

 - [DeleteUser](audit/mdb/clickhouse/events-ref/DeleteUser.md)

 - [GetDatabase](audit/mdb/clickhouse/events-ref/GetDatabase.md)

 - [GetUser](audit/mdb/clickhouse/events-ref/GetUser.md)

 - [GrantUserPermission](audit/mdb/clickhouse/events-ref/GrantUserPermission.md)

 - [ListDatabases](audit/mdb/clickhouse/events-ref/ListDatabases.md)

 - [ListUsers](audit/mdb/clickhouse/events-ref/ListUsers.md)

 - [MoveCluster](audit/mdb/clickhouse/events-ref/MoveCluster.md)

 - [RescheduleMaintenance](audit/mdb/clickhouse/events-ref/RescheduleMaintenance.md)

 - [RestartClusterHosts](audit/mdb/clickhouse/events-ref/RestartClusterHosts.md)

 - [RestoreCluster](audit/mdb/clickhouse/events-ref/RestoreCluster.md)

 - [RevokeUserPermission](audit/mdb/clickhouse/events-ref/RevokeUserPermission.md)

 - [SetClusterAccessBindings](audit/mdb/clickhouse/events-ref/SetClusterAccessBindings.md)

 - [SetClusterExtensions](audit/mdb/clickhouse/events-ref/SetClusterExtensions.md)

 - [StartCluster](audit/mdb/clickhouse/events-ref/StartCluster.md)

 - [StopCluster](audit/mdb/clickhouse/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/clickhouse/events-ref/UpdateCluster.md)

 - [UpdateClusterAccessBindings](audit/mdb/clickhouse/events-ref/UpdateClusterAccessBindings.md)

 - [UpdateClusterExtension](audit/mdb/clickhouse/events-ref/UpdateClusterExtension.md)

 - [UpdateClusterExternalDictionary](audit/mdb/clickhouse/events-ref/UpdateClusterExternalDictionary.md)

 - [UpdateClusterHosts](audit/mdb/clickhouse/events-ref/UpdateClusterHosts.md)

 - [UpdateClusterShard](audit/mdb/clickhouse/events-ref/UpdateClusterShard.md)

 - [UpdateFormatSchema](audit/mdb/clickhouse/events-ref/UpdateFormatSchema.md)

 - [UpdateMlModel](audit/mdb/clickhouse/events-ref/UpdateMlModel.md)

 - [UpdateShardGroup](audit/mdb/clickhouse/events-ref/UpdateShardGroup.md)

 - [UpdateUser](audit/mdb/clickhouse/events-ref/UpdateUser.md)

### mdb.greenplum

 - [BatchUpdateHBARule](audit/mdb/greenplum/events-ref/BatchUpdateHBARule.md)

 - [CreateCluster](audit/mdb/greenplum/events-ref/CreateCluster.md)

 - [CreateHBARule](audit/mdb/greenplum/events-ref/CreateHBARule.md)

 - [CreatePXFDatasource](audit/mdb/greenplum/events-ref/CreatePXFDatasource.md)

 - [CreateResourceGroup](audit/mdb/greenplum/events-ref/CreateResourceGroup.md)

 - [CreateUser](audit/mdb/greenplum/events-ref/CreateUser.md)

 - [DeleteBackup](audit/mdb/greenplum/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/greenplum/events-ref/DeleteCluster.md)

 - [DeleteHBARule](audit/mdb/greenplum/events-ref/DeleteHBARule.md)

 - [DeletePXFDatasource](audit/mdb/greenplum/events-ref/DeletePXFDatasource.md)

 - [DeleteResourceGroup](audit/mdb/greenplum/events-ref/DeleteResourceGroup.md)

 - [DeleteUser](audit/mdb/greenplum/events-ref/DeleteUser.md)

 - [ExpandCluster](audit/mdb/greenplum/events-ref/ExpandCluster.md)

 - [ListPXFDatasources](audit/mdb/greenplum/events-ref/ListPXFDatasources.md)

 - [ListUsers](audit/mdb/greenplum/events-ref/ListUsers.md)

 - [MoveCluster](audit/mdb/greenplum/events-ref/MoveCluster.md)

 - [RestoreCluster](audit/mdb/greenplum/events-ref/RestoreCluster.md)

 - [StartCluster](audit/mdb/greenplum/events-ref/StartCluster.md)

 - [StopCluster](audit/mdb/greenplum/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/greenplum/events-ref/UpdateCluster.md)

 - [UpdateHBARule](audit/mdb/greenplum/events-ref/UpdateHBARule.md)

 - [UpdatePXFDatasource](audit/mdb/greenplum/events-ref/UpdatePXFDatasource.md)

 - [UpdateResourceGroup](audit/mdb/greenplum/events-ref/UpdateResourceGroup.md)

 - [UpdateUser](audit/mdb/greenplum/events-ref/UpdateUser.md)

### mdb.kafka

 - [AlterConfigAdminApi](audit/mdb/kafka/events-ref/AlterConfigAdminApi.md)

 - [CreateCluster](audit/mdb/kafka/events-ref/CreateCluster.md)

 - [CreateConnector](audit/mdb/kafka/events-ref/CreateConnector.md)

 - [CreateTopic](audit/mdb/kafka/events-ref/CreateTopic.md)

 - [CreateTopicAdminApi](audit/mdb/kafka/events-ref/CreateTopicAdminApi.md)

 - [CreateUser](audit/mdb/kafka/events-ref/CreateUser.md)

 - [DeleteCluster](audit/mdb/kafka/events-ref/DeleteCluster.md)

 - [DeleteConnector](audit/mdb/kafka/events-ref/DeleteConnector.md)

 - [DeleteTopic](audit/mdb/kafka/events-ref/DeleteTopic.md)

 - [DeleteTopicAdminApi](audit/mdb/kafka/events-ref/DeleteTopicAdminApi.md)

 - [DeleteUser](audit/mdb/kafka/events-ref/DeleteUser.md)

 - [GrantUserPermission](audit/mdb/kafka/events-ref/GrantUserPermission.md)

 - [MoveCluster](audit/mdb/kafka/events-ref/MoveCluster.md)

 - [PauseConnector](audit/mdb/kafka/events-ref/PauseConnector.md)

 - [ResumeConnector](audit/mdb/kafka/events-ref/ResumeConnector.md)

 - [RevokeUserPermission](audit/mdb/kafka/events-ref/RevokeUserPermission.md)

 - [SetClusterAccessBindings](audit/mdb/kafka/events-ref/SetClusterAccessBindings.md)

 - [StartCluster](audit/mdb/kafka/events-ref/StartCluster.md)

 - [StopCluster](audit/mdb/kafka/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/kafka/events-ref/UpdateCluster.md)

 - [UpdateClusterAccessBindings](audit/mdb/kafka/events-ref/UpdateClusterAccessBindings.md)

 - [UpdateConnector](audit/mdb/kafka/events-ref/UpdateConnector.md)

 - [UpdateTopic](audit/mdb/kafka/events-ref/UpdateTopic.md)

 - [UpdateUser](audit/mdb/kafka/events-ref/UpdateUser.md)

### mdb.mongodb

 - [AddClusterHosts](audit/mdb/mongodb/events-ref/AddClusterHosts.md)

 - [AddClusterShard](audit/mdb/mongodb/events-ref/AddClusterShard.md)

 - [AuthCheck](audit/mdb/mongodb/events-ref/AuthCheck.md)

 - [BackupCluster](audit/mdb/mongodb/events-ref/BackupCluster.md)

 - [CreateCluster](audit/mdb/mongodb/events-ref/CreateCluster.md)

 - [CreateDatabase](audit/mdb/mongodb/events-ref/CreateDatabase.md)

 - [CreateUser](audit/mdb/mongodb/events-ref/CreateUser.md)

 - [DeleteBackup](audit/mdb/mongodb/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/mongodb/events-ref/DeleteCluster.md)

 - [DeleteClusterHosts](audit/mdb/mongodb/events-ref/DeleteClusterHosts.md)

 - [DeleteClusterShard](audit/mdb/mongodb/events-ref/DeleteClusterShard.md)

 - [DeleteDatabase](audit/mdb/mongodb/events-ref/DeleteDatabase.md)

 - [DeleteUser](audit/mdb/mongodb/events-ref/DeleteUser.md)

 - [EnableClusterSharding](audit/mdb/mongodb/events-ref/EnableClusterSharding.md)

 - [GenericAuditEvent](audit/mdb/mongodb/events-ref/GenericAuditEvent.md)

 - [GetDatabase](audit/mdb/mongodb/events-ref/GetDatabase.md)

 - [GetUser](audit/mdb/mongodb/events-ref/GetUser.md)

 - [GrantUserPermission](audit/mdb/mongodb/events-ref/GrantUserPermission.md)

 - [ListDatabases](audit/mdb/mongodb/events-ref/ListDatabases.md)

 - [ListUsers](audit/mdb/mongodb/events-ref/ListUsers.md)

 - [MoveCluster](audit/mdb/mongodb/events-ref/MoveCluster.md)

 - [RescheduleMaintenance](audit/mdb/mongodb/events-ref/RescheduleMaintenance.md)

 - [ResetupHosts](audit/mdb/mongodb/events-ref/ResetupHosts.md)

 - [RestartHosts](audit/mdb/mongodb/events-ref/RestartHosts.md)

 - [RestoreCluster](audit/mdb/mongodb/events-ref/RestoreCluster.md)

 - [RevokeUserPermission](audit/mdb/mongodb/events-ref/RevokeUserPermission.md)

 - [SetClusterAccessBindings](audit/mdb/mongodb/events-ref/SetClusterAccessBindings.md)

 - [StartCluster](audit/mdb/mongodb/events-ref/StartCluster.md)

 - [StepdownHosts](audit/mdb/mongodb/events-ref/StepdownHosts.md)

 - [StopCluster](audit/mdb/mongodb/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/mongodb/events-ref/UpdateCluster.md)

 - [UpdateClusterAccessBindings](audit/mdb/mongodb/events-ref/UpdateClusterAccessBindings.md)

 - [UpdateClusterHosts](audit/mdb/mongodb/events-ref/UpdateClusterHosts.md)

 - [UpdateUser](audit/mdb/mongodb/events-ref/UpdateUser.md)

 - [UserAuthentication](audit/mdb/mongodb/events-ref/UserAuthentication.md)

 - [UserLogout](audit/mdb/mongodb/events-ref/UserLogout.md)

### mdb.mysql

 - [AddClusterHosts](audit/mdb/mysql/events-ref/AddClusterHosts.md)

 - [BackupCluster](audit/mdb/mysql/events-ref/BackupCluster.md)

 - [CreateCluster](audit/mdb/mysql/events-ref/CreateCluster.md)

 - [CreateDatabase](audit/mdb/mysql/events-ref/CreateDatabase.md)

 - [CreateUser](audit/mdb/mysql/events-ref/CreateUser.md)

 - [DatabaseUserLogin](audit/mdb/mysql/events-ref/DatabaseUserLogin.md)

 - [DatabaseUserLogout](audit/mdb/mysql/events-ref/DatabaseUserLogout.md)

 - [DatabaseUserSQLRequest](audit/mdb/mysql/events-ref/DatabaseUserSQLRequest.md)

 - [DeleteBackup](audit/mdb/mysql/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/mysql/events-ref/DeleteCluster.md)

 - [DeleteClusterHosts](audit/mdb/mysql/events-ref/DeleteClusterHosts.md)

 - [DeleteDatabase](audit/mdb/mysql/events-ref/DeleteDatabase.md)

 - [DeleteUser](audit/mdb/mysql/events-ref/DeleteUser.md)

 - [GetDatabase](audit/mdb/mysql/events-ref/GetDatabase.md)

 - [GetUser](audit/mdb/mysql/events-ref/GetUser.md)

 - [GrantUserPermission](audit/mdb/mysql/events-ref/GrantUserPermission.md)

 - [ListDatabases](audit/mdb/mysql/events-ref/ListDatabases.md)

 - [ListUsers](audit/mdb/mysql/events-ref/ListUsers.md)

 - [MoveCluster](audit/mdb/mysql/events-ref/MoveCluster.md)

 - [RescheduleMaintenance](audit/mdb/mysql/events-ref/RescheduleMaintenance.md)

 - [RestoreCluster](audit/mdb/mysql/events-ref/RestoreCluster.md)

 - [RevokeUserPermission](audit/mdb/mysql/events-ref/RevokeUserPermission.md)

 - [SetClusterAccessBindings](audit/mdb/mysql/events-ref/SetClusterAccessBindings.md)

 - [StartCluster](audit/mdb/mysql/events-ref/StartCluster.md)

 - [StartClusterFailover](audit/mdb/mysql/events-ref/StartClusterFailover.md)

 - [StopCluster](audit/mdb/mysql/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/mysql/events-ref/UpdateCluster.md)

 - [UpdateClusterAccessBindings](audit/mdb/mysql/events-ref/UpdateClusterAccessBindings.md)

 - [UpdateClusterHosts](audit/mdb/mysql/events-ref/UpdateClusterHosts.md)

 - [UpdateDatabase](audit/mdb/mysql/events-ref/UpdateDatabase.md)

 - [UpdateUser](audit/mdb/mysql/events-ref/UpdateUser.md)

### mdb.opensearch

 - [AddDashboardsNodeGroup](audit/mdb/opensearch/events-ref/AddDashboardsNodeGroup.md)

 - [AddOpenSearchNodeGroup](audit/mdb/opensearch/events-ref/AddOpenSearchNodeGroup.md)

 - [BackupCluster](audit/mdb/opensearch/events-ref/BackupCluster.md)

 - [ComplianceReadEvent](audit/mdb/opensearch/events-ref/ComplianceReadEvent.md)

 - [ComplianceWriteEvent](audit/mdb/opensearch/events-ref/ComplianceWriteEvent.md)

 - [CreateCluster](audit/mdb/opensearch/events-ref/CreateCluster.md)

 - [DeleteBackup](audit/mdb/opensearch/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/opensearch/events-ref/DeleteCluster.md)

 - [DeleteDashboardsNodeGroup](audit/mdb/opensearch/events-ref/DeleteDashboardsNodeGroup.md)

 - [DeleteOpenSearchNodeGroup](audit/mdb/opensearch/events-ref/DeleteOpenSearchNodeGroup.md)

 - [FailedLoginRestEvent](audit/mdb/opensearch/events-ref/FailedLoginRestEvent.md)

 - [GrantedPrivilegesRestEvent](audit/mdb/opensearch/events-ref/GrantedPrivilegesRestEvent.md)

 - [GrantedPrivilegesTransportEvent](audit/mdb/opensearch/events-ref/GrantedPrivilegesTransportEvent.md)

 - [MissingPrivilegesRestEvent](audit/mdb/opensearch/events-ref/MissingPrivilegesRestEvent.md)

 - [MissingPrivilegesTransportEvent](audit/mdb/opensearch/events-ref/MissingPrivilegesTransportEvent.md)

 - [MoveCluster](audit/mdb/opensearch/events-ref/MoveCluster.md)

 - [RescheduleMaintenance](audit/mdb/opensearch/events-ref/RescheduleMaintenance.md)

 - [RestartOpenSearch](audit/mdb/opensearch/events-ref/RestartOpenSearch.md)

 - [RestoreCluster](audit/mdb/opensearch/events-ref/RestoreCluster.md)

 - [SecurityIndexAttemptTransportEvent](audit/mdb/opensearch/events-ref/SecurityIndexAttemptTransportEvent.md)

 - [StartCluster](audit/mdb/opensearch/events-ref/StartCluster.md)

 - [StopCluster](audit/mdb/opensearch/events-ref/StopCluster.md)

 - [SwitchMaster](audit/mdb/opensearch/events-ref/SwitchMaster.md)

 - [UpdateCluster](audit/mdb/opensearch/events-ref/UpdateCluster.md)

 - [UpdateDashboardsNodeGroup](audit/mdb/opensearch/events-ref/UpdateDashboardsNodeGroup.md)

 - [UpdateOpenSearchNodeGroup](audit/mdb/opensearch/events-ref/UpdateOpenSearchNodeGroup.md)

### mdb.postgresql

 - [AddClusterHosts](audit/mdb/postgresql/events-ref/AddClusterHosts.md)

 - [BackupCluster](audit/mdb/postgresql/events-ref/BackupCluster.md)

 - [CreateCluster](audit/mdb/postgresql/events-ref/CreateCluster.md)

 - [CreateDatabase](audit/mdb/postgresql/events-ref/CreateDatabase.md)

 - [CreateUser](audit/mdb/postgresql/events-ref/CreateUser.md)

 - [DatabaseUserLogin](audit/mdb/postgresql/events-ref/DatabaseUserLogin.md)

 - [DatabaseUserLogout](audit/mdb/postgresql/events-ref/DatabaseUserLogout.md)

 - [DatabaseUserSQLRequest](audit/mdb/postgresql/events-ref/DatabaseUserSQLRequest.md)

 - [DeleteBackup](audit/mdb/postgresql/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/postgresql/events-ref/DeleteCluster.md)

 - [DeleteClusterHosts](audit/mdb/postgresql/events-ref/DeleteClusterHosts.md)

 - [DeleteDatabase](audit/mdb/postgresql/events-ref/DeleteDatabase.md)

 - [DeleteUser](audit/mdb/postgresql/events-ref/DeleteUser.md)

 - [GetDatabase](audit/mdb/postgresql/events-ref/GetDatabase.md)

 - [GetUser](audit/mdb/postgresql/events-ref/GetUser.md)

 - [GrantUserPermission](audit/mdb/postgresql/events-ref/GrantUserPermission.md)

 - [ListDatabases](audit/mdb/postgresql/events-ref/ListDatabases.md)

 - [ListUsers](audit/mdb/postgresql/events-ref/ListUsers.md)

 - [MoveCluster](audit/mdb/postgresql/events-ref/MoveCluster.md)

 - [RescheduleMaintenance](audit/mdb/postgresql/events-ref/RescheduleMaintenance.md)

 - [RestoreCluster](audit/mdb/postgresql/events-ref/RestoreCluster.md)

 - [RevokeUserPermission](audit/mdb/postgresql/events-ref/RevokeUserPermission.md)

 - [SetClusterAccessBindings](audit/mdb/postgresql/events-ref/SetClusterAccessBindings.md)

 - [StartCluster](audit/mdb/postgresql/events-ref/StartCluster.md)

 - [StartClusterFailover](audit/mdb/postgresql/events-ref/StartClusterFailover.md)

 - [StopCluster](audit/mdb/postgresql/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/postgresql/events-ref/UpdateCluster.md)

 - [UpdateClusterAccessBindings](audit/mdb/postgresql/events-ref/UpdateClusterAccessBindings.md)

 - [UpdateClusterHosts](audit/mdb/postgresql/events-ref/UpdateClusterHosts.md)

 - [UpdateDatabase](audit/mdb/postgresql/events-ref/UpdateDatabase.md)

 - [UpdateUser](audit/mdb/postgresql/events-ref/UpdateUser.md)

### mdb.redis

 - [AddClusterHosts](audit/mdb/redis/events-ref/AddClusterHosts.md)

 - [AddClusterShard](audit/mdb/redis/events-ref/AddClusterShard.md)

 - [BackupCluster](audit/mdb/redis/events-ref/BackupCluster.md)

 - [CreateCluster](audit/mdb/redis/events-ref/CreateCluster.md)

 - [CreateUser](audit/mdb/redis/events-ref/CreateUser.md)

 - [DatabaseConnectionClose](audit/mdb/redis/events-ref/DatabaseConnectionClose.md)

 - [DatabaseConnectionOpen](audit/mdb/redis/events-ref/DatabaseConnectionOpen.md)

 - [DatabaseUserLogin](audit/mdb/redis/events-ref/DatabaseUserLogin.md)

 - [DeleteBackup](audit/mdb/redis/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/redis/events-ref/DeleteCluster.md)

 - [DeleteClusterHosts](audit/mdb/redis/events-ref/DeleteClusterHosts.md)

 - [DeleteClusterShard](audit/mdb/redis/events-ref/DeleteClusterShard.md)

 - [DeleteUser](audit/mdb/redis/events-ref/DeleteUser.md)

 - [EnableClusterSharding](audit/mdb/redis/events-ref/EnableClusterSharding.md)

 - [MoveCluster](audit/mdb/redis/events-ref/MoveCluster.md)

 - [RebalanceCluster](audit/mdb/redis/events-ref/RebalanceCluster.md)

 - [RescheduleMaintenance](audit/mdb/redis/events-ref/RescheduleMaintenance.md)

 - [RestoreCluster](audit/mdb/redis/events-ref/RestoreCluster.md)

 - [StartCluster](audit/mdb/redis/events-ref/StartCluster.md)

 - [StartClusterFailover](audit/mdb/redis/events-ref/StartClusterFailover.md)

 - [StopCluster](audit/mdb/redis/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/redis/events-ref/UpdateCluster.md)

 - [UpdateClusterHosts](audit/mdb/redis/events-ref/UpdateClusterHosts.md)

 - [UpdateUser](audit/mdb/redis/events-ref/UpdateUser.md)

### mdb.spqr

 - [AddClusterHosts](audit/mdb/spqr/events-ref/AddClusterHosts.md)

 - [AddClusterShards](audit/mdb/spqr/events-ref/AddClusterShards.md)

 - [BackupCluster](audit/mdb/spqr/events-ref/BackupCluster.md)

 - [CreateCluster](audit/mdb/spqr/events-ref/CreateCluster.md)

 - [CreateDatabase](audit/mdb/spqr/events-ref/CreateDatabase.md)

 - [CreateUser](audit/mdb/spqr/events-ref/CreateUser.md)

 - [DeleteBackup](audit/mdb/spqr/events-ref/DeleteBackup.md)

 - [DeleteCluster](audit/mdb/spqr/events-ref/DeleteCluster.md)

 - [DeleteClusterHosts](audit/mdb/spqr/events-ref/DeleteClusterHosts.md)

 - [DeleteClusterShards](audit/mdb/spqr/events-ref/DeleteClusterShards.md)

 - [DeleteDatabase](audit/mdb/spqr/events-ref/DeleteDatabase.md)

 - [DeleteUser](audit/mdb/spqr/events-ref/DeleteUser.md)

 - [MoveCluster](audit/mdb/spqr/events-ref/MoveCluster.md)

 - [RescheduleMaintenance](audit/mdb/spqr/events-ref/RescheduleMaintenance.md)

 - [RestoreCluster](audit/mdb/spqr/events-ref/RestoreCluster.md)

 - [StartCluster](audit/mdb/spqr/events-ref/StartCluster.md)

 - [StopCluster](audit/mdb/spqr/events-ref/StopCluster.md)

 - [UpdateCluster](audit/mdb/spqr/events-ref/UpdateCluster.md)

 - [UpdateClusterHosts](audit/mdb/spqr/events-ref/UpdateClusterHosts.md)

 - [UpdateUser](audit/mdb/spqr/events-ref/UpdateUser.md)

### metastore

 - [CreateCluster](audit/metastore/events-ref/CreateCluster.md)

 - [DeleteCluster](audit/metastore/events-ref/DeleteCluster.md)

 - [RescheduleMaintenance](audit/metastore/events-ref/RescheduleMaintenance.md)

 - [StartCluster](audit/metastore/events-ref/StartCluster.md)

 - [StopCluster](audit/metastore/events-ref/StopCluster.md)

 - [UpdateCluster](audit/metastore/events-ref/UpdateCluster.md)

### organizationmanager

 - [AcceptInvitation](audit/organizationmanager/events-ref/AcceptInvitation.md)

 - [ActivateMfaEnforcement](audit/organizationmanager/events-ref/ActivateMfaEnforcement.md)

 - [AddFederatedUserAccounts](audit/organizationmanager/events-ref/AddFederatedUserAccounts.md)

 - [AddFederationDomain](audit/organizationmanager/events-ref/AddFederationDomain.md)

 - [AddOAuthFederatedUserAccounts](audit/organizationmanager/events-ref/AddOAuthFederatedUserAccounts.md)

 - [AddUserBlock](audit/organizationmanager/events-ref/AddUserBlock.md)

 - [AddUserpoolDomain](audit/organizationmanager/events-ref/AddUserpoolDomain.md)

 - [AttachRegion](audit/organizationmanager/events-ref/AttachRegion.md)

 - [AuthenticateByPassword](audit/organizationmanager/events-ref/AuthenticateByPassword.md)

 - [BindOrganizationAccessPolicy](audit/organizationmanager/events-ref/BindOrganizationAccessPolicy.md)

 - [ChangeOneTimePassword](audit/organizationmanager/events-ref/ChangeOneTimePassword.md)

 - [ConvertUserToExternal](audit/organizationmanager/events-ref/ConvertUserToExternal.md)

 - [CreateApplication](audit/organizationmanager/events-ref/CreateApplication.md)

 - [CreateApplication](audit/organizationmanager/events-ref/CreateApplication.md)

 - [CreateAsset](audit/organizationmanager/events-ref/CreateAsset.md)

 - [CreateBranding](audit/organizationmanager/events-ref/CreateBranding.md)

 - [CreateCertificate](audit/organizationmanager/events-ref/CreateCertificate.md)

 - [CreateFederation](audit/organizationmanager/events-ref/CreateFederation.md)

 - [CreateGroup](audit/organizationmanager/events-ref/CreateGroup.md)

 - [CreateGroupMapping](audit/organizationmanager/events-ref/CreateGroupMapping.md)

 - [CreateInvitations](audit/organizationmanager/events-ref/CreateInvitations.md)

 - [CreateMembership](audit/organizationmanager/events-ref/CreateMembership.md)

 - [CreateMfaEnforcement](audit/organizationmanager/events-ref/CreateMfaEnforcement.md)

 - [CreateOrganization](audit/organizationmanager/events-ref/CreateOrganization.md)

 - [CreateOsLoginProfile](audit/organizationmanager/events-ref/CreateOsLoginProfile.md)

 - [CreateSignatureCertificate](audit/organizationmanager/events-ref/CreateSignatureCertificate.md)

 - [CreateUser](audit/organizationmanager/events-ref/CreateUser.md)

 - [CreateUserpool](audit/organizationmanager/events-ref/CreateUserpool.md)

 - [CreateUserSshKey](audit/organizationmanager/events-ref/CreateUserSshKey.md)

 - [DeactivateMfaEnforcement](audit/organizationmanager/events-ref/DeactivateMfaEnforcement.md)

 - [DeleteApplication](audit/organizationmanager/events-ref/DeleteApplication.md)

 - [DeleteApplication](audit/organizationmanager/events-ref/DeleteApplication.md)

 - [DeleteAsset](audit/organizationmanager/events-ref/DeleteAsset.md)

 - [DeleteBranding](audit/organizationmanager/events-ref/DeleteBranding.md)

 - [DeleteCertificate](audit/organizationmanager/events-ref/DeleteCertificate.md)

 - [DeleteFederatedUserAccounts](audit/organizationmanager/events-ref/DeleteFederatedUserAccounts.md)

 - [DeleteFederation](audit/organizationmanager/events-ref/DeleteFederation.md)

 - [DeleteFederationDomain](audit/organizationmanager/events-ref/DeleteFederationDomain.md)

 - [DeleteGroup](audit/organizationmanager/events-ref/DeleteGroup.md)

 - [DeleteGroupMapping](audit/organizationmanager/events-ref/DeleteGroupMapping.md)

 - [DeleteInvitation](audit/organizationmanager/events-ref/DeleteInvitation.md)

 - [DeleteMembership](audit/organizationmanager/events-ref/DeleteMembership.md)

 - [DeleteMfaEnforcement](audit/organizationmanager/events-ref/DeleteMfaEnforcement.md)

 - [DeleteOrganization](audit/organizationmanager/events-ref/DeleteOrganization.md)

 - [DeleteOsLoginProfile](audit/organizationmanager/events-ref/DeleteOsLoginProfile.md)

 - [DeleteSignatureCertificate](audit/organizationmanager/events-ref/DeleteSignatureCertificate.md)

 - [DeleteUser](audit/organizationmanager/events-ref/DeleteUser.md)

 - [DeleteUserpool](audit/organizationmanager/events-ref/DeleteUserpool.md)

 - [DeleteUserpoolDomain](audit/organizationmanager/events-ref/DeleteUserpoolDomain.md)

 - [DeleteUserSshKey](audit/organizationmanager/events-ref/DeleteUserSshKey.md)

 - [OAuthFederationPrivateTlsCreateCertificate](audit/organizationmanager/events-ref/OAuthFederationPrivateTlsCreateCertificate.md)

 - [OAuthFederationPrivateTlsDeleteCertificate](audit/organizationmanager/events-ref/OAuthFederationPrivateTlsDeleteCertificate.md)

 - [OAuthFederationPrivateTlsUpdateCertificate](audit/organizationmanager/events-ref/OAuthFederationPrivateTlsUpdateCertificate.md)

 - [ReactivateApplication](audit/organizationmanager/events-ref/ReactivateApplication.md)

 - [ReactivateApplication](audit/organizationmanager/events-ref/ReactivateApplication.md)

 - [ReactivateFederatedUserAccounts](audit/organizationmanager/events-ref/ReactivateFederatedUserAccounts.md)

 - [ReactivateUser](audit/organizationmanager/events-ref/ReactivateUser.md)

 - [RejectInvitation](audit/organizationmanager/events-ref/RejectInvitation.md)

 - [RemoveUserBlock](audit/organizationmanager/events-ref/RemoveUserBlock.md)

 - [ResendInvitation](audit/organizationmanager/events-ref/ResendInvitation.md)

 - [ResetOwnPassword](audit/organizationmanager/events-ref/ResetOwnPassword.md)

 - [SetApplicationAccessBindings](audit/organizationmanager/events-ref/SetApplicationAccessBindings.md)

 - [SetApplicationAccessBindings](audit/organizationmanager/events-ref/SetApplicationAccessBindings.md)

 - [SetDefaultProfile](audit/organizationmanager/events-ref/SetDefaultProfile.md)

 - [SetGroupAccessBindings](audit/organizationmanager/events-ref/SetGroupAccessBindings.md)

 - [SetOrganizationAccessBindings](audit/organizationmanager/events-ref/SetOrganizationAccessBindings.md)

 - [SetUserPassword](audit/organizationmanager/events-ref/SetUserPassword.md)

 - [SetUserpoolAccessBindings](audit/organizationmanager/events-ref/SetUserpoolAccessBindings.md)

 - [SuspendApplication](audit/organizationmanager/events-ref/SuspendApplication.md)

 - [SuspendApplication](audit/organizationmanager/events-ref/SuspendApplication.md)

 - [SuspendFederatedUserAccounts](audit/organizationmanager/events-ref/SuspendFederatedUserAccounts.md)

 - [SuspendUser](audit/organizationmanager/events-ref/SuspendUser.md)

 - [UnbindOrganizationAccessPolicy](audit/organizationmanager/events-ref/UnbindOrganizationAccessPolicy.md)

 - [UpdateApplication](audit/organizationmanager/events-ref/UpdateApplication.md)

 - [UpdateApplication](audit/organizationmanager/events-ref/UpdateApplication.md)

 - [UpdateApplicationAccessBindings](audit/organizationmanager/events-ref/UpdateApplicationAccessBindings.md)

 - [UpdateApplicationAccessBindings](audit/organizationmanager/events-ref/UpdateApplicationAccessBindings.md)

 - [UpdateApplicationAssignments](audit/organizationmanager/events-ref/UpdateApplicationAssignments.md)

 - [UpdateApplicationAssignments](audit/organizationmanager/events-ref/UpdateApplicationAssignments.md)

 - [UpdateBranding](audit/organizationmanager/events-ref/UpdateBranding.md)

 - [UpdateCertificate](audit/organizationmanager/events-ref/UpdateCertificate.md)

 - [UpdateFederation](audit/organizationmanager/events-ref/UpdateFederation.md)

 - [UpdateGroup](audit/organizationmanager/events-ref/UpdateGroup.md)

 - [UpdateGroupAccessBindings](audit/organizationmanager/events-ref/UpdateGroupAccessBindings.md)

 - [UpdateGroupMapping](audit/organizationmanager/events-ref/UpdateGroupMapping.md)

 - [UpdateGroupMappingItems](audit/organizationmanager/events-ref/UpdateGroupMappingItems.md)

 - [UpdateGroupMembers](audit/organizationmanager/events-ref/UpdateGroupMembers.md)

 - [UpdateMfaEnforcement](audit/organizationmanager/events-ref/UpdateMfaEnforcement.md)

 - [UpdateMfaEnforcementAudience](audit/organizationmanager/events-ref/UpdateMfaEnforcementAudience.md)

 - [UpdateMfaEnforcementExcludedAudience](audit/organizationmanager/events-ref/UpdateMfaEnforcementExcludedAudience.md)

 - [UpdateOrganization](audit/organizationmanager/events-ref/UpdateOrganization.md)

 - [UpdateOrganizationAccessBindings](audit/organizationmanager/events-ref/UpdateOrganizationAccessBindings.md)

 - [UpdateOrganizationAccessPolicyBindingParameters](audit/organizationmanager/events-ref/UpdateOrganizationAccessPolicyBindingParameters.md)

 - [UpdateOsLoginProfile](audit/organizationmanager/events-ref/UpdateOsLoginProfile.md)

 - [UpdateOsLoginSettings](audit/organizationmanager/events-ref/UpdateOsLoginSettings.md)

 - [UpdateSignatureCertificate](audit/organizationmanager/events-ref/UpdateSignatureCertificate.md)

 - [UpdateSubscribers](audit/organizationmanager/events-ref/UpdateSubscribers.md)

 - [UpdateSubscriptionLimit](audit/organizationmanager/events-ref/UpdateSubscriptionLimit.md)

 - [UpdateUser](audit/organizationmanager/events-ref/UpdateUser.md)

 - [UpdateUserpool](audit/organizationmanager/events-ref/UpdateUserpool.md)

 - [UpdateUserpoolAccessBindings](audit/organizationmanager/events-ref/UpdateUserpoolAccessBindings.md)

 - [UpdateUserSshKey](audit/organizationmanager/events-ref/UpdateUserSshKey.md)

 - [UploadSignatureCertificate](audit/organizationmanager/events-ref/UploadSignatureCertificate.md)

 - [ValidateFederationDomain](audit/organizationmanager/events-ref/ValidateFederationDomain.md)

 - [ValidateUserpoolDomain](audit/organizationmanager/events-ref/ValidateUserpoolDomain.md)

### postbox

 - [CreateConfigurationSet](audit/postbox/events-ref/CreateConfigurationSet.md)

 - [CreateIdentity](audit/postbox/events-ref/CreateIdentity.md)

 - [DeleteConfigurationSet](audit/postbox/events-ref/DeleteConfigurationSet.md)

 - [DeleteIdentity](audit/postbox/events-ref/DeleteIdentity.md)

 - [UpdateConfigurationSet](audit/postbox/events-ref/UpdateConfigurationSet.md)

 - [UpdateIdentity](audit/postbox/events-ref/UpdateIdentity.md)

### resourcemanager

 - [AddCloudToOrganization](audit/resourcemanager/events-ref/AddCloudToOrganization.md)

 - [BindCloudAccessPolicy](audit/resourcemanager/events-ref/BindCloudAccessPolicy.md)

 - [BindFolderAccessPolicy](audit/resourcemanager/events-ref/BindFolderAccessPolicy.md)

 - [CreateCloud](audit/resourcemanager/events-ref/CreateCloud.md)

 - [CreateFolder](audit/resourcemanager/events-ref/CreateFolder.md)

 - [DeleteCloud](audit/resourcemanager/events-ref/DeleteCloud.md)

 - [DeleteFolder](audit/resourcemanager/events-ref/DeleteFolder.md)

 - [SetCloudAccessBindings](audit/resourcemanager/events-ref/SetCloudAccessBindings.md)

 - [SetFolderAccessBindings](audit/resourcemanager/events-ref/SetFolderAccessBindings.md)

 - [UnbindCloudAccessPolicy](audit/resourcemanager/events-ref/UnbindCloudAccessPolicy.md)

 - [UnbindFolderAccessPolicy](audit/resourcemanager/events-ref/UnbindFolderAccessPolicy.md)

 - [UpdateCloud](audit/resourcemanager/events-ref/UpdateCloud.md)

 - [UpdateCloudAccessBindings](audit/resourcemanager/events-ref/UpdateCloudAccessBindings.md)

 - [UpdateCloudAccessPolicyBindingParameters](audit/resourcemanager/events-ref/UpdateCloudAccessPolicyBindingParameters.md)

 - [UpdateFolder](audit/resourcemanager/events-ref/UpdateFolder.md)

 - [UpdateFolderAccessBindings](audit/resourcemanager/events-ref/UpdateFolderAccessBindings.md)

 - [UpdateFolderAccessPolicyBindingParameters](audit/resourcemanager/events-ref/UpdateFolderAccessPolicyBindingParameters.md)

### securitydeck.alerts

 - [CreateAlert](audit/securitydeck/alerts/events-ref/CreateAlert.md)

 - [CreateAlertSink](audit/securitydeck/alerts/events-ref/CreateAlertSink.md)

 - [DeleteAlertSink](audit/securitydeck/alerts/events-ref/DeleteAlertSink.md)

 - [UpdateAlertSink](audit/securitydeck/alerts/events-ref/UpdateAlertSink.md)

### securitydeck.cspm

 - [AssetFailedRuleCheck](audit/securitydeck/cspm/events-ref/AssetFailedRuleCheck.md)

 - [AssetPassedRuleCheck](audit/securitydeck/cspm/events-ref/AssetPassedRuleCheck.md)

 - [AssetRuleCheckCouldNotBeExecuted](audit/securitydeck/cspm/events-ref/AssetRuleCheckCouldNotBeExecuted.md)

 - [AssetRuleCheckNoLongerInScope](audit/securitydeck/cspm/events-ref/AssetRuleCheckNoLongerInScope.md)

 - [CreateScanJob](audit/securitydeck/cspm/events-ref/CreateScanJob.md)

 - [CreateScopeFilter](audit/securitydeck/cspm/events-ref/CreateScopeFilter.md)

 - [DeleteScanJob](audit/securitydeck/cspm/events-ref/DeleteScanJob.md)

 - [DeleteScopeFilter](audit/securitydeck/cspm/events-ref/DeleteScopeFilter.md)

 - [UpdateScanJob](audit/securitydeck/cspm/events-ref/UpdateScanJob.md)

 - [UpdateScopeFilter](audit/securitydeck/cspm/events-ref/UpdateScopeFilter.md)

### securitydeck.kspm

 - [CreateException](audit/securitydeck/kspm/events-ref/CreateException.md)

 - [CreateProject](audit/securitydeck/kspm/events-ref/CreateProject.md)

 - [DeleteException](audit/securitydeck/kspm/events-ref/DeleteException.md)

 - [DeleteProject](audit/securitydeck/kspm/events-ref/DeleteProject.md)

 - [EnableProject](audit/securitydeck/kspm/events-ref/EnableProject.md)

 - [TriggerAdmissionControl](audit/securitydeck/kspm/events-ref/TriggerAdmissionControl.md)

 - [TriggerRuntimeControl](audit/securitydeck/kspm/events-ref/TriggerRuntimeControl.md)

 - [TriggerRuntimeProcessInfo](audit/securitydeck/kspm/events-ref/TriggerRuntimeProcessInfo.md)

 - [UpdateException](audit/securitydeck/kspm/events-ref/UpdateException.md)

 - [UpdateProject](audit/securitydeck/kspm/events-ref/UpdateProject.md)

### securitydeck.orchestrator

 - [CreateConnector](audit/securitydeck/orchestrator/events-ref/CreateConnector.md)

 - [CreateScope](audit/securitydeck/orchestrator/events-ref/CreateScope.md)

 - [CreateWorkspace](audit/securitydeck/orchestrator/events-ref/CreateWorkspace.md)

 - [DeleteConnector](audit/securitydeck/orchestrator/events-ref/DeleteConnector.md)

 - [DeleteScope](audit/securitydeck/orchestrator/events-ref/DeleteScope.md)

 - [DeleteWorkspace](audit/securitydeck/orchestrator/events-ref/DeleteWorkspace.md)

 - [UpdateConnector](audit/securitydeck/orchestrator/events-ref/UpdateConnector.md)

 - [UpdateScope](audit/securitydeck/orchestrator/events-ref/UpdateScope.md)

 - [UpdateWorkspace](audit/securitydeck/orchestrator/events-ref/UpdateWorkspace.md)

### serverless

 - [AddDomain](audit/serverless/events-ref/AddDomain.md)

 - [CreateApiGateway](audit/serverless/events-ref/CreateApiGateway.md)

 - [CreateContainer](audit/serverless/events-ref/CreateContainer.md)

 - [CreateFunction](audit/serverless/events-ref/CreateFunction.md)

 - [CreateFunctionVersion](audit/serverless/events-ref/CreateFunctionVersion.md)

 - [CreateProxy](audit/serverless/events-ref/CreateProxy.md)

 - [CreateTrigger](audit/serverless/events-ref/CreateTrigger.md)

 - [DeleteApiGateway](audit/serverless/events-ref/DeleteApiGateway.md)

 - [DeleteContainer](audit/serverless/events-ref/DeleteContainer.md)

 - [DeleteDomain](audit/serverless/events-ref/DeleteDomain.md)

 - [DeleteFunction](audit/serverless/events-ref/DeleteFunction.md)

 - [DeleteFunctionVersion](audit/serverless/events-ref/DeleteFunctionVersion.md)

 - [DeleteProxy](audit/serverless/events-ref/DeleteProxy.md)

 - [DeleteTrigger](audit/serverless/events-ref/DeleteTrigger.md)

 - [DeployContainerRevision](audit/serverless/events-ref/DeployContainerRevision.md)

 - [PauseTrigger](audit/serverless/events-ref/PauseTrigger.md)

 - [RemoveFunctionTag](audit/serverless/events-ref/RemoveFunctionTag.md)

 - [RemoveScalingPolicy](audit/serverless/events-ref/RemoveScalingPolicy.md)

 - [ResumeApiGateway](audit/serverless/events-ref/ResumeApiGateway.md)

 - [ResumeTrigger](audit/serverless/events-ref/ResumeTrigger.md)

 - [RollbackContainer](audit/serverless/events-ref/RollbackContainer.md)

 - [SetApiGatewayAccessBindings](audit/serverless/events-ref/SetApiGatewayAccessBindings.md)

 - [SetContainerAccessBindings](audit/serverless/events-ref/SetContainerAccessBindings.md)

 - [SetFunctionAccessBindings](audit/serverless/events-ref/SetFunctionAccessBindings.md)

 - [SetFunctionTag](audit/serverless/events-ref/SetFunctionTag.md)

 - [SetProxyAccessBindings](audit/serverless/events-ref/SetProxyAccessBindings.md)

 - [SetScalingPolicy](audit/serverless/events-ref/SetScalingPolicy.md)

 - [StopApiGateway](audit/serverless/events-ref/StopApiGateway.md)

 - [UpdateApiGateway](audit/serverless/events-ref/UpdateApiGateway.md)

 - [UpdateApiGatewayAccessBindings](audit/serverless/events-ref/UpdateApiGatewayAccessBindings.md)

 - [UpdateContainer](audit/serverless/events-ref/UpdateContainer.md)

 - [UpdateContainerAccessBindings](audit/serverless/events-ref/UpdateContainerAccessBindings.md)

 - [UpdateFunction](audit/serverless/events-ref/UpdateFunction.md)

 - [UpdateFunctionAccessBindings](audit/serverless/events-ref/UpdateFunctionAccessBindings.md)

 - [UpdateProxy](audit/serverless/events-ref/UpdateProxy.md)

 - [UpdateProxyAccessBindings](audit/serverless/events-ref/UpdateProxyAccessBindings.md)

 - [UpdateTrigger](audit/serverless/events-ref/UpdateTrigger.md)

 - [AddDomain](audit/serverless/apigateway/events-ref/AddDomain.md)

 - [CreateApiGateway](audit/serverless/apigateway/events-ref/CreateApiGateway.md)

 - [DeleteApiGateway](audit/serverless/apigateway/events-ref/DeleteApiGateway.md)

 - [DeleteDomain](audit/serverless/apigateway/events-ref/DeleteDomain.md)

 - [ResumeApiGateway](audit/serverless/apigateway/events-ref/ResumeApiGateway.md)

 - [SetApiGatewayAccessBindings](audit/serverless/apigateway/events-ref/SetApiGatewayAccessBindings.md)

 - [StopApiGateway](audit/serverless/apigateway/events-ref/StopApiGateway.md)

 - [UpdateApiGateway](audit/serverless/apigateway/events-ref/UpdateApiGateway.md)

 - [UpdateApiGatewayAccessBindings](audit/serverless/apigateway/events-ref/UpdateApiGatewayAccessBindings.md)

### smartcaptcha

 - [CreateCaptcha](audit/smartcaptcha/events-ref/CreateCaptcha.md)

 - [DeleteCaptcha](audit/smartcaptcha/events-ref/DeleteCaptcha.md)

 - [UpdateCaptcha](audit/smartcaptcha/events-ref/UpdateCaptcha.md)

### smartwebsecurity

 - [ArlMatchedRequest](audit/smartwebsecurity/events-ref/ArlMatchedRequest.md)

 - [CreateArlProfile](audit/smartwebsecurity/events-ref/CreateArlProfile.md)

 - [CreateCustomPage](audit/smartwebsecurity/events-ref/CreateCustomPage.md)

 - [CreateDomain](audit/smartwebsecurity/events-ref/CreateDomain.md)

 - [CreateLoadBalancer](audit/smartwebsecurity/events-ref/CreateLoadBalancer.md)

 - [CreateMatchList](audit/smartwebsecurity/events-ref/CreateMatchList.md)

 - [CreateSecurityProfile](audit/smartwebsecurity/events-ref/CreateSecurityProfile.md)

 - [CreateSolidWafProfile](audit/smartwebsecurity/events-ref/CreateSolidWafProfile.md)

 - [CreateWafProfile](audit/smartwebsecurity/events-ref/CreateWafProfile.md)

 - [DeleteArlProfile](audit/smartwebsecurity/events-ref/DeleteArlProfile.md)

 - [DeleteCustomPage](audit/smartwebsecurity/events-ref/DeleteCustomPage.md)

 - [DeleteDomain](audit/smartwebsecurity/events-ref/DeleteDomain.md)

 - [DeleteLoadBalancer](audit/smartwebsecurity/events-ref/DeleteLoadBalancer.md)

 - [DeleteMatchList](audit/smartwebsecurity/events-ref/DeleteMatchList.md)

 - [DeleteSecurityProfile](audit/smartwebsecurity/events-ref/DeleteSecurityProfile.md)

 - [DeleteSolidWafProfile](audit/smartwebsecurity/events-ref/DeleteSolidWafProfile.md)

 - [DeleteWafProfile](audit/smartwebsecurity/events-ref/DeleteWafProfile.md)

 - [StartLoadBalancer](audit/smartwebsecurity/events-ref/StartLoadBalancer.md)

 - [StopLoadBalancer](audit/smartwebsecurity/events-ref/StopLoadBalancer.md)

 - [SWSMatchedRequest](audit/smartwebsecurity/events-ref/SWSMatchedRequest.md)

 - [UpdateArlProfile](audit/smartwebsecurity/events-ref/UpdateArlProfile.md)

 - [UpdateCustomPage](audit/smartwebsecurity/events-ref/UpdateCustomPage.md)

 - [UpdateDomain](audit/smartwebsecurity/events-ref/UpdateDomain.md)

 - [UpdateLoadBalancer](audit/smartwebsecurity/events-ref/UpdateLoadBalancer.md)

 - [UpdateMatchList](audit/smartwebsecurity/events-ref/UpdateMatchList.md)

 - [UpdateSecurityProfile](audit/smartwebsecurity/events-ref/UpdateSecurityProfile.md)

 - [UpdateSolidWafProfile](audit/smartwebsecurity/events-ref/UpdateSolidWafProfile.md)

 - [UpdateWafProfile](audit/smartwebsecurity/events-ref/UpdateWafProfile.md)

 - [WafMatchedExclusionRule](audit/smartwebsecurity/events-ref/WafMatchedExclusionRule.md)

 - [WafMatchedRule](audit/smartwebsecurity/events-ref/WafMatchedRule.md)

### spark

 - [CreateCluster](audit/spark/events-ref/CreateCluster.md)

 - [DeleteCluster](audit/spark/events-ref/DeleteCluster.md)

 - [RescheduleMaintenance](audit/spark/events-ref/RescheduleMaintenance.md)

 - [StartCluster](audit/spark/events-ref/StartCluster.md)

 - [StopCluster](audit/spark/events-ref/StopCluster.md)

 - [UpdateCluster](audit/spark/events-ref/UpdateCluster.md)

### speechsense

 - [CreateProject](audit/speechsense/events-ref/CreateProject.md)

 - [CreateProjectBinding](audit/speechsense/events-ref/CreateProjectBinding.md)

 - [CreateSpace](audit/speechsense/events-ref/CreateSpace.md)

 - [CreateTalksReport](audit/speechsense/events-ref/CreateTalksReport.md)

 - [DeleteProject](audit/speechsense/events-ref/DeleteProject.md)

 - [DeleteSpace](audit/speechsense/events-ref/DeleteSpace.md)

 - [GetTalk](audit/speechsense/events-ref/GetTalk.md)

 - [GetTalkAudio](audit/speechsense/events-ref/GetTalkAudio.md)

 - [SearchTalks](audit/speechsense/events-ref/SearchTalks.md)

 - [SetProjectAccessBindings](audit/speechsense/events-ref/SetProjectAccessBindings.md)

 - [SetSpaceAccessBindings](audit/speechsense/events-ref/SetSpaceAccessBindings.md)

 - [UpdateProject](audit/speechsense/events-ref/UpdateProject.md)

 - [UpdateProjectAccessBindings](audit/speechsense/events-ref/UpdateProjectAccessBindings.md)

 - [UpdateSpace](audit/speechsense/events-ref/UpdateSpace.md)

 - [UpdateSpaceAccessBindings](audit/speechsense/events-ref/UpdateSpaceAccessBindings.md)

 - [UploadTalkToConnection](audit/speechsense/events-ref/UploadTalkToConnection.md)

### storage

 - [BucketAccessBindingsUpdate](audit/storage/events-ref/BucketAccessBindingsUpdate.md)

 - [BucketAclUpdate](audit/storage/events-ref/BucketAclUpdate.md)

 - [BucketCorsUpdate](audit/storage/events-ref/BucketCorsUpdate.md)

 - [BucketCreate](audit/storage/events-ref/BucketCreate.md)

 - [BucketDelete](audit/storage/events-ref/BucketDelete.md)

 - [BucketEncryptionUpdate](audit/storage/events-ref/BucketEncryptionUpdate.md)

 - [BucketHttpsUpdate](audit/storage/events-ref/BucketHttpsUpdate.md)

 - [BucketLifecycleUpdate](audit/storage/events-ref/BucketLifecycleUpdate.md)

 - [BucketLoggingUpdate](audit/storage/events-ref/BucketLoggingUpdate.md)

 - [BucketObjectLockUpdate](audit/storage/events-ref/BucketObjectLockUpdate.md)

 - [BucketPolicyUpdate](audit/storage/events-ref/BucketPolicyUpdate.md)

 - [BucketTagsUpdate](audit/storage/events-ref/BucketTagsUpdate.md)

 - [BucketUpdate](audit/storage/events-ref/BucketUpdate.md)

 - [BucketVersioningUpdate](audit/storage/events-ref/BucketVersioningUpdate.md)

 - [BucketWebsiteUpdate](audit/storage/events-ref/BucketWebsiteUpdate.md)

 - [ObjectAclUpdate](audit/storage/events-ref/ObjectAclUpdate.md)

 - [ObjectCreate](audit/storage/events-ref/ObjectCreate.md)

 - [ObjectDelete](audit/storage/events-ref/ObjectDelete.md)

 - [ObjectGetByPresignURL](audit/storage/events-ref/ObjectGetByPresignURL.md)

 - [ObjectTagsDelete](audit/storage/events-ref/ObjectTagsDelete.md)

 - [ObjectTagsUpdate](audit/storage/events-ref/ObjectTagsUpdate.md)

 - [ObjectUpdate](audit/storage/events-ref/ObjectUpdate.md)

 - [PresignURLCreate](audit/storage/events-ref/PresignURLCreate.md)

### trino

 - [CreateCatalog](audit/trino/events-ref/CreateCatalog.md)

 - [CreateCluster](audit/trino/events-ref/CreateCluster.md)

 - [DeleteCatalog](audit/trino/events-ref/DeleteCatalog.md)

 - [DeleteCluster](audit/trino/events-ref/DeleteCluster.md)

 - [RescheduleMaintenance](audit/trino/events-ref/RescheduleMaintenance.md)

 - [StartCluster](audit/trino/events-ref/StartCluster.md)

 - [StopCluster](audit/trino/events-ref/StopCluster.md)

 - [UpdateCatalog](audit/trino/events-ref/UpdateCatalog.md)

 - [UpdateCluster](audit/trino/events-ref/UpdateCluster.md)

### video

 - [BatchDeleteChannels](audit/video/events-ref/BatchDeleteChannels.md)

 - [BatchDeleteEpisodes](audit/video/events-ref/BatchDeleteEpisodes.md)

 - [BatchDeletePlaylists](audit/video/events-ref/BatchDeletePlaylists.md)

 - [BatchDeleteStreamLines](audit/video/events-ref/BatchDeleteStreamLines.md)

 - [BatchDeleteStreams](audit/video/events-ref/BatchDeleteStreams.md)

 - [BatchDeleteVideos](audit/video/events-ref/BatchDeleteVideos.md)

 - [CreateChannel](audit/video/events-ref/CreateChannel.md)

 - [CreateEpisode](audit/video/events-ref/CreateEpisode.md)

 - [CreatePlaylist](audit/video/events-ref/CreatePlaylist.md)

 - [CreateStream](audit/video/events-ref/CreateStream.md)

 - [CreateStreamLine](audit/video/events-ref/CreateStreamLine.md)

 - [CreateStylePreset](audit/video/events-ref/CreateStylePreset.md)

 - [CreateSubtitle](audit/video/events-ref/CreateSubtitle.md)

 - [CreateThumbnail](audit/video/events-ref/CreateThumbnail.md)

 - [CreateVideo](audit/video/events-ref/CreateVideo.md)

 - [DeleteChannel](audit/video/events-ref/DeleteChannel.md)

 - [DeleteEpisode](audit/video/events-ref/DeleteEpisode.md)

 - [DeletePlaylist](audit/video/events-ref/DeletePlaylist.md)

 - [DeleteStream](audit/video/events-ref/DeleteStream.md)

 - [DeleteStreamLine](audit/video/events-ref/DeleteStreamLine.md)

 - [DeleteStylePreset](audit/video/events-ref/DeleteStylePreset.md)

 - [DeleteSubtitle](audit/video/events-ref/DeleteSubtitle.md)

 - [DeleteThumbnail](audit/video/events-ref/DeleteThumbnail.md)

 - [DeleteVideo](audit/video/events-ref/DeleteVideo.md)

 - [DeleteWithReplaceStylePreset](audit/video/events-ref/DeleteWithReplaceStylePreset.md)

 - [DownloadEpisode](audit/video/events-ref/DownloadEpisode.md)

 - [EpisodePerformAction](audit/video/events-ref/EpisodePerformAction.md)

 - [SetChannelAccessBindings](audit/video/events-ref/SetChannelAccessBindings.md)

 - [StreamLinePerformAction](audit/video/events-ref/StreamLinePerformAction.md)

 - [StreamLineUpdateStreamKey](audit/video/events-ref/StreamLineUpdateStreamKey.md)

 - [StreamPerformAction](audit/video/events-ref/StreamPerformAction.md)

 - [TranscodeVideo](audit/video/events-ref/TranscodeVideo.md)

 - [UpdateChannel](audit/video/events-ref/UpdateChannel.md)

 - [UpdateChannelAccessBindings](audit/video/events-ref/UpdateChannelAccessBindings.md)

 - [UpdateEpisode](audit/video/events-ref/UpdateEpisode.md)

 - [UpdatePlaylist](audit/video/events-ref/UpdatePlaylist.md)

 - [UpdateStream](audit/video/events-ref/UpdateStream.md)

 - [UpdateStreamLine](audit/video/events-ref/UpdateStreamLine.md)

 - [UpdateStylePreset](audit/video/events-ref/UpdateStylePreset.md)

 - [UpdateVideo](audit/video/events-ref/UpdateVideo.md)

 - [VideoPerformAction](audit/video/events-ref/VideoPerformAction.md)

### vpc

 - [AddressAttached](audit/vpc/events-ref/AddressAttached.md)

 - [AddressDetached](audit/vpc/events-ref/AddressDetached.md)

 - [CreateAddress](audit/vpc/events-ref/CreateAddress.md)

 - [CreateGateway](audit/vpc/events-ref/CreateGateway.md)

 - [CreateIpfix](audit/vpc/events-ref/CreateIpfix.md)

 - [CreateNetwork](audit/vpc/events-ref/CreateNetwork.md)

 - [CreatePrivateEndpoint](audit/vpc/events-ref/CreatePrivateEndpoint.md)

 - [CreateRouteTable](audit/vpc/events-ref/CreateRouteTable.md)

 - [CreateSecurityGroup](audit/vpc/events-ref/CreateSecurityGroup.md)

 - [CreateSubnet](audit/vpc/events-ref/CreateSubnet.md)

 - [DeleteAddress](audit/vpc/events-ref/DeleteAddress.md)

 - [DeleteGateway](audit/vpc/events-ref/DeleteGateway.md)

 - [DeleteIpfix](audit/vpc/events-ref/DeleteIpfix.md)

 - [DeleteNetwork](audit/vpc/events-ref/DeleteNetwork.md)

 - [DeletePrivateEndpoint](audit/vpc/events-ref/DeletePrivateEndpoint.md)

 - [DeleteRouteTable](audit/vpc/events-ref/DeleteRouteTable.md)

 - [DeleteSecurityGroup](audit/vpc/events-ref/DeleteSecurityGroup.md)

 - [DeleteSubnet](audit/vpc/events-ref/DeleteSubnet.md)

 - [ExternalFlow](audit/vpc/events-ref/ExternalFlow.md)

 - [GatewayAttached](audit/vpc/events-ref/GatewayAttached.md)

 - [GatewayDetached](audit/vpc/events-ref/GatewayDetached.md)

 - [MoveAddress](audit/vpc/events-ref/MoveAddress.md)

 - [MoveGateway](audit/vpc/events-ref/MoveGateway.md)

 - [MoveNetwork](audit/vpc/events-ref/MoveNetwork.md)

 - [MoveRouteTable](audit/vpc/events-ref/MoveRouteTable.md)

 - [MoveSecurityGroup](audit/vpc/events-ref/MoveSecurityGroup.md)

 - [MoveSubnet](audit/vpc/events-ref/MoveSubnet.md)

 - [RelocateSubnet](audit/vpc/events-ref/RelocateSubnet.md)

 - [RouteTableAttached](audit/vpc/events-ref/RouteTableAttached.md)

 - [RouteTableDetached](audit/vpc/events-ref/RouteTableDetached.md)

 - [UpdateAddress](audit/vpc/events-ref/UpdateAddress.md)

 - [UpdateGateway](audit/vpc/events-ref/UpdateGateway.md)

 - [UpdateNetwork](audit/vpc/events-ref/UpdateNetwork.md)

 - [UpdatePrivateEndpoint](audit/vpc/events-ref/UpdatePrivateEndpoint.md)

 - [UpdateRouteTable](audit/vpc/events-ref/UpdateRouteTable.md)

 - [UpdateSecurityGroup](audit/vpc/events-ref/UpdateSecurityGroup.md)

 - [UpdateSubnet](audit/vpc/events-ref/UpdateSubnet.md)

### websql

 - [CreateSavedQuery](audit/websql/events-ref/CreateSavedQuery.md)

 - [DeleteExecutedQuery](audit/websql/events-ref/DeleteExecutedQuery.md)

 - [DeleteSavedQuery](audit/websql/events-ref/DeleteSavedQuery.md)

 - [EditSavedQuery](audit/websql/events-ref/EditSavedQuery.md)

 - [Execute](audit/websql/events-ref/Execute.md)

 - [GenerateSql](audit/websql/events-ref/GenerateSql.md)

 - [GetDatabaseStructure](audit/websql/events-ref/GetDatabaseStructure.md)

 - [PublishExecutedQuery](audit/websql/events-ref/PublishExecutedQuery.md)

 - [PublishSavedQuery](audit/websql/events-ref/PublishSavedQuery.md)

 - [UpdateExecutedQueryAccessBindings](audit/websql/events-ref/UpdateExecutedQueryAccessBindings.md)

 - [UpdateSavedQueryAccessBindings](audit/websql/events-ref/UpdateSavedQueryAccessBindings.md)

### wiki

 - [AccessRequestCreate](audit/wiki/events-ref/AccessRequestCreate.md)

 - [AccessRequestProcess](audit/wiki/events-ref/AccessRequestProcess.md)

 - [AttachmentCreate](audit/wiki/events-ref/AttachmentCreate.md)

 - [AttachmentDelete](audit/wiki/events-ref/AttachmentDelete.md)

 - [AuthorRoleRequestCreate](audit/wiki/events-ref/AuthorRoleRequestCreate.md)

 - [AuthorRoleRequestProcess](audit/wiki/events-ref/AuthorRoleRequestProcess.md)

 - [BookmarkCreate](audit/wiki/events-ref/BookmarkCreate.md)

 - [BookmarkDelete](audit/wiki/events-ref/BookmarkDelete.md)

 - [BookmarkTagsCreate](audit/wiki/events-ref/BookmarkTagsCreate.md)

 - [BookmarkTagsDelete](audit/wiki/events-ref/BookmarkTagsDelete.md)

 - [BookmarkUpdate](audit/wiki/events-ref/BookmarkUpdate.md)

 - [ChangeOrganizationDomain](audit/wiki/events-ref/ChangeOrganizationDomain.md)

 - [ChangeOrganizationMetrika](audit/wiki/events-ref/ChangeOrganizationMetrika.md)

 - [ChangeOrganizationSettings](audit/wiki/events-ref/ChangeOrganizationSettings.md)

 - [ClusterMove](audit/wiki/events-ref/ClusterMove.md)

 - [CommentCreate](audit/wiki/events-ref/CommentCreate.md)

 - [CommentDelete](audit/wiki/events-ref/CommentDelete.md)

 - [CommentUpdate](audit/wiki/events-ref/CommentUpdate.md)

 - [DraftCreate](audit/wiki/events-ref/DraftCreate.md)

 - [DraftPublish](audit/wiki/events-ref/DraftPublish.md)

 - [GridAddColumns](audit/wiki/events-ref/GridAddColumns.md)

 - [GridAddRows](audit/wiki/events-ref/GridAddRows.md)

 - [GridClone](audit/wiki/events-ref/GridClone.md)

 - [GridCreate](audit/wiki/events-ref/GridCreate.md)

 - [GridDelete](audit/wiki/events-ref/GridDelete.md)

 - [GridImport](audit/wiki/events-ref/GridImport.md)

 - [GridMoveColumns](audit/wiki/events-ref/GridMoveColumns.md)

 - [GridMoveRows](audit/wiki/events-ref/GridMoveRows.md)

 - [GridRemoveColumns](audit/wiki/events-ref/GridRemoveColumns.md)

 - [GridRemoveRows](audit/wiki/events-ref/GridRemoveRows.md)

 - [GridRollback](audit/wiki/events-ref/GridRollback.md)

 - [GridUpdate](audit/wiki/events-ref/GridUpdate.md)

 - [GridUpdateCells](audit/wiki/events-ref/GridUpdateCells.md)

 - [GridUpdateColumn](audit/wiki/events-ref/GridUpdateColumn.md)

 - [GridUpdateRow](audit/wiki/events-ref/GridUpdateRow.md)

 - [InviteActivate](audit/wiki/events-ref/InviteActivate.md)

 - [InviteDelete](audit/wiki/events-ref/InviteDelete.md)

 - [InviteReactivate](audit/wiki/events-ref/InviteReactivate.md)

 - [InviteRemoveAccess](audit/wiki/events-ref/InviteRemoveAccess.md)

 - [InviteRemoveAllAccesses](audit/wiki/events-ref/InviteRemoveAllAccesses.md)

 - [InviteUse](audit/wiki/events-ref/InviteUse.md)

 - [PageChangeOrder](audit/wiki/events-ref/PageChangeOrder.md)

 - [PageChangeToYFM](audit/wiki/events-ref/PageChangeToYFM.md)

 - [PageClone](audit/wiki/events-ref/PageClone.md)

 - [PageCreate](audit/wiki/events-ref/PageCreate.md)

 - [PageDelete](audit/wiki/events-ref/PageDelete.md)

 - [PageImport](audit/wiki/events-ref/PageImport.md)

 - [PageRecover](audit/wiki/events-ref/PageRecover.md)

 - [PageUpdate](audit/wiki/events-ref/PageUpdate.md)

 - [RecoveryTokenDelete](audit/wiki/events-ref/RecoveryTokenDelete.md)

 - [SubscriberDelete](audit/wiki/events-ref/SubscriberDelete.md)

 - [SubscribersAdd](audit/wiki/events-ref/SubscribersAdd.md)

 - [SubscriptionAdd](audit/wiki/events-ref/SubscriptionAdd.md)

 - [SubscriptionDelete](audit/wiki/events-ref/SubscriptionDelete.md)

### ydb

 - [AlterTopic](audit/ydb/events-ref/AlterTopic.md)

 - [BackupDatabase](audit/ydb/events-ref/BackupDatabase.md)

 - [CreateDatabase](audit/ydb/events-ref/CreateDatabase.md)

 - [CreateTopic](audit/ydb/events-ref/CreateTopic.md)

 - [DeleteBackup](audit/ydb/events-ref/DeleteBackup.md)

 - [DeleteDatabase](audit/ydb/events-ref/DeleteDatabase.md)

 - [DeleteTopic](audit/ydb/events-ref/DeleteTopic.md)

 - [MoveDatabase](audit/ydb/events-ref/MoveDatabase.md)

 - [RestoreBackup](audit/ydb/events-ref/RestoreBackup.md)

 - [SetBackupAccessBindings](audit/ydb/events-ref/SetBackupAccessBindings.md)

 - [SetDatabaseAccessBindings](audit/ydb/events-ref/SetDatabaseAccessBindings.md)

 - [StartDatabase](audit/ydb/events-ref/StartDatabase.md)

 - [StopDatabase](audit/ydb/events-ref/StopDatabase.md)

 - [UpdateBackupAccessBindings](audit/ydb/events-ref/UpdateBackupAccessBindings.md)

 - [UpdateDatabase](audit/ydb/events-ref/UpdateDatabase.md)

 - [UpdateDatabaseAccessBindings](audit/ydb/events-ref/UpdateDatabaseAccessBindings.md)

### ymq

 - [CreateMessageQueue](audit/ymq/events-ref/CreateMessageQueue.md)

 - [DeleteMessageQueue](audit/ymq/events-ref/DeleteMessageQueue.md)

 - [UpdateMessageQueue](audit/ymq/events-ref/UpdateMessageQueue.md)

### yq

 - [ControlQuery](audit/yq/events-ref/ControlQuery.md)

 - [CreateBinding](audit/yq/events-ref/CreateBinding.md)

 - [CreateConnection](audit/yq/events-ref/CreateConnection.md)

 - [CreateQuery](audit/yq/events-ref/CreateQuery.md)

 - [DeleteBinding](audit/yq/events-ref/DeleteBinding.md)

 - [DeleteConnection](audit/yq/events-ref/DeleteConnection.md)

 - [DeleteQuery](audit/yq/events-ref/DeleteQuery.md)

 - [UpdateBinding](audit/yq/events-ref/UpdateBinding.md)

 - [UpdateConnection](audit/yq/events-ref/UpdateConnection.md)

 - [UpdateQuery](audit/yq/events-ref/UpdateQuery.md)

### ytsaurus

 - [CreateCluster](audit/ytsaurus/events-ref/CreateCluster.md)

 - [DeleteCluster](audit/ytsaurus/events-ref/DeleteCluster.md)

 - [StartCluster](audit/ytsaurus/events-ref/StartCluster.md)

 - [StopCluster](audit/ytsaurus/events-ref/StopCluster.md)

 - [UpdateCluster](audit/ytsaurus/events-ref/UpdateCluster.md)

 - [UpdateClusterGroupMembers](audit/ytsaurus/events-ref/UpdateClusterGroupMembers.md)

 - [История изменений](release-notes.md)

 - [Обучающие курсы](training.md)