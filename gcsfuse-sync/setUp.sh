#!/bin/bash          

mkdir -p $FUSE_MOUNT_DIR
rm -rf "$FUSE_MOUNT_DIR/*"
gcsfuse -o allow_other $FUSE_BUCKET_NAME $FUSE_MOUNT_DIR
echo "Mounted succesfully FUSE bucket $FUSE_BUCKET_NAME in $FUSE_MOUNT_DIR"
for dir in ${SUBDIRECTORY_STRUCTURE}; do
    echo "Created '$FUSE_MOUNT_DIR/$dir' subdirectory"
    mkdir -p "${FUSE_MOUNT_DIR}/${dir}"
done
ls $FUSE_MOUNT_DIR
tail -f /dev/null
