file { '/tmp/puppet-file-recursive-destiny':
	source => '/tmp/puppet-file-recursive-l1',
	recurse => true,
}
