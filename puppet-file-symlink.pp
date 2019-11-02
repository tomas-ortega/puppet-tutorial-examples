file { '/tmp/direct_link_to_file1_lv1':
	ensure => link,
	target => '/tmp/puppet-file-recursive-l1/file1-lv1.txt'
}
