# Resolving timeout issues when connecting to a Managed Service for YDB database from cloud functions



## Issue description {#issue-description}

When switching the display mode of the chart from "Linear" to "Indicator", you see this error message:


This is possibly seen by a client who uses this link:

This ticket is a good illustration of constant issues with this link.
Objectives - user claims:

Since Friday, we have been noticing periodic spikes in latency on the gateway ID d5dsgm893c03hoafah7a, so far within 10 seconds, but this is enough to cause errors 502 (for example, ERROR RequestID: 279b0856-299a-484d-ae53-aff6a1bc6923 Code: 502 Message: Error during function invocation) and errors  499 (for example, ERROR RequestID: c4606727-9504-4206-bed5-73ecb1a47b5c Code: 499 Message: Request cancelled) in the gw-auth id d4emgc8tvfu0g1v5akfb cloud function.
Previously, when the delay reached 30+ seconds, it caused disruptions in the availability of our services running via the API gateway.
Could you please look into the cause?

We are struggling with the ticket, mumbling something, but cannot come up with a solution. Hence, we called the service:

Ivan Zuev - Error requests in utils-auth:

NK: This was the first part, for matching
The second part is from the service:

So, at the current stage, we are experiencing widespread timeouts when working with YDB:
11:45:49, 10.11.2022
ERROR
ERROR RequestID: 146b0230-b603-4733-bc4f-6843a4f19d3c Code: 504 Message: Execution timeout exceeded
11:45:49, 10.11.2022
ERROR
ERROR RequestID: 432eff3c-1aba-4c96-ac29-22b712be9cf4 Code: 499 Message: Request cancelled
11:45:53, 10.11.2022
ERROR
ERROR RequestID: 5dea08df-ebfe-4710-b141-51087e2f7369 Code: 504 Message: Execution timeout exceeded
11:45:53, 10.11.2022
ERROR
ERROR RequestID: 4dd4090c-07bd-4fa9-ab19-0fdf9cc3f09e Code: 499 Message: Request cancelled
11:45:55, 10.11.2022
ERROR
ERROR RequestID: cc0af066-89bd-4079-94b3-3d0044fba4ab Code: 504 Message: Execution timeout exceeded
11:45:55, 10.11.2022
ERROR
ERROR RequestID: a4291b70-815e-47ff-aaf7-0731097ff7f8 Code: 499 Message: Request cancelled
11:47:20, 10.11.2022
ERROR
ERROR RequestID: 8c8103a3-515c-4d04-9345-6ee4df994b27 Code: 504 Message: Execution timeout exceeded
11:47:20, 10.11.2022
ERROR
ERROR RequestID: 95a19f04-91e4-41c9-918a-b128ad817635 Code: 504 Message: Execution timeout exceeded

11:47:22, 10.11.2022
ERROR
ERROR RequestID: 804805c5-18ee-4f71-8ccd-a73e01343b94 Code: 504 Message: Execution timeout exceeded

11:47:29, 10.11.2022
ERROR
ERROR RequestID: 2340ff5a-acb9-4cc3-bae9-751163c5254f Code: 504 Message: Execution timeout exceeded

11:47:32, 10.11.2022
ERROR
ERROR RequestID: 106e4d2e-c56a-4c62-bb97-4bb715c26f61 Code: 504 Message: Execution timeout exceeded

-----



So, at the current stage, we are experiencing widespread timeouts when working with YDB:
The custom function that interacts with YDB: https://paste.yandex-team.ru/cb9c0d58-a78f-421a-9ba8-4e14e73667e0
DB module: https://paste.yandex-team.ru/87884342-e889-47d0-90a3-edbf0aaea34f
ydb-sdk version: 2.5.0
YDB in serverless mode: etn01v8miopmluqp1l9e
YDB debugging is enabled in the code, here is what is in the logs: https://paste.yandex-team.ru/19094c75-9049-4995-ba29-dd955aba066e

Question: Where are the five seconds? In this interval


11:47:17, 10.11.2022
[DEBUG] 2022-11-10T08:47:17.657Z 804805c5-18ee-4f71-8ccd-a73e01343b94 RpcState(CreateSession, 059e286d-3fa6-401e-b2e9-f94a0a0a8b62, ru-central1-c.ydb.serverless.yandexcloud.net:2135): on response callback success

11:47:22, 10.11.2022
[DEBUG] 2022-11-10T08:47:22.110Z 804805c5-18ee-4f71-8ccd-a73e01343b94 Channel options: [('grpc.max_receive_message_length', 64000000), ('grpc.max_send_message_length', 64000000), ('grpc.primary_user_agent', 'python-library'), ('grpc.lb_policy_name', 'round_robin')]


Final conclusion:
Following private conversations with the client and discussions with the YDB team, we have come to the following conclusion: the root of the issue is failing queries to YDB. Here is the chart: https://monitoring.cloud.yandex.ru/folders/yc.serverless.database/explorer/legend?q.0.s="requests_completed"{folderId%3D"yc.serverless.database"%2C service%3D"slydb"%2C "database.serverless"%3D"etn01v8miopmluqp1l9e"%2C host%3D"cluster"%2C resource_type%3D"database.serverless"%2C cloud_id%3D"b1gr0iuqbcebkckqp99c"%2C location_id%3D"ru-central1"%2C folder_id%3D"-"}&from=now-1d&to=now&refresh=60000&normz=off&colors=auto&type=auto&interpolation=linear&dsp_method=auto&dsp_aggr=avg&dsp_fill=default&vis_labels=off&vis_aggr=avg.

Recommendation from the YDB team: Set timeouts for queries (example) and add retries for operations with YDB.
Example: https://github.com/ydb-platform/ydb-python-sdk/blob/dec0c40c755dc60282820db3a28ea835c1d37521/examples/cloud-function-trivial-example/index.py#L19
The linked ticket includes a bunch of related tickets with this "serverless - ydb" issue