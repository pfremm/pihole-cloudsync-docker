FROM pihole/pihole

RUN apt-get -y update
RUN apt-get -y install vim git

WORKDIR /usr/local/bin
RUN git clone https://github.com/stevejenkins/pihole-cloudsync.git
RUN echo "#!/bin/bash" > /usr/local/bin/cron-pihole-sync
RUN echo "source /etc/environment" >> /usr/local/bin/cron-pihole-sync
RUN echo '/usr/local/bin/pihole-cloudsync/pihole-cloudsync --$MODE' >> /usr/local/bin/cron-pihole-sync
RUN chmod 0774 /usr/local/bin/cron-pihole-sync

WORKDIR /etc/cron.d
RUN rm /etc/cron.d/*
#RUN echo "00 01,07,13,19 * * * root /usr/local/bin/cron-pihole-sync  2>&1" > /etc/cron.d/pihole-cloudsync
RUN echo "*/30 * * * * /usr/local/bin/cron-pihole-sync  2>&1" > /etc/cron.d/pihole-cloudsync

RUN chmod 0644 /etc/cron.d/pihole-cloudsync

RUN crontab /etc/cron.d/pihole-cloudsync

# Create the log file to be able to run tail
RUN touch /var/log/cron.log
# Run the command on container startup
ENTRYPOINT [ "" ]
CMD cron && tail -f /var/log/cron.log
