# [maxime1907/filegator](https://github.com/maxime1907/docker-filegator)

[![GitHub Stars](https://img.shields.io/github/stars/maxime1907/docker-filegator.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/maxime1907/docker-filegator)
[![GitHub Release](https://img.shields.io/github/release/maxime1907/docker-filegator.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/maxime1907/docker-filegator/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=maxime1907.io&message=GitHub%20Package&logo=github)](https://github.com/maxime1907/docker-filegator/packages)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/maxime1907/filegator.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge)](https://microbadger.com/images/maxime1907/filegator "Get your own version badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/maxime1907/filegator.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/maxime1907/filegator)
[![Docker Stars](https://img.shields.io/docker/stars/maxime1907/filegator.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/maxime1907/filegator)

[FileGator](https://filegator.io) is a free, open-source, self-hosted web application for managing files and folders.

[![FileGator](https://raw.githubusercontent.com/filegator/filegator/master/dist/img/logo.png)](https://filegator.io)

## Supported Architectures

Our images support multiple architectures such as `x86-64`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `maxime1907/filegator` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | latest |

## Version Tags

This image provides various versions that are available via tags. `latest` tag usually provides the latest stable version. Others are considered under development and caution must be exercised when using them.

| Tag | Description |
| :----: | --- |
| latest | Stable FileGator releases. |

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose ([recommended](https://docs.linuxserver.io/general/docker-compose))

Compatible with docker-compose v3 schemas.

```yaml
---
version: '3.7'

services:
  filerun:
    image: maxime1907/filegator
    container_name: filegator
    ports:
      - 80:80
      - 443:443
    environment:
      PUID: 1000
      PGID: 1000
      TZ: Europe/London
    volumes:
      - /your/data/folder:/data
      - /your/config/folder:/config
    restart: unless-stopped
```

### docker cli

```
docker run -d \
  --name=filegator \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 80:80 \
  -p 443:443 \
  -v </path/to/appdata/config>:/config \
  -v </path/to/data>:/data \
  --restart unless-stopped \
  maxime1907/filegator
```


## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | http gui |
| `-p 443` | https gui |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-v /config` | Contains all relevant configuration files. |
| `-v /data` | Contains all personal files. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

Access the web gui at http://SERVERIP:PORT


### Adding password protection

This image now supports password protection through htpasswd. Run the following command on your host to generate the htpasswd file `docker exec -it filegator htpasswd -c /config/nginx/.htpasswd <username>`. Replace <username> with a username of your choice and you will be asked to enter a password. New installs will automatically pick it up and implement password protected access. Existing users updating their image can delete their site config at `/config/nginx/site-confs/default` and restart the container after updating the image. A new site config with htpasswd support will be created in its place.


## Docker Mods
[![Docker Mods](https://img.shields.io/badge/dynamic/yaml?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=filegator&query=%24.mods%5B%27filegator%27%5D.mod_count&url=https%3A%2F%2Fraw.githubusercontent.com%2Flinuxserver%2Fdocker-mods%2Fmaster%2Fmod-list.yml)](https://mods.linuxserver.io/?mod=filegator "view available mods for this container.") [![Docker Universal Mods](https://img.shields.io/badge/dynamic/yaml?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=universal&query=%24.mods%5B%27universal%27%5D.mod_count&url=https%3A%2F%2Fraw.githubusercontent.com%2Flinuxserver%2Fdocker-mods%2Fmaster%2Fmod-list.yml)](https://mods.linuxserver.io/?mod=universal "view available universal mods.")

We publish various [Docker Mods](https://github.com/linuxserver/docker-mods) to enable additional functionality within the containers. The list of Mods available for this image (if any) as well as universal mods that can be applied to any one of our images can be accessed via the dynamic badges above.


## Support Info

* Shell access whilst the container is running: `docker exec -it filegator /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f filegator`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' filegator`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' maxime1907/filegator`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull filegator`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d filegator`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run
* Update the image: `docker pull maxime1907/filegator`
* Stop the running container: `docker stop filegator`
* Delete the container: `docker rm filegator`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (only use if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once filegator
  ```
* You can also remove the old dangling images: `docker image prune`

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using [Docker Compose](https://docs.linuxserver.io/general/docker-compose).

### Image Update Notifications - Diun (Docker Image Update Notifier)
* We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:
```
git clone https://github.com/maxime1907/docker-filegator.git
cd docker-filegator
source $PWD/config.env
docker build \
  --no-cache \
  --pull \
  --build-arg DOCKER_HUB_USER="$DOCKER_HUB_USER" \
  --build-arg IMAGE_BUILD_DATE="$IMAGE_BUILD_DATE" \
  --build-arg IMAGE_VERSION="$IMAGE_VERSION" \
  -t "$DOCKER_HUB_USER"/"$IMAGE_NAME":"$IMAGE_VERSION" .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **01.02.21:** - Initial Release.