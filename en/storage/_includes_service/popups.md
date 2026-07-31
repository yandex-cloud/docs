#### {#noncurrent-delete-markers}

The non-current object version that has been deleted gets marked by a non-current delete marker (`NoncurrentDeleteMarker`). This happens when a new object version is loaded on top of a deleted one. In which case the object becomes available again, and the marker which used to mark the deleted version moves to the version history.
