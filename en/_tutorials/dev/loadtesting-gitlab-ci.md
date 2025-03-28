To add the load testing invocation from {{ GL }} CI:
1. [Get your cloud ready](#before-begin).
1. [Set up your infrastructure](#infrastructure-prepare).
1. [Prepare a file with test data](#test-file).
1. [Create {{ GL }}](#add-variables) environment variables.
1. [Add the load testing stage to the CI scenario configuration file](#add-loadtesting-ci).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

1. If the [agent](../../load-testing/concepts/agent.md) is hosted on {{ yandex-cloud }}, you pay for computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

1. Fee for data storage in a bucket and data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).

## Set up your infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

1. [Create](../../iam/operations/sa/create.md) a service account named `sa-loadtest` in the folder that will host the agent to supply the load.
1. [Assign](../../iam/operations/roles/grant.md) the following [roles](../../load-testing/security/#roles-list) to the service account:
   * `loadtesting.generatorClient`
   * `loadtesting.loadTester`
   * `iam.serviceAccounts.user`
   * `compute.editor`
   * `vpc.user`
   * `vpc.publicAdmin` (optional, if deploying the agent in a public network)

1. [Create](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) an authorized key for the service account and save it to the `key.json` file:

### Configure a network {#network-setup}

[Create and configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet where your test target is and where the agent will reside. This will enable the agent to access {{ load-testing-name }}.

### Configure the security group {#security-group-setup}

Set up the test agent's security group:

{% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

### Prepare a CI/CD pipeline in {{ GL }} for deploying the test target {#prepare-gitlab-ci}

In this scenario, we will use an application with the `51.250.103.44` [public IP address](../../vpc/concepts/address#public-addresses) to exemplify the test objective. For an example of building a CI/CD pipeline in {{ GL }}, see [this article](../../tutorials/serverless/ci-cd-serverless).

## Prepare a file with test data {#test-file}

1. Generate payloads in [HTTP_JSON](../../load-testing/concepts/payloads/http-json.md) format:

   ```JSON
   {"host": "51.250.103.44", "method": "GET", "uri": "/", "tag": "url1", "headers": {"User-agent": "Tank", "Connection": "Close"}}
   ```

   Where:
   * `host`: `Host` header value.
   * `method`: HTTP request method.
   * `uri`: Request URI.
   * `tag`: Request tag for use in reports.
   * `headers`: Request headers.

You can also use the [Dispatcher](../../load-testing/operations/payload-dispatcher) tool to prepare payloads.

1. Save the payloads to a file named `httpjson.payload`.
1. [Create](../../storage/operations/buckets/create.md) a bucket and [upload](../../storage/operations/objects/upload.md) the test data file into it.
1. Grant read permissions for the bucket to the service account. To do this, edit the bucket's [ACL](../../storage/concepts/acl.md):
   1. In the [management console]({{ link-console-main }}), select the folder the bucket is in.
   1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the bucket and select **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
   1. In the window that opens, enter the service account name, select `READ` for bucket permissions, and click **{{ ui-key.yacloud.common.add }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

   This grants the service account permission to read data from this bucket only.

## Create {{ GL }} environment variables {#add-variables}

1. In {{ GL }}, navigate to **Settings** in the left-hand panel and select **CI/CD** from the drop-down list.
1. Click **Expand** next to **Variables**.
1. Add environment variables with the protection option disabled:
   * `SERVICE_ACCOUNT_ID`: `sa-loadtest` service account ID.
   * `SA_AUTHORIZED_KEY`: Contents of the authorized key for the `sa-loadtest` service account.
   * `SECURITY_GROUP_ID`: Test agent's `agent-sg` security group ID.
   * `SUBNET_ID`: ID of the subnet to host the test agent.
   * `ZONE`: Availability zone to host the test agent, e.g.,`ru-central1-a`.
   * `YC_FOLDER_ID`: ID of the folder to host the resources.

   To add a variable:
   1. Click **Add variable**.
   1. In the window that opens, specify the variable name in the **Key** field and its value in the **Value** field.
   1. Disable the **Protect variable** option.
   1. Click **Add variable**.

## Add the load testing stage to the CI scenario configuration file {#add-loadtesting-ci}

1. Add the `test-config.yaml` load testing configuration file to your project repository in {{ GL }}:

   ```yaml
   pandora:
      enabled: true
      package: yandextank.plugins.Pandora
      config_content:
         pools:
            - id: HTTP
            gun:
               type: http
               target: 51.250.103.44
               ssl: false
            ammo:
               type: http/json
               file: httpjson.payload
            result:
               type: phout
               destination: ./phout.log
            startup:
               type: once
               times: 1000
            rps:
               - type: line
                  from: 0
                  to: 500
                  duration: 60s
            discard_overflow: true
         log:
            level: error
         monitoring:
            expvar:
               enabled: true
               port: 1234
   autostop:
      enabled: true
      package: yandextank.plugins.Autostop
      autostop:
         - limit(5m) # Required parameter
         - quantile(50,100,5,)
   core: {}
   ```

   In the `target` field, enter the address of your application. This testing configuration will generate a [linear load](../../load-testing/concepts/load-profile) from 0 to 500 requests per second for 60 seconds. The [autostop](../../load-testing/concepts/auto-stop) criterion is also configured. This criterion stops the test if the 50th percentile exceeds 100 milliseconds for 5 seconds.

1. Add a load testing stage to the `.gitlab-ci.yml` file after deploying the application:
  
   ```yaml
   stages:
      ...
      - loadtesting
      ...

   loadtesting-job:
      stage: loadtesting
      allow_failure: true
      artifacts: 
         when: always
         name: "tests_output"
         paths:
            - agent_id.txt
      before_script:
         # Installing tools.
         - sudo apt-get install -y jq
         - curl --fail --silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
         - sudo bash install.sh -i /usr/local/yandex-cloud -n
         - sudo ln -f -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
         # Authentication using a service account key
         - echo "$SA_AUTHORIZED_KEY" > key.json
         - yc config profile create sa-profile || echo "Profile already exists"
         - yc config set service-account-key key.json
         - yc config set folder-id ${YC_FOLDER_ID}
      script:
         # Creating a test agent
         - agent_id=$(yc loadtesting agent create --name agent${CI_JOB_ID} --zone ${ZONE} --service-account-id ${SERVICE_ACCOUNT_ID} --network-interface security-group-ids=${SECURITY_GROUP_ID},subnet-id=${SUBNET_ID} --format json | jq -r .id)
         - echo $agent_id > agent_id.txt
         # Waiting for the agent to become available
         - |
           while true; do
              if ! _status=$(yc loadtesting agent get "$agent_id" --format json | jq -r '.status'); then
                 sleep 10
                 continue
              fi
              if [[ "$_status" == "READY_FOR_TEST" ]]; then
                 echo "Agent is ready"
                 break
              fi
              echo "Waiting for agent..."
              sleep 10
           done
         # Creating a configuration
         - config_id=$(yc loadtesting test-config create --from-yaml-file test-config.yaml --format json | jq -r .id)
         # Running the test
         - test_id=$(yc loadtesting test create --name "test_${CI_COMMIT_SHORT_SHA}" --description "${CI_COMMIT_MESSAGE}" --labels auto=true --configuration agent-id=$agent_id,id=$config_id,test-data=httpjson.payload --test-data name=httpjson.payload,s3bucket=payload-bucket,s3file=httpjson.payload --wait --format json | jq -r .id)
         - yc loadtesting test wait --idle-timeout 120s $test_id
         # Evaluating test results
         - q50=$(yc loadtesting test get-report-table $test_id --format json | jq -r .overall.quantiles.q50)
         - |
           if [[ $q50 -gt 100 ]]; then
              echo "Q50 exceeds 100 ms, test failed"
              exit 1
           fi
      after_script:
         # Deleting a test agent
         - agent_id=$(cat agent_id.txt)
         - yc loadtesting agent delete $agent_id
         - rm agent_id.txt
   ```

   During the stage described here, the script will create a test agent, run the test, and check the test result. The result evaluation is based on the 50th percentile. If it exceeds 100ms, the stage will terminate with an error.

   After you save the `.gitlab-ci.yml` configuration file, the build scenario will start.

   You can view the test results in more detail in the management console:
      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. In the left-hand panel, select ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
      1. Select the test you created and navigate to the **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.

   You can use any connection logic for this stage:
      * On commits to the main branch
      * On pull request updates



## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the service accounts](../../iam/operations/sa/delete.md).
1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
1. Make sure that the test agent created by the script was deleted. You can [delete the agent](../../compute/operations/vm-control/vm-delete.md) manually.
1. [Delete the route table](../../vpc/operations/delete-route-table.md).
1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
