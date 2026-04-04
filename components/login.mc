<%args>
$.data => sub { {} }
</%args>
<!doctype html>
<html lang="de">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><% $self->data->{env}->{HTTP_HOST} %> | Login</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="min-h-screen flex items-center justify-center bg-gray-100">
<div class="text-center">

<h1 class="fixed top-0 left-0 w-full text-3xl font-bold text-blue-600 bg-gray-100 px-4 py-2 z-50">I am Sub-Foo (index)</h1>

<h2 class="text-2xl font-bold">Hello <% $self->data->{name} // 'Anonymous' %>?!</h2>

<form method="post" XXXaction="/login" class="flex flex-col gap-3 w-72 mx-auto mt-6">
	<input type="text" name="user" placeholder="Benutzername"
		class="rounded-lg border border-gray-300 px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
	<input type="password" name="pass" placeholder="Passwort"
		class="rounded-lg border border-gray-300 px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
	<button type="submit"
		class="rounded-lg bg-blue-600 px-4 py-2 text-sm font-semibold text-white hover:bg-blue-700 active:bg-blue-800 transition-colors">
		Login
	</button>
</form>
<br>

% foreach (keys %{ $self->data->{result} }) {
	[result / REST API] - <b><% $_ %></b> = <% $self->data->{result}->{$_} %><br>
% }
<hr>

% foreach (keys %{ $self->data->{subdata} }) {
% # XXX	[CGI] - <% $_ %> = <% $self->data->{subdata}->{$_} %><br>
% }

<hr>
<p class="text-left mb-3">
%       foreach (sort keys %{ $self->data->{cookies} }) {
                [🍪 Cookie] <b><% $_ %></b> = <% substr($self->data->{cookies}->{$_}, 0, 110) %><br>
%       }
</p>

<hr>
% foreach (keys %{ $self->data->{_session} }) {
	[Sess] - <b><% $_ %></b> = <% $self->data->{_session}->{$_} %><br>
% }

<& partials/footer.mc, data=>$self->data &>

</div>
</body>
</html>
