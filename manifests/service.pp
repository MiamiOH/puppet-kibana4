# == Class: kibana5
#
# Service creation and mgmt
#
class kibana5::service {

  service { 'kibana5':
    ensure     => $kibana5::service_ensure,
    enable     => $kibana5::service_enable,
    name       => kibana,
    provider   => $kibana5::service_provider,
    hasstatus  => true,
    hasrestart => true,
  }

}
