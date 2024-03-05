# Getting notebook and cell IDs

{% include [serverless-deprecation-note](../../../_includes/datasphere/serverless-deprecation-note.md) %}

To work with a project through API, you may need IDs of notebooks and their cells.

{% note warning %}

The guide applies to {{ ds }} mode only.

{% endnote %}

## Getting started {#before-begin}

{% include [include](../../../_includes/datasphere/ui-before-begin.md) %}

## Getting a notebook ID {#get-notebook-id}

{% list tabs %}

- {{ ds }}

   1. Right-click any cell.
   1. In the window that opens, select **Сopy Notebook Id**.

      The clipboard will have a line like:

      ```text
      null/<community_ID>/<project_ID>/<notebook_ID>
      ```

   1. Copy the part of the line with the notebook ID.

{% endlist %}

## Getting a cell ID {#get-cell-id}

{% list tabs %}

- {{ ds }}

   1. Right-click the cell you need.
   1. In the window that opens, select **Сopy Cell Id**.

      The clipboard will have a line like:

      ```text
      null/<community_ID>/<project_ID>/<notebook_ID>/cell/<cell_ID>
      ```

   1. Copy the part of the line with the cell ID.

{% endlist %}