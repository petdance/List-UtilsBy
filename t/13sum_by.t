#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use List::UtilsBy qw( sum_by sum0_by );

my @employees = (
   Employee->new( 50_000 ),
   Employee->new( 90_000 ),
   Employee->new( 75_000 ),
);

SUM: {
   my $sum;
   $sum = sum_by { $_ * 9 } 1..10;
   is( $sum, 495, 'Mulitplication on sum_by' );

   $sum = sum_by { $_ * $_ } ();
   is( $sum, undef, 'Empty list = undef' );

   $sum = sum_by { $_->salary } @employees;
   is( $sum, 215_000, 'Salary sum' );
}


SUM0: {
   my $sum0;
   $sum0 = sum0_by { $_ * 9 } 1..10;
   is( $sum0, 495, 'Mulitplication on sum0_by' );

   $sum0 = sum0_by { $_ * $_ } ();
   is( $sum0, 0, 'Empty list = undef' );

   $sum0 = sum0_by { $_->salary } @employees;
   is( $sum0, 215_000, 'Salary sum0' );
}

done_testing;

exit 0;

package Employee;

sub new {
    my $class  = shift;
    my $salary = shift;

    return bless { salary => $salary }, $class;
}

sub salary {
    my $self = shift;

    return $self->{salary};
}
