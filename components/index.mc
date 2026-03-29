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

	<h1 class="text-4xl font-bold text-blue-600">
		Hello <% $self->data->{name} // 'Anonymous' %> 🚗!
	</h1>

    <p class="mt-4 text-gray-700">Meine erste Tailwind CSS Seite mit CDN.</p>

    <p class="mt-10 text-gray-700 text-left">
%	foreach (sort keys %{ $self->data }) {
		[data] - <b><% $_ %></b> = <% $self->data->{$_} %><br>
%	}
    </p>

    <p class="mt-10 text-gray-700 XXXtext-left">
	<& partials/footer.mc, data=>$self->data &>
    </p>

  </div>

</body>
</html>
