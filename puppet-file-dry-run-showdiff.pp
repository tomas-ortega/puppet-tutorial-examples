file { '/tmp/puppet-file-dry-run-showdiff.txt':
	ensure	=> file,
	content => "First line in file! :) \n
                    and this is the second line!",
}
