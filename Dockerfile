FROM atmoz/sftp

# Install FUSE so we can mount GCS buckets
# Ref: https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/installing.md
RUN apt-get update
RUN apt-get install -y curl lsb gnupg wget
RUN echo "deb http://packages.cloud.google.com/apt gcsfuse-stretch main" | tee /etc/apt/sources.list.d/gcsfuse.list
RUN cat /etc/apt/sources.list.d/gcsfuse.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y gcsfuse

# change ssh port for gcp compute engine
RUN sed -i '$a\Port 2222' "/etc/ssh/sshd_config"

#you can configure the users in a file inside the container or by parameters
#COPY etc/sftp/users.conf /etc/sftp/users.conf
COPY etc/sftp.d/mount.sh /etc/sftp.d/mount.sh
COPY etc/sftp.d/bind.sh /etc/sftp.d/bind.sh
COPY secrets/gcloud-key.json key.json

#RUN sh ./gcs-mounts.sh