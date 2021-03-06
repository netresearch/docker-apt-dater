Docker Container for apt-dater
==============================

- OS: Debian unstable
- Service: apt-dater

apt-dater provides an ncurses interface for managing package updates of multiple
hosts.

- https://github.com/DE-IBH/apt-dater

This container image uses the debian version of apt-dater, which includes some
extra patches not merged in above github repository.

For general apt-dater usage or preparation of hosts please see apt-dater manual.

Usage
-----

You can prepare a host folder with example files if you like::
    
    docker run -v `pwd`:/var/apt-dater-init netresearch/apt-dater init


This will copy example docker-compose.yml and hosts.xml and README to your current folder.

Use docker-compose to start apt-dater container:

Start apt-dater TUI::
    
    docker-compose run --rm apt-dater


Just update hosts and print result as XML::
    
    docker-compose run --rm apt-dater -r


Print apt-dater help screen::
    
    docker-compose run --rm apt-dater -h


Configuration
-------------

Adding hosts
............

Preparing your hosts
,,,,,,,,,,,,,,,,,,,,

- install apt-dater-host package
- configure a user to be used by apt-dater
- deploy your public key to the hosts

For more details see https://github.com/DE-IBH/apt-dater

Add hosts to apt-dater
,,,,,,,,,,,,,,,,,,,,,,

Copy hosts.d/host.xml.example to hosts.d/yourhost.xml and modify it to your needs.

You can have multiple hosts.d/<yourhost>.xml files, the container entrypoint script
will merge them.

hosts.d/host.xml example::
    
    <group name="Internal Hosts">
        <host name="server1.internal" ssh-user="apt-dater"/>
    </group>


Add SSH key
...........

By default the private key of the user starting the container is used by apt-dater
to authenticate with managed hosts.

Edit docker-compose.yml or alter docker command line to use another SSH key.


Detailed usage
--------------

Start apt-dater container with Docker::

    docker run -ti --rm \
        -v ~/.ssh/id_rsa:/opt/apt-dater/id_rsa1 \        # mount private key of current user, used for authentication against apt-dater managed hosts
        -v `realpath ./hosts.d`:/opt/apt-dater/hosts.d \ # mount apt-dater hosts configuration
        netresearch/apt-dater


Wrapper for apt-dater CLI command
---------------------------------

In contrib/ you find a simple shell script which can be used as a wrapper for
apt-dater CLI command, just place it in /usr/bin and modify the path in the script.


Known issues
------------

- auto-refresh is disabled, it caused hosts to disappear in apt-dater host list

