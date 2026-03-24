<%args>
$.data => sub { {} }
</%args>

<h1>I'm Foo<br>
Hello <% $self->data->{name} // 'Anonymous' %> 🚗!</h1>

<p>
%	foreach (keys %{ $self->data->{_session} }) {
        	[Sess] - <b><% $_ %></b> = <% $self->data->{_session}->{$_} %><br>
%	}
</p>

<p>
%	foreach (keys %{ $self->data->{env} }) {
		[env] - <b><% $_ %></b> = <% $self->data->{env}->{$_} %><br>
%	}
</p>

<& partials/footer.mc, data=>$self->data &>
