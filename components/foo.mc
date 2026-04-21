<%args>
$.data => sub { {} }
</%args>
<!doctype html>
<html lang="de">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><% $self->data->{env}->{HTTP_HOST} %> | Foo | Hallo Welt</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="min-h-screen flex items-center justify-center bg-gray-100">

  <div class="text-center w-full max-w-screen-lg px-4 overflow-x-auto">

	<h1 class="fixed top-0 left-0 w-full text-4xl font-bold text-blue-600 bg-gray-100 px-4 py-2 z-50">I am Foo<br>
	Hello <% $self->data->{name} // 'Anonymous' %> 🚗!</h1>

<p class="text-left mb-3">
%	unless (%{ $self->data->{_session} }) {
		<p class="text-left text-sm">Derzeit keine Session-Daten.</p>
%	}
%	foreach (keys %{ $self->data->{_session} }) {
        	[Sess] <b><% $_ %></b> = <% $self->data->{_session}->{$_} %><br>
%	}
	via MyApp::Service::Auth::_is_logged_in( ) &rarr; "<% $self->data->{is_logged_in} %>"
</p>
<hr>

<p class="text-left mb-3">
	<a class="text-red-800" href="/foo/set-cookie">🚀 Set Cookie</a><br>
%	if ( $self->data->{msg} ) {
		<b><% $self->data->{msg} %></b><br>
%	}
%	foreach (sort keys %{ $self->data->{cookies} }) {
        	[🍪 Cookie] <b><% $_ %></b> = <% substr($self->data->{cookies}->{$_}, 0, 110) %><br>
%	}
</p>
<hr>

% my $p__foo = $self->data->{p}->foo();
% foreach (sort keys %$p__foo) {
	[Prismado / foo] - <b><% $_ %></b> = <% $p__foo->{$_} %><br>
% }

<div class="mt-3 text-left columns-2 gap-5 break-all">
%	foreach (sort keys %{ $self->data->{env} }) {
%		next unless length( $self->data->{env}->{$_} );
%		next if /^HTTP_SEC_FETCH_.+/ or /^HTTP_ACCEPT.*/ or $self->data->{env}->{$_} =~ /.+\(0x.+/;
		[env] <b><% $_ %></b> = <% substr($self->data->{env}->{$_}, 0, 95) %><br>
%	}
</div>

<& partials/footer.mc, data=>$self->data &>

</div>

</body>
</html>
