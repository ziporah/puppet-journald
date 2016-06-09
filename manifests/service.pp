class journald::service {
  service { ['systemd-journald']:
    ensure => running,
    enable => true,
  }
  if $journald::upload::URL != undef {
    service { ['systemd-journal-upload']:
      ensure => running,
      enable => true,
    }
  }
}
