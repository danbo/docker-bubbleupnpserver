# docker-bubbleupnpserver

For use with the [BubbleUPnP app](https://play.google.com/store/apps/details?id=com.bubblesoft.android.bubbleupnp) for android. This allows automatic transcoding for specific targets, namely the Google Chromecast. 

The Chromecast does not support ac3 or dts audio streams and so needs to be transcoded. The BubbleUPnP app in conjunction with this server will allow the chromecast to play a wide selection of media formats.

### Prerequisites
* Docker 
* Docker Compose

### Quick start
Pull from docker and start:

    $ cd <folder_with_docker-compose.yml>
    $ docker-compose up -d

The image will be pulled or built if it does not exist.

To shut it down

    $ cd <folder_with_docker-compose.yml>
    $ docker-compose down
    
Then use the Quick start command to run the bubbleupnpserver.

Forked from: https://github.com/wernerb/docker-bubbleupnpserver

Adaptations:

1. Updated to Alpine and Java 8, reference: https://bitbucket.org/rw_grim/docker-bubbleupnpserver
2. Added new OOM shutdown params: https://stackoverflow.com/questions/12096403/java-shutting-down-on-out-of-memory-error
  * for some reason the wernerb image gets "Thread terminated (b) abruptly with exception: java.lang.OutOfMemoryError: PermGen space" from time to time.
    These new OOM flags should shut down the JVM on OOM and have docker restart the container if the --restart=unless-stopped flag was used.
3. Added docker-compose for easy management

NOTE:

After the first time the container is run, I would copy out the configuration.xml via

docker cp <image_name>:/opt/bubbleupnpserver/configuration.xml .

shut down via docker-compose down

and then uncomment the mount line in the docker-compose.yml file and start it up again.

This way, your configuration persists should you need to rerun the build.
