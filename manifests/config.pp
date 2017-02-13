# == Class: kibana5
#
# Configuration
#
class kibana5::config {

  if $kibana5::config {

    file { 'kibana-config-file':
      ensure  => file,
      path    => '/etc/kibana/kibana.yml',
      owner   => 'kibana',
      group   => 'kibana',
      mode    => '0755',
      content => template('kibana5/kibana.yml.erb'),
      notify  => Service['kibana5'],
    }
  }

}
