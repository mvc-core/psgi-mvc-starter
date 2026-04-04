<%args>
$.data => sub { {} }
</%args>
<footer class="fixed bottom-0 left-0 w-full bg-white border-t border-gray-200 px-4 py-2 z-50">
    Fusszeile &ndash; Session-User: <% $self->data->{_session}{user} // '(nicht eingeloggt)' %>
    &mdash; xy = "<% $self->data->{xy} // '' %>"<br><br>

    <div class="text-blue-800">
	<a href="/"><b>Start</b></a> &ndash;
	<a href="/foo">Foo</a> &ndash;
	<a href="/subfoo">Sub Foo</a> &ndash;
	<a href="/subfoo/bar">Sub Foo Bar</a> &mdash;
	[ <a href="/api/ping">/api/ping</a> ] &mdash;
	<span class="text-xs">
		[ <a target="_blank" href="https://github.com/mvc-core/psgi-mvc-starter">GitHub</a> ]
	</span>
    </div>

	<p class="mt-6 text-left text-sm">
%	foreach (sort keys %{ $self->data }) {
		[data] - <b><% $_ %></b> = <% $self->data->{$_} %><br>
%	}
	</p>
</footer>
