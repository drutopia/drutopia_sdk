<?php

/**
 * @file
 * Settings for the production environment.
 */

$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => 'drutopia',
  'username' => 'drutopia',
  'password' => 'EdhwQfs6gzaRgQ5h',
  'host' => 'localhost',
  'prefix' => '',
);

$settings['hash_salt'] = 'sjmcb9AS_K7QG5fVDrusUD2VIeeANeKen0XfpRkmcAKYcSlh8topia9Lp2UM5hNGUjAvxGa0Uw';
$settings['trusted_host_patterns'] = array('drutopia.org', 'drutopia.mayfirst.org');
