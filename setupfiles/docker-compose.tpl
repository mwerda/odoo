postgres:
  image: xcgd/postgresql
  expose:
    - "5432"

pgutils:
  image: grupocitec/pgutils
  links:
    - postgres:db
  volumes:
    - /tmp:/tmp  # TODO: see how to do this in a better way instead of mounting /tmp always: the problems is that docker-compose run doesn't allow the -v option to mount volumes on the fly

odoo:
  build: ./containers/odoo
  command: start -d ${ODOO_DBNAME} --db-filter=${ODOO_DBNAME} --addons=${ADDONS_PATH}
  environment:
    ODOO_MASTER_PASS: ${ODOO_MASTER_PASS}
    ODOO_DBNAME: ${ODOO_DBNAME}
  links:
    - postgres:db
  ports:
    - "8069:8069"
  volumes:
    # Project's specific Modules here
    #- ./odoo_modules:/odoo_modules
    # Odoo conf
    - ./setupfiles/odoo.conf:/etc/odoo/odoo.tpl
