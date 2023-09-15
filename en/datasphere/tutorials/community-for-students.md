# How to set up a student community

With {{ ml-platform-full-name }}, you can set up student-friendly workspaces. To launch a course, a teacher needs to create a new {{ ml-platform-name }} [community](../concepts/community.md), where all students will have access to common materials: [Docker images](../concepts/docker.md) with pre-installed libraries, connections to [{{ objstorage-full-name }}](../../storage/) buckets, and prepared datasets.

This guide describes how you can set up a course for students with {{ ml-platform-name }}.

1. [{#T}](#create-projects).
1. [{#T}](#prepare-tasks).
1. [{#T}](#check-tasks).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

## Creating projects {#create-projects}

Create a separate [project](../concepts/project.md) for each student in the community, so they can store their own resources and run the {{ jlab }}Lab development environment. You can [restrict](../operations/community/manage-community-config.md) the [configurations](../concepts/configurations.md) allowed in the community. Furthermore, you can set [limits](../operations/projects/restrictions.md) to manage resource usage within each educational project.

All students should be [assigned](../security/index.md#grant-role) the `developer` role within their project so they can run code and use cloud resources but cannot change the limits set for the project. Each student runs their own instance of the development environment within their individual project, where they can solve tasks in their notebook and store their own data and [secrets](../concepts/secrets.md).

To facilitate communication within your community, [add a link to a Telegram or Slack channel](../operations/community/link-channel.md).

You can automate the process of creating communities and projects, setting limits, and granting access using the [{{ ml-platform-name }} API](../api-ref/overview.md). Check an example of such a solution in the [guide on automating project setup](automation-community-settings.md).

## Preparing tasks {#prepare-tasks}

The teacher can create their own project in the community to prepare a base notebook for tasks. To share the notebook with students, add it to a GitHub repository and send them the link. The students should then [clone the GitHub repository](../operations/projects/work-with-git#clone-public) to their project. Whenever a new assignment becomes available, the students only need to [pull the changes from the repository](../operations/projects/work-with-git.md#pull).

{% note info %}

Project activity is only visible to its participants and community users with `admin` and `editor` roles. New project participants can only be added by users who have the `admin` role in the project or the community.

{% endnote %}

### Sharing datasets for tasks {#share-data}

There are two ways to share data for a task:

1. **Using a [dataset](../concepts/dataset.md) resource:**
   * Upload the data to your project and [combine it into a Dataset](../operations/data/dataset.md).
   * [Share the dataset with the community](../operations/data/dataset.md#share).
1. **Using a [bucket](../../storage/concepts/bucket.md):**
   * [Create a new {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) and add your data to it.
   * [Configure an S3 connector](../operations/data/s3-connectors.md) in {{ ml-platform-name }}.
   * [Share the connector in the community](../operations/data/s3-connectors.md#share).

After that, the students will be able to add the connector to their project and connect to your {{ objstorage-name }} bucket.

## Checking completed tasks {#check-tasks}

Teachers have two approaches for checking tasks:

1. Students upload their notebooks with completed tasks back to the repository so the teacher can [pull the changes](../operations/projects/work-with-git.md#pull).
1. The teacher has the `{{ roles-datasphere-communities-admin }}` role in each student's project and can open and check tasks directly in these projects.
