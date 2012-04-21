#######
##
##----- LOSYME
##----- Log::Dispatch::Socket
##----- Log messages to a socket 
##----- Makefile.PL
##
########################################################################################################################

use strict;
use ExtUtils::MakeMaker;

WriteMakefile
(
      NAME          => 'Log::Dispatch::Socket'
    , LICENSE       => 'perl'
    , AUTHOR        => 'Loïc TROCHET <losyme@gmail.com>'
    , VERSION_FROM  => 'lib/Log/Dispatch/Socket.pm'
    , ABSTRACT      => 'Log messages to a socket.'
    , clean         => { FILES => 'Log-Dispatch-Socket-*' }
    , META_MERGE    => { resources => { repository  => 'https://github.com/losyme/Log-Dispatch-Socket' }}
    , BUILD_REQUIRES
      => {
          'Test::More' => 0
      }
    , PREREQ_PM
      => {
          'parent'           => 0
        , 'IO::Socket::INET' => 0
        , 'Params::Validate' => 0
        , 'Log::Dispatch'    => 0
      }
);

####### END ############################################################################################################
