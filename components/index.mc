<%args>
$.data => sub { {} }
</%args>

<h1>Hello <% $self->data->{name} // 'Anonymous' %> 🚗!</h1>

<p>
	<a href="/foo">foo</a>
</p>

% foreach (sort keys %{ $self->data }) {
	XX <% $_ %> = <% $self->data->{$_} %><br>
% }

<& partials/footer.mc, data=>$self->data &>
