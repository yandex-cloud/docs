# Working with a service agent from a job

You can work with other services from [jobs](../../concepts/jobs/index.md) using a [service agent](../../../iam/concepts/service-control.md#service-agent). A service agent is a special service account under which {{ ml-platform-name }} projects will perform actions in other {{ yandex-cloud }} services.

To work with other services from jobs:

1. [Create](../community/create-ssa.md) a service agent and enable it in the [community](../../concepts/community.md).
1. [Run](work-with-jobs.md) the job. The service agent token will be saved to a file and will be available from the `SA_TOKEN_FILENAME` environment variable.
1. Use the `SA_TOKEN_FILENAME` variable to work with other services. For example, this is how you can get the contents of the [{{ lockbox-full-name }}](../../../lockbox/) secret using the API:

   ```bash
   curl --header "Authorization: Bearer $(cat $SA_TOKEN_FILENAME)" \
     https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/<secret_ID>/payload
   ```

   Result:

   ```text
   {
    "entries": [
     {
      "key": "my-key",
      "textValue": "key-example"
     }
    ],
    "versionId": "e6qlcb7fqtt6********"
   }
   ```