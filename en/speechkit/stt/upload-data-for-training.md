# Uploading fine-tuning data for a speech recognition model


To upload [fine-tuning data for a speech recognition model](additional-training.md#advanced-training), collect them into an archive and send the archive to the {{ speechkit-name }} team. Tuning is available for recognition in the Russian language only.

## Getting started {#before-you-begin}

1. Prepare TSV files with [terms and examples](additional-training.md#advanced-training).
1. [Create a community](../../datasphere/operations/community/create.md) in {{ ml-platform-full-name }}. This is where you will work from.
1. [Link a billing account to the community](../../datasphere/operations/community/link-ba.md).

## Preparing an archive with fine-tuning data {#prepare}

1. [Create a project](../../datasphere/operations/projects/create.md) on the {{ ml-platform-name }} home page.
1. [Open the notebook]({{ link-datasphere-main }}/import-ipynb?path=https://{{ s3-storage-host }}/doc-files/SpeechKit-prepare-templates.ipynb) containing the data check function. Your data will be packed into an archive you will need to forward to the {{ speechkit-name }} team to fine-tune the model.

1. Click **Run in {{ ml-platform-full-name }}**.
1. Select the project you created earlier and click **Add**.

   The notebook will open in {{ jlab }}Lab in the selected project.

1. Drag files with terms and examples to the project directory in {{ jlab }}Lab.
1. In the notebook, invoke the data check function. This will form an archive to be loaded to {{ speechkit-name }}.

   To invoke the function, select the following cell in the notebook and click ![run](../../_assets/datasphere/jupyterlab/run.svg):

   ```python
   prepare_stt_templates(
      templates_path="<name_of_file_with_terms_and_examples>.tsv",
      output_path="<output_file_name>_tar.gz",
   )
   ```

1. Download the archive. To do this, right-click it and select ![download](../../_assets/datasphere/jupyterlab/download.svg) **Download**.
1. [Contact support]({{ link-console-support }}) and provide the archive to it.
