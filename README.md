# BeeGood IT Hosting Client

## Usage

    #> BGIT_HOSTING_CLIENT_ENDPOINT=http://localhost:3000/api/hosting/create_docker_resource_usage_services.json BGIT_HOSTING_CLIENT_HOST=localhost BGIT_HOSTING_CLIENT_API_TOKEN=ae100b06f4353392dfc8c5a1b6d58dc68f092caf3b34a3adfe46d4098fe27f75 bin/bgit-hosting-client

## Using bgit-hosting-client as a service

To run the bgit-hosting-client client as a daemon service, we need to create a system service definition. Here are the steps to create and configure a systemd service definition:

### Add a user

    #> sudo adduser bgit-hosting-client
    #> sudo usermod -aG docker bgit-hosting-client
    #> sudo adduser bgit-hosting-client sudo

### Install rvm

    #> su - bgit-hosting-client
    #> gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    #> \curl -sSL https://get.rvm.io | bash
    #> source /home/bgit-hosting-client/.rvm/scripts/rvm

### Setup the client

    #> mkdir ~/bgit-hosting-client
    #> cd ~/bgit-hosting-client

    #> echo "ruby-3.2.2" > .ruby-version
    #> echo "bgit-hosting-client" > .ruby-gemset
    #> echo 'source "https://rubygems.org"' >> Gemfile
    #> echo 'gem "bgit-hosting-client", git: "https://github.com/beegoodit/bgit-hosting-client.git"' >> Gemfile
    
    #> cd .
    #> rvm install "ruby-3.2.2"
    #> bundle install
    
    #> echo '#!/bin/bash' >> run.sh
    #> echo 'source ~/.rvm/scripts/rvm' >> run.sh
    #> echo 'rvm use' >> run.sh
    #> echo 'BGIT_HOSTING_CLIENT_ENDPOINT=https://production-hosting-beegoodit-de.hosting.beegoodit.de/api/hosting/create_docker_resource_usage_services.json BGIT_HOSTING_CLIENT_HOST=localhost BGIT_HOSTING_CLIENT_API_TOKEN=<api-token> bgit-hosting-client-service' >> run.sh
    #> chmod u+x ./run.sh

### Create the service definition

Create a new file /etc/systemd/system/bgit-hosting-client.service with the following contents:

    [Unit]
    Description=BeeGood IT Hosting Client

    [Service]
    WorkingDirectory=/home/bgit-hosting-client/bgit-hosting-client
    User=bgit-hosting-client
    Group=bgit-hosting-client
    ExecStart=/home/bgit-hosting-client/bgit-hosting-client/run.sh
    Restart=always
    RestartSec=10

    [Install]
    WantedBy=multi-user.target

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