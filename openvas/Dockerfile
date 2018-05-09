FROM alpine

MAINTAINER suntzu (suntzu@theartofwar.org)

# Install openrc
RUN apk update && apk add --no-cache openrc &&\
# Tell openrc its running inside a container, till now that has meant LXC
    sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf &&\
# Tell openrc loopback and net are already there, since docker handles the networking
    echo 'rc_provide="loopback net"' >> /etc/rc.conf &&\
# no need for loggers
    sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf &&\
# can't get ttys unless you run the container in privileged mode
    sed -i '/tty/d' /etc/inittab &&\
# can't set hostname since docker sets it
    sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname &&\
# can't mount tmpfs since not privileged
    sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh &&\
# can't do cgroups
    sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh


# Install components
RUN apk add --no-cache 	openvas-manager \
			gnutls-utils \
			openvas-cli \
			openvas-scanner \
			greenbone-security-assistant \ 
			python2 \
			redis \
			rpm \
			alien \
			openssh-keygen \
			alien 
RUN 	sed  -i -e "s/# \(unix.*\)/\1/" /etc/redis.conf && sed -i -e "s/port\ 6379/port\ 0/g" /etc/redis.conf && \
	sed -i -e 's/MANAGER_LISTEN=.*/MANAGER_LISTEN="--listen=0.0.0.0"/g' /etc/conf.d/openvasmd && \
	sed -i -e "s/127\.0\.0\.1/0\.0\.0\.0/g" /etc/conf.d/gsad
RUN mkdir -p /run/openrc && touch /run/openrc/softlevel
RUN greenbone-nvt-sync && \
    greenbone-scapdata-sync && \
    greenbone-certdata-sync
ADD run.sh /run.sh
CMD /run.sh $@
