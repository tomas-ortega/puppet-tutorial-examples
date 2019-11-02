define user_favourite_colour(
    Enum[
        'red',
        'green',
        'yellow',
        'black'
    ] $colour_selection,
    String $user_name,
) {
    file { "/tmp/${user_name}.txt":
        ensure  => file,
        content => "${colour_selection}",

    }
}

user_favourite_colour { 'Pakito Task':
    colour_selection => 'green',
    user_name => 'Pakito',
}
