# @summary This define installs an instance of Tomcat.
#
# @param catalina_home
#   Specifies the directory where the Apache Tomcat software is installed by a `tomcat::install` resource. Valid options: a string containing an absolute path. 
# @param catalina_base
#   Specifies the `$CATALINA_BASE` of the Tomcat instance where logs, configuration files, and the 'webapps' directory are managed. For single-instance installs, this is the same as the `catalina_home` parameter Valid options: a string containing an absolute path. `$catalina_home`.
# @param user
#   Specifies the owner of the instance directories and files. `$::tomcat::user`.
# @param group
#   Specifies the group of the instance directories and files. `$::tomcat::group`.
# @param manage_user
#   Specifies whether the user should be managed by this module or not. `$::tomcat::manage_user`.
# @param manage_group
#   Specifies whether the group should be managed by this module or not. `$::tomcat::manage_group`.
# @param manage_service
#   Specifies whether a `tomcat::service` corresponding to this instance should be declared. Valid options: Boolean `true` (multi-instance installs), `false` ()single-instance installs).
# @param manage_base
#   Specifies whether the directory of catalina_base should be managed by Puppet. This might not be preferable in network filesystem environments. `true`.
# @param manage_properties
#   Specifies whether the `catalina.properties` file is created and managed. If `true`, custom modifications to this file will be overwritten during runs Valid options: Boolean `true`.
# @param java_home
#   Specifies the java home to be used when declaring a `tomcat::service` instance. See [tomcat::service](# tomcatservice)
# @param use_jsvc
#   Specifies whether jsvc should be used when declaring a `tomcat::service` instance. 
# @param use_init
#   Specifies whether an init script should be managed when declaring a `tomcat::service` instance. See [tomcat::service](# tomcatservice)
# @param manage_dirs
#   Determines whether subdirectories for `catalina_base` should be managed as part of tomcat::instance. The default directories are listed in `dir_list`. Valid options: Boolean.
# @param dir_list
#   Specifies the subdirectories under `catalina_base` to be managed for an instance (disabled via `manage_dirs` Boolean). Valid options: an array of strings, each being a relative subdirectory to `catalina_base`. `['bin','conf','lib','logs','temp','webapps','work']`.
# @param dir_mode
#   Specifies a mode for the managed subdirectories under `catalina_base` for an instance (as specified in `dir_list` and disabled via `manage_dirs` Boolean). Valid option: a string containing a standard Linux mode. 
# @param manage_copy_from_home
#   Specifies whether to copy the initial config files from `catalina_home` to `catalina_base`. Valid options: Boolean. `true`.
# @param copy_from_home_list
#   Specifies the full path of config files to copy from `catalina_home` to `catalina_base` for an instance (disabled via `manage_copy_from_home` Boolean). Valid options: array of strings containing path + filename.
#   ```
#   [ '${_catalina_base}/conf/catalina.policy',
#     '${_catalina_base}/conf/context.xml',
#     '${_catalina_base}/conf/logging.properties',
#     '${_catalina_base}/conf/server.xml',
#     '${_catalina_base}/conf/web.xml']
#   ```
# @param copy_from_home_mode
#   Specifies the file mode when copying the initial config files from `catalina_home` to `catalina_base`. Valid options: a string containing a standard Linux mode.
# @param install_from_source
#   Specifies whether or not the instance should be installed from source.
# @param source_url
#   URL to install from.
# @param source_strip_first_dir
#   Whether or not to strip the first directory when unpacking the source tarball. Defaults to true when installing from source. Requires puppet/archive.
# @param package_ensure
#   Ensure for the package resource when installing from package.
# @param package_name
#   Name of package when installing from package.
# @param package_options
#   Extra options to pass to the package resource.
#
define tomcat::instance (
  $catalina_home          = undef,
  $catalina_base          = undef,
  $user                   = undef,
  $group                  = undef,
  $manage_user            = undef,
  $manage_group           = undef,
  $manage_service         = undef,
  $manage_base            = undef,
  $manage_properties      = undef,
  $java_home              = undef,
  $use_jsvc               = undef,
  $use_init               = undef,
  $manage_dirs            = true,
  $dir_list               = ['bin','conf','lib','logs','temp','webapps','work'],
  $dir_mode               = '2770',
  $manage_copy_from_home  = true,
  $copy_from_home_list    = undef,
  $copy_from_home_mode    = '0660',

  #used for single installs. Deprecated.
  $install_from_source    = undef,
  $source_url             = undef,
  $source_strip_first_dir = undef,
  $package_ensure         = undef,
  $package_name           = undef,
  $package_options        = undef,
) {
  include ::tomcat
  $_catalina_home = pick($catalina_home, $::tomcat::catalina_home)
  $_catalina_base = pick($catalina_base, $_catalina_home) #default to home
  tag(sha1($_catalina_home))
  tag(sha1($_catalina_base))
  $_user = pick($user, $::tomcat::user)
  $_group = pick($group, $::tomcat::group)
  $_manage_user = pick($manage_user, $::tomcat::manage_user)
  $_manage_group = pick($manage_group, $::tomcat::manage_group)
  $_manage_base = pick($manage_base, $::tomcat::manage_base)
  $_manage_properties = pick($manage_properties, $::tomcat::manage_properties)

  if $source_url and $install_from_source == undef {
    # XXX Backwards compatibility mode enabled; install_from_source used to default
    # to true.
    $_install_from_source = true
  } else {
    # XXX If install_from_source is undef, then we're in multi-instance mode. If
    # it's true or false, then we're in backwards-compatible mode.
    $_install_from_source = $install_from_source
  }

  tomcat::instance::dependencies { $name:
    catalina_home => $_catalina_home,
    catalina_base => $_catalina_base,
  }

  if $_install_from_source != undef {
    warning('Passing install_from_source, source_url, source_strip_first_dir, package_ensure, package_name, or package_options to tomcat::instance is deprecated. Please use tomcat::install instead and point tomcat::instance::catalina_home there.') # lint:ignore:140chars
    # XXX This file resource is for backwards compatibility. Previously the base
    # class created this directory for source installs, even though it may never
    # be used. Users may have created source installs under this directory, so
    # it must exist. tomcat::install::source will take care of creating base.
    if $_catalina_base != $_catalina_home and $_manage_base {
      ensure_resource('file',$_catalina_home, {
        ensure => directory,
        owner  => $_user,
        group  => $_group,
      })
    }
    # XXX This is for backwards compatibility. Declare a tomcat install, but install
    # the software into the base instead of the home.
    tomcat::install { $name:
      catalina_home          => $_catalina_base,
      install_from_source    => $_install_from_source,
      source_url             => $source_url,
      source_strip_first_dir => $source_strip_first_dir,
      user                   => $_user,
      group                  => $_group,
      manage_user            => $_manage_user,
      manage_group           => $_manage_group,
      manage_home            => $_manage_base,
      package_ensure         => $package_ensure,
      package_name           => $package_name,
      package_options        => $package_options,
    }
    $_manage_service = pick($manage_service, false)
  } else {
    if $_catalina_home != $_catalina_base {
      if $_manage_user {
        ensure_resource('user', $_user, {
          ensure => present,
          gid    => $_group,
        })
      }
      if $_manage_group {
        ensure_resource('group', $_group, {
          ensure => present,
        })
      }

      if $_manage_base {
        # Configure additional instances in custom catalina_base
        file { $_catalina_base:
          ensure => directory,
          owner  => $_user,
          group  => $_group,
        }
      }
      if $manage_dirs {
        # Ensure install finishes before creating instances from it.
        $home_sha = sha1($_catalina_home)
        Tomcat::Install <| tag == $home_sha |> -> File <| tag == 'dir_list' |>
        $dir_list.each |$dir| {
          file { "${_catalina_base}/${dir}":
            ensure => directory,
            owner  => $_user,
            group  => $_group,
            mode   => $dir_mode,
            tag    => 'dir_list',
          }
        }
      }
      # Set default copy_from_home files list if not overridden; requires $_catalina_base
      if $copy_from_home_list == undef {
        $_copy_from_home_list = [
          "${_catalina_base}/conf/catalina.policy",
          "${_catalina_base}/conf/context.xml",
          "${_catalina_base}/conf/logging.properties",
          "${_catalina_base}/conf/server.xml",
          "${_catalina_base}/conf/web.xml",
        ]
      }
      else {
        $_copy_from_home_list = $copy_from_home_list
      }
      if $manage_copy_from_home {
        tomcat::instance::copy_from_home { $_copy_from_home_list:
          catalina_home => $_catalina_home,
          user          => $_user,
          group         => $_group,
          mode          => $copy_from_home_mode,
        }
      }
    }
    $_manage_service = pick($manage_service, true)
  }
  if $_manage_service {
    tomcat::service { $name:
      catalina_home => $_catalina_home,
      catalina_base => $_catalina_base,
      java_home     => $java_home,
      use_jsvc      => $use_jsvc,
      use_init      => $use_init,
      user          => $_user,
    }
  }
  if $_manage_properties {
    tomcat::config::properties { "${_catalina_base} catalina.properties":
      catalina_home => $_catalina_home,
      catalina_base => $_catalina_base,
      user          => $_user,
      group         => $_group,
    }
  }
}
