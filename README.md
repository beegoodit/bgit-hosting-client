# BeeGood IT Hosting Client

## Usage

    #> BGIT_HOSTING_CLIENT_ENDPOINT=http://localhost:3000/api/hosting/create_docker_resource_usage_services.json BGIT_HOSTING_CLIENT_HOST=localhost BGIT_HOSTING_CLIENT_API_KEY=ae100b06f4353392dfc8c5a1b6d58dc68f092caf3b34a3adfe46d4098fe27f75 bin/bgit-hosting-client

## Using bgit-hosting-client as a service

To run the bgit-hosting-client client as a daemon service, we need to create a system service definition. Here are the steps to create and configure a systemd service definition:

### Add a user

    #> sudo adduser bgit-hosting-client

### Create the service definition

Create a new file /etc/systemd/system/bgit-hosting-client.service with the following contents:

    [Unit]
    Description=BeeGood IT Hosting Client

    [Service]
    WorkingDirectory=/home/bgit-hosting-client/bgit-hosting-client
    User=bgit-hosting-client
    Group=bgit-hosting-client
    ExecStart=BGIT_HOSTING_CLIENT_ENDPOINT=http://localhost:3000/api/hosting/create_docker_resource_usage_services.json BGIT_HOSTING_CLIENT_HOST=localhost BGIT_HOSTING_CLIENT_API_KEY=ae100b06f4353392dfc8c5a1b6d58dc68f092caf3b34a3adfe46d4098fe27f75 /home/bgit-hosting-client/.rvm/bin/rvm all do bundle exec bin/bgit-hosting-client
    Restart=always
    RestartSec=10

    [Install]
    WantedBy=multi-user.target

This tells systemd to create a new service called bgit-hosting-client, which runs the bgit-hosting-client binary with the API endpoint URL as an argument. The Restart and RestartSec directives configure the service to automatically restart if it crashes or exits. The WantedBy directive specifies that the service should be started automatically during the boot process.

### Reload systemd

Reload the systemd daemon to pick up the new service definition:

    #> sudo systemctl daemon-reload

### Start the service

Start the service:

    #> sudo systemctl start bgit-hosting-client

This will start the bgit-hosting-client service and send the Docker stats to the specified API endpoint.

### Verify that the service is running

Verify that the service is running:

    #> sudo systemctl status bgit-hosting-client

This will show the current status of the service, including whether it is running or stopped.

### Enable the service to start automatically during the boot process

Enable the service to start automatically during the boot process:

    #> sudo systemctl enable bgit-hosting-client

This will configure systemd to start the bgit-hosting-client service automatically during the boot process.

That's it! You now have a systemd service that runs the bgit-hosting-client client as a daemon, which can be started and stopped using the systemctl command.