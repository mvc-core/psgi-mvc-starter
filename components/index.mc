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

  	<h1 class="fixed top-10 left-0 w-full text-3xl font-bold z-50"><% $ENV{HOSTNAME} %></h1>

	<h2 class="text-2xl font-bold text-blue-600 bg-gray-100 px-4 py-2 z-50">
		Hello <% $self->data->{name} // 'Anonymous' %> 🚗!
	</h2>

    <p class="mt-4 text-gray-700 font-bold">Meine erste Tailwind CSS Seite mit CDN.</p>

    <h3 class="mt-6 mb-3 text-lg font-semibold text-gray-600 uppercase tracking-wider">Funktionen</h3>
    <ul class="flex flex-col gap-2 w-56 mx-auto">
      <li>
        <a href="/login"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Login
        </a>
      </li>
      <li>
        <a href="/foo"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Testfunktion
        </a>
      </li>
    </ul>

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
