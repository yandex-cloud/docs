# Setting up npm

To do the setting up:

* For all projects: run this command:

    `npm config set registry {{ cloud-registry }}/npm/<registry_ID>`

* For one project:

    1. Open the `.npmrc` file in the project root.

    1. Add the `registry={{ cloud-registry }}/npm/<registry_ID>` line to the `.npmrc` file.
