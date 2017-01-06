<?php
// Specify your Drupal core base directory (useful if you use symlinks).
$options['r'] = '/vagrant/web';
$options['l'] = 'http://drutopia-sdk.local';
$command_specific['site-install'] = array(
  'site-name' => 'Drutopia SDK',
  'site-mail' => 'welcome@example.com',
);
