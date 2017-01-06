<?php

/**
 * @file
 * Settings for the stage environment.
 */

$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => 'drupal-drutopia',
  'username' => 'drupal',
  'password' => 'o6VQpRRR',
  'host' => 'localhost',
  'prefix' => '',
);

$config_directories = array(
    CONFIG_SYNC_DIRECTORY => '../config/default'
);

$settings['hash_salt'] = 'sjmcb9AS_K7QG5fVDrusUD2VIeeANeKen0XfpRkmcAKYcSlh8topia9Lp2UM5hNGUjAvxGa0Uw';
$settings['trusted_host_patterns'] = array('drutopia.test.agaric.com');
