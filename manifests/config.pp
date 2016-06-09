class journald::config {
  $merged_options = merge($::journald::params::default_options, $::journald::options)
  $merged_upload = merge($::journald::params::default_upload, $::journald::upload)

  if $::journald::persist_log {
    $journald_dir = 'directory'
  } else {
    $journald_dir = 'absent'
  }

  file { '/var/log/journal/':
    ensure => $journald_dir,
    force  => true,
    owner  => 0,
    group  => 'systemd-journal',
  }

  file { '/etc/systemd/journald.conf':
    ensure  => 'file',
    owner   => 0,
    group   => 0,
    content => template("${module_name}/journald.conf.erb"),
  }

  file { '/etc/systemd/journal-upload.conf':
    ensure  => 'file',
    owner   => 0,
    group   => 0,
    content => template("${module_name}/journal-upload.conf.erb"),
  }
}
