package MyApp::API;
use Dancer2;

set serializer => 'JSON';

get '/ping' => sub {
    return { status => 'ok' };
};

get '/me' => sub {
    return { user => 'demo' };
};

1;
