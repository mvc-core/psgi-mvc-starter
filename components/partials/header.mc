<%args>
$.data => sub { {} }
</%args>
<div class="fixed top-25 left-0 w-full bg-white border-t border-gray-200 px-4 py-2 z-50">
    Fusszeile &ndash; Session-User: <% $self->data->{_session}{user} // '(nicht eingeloggt)' %>
    &mdash; xy = "<% $self->data->{xy} // '' %>"<br><br>

    <div class="text-blue-800">
	<a href="/"><b>Start</b></a> &ndash;
	<a href="/login">Login</a> &ndash;
	<a href="/logout">Logout</a> &ndash;
	<a href="/foo">Foo</a> &ndash;
	<a href="/subfoo">Subfoo</a> &ndash;
	<a href="/subfoo/bar">Subfoo/Bar</a>/<a href="/subfoo/bar/4321"><sup>+</sup></a> &mdash;
	[ <a href="/api/ping">/api/ping</a> ] &mdash;
	<span class="text-xs">
		[ <a target="_blank" href="https://github.com/mvc-core/psgi-mvc-starter">GitHub</a> ]
	</span>
    </div>

</div>
