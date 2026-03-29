<%args>
$.data => sub { {} }
</%args>
<!doctype html>
<html lang="de">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Hallo Welt</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="min-h-screen flex items-center justify-center bg-gray-100">

  <div class="text-center w-full max-w-screen-lg px-4 overflow-x-auto">

<h1 class="fixed top-0 left-0 w-full text-4xl font-bold text-blue-600 bg-gray-100 px-4 py-2 z-50">I am Foo<br>
Hello <% $self->data->{name} // 'Anonymous' %> 🚗!</h1>

<p class="text-left">
%	foreach (keys %{ $self->data->{_session} }) {
        	[Sess] - <b><% $_ %></b> = <% $self->data->{_session}->{$_} %><br>
%	}
</p>

<div class="text-left columns-2 gap-5">
%	foreach (sort keys %{ $self->data->{env} }) {
		[env] - <b><% $_ %></b> = <% substr($self->data->{env}->{$_}, 0, 40) %><br>
%	}
</div>

<& partials/footer.mc, data=>$self->data &>

</div>

</body>
</html>
