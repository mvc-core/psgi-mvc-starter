<%args>
$.data => sub { {} }
</%args>

<h1>I'm Sub-Foo (index)<br>
Hello <% $self->data->{name} // 'Anonymous' %> ??!</h1>

<form method="post" action="/subfoo">
	<input type="text" name="user">
	<input type="text" name="pass">
	<input type="submit" value="Login">
</form>

% foreach (keys %{ $self->data->{subdata} }) {
	[CGI] - <% $_ %> = <% $self->data->{subdata}->{$_} %><br>
% }

<hr />
% foreach (keys %{ $self->data->{_session} }) {
	[Sess] - <b><% $_ %></b> = <% $self->data->{_session}->{$_} %><br>
% }

<hr />
% foreach (keys %{ $self->data->{subdata} }) {
	[subdata] - <b><% $_ %></b> = <% $self->data->{subdata}->{$_} %><br>
% }

<& partials/footer.mc, data=>$self->data &>
