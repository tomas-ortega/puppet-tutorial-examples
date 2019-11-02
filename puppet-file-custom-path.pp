file { 'My Custom File Path':
	path	=> '/tmp/puppet-file-custom-path.txt',
	content => "Contenido del archivo.\n $os \n",
}
