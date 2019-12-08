FROM centos:7
ENV container docker

#Install systemd from centos docker hub page
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

#Install dependancies and ansible
RUN yum makecache fast && \ 
    yum -y update && \ 
    yum -y install ansible && \ 
    yum clean all

#Setting up inventory file
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts


