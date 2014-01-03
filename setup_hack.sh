apt-get -y install python-software-properties

echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
add-apt-repository -y ppa:nginx/stable
apt-get -y update
apt-get -y upgrade --force-yes

# Preconfigure MySQL root password
echo "mysql-server mysql-server/root_password password docker" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password docker" | debconf-set-selections

# Dependencies
apt-get -y install git \
                   wget \
                   nginx \
                   supervisor \
                   mysql-server \
                   mysql-client \
                   python \
                   python-dev \
                   python-pip \
                   build-essential \
                   libmysqlclient-dev \
                   gcc \
                   python-gevent \
                   python-xapian \
                   libzmq-dev \
                   python-zmq \
                   python-lxml \
                   libmagickwand-dev \
                   tmux


# Install requirements from PyPI and GitHub
pip install --upgrade pip
easy_install -U distribute

pip install argparse==1.2.1 \
            beautifulsoup4==4.3.2 \
            httplib2==0.8 \
            pytest==2.3.4 \
            tornado==3.0.1 \
            wsgiref==0.1.2 \
            futures==2.1.3 \
            jsonrpclib==0.1.3 \
            SQLAlchemy==0.8.3 \
            pymongo==2.5.2  \
            dnspython==1.11.0 \
            boto==2.10.0 \
            ipython==1.0.0 \
            Flask==0.10.1 \
            gevent-socketio==0.3.5-rc2 \
            geventconnpool==0.2 \
            gunicorn==17.5 \
            colorlog==1.8 \
            MySQL-python==1.2.4 \
            requests==2.0.0 \
            Fabric==1.7.0 \
            supervisor==3.0 \
            chardet==2.1.1 \
            #PIL==1.1.7 \
            #http://effbot.org/media/downloads/Imaging-1.1.7.tar.gz \
            Wand==0.3.5 \
            setproctitle==1.1.8 \
            Cython==0.19.1 \
            zerorpc==0.4.3 \
            gdata==2.0.18 \
            python-dateutil==2.1 \
            flanker==0.3.3 \
            git+https://github.com/zeromq/pyzmq.git@v13.1.0#egg=zmq \
            git+https://github.com/inboxapp/imapclient.git#egg=imapclient \
            git+https://github.com/inboxapp/bleach.git#egg=bleach \
            git+https://github.com/inboxapp/iconv.git#egg=iconv \
            geventconnpool==0.2

# Install NodeJS
wget -O - http://nodejs.org/dist/v0.8.26/node-v0.8.26-linux-x64.tar.gz | tar -C /usr/local/ --strip-components=1 -zxv


# MySQL -- copy this file!
cp ./deploy/my.cnf /etc/mysql/conf.d/inboxapp.cnf

# Create default MySQL database. Perhaps we should do this at some configuration time
#/usr/sbin/mysqld & sleep 5 ; echo "CREATE DATABASE inboxdb DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci" | mysql -u root --password=docker


# copy to this directory!
cp -r . /srv/inboxapp

# Default config file
# RUN cp config-sample.cfg config.cfg

apt-get -y purge build-essential
apt-get -y autoremove

# ENTRYPOINT /usr/bin/mysqld_safe & /bin/bash
