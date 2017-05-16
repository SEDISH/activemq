#/bin/bash

/activemq/bin/activemq start
tail -f /activemq/data/activemq.log
