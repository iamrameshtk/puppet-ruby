# = Class: ruby::compile
#
# This class installs ruby compiling it from upstream source
#
class ruby::compile {

  $packages_list = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'build-essential unzip vim git-core curl bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev libcurl4-openssl-dev libopenssl-ruby apache2-prefork-dev libapr1-dev libaprutil1-dev libx11-dev libffi-dev tcl-dev tk-dev',
    default                   => '',
  }

  puppi::install_packages { 'ruby_compile_prerequisites':
    packages => $packages_list ,
  }

  puppi::netinstall { 'ruby_source':
    url                 => "ftp://ftp.ruby-lang.org/pub/ruby/ruby-${ruby::version}.zip",
    destination_dir     => "/var/tmp",
    extracted_dir       => "ruby-${ruby::version}",
    postextract_command => "sh configure && make && make test && make install",
    require             => Puppi::Install_packages['ruby_compile_prerequisites'],
  }

}