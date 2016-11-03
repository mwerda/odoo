odoo docker-compose stack
=======================

This docker-compose project includes 3 modules:
- postgresql ([xcgd/postgresql](https://bitbucket.org/xcgd/postgresql))
- odoo ([grupocitec/odoo](https://github.com/citec/docker-odoo))
- pqutils ([grupocitec/pgutils](https://github.com/citec/docker-pgutils))

----------


Usage
-------------

### Initialization:

#### Environment:

Two environment variables are needed:

    ODOO_DBNAME (default "demo")
    ODOO_MASTER_PASS (default "demo")
You can add a script file calle <i>environment.sh</i> to the project's path if you need to add custom environment variables, etc.
Example:

    #!/bin/bash
    export ODOO_DBNAME="mydbname"

#### Render your docker-compose.yml:

If you have a look at the source code, you will notice that the docker-compose.yml file is missing. This is because we added a way of allowing/dinamically rendering environment variables into it. In order to keep your sensitive data (passwords, etc) away from your code, just set those environment variables as described in the last step. Then. just run:

    ./update_yml.sh
Your brand new docker-compose.yml file will be rendered, using your environment variables on it

###  Run odoo:

####  Just run standard odoo:

    docker-compose up -d
This will launch 3 containers, 2 of which will remain running. Just access in your browser:

    http://localhost:8069
And you will have an odoo instance running (version 8.0 for now)

#### Run odoo with your own modules:

- Copy your modules to <i>some/path</i> inside the repo's folder (not needed, can be absolute path too)
- Edit setupfiles/docker-compose.tpl under the <i>volumes:</i> section of the odoo container definition and mount your modules into the odoo container

    ./some/path:/some/path/inside/the/container

- update your yml file

    ./update_yml.sh

- Add <i>/some/path/inside/the/container</i> to the file <i>addons_path.conf</i>
- run your project normally

### Use the <i>pgutils</i> container to make db operations:

Run this for help:

    docker-compose run pgutils

Examples:

    docker-compose run pgutils list  # This list databases

    docker-compose run pgutils dbsize # Show databases sizes

    docker-compose run pgutils drop {dbname} # Drop database {dbname}

    docker-compose run pgutils backup {dbname} {filename} # Backup database {dbname} into {filename} (must be in /tmp)

    docker-compose run pgutils restore {dbname} {filename} # Restore database {dbname} from {filename} (must be in /tmp)
