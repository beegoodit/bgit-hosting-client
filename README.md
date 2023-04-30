# docker-stats-api

## Usage

    #> docker-stats-api https://your-api-endpoint.com/stats

## Using docker-stats-api as a service

To run the docker-stats-api client as a daemon service, we need to create a system service definition. Here are the steps to create and configure a systemd service definition:

### Create the service definition

Create a new file /etc/systemd/system/docker-stats-api.service with the following contents:

    # makefile

    [Unit]
    Description=Docker Stats API Client

    [Service]
    ExecStart=/usr/local/bin/docker-stats-api https://your-api-endpoint.com/stats
    Restart=always
    RestartSec=10

    [Install]
    WantedBy=multi-user.target

This tells systemd to create a new service called docker-stats-api, which runs the docker-stats-api binary with the API endpoint URL as an argument. The Restart and RestartSec directives configure the service to automatically restart if it crashes or exits. The WantedBy directive specifies that the service should be started automatically during the boot process.

### Reload systemd

Reload the systemd daemon to pick up the new service definition:

    #> sudo systemctl daemon-reload

### Start the service

Start the service:

    #> sudo systemctl start docker-stats-api

This will start the docker-stats-api service and send the Docker stats to the specified API endpoint.

### Verify that the service is running

Verify that the service is running:

    #> sudo systemctl status docker-stats-api

This will show the current status of the service, including whether it is running or stopped.

### Enable the service to start automatically during the boot process

Enable the service to start automatically during the boot process:

    #> sudo systemctl enable docker-stats-api

This will configure systemd to start the docker-stats-api service automatically during the boot process.

That's it! You now have a systemd service that runs the docker-stats-api client as a daemon, which can be started and stopped using the systemctl command.