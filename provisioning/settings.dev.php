<?php

/**
 * @file
 * Settings for the dev environment.
 */

$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => 'drupal',
  'username' => 'root',
  'password' => '',
  'host' => 'localhost',
  'prefix' => '',
);

$settings['hash_salt'] = 'sjmcb9AS_K7QG5fVDrusUD2VIeeANeKen0XfpRkmcAKYcSlh8topia9Lp2UM5hNGUjAvxGa0Uw';
$settings['trusted_host_patterns'] = array(
  '^drutopia\.local$',
);

$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;
