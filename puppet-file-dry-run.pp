file { '/tmp/puppet-file-dry-run.txt':
       ensure => file,
       content => "File with dry run execution! :D",
}
