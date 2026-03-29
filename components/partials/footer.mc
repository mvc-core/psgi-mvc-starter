<%args>
$.data => sub { {} }
</%args>
<hr class="mb-3">
<footer>
    Fusszeile &ndash; Session-User: <% $self->data->{_session}{user} // '(nicht eingeloggt)' %>
    &mdash; xy = "<% $self->data->{xy} // '' %>"<br><br>

    <div class="text-blue-800">
	<a href="/"><b>Start</b></a> &ndash;
	<a href="/foo">Foo</a> &ndash;
	<a href="/subfoo">Sub Foo</a> &ndash;
	<a href="/subfoo/bar">Sub Foo Bar</a> ------
	[ <a target="_blank" href="https://github.com/mvc-core/psgi-mvc-starter">GitHub</a> ]
    </div>

	<p class="mt-6 text-left text-sm">
%	foreach (sort keys %{ $self->data }) {
		[data] - <b><% $_ %></b> = <% $self->data->{$_} %><br>
%	}
	</p>
</footer>
