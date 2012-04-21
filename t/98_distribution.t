#######
##
##----- LOSYME
##----- Log::Dispatch::Socket
##----- Log messages to a socket 
##----- 98_distribution.t
##
########################################################################################################################

use strict;
use warnings;
use Test::More;

eval 'use Test::Distribution';
plan(skip_all => "Test::Distribution required for checking distribution") if $@;

####### END ############################################################################################################
