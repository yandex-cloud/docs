# How to set up a student community

With {{ ml-platform-full-name }}, you can create a student-friendly workspace. To launch a course, the instructor needs to create a new {{ ml-platform-name }} [community](../../datasphere/concepts/community.md) where all students will have access to shared materials: [Docker images](../../datasphere/concepts/docker.md) with pre-installed libraries, connections to [{{ objstorage-full-name }}](../../storage/) buckets, and ready-made datasets.

This guide covers the principles of setting up a training course for students with {{ ml-platform-name }}.

1. [Create projects](#create-projects).
1. [Prepare tasks](#prepare-tasks).
1. [Check completed tasks](#check-tasks).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

## Create projects {#create-projects}

Create a separate [project](../../datasphere/concepts/project.md) for each student in the community, so they can store their own resources and run the {{ jlab }}Lab development environment. You can [restrict](../../datasphere/operations/community/manage-community-config.md) the [configurations](../../datasphere/concepts/configurations.md) allowed in the community. You can additionally set [usage limits](../../datasphere/operations/projects/restrictions.md) to manage resource consumption within learning projects.

Students need the `Developer` [role](../../datasphere/security/index.md#grant-role) within their projects so that they can run the code and use cloud resources but cannot change the limits set for the project. Each student runs their own instance of the development environment within their individual project, where they can solve tasks in their notebook and store their own data and [secrets](../../datasphere/concepts/secrets.md).

To facilitate communication within your community, [add a link to a Telegram or Slack channel](../../datasphere/operations/community/link-channel.md).

You can automate the process of creating communities and projects, setting limits, and granting access using the [{{ ml-platform-name }}](../../datasphere/api-ref/overview.md) API. Check an example of such a solution in the [guide on automating project setup](../../datasphere/tutorials/automation-community-settings.md).

## Prepare tasks {#prepare-tasks}

The instructor can create a project in the community to prepare a generic notebook with tasks in it. The instructor uploads the notebook to a GitHub repository with a link to it to the students. The students should then [clone the GitHub repository](../../datasphere/operations/projects/work-with-git#clone-public) into their project. Whenever a new task becomes available, the students only need to [pull the changes from the repository](../../datasphere/operations/projects/work-with-git.md#pull).

{% note info %}

The project's activities are only visible to its members and the community users with the `Admin` and `Editor` roles. New project members can only be added by users with the `Admin` role for the project or community.

{% endnote %}

### Share task data {#share-data}

There are two ways the instructor can share task data:

1. **Using a [dataset](../../datasphere/concepts/dataset.md)** resource:
    * Upload the data into a project and [form a dataset out of it](../../datasphere/operations/data/dataset.md).
    * [Share the dataset with the community](../../datasphere/operations/data/dataset.md#share).
1. **Using a [bucket](../../storage/concepts/bucket.md)**:
    * [Create a new {{ objstorage-name }}](../../storage/operations/buckets/create.md) bucket and add the data to it.
    * [Configure an S3 connector](../../datasphere/operations/data/s3-connectors.md) in {{ ml-platform-name }}.
    * [Share the connector in the community](../../datasphere/operations/data/s3-connectors.md#share).

The students will be able to add the connector to their project and thus connect to the {{ objstorage-name }} bucket.

## Check completed tasks {#check-tasks}

The instructor can opt for one of the two possible approaches:

1. Students upload their completed notebooks back into the repository, and the instructor [pulls the changes from it](../../datasphere/operations/projects/work-with-git.md#pull).
1. The instructor has the `{{ roles-datasphere-communities-admin }}` role in each one of the students' projects and can open any of them to check the task there directly.
