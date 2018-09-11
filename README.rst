Docker Container for apt-dater
==============================

- OS: Debian unstable
- Service: apt-dater


Usage
-----

Use docker-compose to start apt-dater container:

Start apt-dater TUI::
    
    docker-composer run apt-dater


Just update hosts and print result as XML::
    
    docker-composer run apt-dater -r


Print apt-dater help screen::
    
    docker-composer run apt-dater -h


Configuration
-------------

Adding hosts
............

Copy hosts.d/host.xml.example to hosts.d/yourhost.xml and modify it to your needs.

You can have multiple hosts.d/<youhost>.xml files, the container entrypoint script
will merge them.

Add ssh key
...........

By default the private key of the user starting the container is used by apt-dater
to authenticate with managed hosts.


Detailed usage
--------------

Start apt-dater container with Docker::

    docker run -ti --rm 
        -v ~/.ssh/id_rsa:/opt/apt-dater/id_rsa1         # mount private key of current user, used for authentication against apt-dater managed hosts
        -v `realpath ./hosts.d`:/opt/apt-dater/hosts.d  # mount apt-dater hosts configuration
        netresearch/apt-dater

