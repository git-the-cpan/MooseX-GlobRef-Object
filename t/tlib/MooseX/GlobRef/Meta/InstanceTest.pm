package MooseX::GlobRef::Meta::InstanceTest;

use parent 'Test::Unit::TestCase';
use Test::Assert ':all';

use Scalar::Util 'reftype';


{
    package MooseX::GlobRef::Meta::InstanceTest::Test1;

    use metaclass 'Moose::Meta::Class' => (
        instance_metaclass => 'MooseX::GlobRef::Meta::Instance'
    );

    use Moose;

    has field => ( is => 'rw' );
};


sub test___isa {
    my $self = shift;
    my $obj = MooseX::GlobRef::Meta::InstanceTest::Test1->new;
    assert_not_null($obj);
    assert_true($obj->isa('MooseX::GlobRef::Meta::InstanceTest::Test1'));
    assert_equals('GLOB', reftype($obj));
    assert_equals('HASH', reftype(${*$obj}));
};

sub test_accessor {
    my $self = shift;
    my $obj = MooseX::GlobRef::Meta::InstanceTest::Test1->new(field => $$);
    assert_not_null($obj);
    assert_true($obj->isa('MooseX::GlobRef::Meta::InstanceTest::Test1'));
    assert_equals($$, $obj->field);
    assert_equals(1, $obj->field(1));
    assert_equals(1, $obj->field);
};

1;
