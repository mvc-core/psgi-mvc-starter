<%args>
$.data => sub { {} }
</%args>
<!doctype html>
<html lang="de">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><% $self->data->{env}->{HTTP_HOST} %> | Crypt</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="min-h-screen flex items-start justify-center bg-gray-100 pt-28">

  <& partials/header.mc, data => $self->data &>

<div class="text-center w-full max-w-screen-lg px-4 overflow-x-auto">

<h1 class="text-4xl font-bold text-blue-600 px-4 py-2">
	🔒 Crypt
</h1>

<h2 class="text-2xl font-bold">Hello <% $self->data->{name} // 'Anonymous' %>?!</h2>

<form method="post" class="flex flex-col gap-3 w-72 mx-auto mt-20">
	<input type="text" name="in" placeholder="Input" value="<% $self->data->{cgi}->{in} %>"
		class="rounded-lg border border-gray-300 px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">

	<button type="submit"
		class="rounded-lg bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700 active:bg-blue-800 transition-colors">
		Encrypt
	</button>
</form>

<br>

<form method="post" class="flex flex-col gap-3 w-72 mx-auto mt-6">
	<input type="text" name="enc" placeholder="Encrypted Base 64" value="<% $self->data->{cgi}->{enc} %>"
		class="rounded-lg border border-gray-300 px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">

	<button type="submit"
		class="rounded-lg bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700 active:bg-blue-800 transition-colors">
		Decrypt
	</button>
</form>

<p class="text-left mt-10 mb-3">
% foreach (sort keys %{ $self->data->{result} }) {
	[result] - <b><% $_ %></b> &larr; <% $self->data->{result}->{$_} %><br>
% }

%	foreach (sort keys %{ $self->data->{result}->{out} }) {
%		next if $_ eq 'encrypted';
		[result / out ] - <b><% $_ %></b> = <% $self->data->{result}->{out}->{$_} %><br>
%	}
</p>

<div class="mt-20">
	<hr class="mb-3">
	<p class="text-left mb-3">
%	unless (defined $self->data->{cookies}) {
		<p class="mb-4 text-sm">Derzeit keine <a class="text-blue-800" href="/foo/set-cookie">Cookies</a>.</p>
%	}

%       foreach (sort keys %{ $self->data->{cookies} }) {
                [🍪 Cookie] <b><% $_ %></b> = <% substr($self->data->{cookies}->{$_}, 0, 66) %><br>
%       }
	</p>

	<hr class="mb-2">
	<p class="text-left mb-3">
%		foreach (keys %{ $self->data->{_session} }) {
			[Sess] - <b><% $_ %></b> = <% $self->data->{_session}->{$_} %><br>
%		}
	</p>
</div>

% foreach (sort keys %{ $self->data->{cgi} }) {
	[cgi] - <% $_ %> = <% $self->data->{cgi}->{$_} %><br>
% }

<& partials/footer.mc, data=>$self->data &>

</div>
</body>
</html>
