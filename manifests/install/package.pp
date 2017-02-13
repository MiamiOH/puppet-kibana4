# == Class: kibana5
#
# Package Installation Method
#
class kibana5::install::package {

  if ($kibana5::manage_repo) {

    case $::osfamily {

      'RedHat': {
        yumrepo { "kibana-${kibana5::package_repo_version}.x":
          baseurl  => "https://artifacts.elastic.co/packages/${kibana5::package_repo_version}/yum",
          enabled  => '1',
          gpgcheck => '1',
          gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
          descr    => "Kibana repository for ${kibana5::package_repo_version}.x packages",
          proxy    => $kibana5::package_repo_proxy,
          before   => Package['kibana5'],
        }
      }

      'Debian': {
        if !defined(Class['apt']) {
          class { 'apt': }
        }
        apt::source { "kibana-${kibana5::package_repo_version}":
          location => "https://artifacts.elastic.co/packages/${kibana5::package_repo_version}/apt",
          release  => 'stable',
          repos    => 'main',
          key      => {
            'source' => 'http://artifacts.elastic.co/GPG-KEY-elasticsearch',
            'id'     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
          },
          include  => {
            'src' => false,
          },
          before   => Package['kibana5'],
        }
      }

      default: {
        fail("${::operatingsystem} not supported")
      }
    }
  }

  package { 'kibana5':
    ensure => $kibana5::version,
    name   => kibana,
  }
}
