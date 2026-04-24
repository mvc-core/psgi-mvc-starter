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

<body class="min-h-screen flex items-start justify-center bg-gray-100 pt-28">

  <& partials/header.mc, data => $self->data &>

  <div class="text-center w-full max-w-screen-lg px-4 overflow-x-auto">

  	<div class="flex justify-center">
  		<img src="/assets/images/logos/logo_mvc.webp" class="w-1/5">
	</div>

  	<h1 class="text-4xl font-bold text-blue-600 px-4 py-2"><% $ENV{HOSTNAME} %></h1>

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
        <a href="/logout"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Logout
        </a>
      </li>

      <li>
        <a href="/crypt"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Crypt
        </a>
      </li>

      <li>
        <a href="/argon2"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Argon2
        </a>
      </li>

      <li>
        <a href="/foo"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Testfunktionen
        </a>
      </li>

      <li>
        <a href="/upload"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Upload
        </a>
      </li>

      <li>
        <a href="/config"
           class="flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:border-blue-400 hover:text-blue-700 transition-colors shadow-sm">
          <span class="text-blue-500">&#9654;</span> Konfiguration
        </a>
      </li>

    </ul>

    <& partials/inc_debug_data.html, data => $self->data &>
<%doc>
XXX:
/XXX
</%doc>

    <p class="mt-10 text-gray-700 XXXtext-left">
	<& partials/footer.mc, data=>$self->data &>
    </p>

  </div>

</body>
</html>
