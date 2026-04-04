package MyApp::API;
use Dancer2;

set serializer => 'JSON';

get '/ping' => sub {
    return { status => 'ok' };
};

get '/me' => sub {
    return { user => 'demo' };
};

get '/secure' => sub {
    my $auth = request->header('Authorization');

    return send_error('Unauthorized', 401)
        unless $auth && $auth =~ /^Bearer (.+)$/;

    my $token = $1;

    return send_error('Forbidden', 403)
        unless $token eq 'secret';

    return { ok => 1 };
};

1;
