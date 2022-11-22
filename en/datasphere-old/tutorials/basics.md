# Getting started with {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

{{ ml-platform-full-name }} lets you analyze data and build machine learning (ML) models using the familiar {{ jlab }} Notebook interface. From this use case, you'll learn about the service's features by using a notebook for the [2017 Kaggle ML & DS Survey](https://www.kaggle.com/kaggle/kaggle-survey-2017) dataset (2017 [Kaggle](https://www.kaggle.com/) survey).

To get started with the service:

1. [{#T}](#get-cwd).
1. [{#T}](#unzip-dataset).
1. [{#T}](#satisfy-dependencies).
1. [{#T}](#load-dataset).
1. [{#T}](#analyze-dataset).

## Before you begin {#before-you-begin}

1. [Create a new empty project](../operations/projects/create) in **{{ ml-platform-name }}** and open it.
1. [Clone](../operations/projects/work-with-git.md#clone) the Git repository that contains the prepared notebook with the dataset:

   ```text
   https://github.com/dalyona/Yandex_Scale_DataSphere_demo
   ```

   Wait until the cloning is complete. It may take some time. Once the operation is complete, the folder of the cloned repository will appear in the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** section.

1. Open the **Yandex_Scale_DataSphere_demo** folder and review the contents of the **kaggle2017.ipynb** notebook.

   {% include [safe-state-warn](../../_includes/datasphere/safe-state.md) %}

## Check the current directory {#get-cwd}

1. Select the first cell with the code:

   ```python
   # Let's check our current directory and change it
   import os
   os.getcwd()
   ```

   Invoking the `getcwd()` function from the `os` module returns the name of the current folder.

1. Run this cell. To do this, choose **Run → Run Selected Cells** or press **Shift**+**Enter**.

   {% note info %}

   By default, all cells are run in the [<q>c1.4</q> configuration](../concepts/configurations.md) with minimum computing resources. You can run one or more cells (or even the entire notebook) in different configurations, and the state of the notebook is saved, meaning that no variables or computation results are reset. For more information, see [{#T}](../operations/projects/control-compute-resources.md).

   {% endnote %}

1. Wait for the operation to complete.

{{ ml-platform-full-name }} starts the VM, runs code in the cell, and returns the result directly below that cell. For example:

```text
'/home/jupyter/work/resources/Yandex_Scale_DataSphere_demo'
```

## Unzip the dataset {#unzip-dataset}

1. Add a new cell with code for unzipping files. To do this, choose **Snippets → Extract ZIP file.py**. The new cell is added below the current cell.

1. Change the value of the `fname` variable in the cell:

   ```bash
   fname='./input.zip'
   ```

1. Run this cell with the code.
1. Wait for the operation to complete.

This extracts files from the `input.zip` archive to the `input` directory inside the current directory.

## Install dependencies {#satisfy-dependencies}

1. Select and run the cell with the code in the **Introduction for this demo and Kaggle data** section:

   ```python
   # Let's start with import and install all necessary libraries and packages
   # Import packages that are pre-installed already and install through %pip packages that are not in the list, although requires
   import pandas as pd
   %pip install seaborn
   import seaborn as sns
   import matplotlib.pyplot as plt
   ...
   ```

1. Wait for the operation to complete.

Some packages are already installed and imported using the `import` command. Other are installed using the `%pip install` command and imported after that. For the full list of packages pre-installed in {{ ml-platform-name }}, see [{#T}](../concepts/preinstalled-packages.md).

## Upload the dataset from a file {#load-dataset}

In this use case, you'll upload data from a file named `input/multipleChoiceResponses.csv` and output the first few rows from it using the Pandas library. To upload the dataset and get its first five rows:

1. Select the following two cells with code by holding **Shift** and clicking to the left of these cells:

   ```python
   response=pd.read_csv('input/multipleChoiceResponses.csv',encoding='ISO-8859-1')
   ```

   ```python
   response.head()
   ```

   For more information about the `head()` method, see the [Pandas documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.head.html#pandas.DataFrame.head).

1. Run these cells.

1. Wait for the operation to complete.

## Get statistics on the dataset {#analyze-dataset}

1. Select a cell in the **Some Basic Analysis** section:

   ```python
   print('The total number of respondents:',response.shape[0])
   print('Total number of Countries with respondents:',response['Country'].nunique())
   print('Country with highest respondents:',response['Country'].value_counts().index[0],'with',response['Country'].value_counts().values[0],'respondents')
   print('Youngest respondent:',response['Age'].min(),' and Oldest respondent:',response['Age'].max())
   ```

1. Run this cell and all cells below. To do this, choose **Run → Run Selected Cell and All Below**.

1. Wait for the operation to complete.

{% note info %}

You can [share](../operations/projects/publication.md) the available notebook containing the computations or [export the entire project](../operations/projects/export.md).

{% endnote %}
