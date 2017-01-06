#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install \
	apache2 \
	git \
	mysql-server \
	php5-apcu \
	php5-cli \
	php5-curl \
	php5-fpm \
	php5-gd \
	php5-mysql \
	php5-xdebug \
	rubygems-integration \
	vim-nox
apt-get -y autoremove

# Install composer.
if [ ! -f /usr/local/bin/composer ]; then
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
fi

cp -r /vagrant/provisioning/etc/* /etc/
chmod -R u+w /vagrant/web/sites/default
cp /vagrant/provisioning/settings.dev.php /vagrant/web/sites/default/settings.local.php
cp /vagrant/provisioning/services.yml /vagrant/web/sites/default/

php5enmod vagrant

# Create the database.
if [ ! -d /var/lib/mysql/drupal ]; then
	mysqladmin -u root create drupal
fi

# Disable the system's default virtual host.
if [ -L /etc/apache2/sites-enabled/000-default.conf ]; then
	a2dissite 000-default
fi

# Enable the drupal website as the default virtual host.
if [ ! -L /etc/apache2/sites-enabled/drupal.conf ]; then
	a2ensite drupal
fi

# Enable the required web server modules
if [ ! -L /etc/apache2/mods-enabled/rewrite.load ]; then
	a2enmod rewrite
fi

if [ ! -L /etc/apache2/mods-enabled/proxy.load ]; then
	a2enmod proxy
fi

if [ ! -L /etc/apache2/mods-enabled/proxy_fcgi.load ]; then
	a2enmod proxy_fcgi
fi

service php5-fpm restart
service apache2 restart

# Add /vagrant/vendor/bin to PATH.
grep -q 'export PATH="/vagrant/vendor/bin:$PATH"' .bashrc
if [ $? -eq 1 ]; then
  echo 'export PATH="/vagrant/vendor/bin:$PATH"' >> /home/vagrant/.bashrc
fi

# Conveniently start in the /vagrant folder
grep -q 'cd /vagrant' .bashrc
if [ $? -eq 1 ]; then
  echo 'cd /vagrant' >> /home/vagrant/.bashrc
fi

# Add composer function to disable xdebug with composer
grep -qs 'function composer()' .bash_aliases
if [ $? -ge 1 ]; then
  echo 'function composer() { COMPOSER="$(which composer)" || { echo "Could not find composer in path" >&2 ; return 1 ; } && sudo php5dismod -s cli xdebug ; $COMPOSER "$@" ; STATUS=$? ; sudo php5enmod -s cli xdebug ; return $STATUS ; }' >> /home/vagrant/.bash_aliases
fi

sudo -u vagrant composer config --global repo.packagist composer https://packagist.org

sudo php5dismod -s cli xdebug
cd /vagrant && sudo -u vagrant composer install --prefer-dist
sudo php5enmod -s cli xdebug

# Install the distribution
cd /vagrant && sudo -u vagrant /vagrant/vendor/bin/drush -y si
