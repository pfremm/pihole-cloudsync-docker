FROM pihole/pihole

RUN apt-get -y update
RUN apt-get -y install vim git

WORKDIR /usr/local/bin
RUN git clone https://github.com/stevejenkins/pihole-cloudsync.git