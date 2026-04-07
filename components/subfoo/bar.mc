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

<h1 class="fixed top-0 left-0 w-full text-3xl font-bold text-blue-600 bg-gray-100 px-4 py-2 z-50">I am Subfoo / Bar</h1>

<h2 class="text-2xl font-bold text-blue-600">Hello <% $self->data->{name} // 'Anonymous' %></h2>

<p class="mt-6">
	<a href="/">Back to Start</a>
</p>
<p class="mt-6">
	X -- <code>_id</code> = "<% $self->data->{_id} %>"
</p>

<dl class="mt-6 text-left text-sm divide-y divide-gray-200 border border-gray-200 rounded-lg overflow-hidden w-full max-w-2xl mx-auto">
% foreach (sort keys %ENV) {
%	next if /pass/i or $_ eq 'HOME' or $_ eq 'OLDPWD' or $_ eq 'PATH';
  <div class="flex gap-2 px-4 py-2 even:bg-gray-50 hover:bg-blue-50 transition-colors">
    <dt class="font-semibold text-gray-700 shrink-0 w-56 truncate"><code>$ENV</code> - <% $_ %></dt>
    <dd class="text-gray-500 truncate"><% $ENV{$_} %></dd>
  </div>
% }
</dl>

<& partials/footer.mc, data=>$self->data &>

</div>
</body>
</html>
