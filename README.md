# sftp-gcsfuse

esta imagen permite conectar un bucket de gcp a traves de un servidor sftp basado en la image atmoz/sftp

    docker run --privileged -p 2222:22 -e bucket=mpl-mktg-cama-cl-dev-sfmc_sftp_landing -d sftp-gcsfuse:latest sftp_landing_user:1234:::

la ultima instruccion detalla los usuario 

    <nombre>:<password>:<gid>:<uid>:<folder>

## encriptacion de contraseña
se puede encriptar la contraseña para quue no quede visible. usando la siguiente imagen docker atmoz/makepasswd

    echo -n "your-password" | docker run -i --rm atmoz/makepasswd --crypt-md5 --clearfrom=-

luego se utiliza de la siguiente manera

    docker run --privileged -p 2222:22 -e bucket=mpl-mktg-cama-cl-dev-sfmc_sftp_landing -d sftp-gcsfuse:latest 'sftp_landing_user:$1$F/1G7NRS$ABXvBA1ezeZXzA1u05gY30:e::'

## GCP compute engine

Configurando una maquina virtual con un contenedor de inicio

- se debe generar una regla de firewall de nombre sftp permitiendo el acceso al puerto 2222
- utilizar como comando '/entrypoint'
- como argumento del comando utilizar la configuracion de usuario 'sftp_landing_user:$1$F/1G7NRS$ABXvBA1ezeZXzA1u05gY30:e::'
- como variable de entorno 'bucket' con el valor del nombre del bucket de destino

