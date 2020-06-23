#!/bin/bash
chgrp users /dev/fuse
for user_home in /home/* ; do
  if [ -d "$user_home" ]; then
    username=`basename $user_home`
    runuser -l $username -c \
    "export GOOGLE_APPLICATION_CREDENTIALS=key.json && \
    gcsfuse -o nonempty --only-dir $username $bucket /home/$username/share"
  fi 
done