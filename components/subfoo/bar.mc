<%args>
$.data => sub { {} }
</%args>
<!doctype html>
<html lang="de">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><% $self->data->{env}->{HTTP_HOST} %> | Hallo Welt</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>

<body class="min-h-screen flex items-center justify-center bg-gray-100">

  <div class="text-center">

<h1>I am Subfoo / Bar<br>
Hello <% $self->data->{name} // 'Anonymous' %> ??!</h1>

<p>
	<a href="/">Start</a>
</p>

% foreach (sort keys %ENV) {
%	next if /pass/i;
	&bull; <b><% $_ %></b> = <% $ENV{$_} %><br>
% }

<& partials/footer.mc, data=>$self->data &>

</div>
</body>
</html>
