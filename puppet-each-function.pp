$files = ['each_file1', 'each_file2', 'each_file3']

$files.each | $single_file | {
    file { "/tmp/${single_file}":
        content => "echo I am ${single_file}\n",
        mode => '0755',
    }
}
