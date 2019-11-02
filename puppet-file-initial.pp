file { '/tmp/fichero_nuevo.txt':
	ensure	=> file,
	owner	=> 'root',
	group	=> 'root',
	mode	=> '0644',
	content => "Este fichero ha sido generado por mi. S.O.\n $os \n",
}
