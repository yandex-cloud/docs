# Getting notebook and cell IDs

To work with a project through API, you may need IDs of notebooks and their cells.

## Getting started {#before-begin}

{% include [include](../../../_includes/datasphere/ui-before-begin.md) %}

## Getting a notebook ID {#get-notebook-id}

1. Right-click any cell.
1. In the window that opens, select **Сopy Notebook Id**.

   The clipboard will have a line like:

   ```text
   null/<community_ID>/<project_ID>/<notebook_ID>
   ```

1. Copy the part of the line with the notebook ID.

## Getting a cell ID {#get-cell-id}

1. Right-click the cell you need.
1. In the window that opens, select **Сopy Cell Id**.

   The clipboard will have a line like:

   ```text
   null/<community_ID>/<project_ID>/<notebook_ID>/cell/<cell_ID>
   ```

1. Copy the part of the line with the cell ID.