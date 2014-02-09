exec { "apt-get update":
  path => "/usr/bin",
}
 
class installStartApache2 {
  package { "apache2":
    ensure  => present,
    require => Exec["apt-get update"],
  }
  service { "apache2":
    ensure  => "running",
    require => Package["apache2"],
  }
}
 
class whatAmI {
  notify{"OS: ${operatingsystem}":}
  notify{"OSFamily: ${osfamily}": }
}
 
class deployClock {
  file { "/var/www/clock":
    ensure  => "link",
    target  => "/vagrant/clock",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }
}
 
include whatAmI
include installStartApache2
include deployClock