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

  <div class="text-center">

<h1>I am Foo<br>
Hello <% $self->data->{name} // 'Anonymous' %> 🚗!</h1>

<p class="text-left">
%	foreach (keys %{ $self->data->{_session} }) {
        	[Sess] - <b><% $_ %></b> = <% $self->data->{_session}->{$_} %><br>
%	}
</p>

<p class="text-left">
%	foreach (keys %{ $self->data->{env} }) {
		[env] - <b><% $_ %></b> = <% $self->data->{env}->{$_} %><br>
%	}
</p>

<& partials/footer.mc, data=>$self->data &>

</div>

</body>
</html>
