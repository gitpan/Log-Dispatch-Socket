#######
##
##----- LOSYME
##----- Log::Dispatch::Socket
##----- Log messages to a socket 
##----- Build.PL
##
########################################################################################################################

use strict;
use Module::Build;

Module::Build->new(
      module_name        => 'Log::Dispatch::Socket' 
    , license            => 'perl' 
    , dist_author        => 'Loïc TROCHET <losyme@gmail.com>' 
    , dist_version_from  => 'lib/Log/Dispatch/Socket.pm'
    , add_to_cleanup     => [ 'Log-Dispatch-Socket-*' ]
    , configure_requires
      => {
          'Module::Build' => 0 
      }
    , build_requires
      => {
          'Test::More' => 0
      }
    , requires
      => {
          'parent'           => 0
        , 'IO::Socket::INET' => 0
        , 'Params::Validate' => 0
        , 'Log::Dispatch'    => 0
      } 
)->create_build_script;

####### END ############################################################################################################
