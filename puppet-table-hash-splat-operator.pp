$file_attributes = {
    'owner' => 'root',
    'group' => 'root',
    'mode' => '0644',
}

file { '/tmp/file-by-splat-operator.txt':
    ensure => present,
    * => $file_attributes,
}
