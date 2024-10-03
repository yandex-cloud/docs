# Getting an IAM token for a service account using a container

If the container revision was created with a service account, you can get an [IAM token](../../iam/concepts/authorization/iam-token.md) from the metadata service in [Google Compute Engine](../../compute/operations/vm-info/get-info.md#gce-metadata) format using the API.

To do this, within the container, run a GET request at `http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token` and specify the HTTP header `Metadata-Flavor: Google`.

Below is an example of a function for obtaining an IAM token.

{% list tabs %}

- JavaScript

    ```js
    const fetch = require("node-fetch");
	let url = 'http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token';
	let headers = {'Metadata-Flavor': 'Google'};

	async function getToken(event) {
	    const resp = await fetch(url, {
	        headers: headers,
	    });
	    let respJson = await resp.json();
	    return {
	        token: respJson['access_token'],
	        expiresInSeconds: respJson['expires_in'],
	    };
	};
    ```

{% endlist %}

