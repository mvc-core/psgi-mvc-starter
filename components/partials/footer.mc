<%args>
$.data => sub { {} }
</%args>
<hr>
<footer>
    Fusszeile &ndash; Session-User: <% $self->data->{_session}{user} // '(nicht eingeloggt)' %>
    &mdash; xy = "<% $self->data->{xy} // '' %>"<br><br>

	<a href="/">Start</a> &ndash;
	<a href="/foo">Foo</a> &ndash;
	<a href="/subfoo">Sub Foo</a> &ndash;
	<a href="/subfoo/bar">Sub Foo Bar</a><br><br>

	<small>
%	foreach (sort keys %{ $self->data }) {
		X ------ <% $_ %> = <% $self->data->{$_} %><br>
%	}
	</small>
</footer>
