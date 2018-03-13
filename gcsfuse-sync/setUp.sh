#!/bin/bash          

mkdir -p $FUSE_MOUNT_DIR
if [ -n "$SUBDIRECTORY_STRUCTURE" ]; then
    for dir in ${SUBDIRECTORY_STRUCTURE}; do
        gs_mount_msg="'gs://$FUSE_BUCKET_NAME/$dir' under '$FUSE_MOUNT_DIR/$dir'"
        local_mount="${FUSE_MOUNT_DIR}/${dir}"
        mkdir -p "$local_mount" && echo "Created '$local_mount' subdirectory" || echo "Failed to create '$local_mount'"
        gcsfuse -o allow_other $FUSE_BUCKET_NAME --only-dir $dir $local_mount && echo "Mounted $gs_mount_msg" || echo "Failed to mount $gs_mount_msg"
    done
else
    local_mount="${FUSE_MOUNT_DIR}"
    gs_mount_msg="'gs://$FUSE_BUCKET_NAME' under '$FUSE_MOUNT_DIR'"
    gcsfuse -o allow_other $FUSE_BUCKET_NAME $local_mount && echo "Mounted $gs_mount_msg" || echo "Failed to mount $gs_mount_msg"
fi
ls $FUSE_MOUNT_DIR
tail -f /dev/null
