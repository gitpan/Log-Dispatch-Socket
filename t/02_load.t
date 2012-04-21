#######
##
##----- LOSYME
##----- Log::Dispatch::Socket
##----- Log messages to a socket 
##----- 02_load.t
##
########################################################################################################################

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use test::tidy execute => load => qw(Log::Dispatch::Socket);

####### END ############################################################################################################
